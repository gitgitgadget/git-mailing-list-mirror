From: Jeff King <peff@peff.net>
Subject: Re: what are the chances of a 'pre-upload' hook?
Date: Mon, 28 Nov 2011 02:51:07 -0500
Message-ID: <20111128075107.GA16901@sigill.intra.peff.net>
References: <7v8vn2vt8p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 28 08:51:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUvzg-0005AP-OT
	for gcvg-git-2@lo.gmane.org; Mon, 28 Nov 2011 08:51:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752541Ab1K1HvL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Nov 2011 02:51:11 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53933
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752573Ab1K1HvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2011 02:51:09 -0500
Received: (qmail 22189 invoked by uid 107); 28 Nov 2011 07:57:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 28 Nov 2011 02:57:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Nov 2011 02:51:07 -0500
Content-Disposition: inline
In-Reply-To: <7v8vn2vt8p.fsf@alter.siamese.dyndns.org>
 <7vmxbivw8u.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186001>

On Sat, Nov 26, 2011 at 11:51:29PM -0800, Junio C Hamano wrote:

> I personally have a huge problem with shipping an inherently unsafe
> mechanism that is disabled by default even if it is marked with big red
> letters saying that it is unsafe and should not be enabled casually. It
> makes it up to the system administrator to decide what is casual and what
> is not, but when end users are get harmed by a clueless administrator's
> decision, the repercussion will come back to the Git software, not to the
> clueless administrator who enabled an unsafe mechanism in an environment
> where it was not designed to support.

I agree. If we can avoid adding any feature which is even potentially
dangerous, it's good to explore alternatives. At the same time, the
subject of remote fetch hooks has come up before, and I don't think it's
going away. It would be nice to reach more resolution this time.

I also have mild concerns about the current receive-pack hooks. The
thought so far has been "well, you're less likely push into a bad
person's repository". Which is probably true. But it seems like a flaky
thing to base security on, especially in multi-user environments with
shared repositories.

> If the mechanism to notify the external machinery (i.e. counting accesses,
> learning the true destination of a new fetch request and have the fetcher
> wait while the real fetch goes to the origin site) were not via a hook
> that runs as the fetcher but were via something else that runs as the
> owner of that external service (i.e. counting accesses, maintaining the
> proxy object pool), I wouldn't have trouble with the proposal.
> 
> For example, upload-pack could write the details of the original request
> to a named pipe to ask the "service" process listening on the other end,
> and wait for its response.

Right, that was the "socket" solution I mentioned earlier. The problem
is that it's a pain to set up. If you really want to have a daemon
running and handling git tasks, then you might as well just have the
whole upload-pack/receive-pack side accessible over a socket (e.g., just
run git-daemon if you don't care about authentication, and
git-over-https if you do).

If you really care about ssh authentication and keeping track of
individual unix users, then one possibility is to run git-daemon
listening on a unix socket, use SO_PEERCRED to get the user on the other
end, and then process everything as a single git user.

For example, imagine Bob and Alice are in the "research" group, and use
a shared central repo. Bob wants to push:

  1. Bob runs "git push" on his workstation. Git on the workstation
     connects to "ssh bob@server git-receive-pack $repo".

  2. git-receive-pack on the server runs as Bob. It notices that
     $repo/daemon-socket exists, and runs in "shim" mode, connecting to
     the socket and proxying data over the socket.

  3. git-daemon, running as the "research" user, listens on the other
     end of the socket (and potentially sockets for other repos). It
     sees the connection and serves it. The daemon already knows which
     repo to serve because it knows which socket Bob connected to. And
     it knows it's OK for Bob to access it, because he was able to get
     to the socket via filesystem permissions.

     The daemon can use getsockopt(SO_PEERCRED) to find out that Bob is
     the user, and probably set an environment variable. It can freely
     run any hooks, because the hooks are owned by the "research" user,
     and that's the user the daemon runs as. Hooks can trust the
     environment from the daemon, and can use Bob's identity for further
     authorization checks if they want to. IOW, we are roughly at the
     same place you would get by connecting over git-over-https.

This naturally extends to "Bob fetches" or "Bob runs his push from the
server".  As an added bonus over the usual shared-central-repo model,
malicious users can't just ignore hooks (in the usual shared-repo model,
everybody can write directly to the object db and refs, so hooks are
somewhat advisory).

I suspect people who really care about this use case are already running
git-over-https, possibly with something like gerrit doing some policy
enforcement. I also suspect there are a lot of corporate environments
where they just have a big shared repo, set core.sharedRepository, and
don't worry too much about users hurting each other (in most dev
environments I've seen, people are perfectly willing to fetch and run
make without looking at the diff, so it's sort of a moot point).

People in the latter half would be one of the potential audiences for
the "screw it, just run hooks from the remote repo" flag.

> I actually like the idea of allowing pre-upload-pack hook on git:// and
> possibly http:// only. git-daemon can tell the upload-pack that it is OK
> to run the hook, and the hook can do the things that only the daemon can
> do, never touching what the original requestor would but the repository
> owner would not have an access to.

That's not necessarily safe. Think about a site like kernel.org. The
administrator is the one running the daemon, on behalf of all of the
users. But my impression is that pre-August, developers had shell access
to their own repos and could write their own hook files. So if
git-daemon runs hooks, then any repo owner could run arbitrary code as
the git-daemon, including killing the running daemon and running their
own trojan.

So you really need some way for the admin to say "it's OK, hooks are
locked down and it's safe for them to run". Which again, I was thinking
of as an environment variable.

However, I think for the daemon case, the other alternative I mentioned
earlier is a bit more elegant: an environment variable which doesn't say
"respect the hooks in the repo", but rather "run this _particular_
program as the pre-upload-pack hook".  And then the admin doesn't have
to care what's in the repos. The daemon runs some particular program
every time a fetch happens.

It's tempting to say "can't they just replace git-upload-pack with a
shim that does what they want and then runs upload-pack?"[1]. But I
think the answer is no, for the same reason we have hooks at all: they
might want to operate under a lock, or use some data produced by
upload-pack, or make a decision that blocks the fetch.

[1] Actually, I think Sitaram's case may not be a pre-upload-pack hook,
    but rather the simple "run before upload-pack" case. Because a
    pre-upload-pack would probably feed the set of requested objects to
    the hook. But he will want to fetch from the upstream before even
    advertising any refs to the client.

> One scenario I do not want to see is this. Suppose there is a company that
> runs more than one project, and one of the projects is so secret that only
> engineers working on the project have access to its repository, while all
> people, including the project-A engineers, in the company have access to
> other repositories. Further suppose that people involved in some or many
> of the general repositories want to do something before a fetch from them
> happens. They will use the pre-upload-hook to implement it if we make it
> available, and their new-hire training course will tell their engineers to
> set the GIT_ALLOW_UNTRUSTED_HOOKS. Perhaps the /etc/skel/profile the
> company gives the new-hires already defines it.

Right. This is a failure of the training course and/or the admin who
wrote the default profile, and is exactly the thing that would be
mentioned in the red flags in the docs. I agree there is a risk of
bone-headed admins, though.

This, btw, is more or less the case I am concerned about _now_ with
receive-pack. With current git, if any of those general repositories is
a shared central repo, then project A is similarly vulnerable to anyone
who can write the hook.

-Peff
