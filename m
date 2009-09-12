From: Jeff King <peff@peff.net>
Subject: Re: git push --confirm ?
Date: Sat, 12 Sep 2009 16:49:06 -0400
Message-ID: <20090912204905.GA31427@coredump.intra.peff.net>
References: <1252777897.2974.24.camel@localhost.localdomain>
 <20090912184342.GB20561@coredump.intra.peff.net>
 <1252786266.2974.61.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org,
	Colin Walters <walters@verbum.org>
To: Owen Taylor <otaylor@redhat.com>
X-From: git-owner@vger.kernel.org Sat Sep 12 22:49:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmZXO-0006A6-AA
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 22:49:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754728AbZILUtK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 16:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754726AbZILUtK
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 16:49:10 -0400
Received: from peff.net ([208.65.91.99]:49152 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754533AbZILUtJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2009 16:49:09 -0400
Received: (qmail 14238 invoked by uid 107); 12 Sep 2009 20:49:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 12 Sep 2009 16:49:27 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 12 Sep 2009 16:49:06 -0400
Content-Disposition: inline
In-Reply-To: <1252786266.2974.61.camel@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128296>

[cc'd Daniel; I think this proposal for a "confirm push" might interact
with your foreign VCS work a bit. I'm not sure anymore what would be the
right level for inserting this code.]

On Sat, Sep 12, 2009 at 04:11:06PM -0400, Owen Taylor wrote:

> The main UI advantage is that you can adjust the default with 'git
> config' it on and leave it on. The time you screw up is not when you are
> worried that you are going to push the wrong thing. It's when you are
> you know exactly what 'git push' is going to do and it does something
> different.

That makes sense. I would not want to use such a feature, but I see the
use case you are talking about (see, I told you I was bad person to
comment. ;) ).

It should be pretty straightforward to implement for the git protocol.
Pushing goes something like:

  1. Get the list of refs from the remote.

  2. Using the desired refspecs (either configured or from the command
     line), make a list of src/dst pairs of refs to be pushed.

  3. For each ref pair, send the "<old> <new> <name>" triple to the
     remote (or not, if it is already up-to-date, a non-fast-forward,
     etc).

  4. Send the packed objects.

  5. For each ref pair, print the status in a summary table.

So you would just want a "2.5" where you show something similar to the
summary table and get some confirmation (or abort). An iterative "do you
want to push this ref" strategy would be similar; just mark the refs you
do and don't want to push.

The tricky thing will be handling different transports. Some of that
code has been factored out, but I haven't looked at the details. On top
of that, I think Daniel is working in this area for his support
of foreign VCS helpers (and other transports like libcurl are getting
pushed out into their own helpers). So he may have a better idea of how
to go about this sanely.

> haven't finished testing. For updates, showing a commit count and (a
> probably limited number of) commit subjects would avoid having to
> cut-and-paste the update summary into git log.
> 
> As you say, maybe that's something that just needs to be fixed
> with a better format for --dry-run. But that doesn't negate the main UI
> advantage.

Sure. I just think the two concepts are somewhat orthogonal (though you
would probably want to enable them together for your particular
workflow). It sounds like you want something like (and obviously you
could have a config option to avoid typing --log-changes each time):

  $ git push --dry-run --log-changes
  To server:/path/to/repo.git
    5ad9dce..cfc497a  topic -> topic
      abcd123: commit subject 1
      cfc497a: commit subject 2

That can potentially get long, though. I'm not sure if you would want to
abbreviate it in some way, and if so, how.

> Hmm, yeah, I've certainly looked at git-receive-pack(1) before but
> hadn't internalized that --force was client side. Certainly doing it
> with a single atomic pass is the better way to do it.

There is actually a server-side analogue, which is the
"receive.denyNonFastForwards" config option, and it defaults to "off".
The "--force" option is a client side way of helping you be polite. The
receive config option is about actual policy.

> (Wouldn't work for rsync and http pushes, right? A simple "Not
> supported" perhaps.)

Rsync, at least, is already non-atomic because there is no way to do
locking. So you wouldn't make anything worse by supporting this feature
(though you do widen the gap for the race condition by waiting for user
input). I'm not sure anyone really cares about rsync these days, though.

I believe http-push actually does some kind of DAV locking. So there's
no reason you this couldn't work for http push.

> Hmm, of two minds about this. Doing it as a pick-and-choose
> --interactive does integrate it conceptually with other parts of Git.
> And probably is occasionally useful.
> 
> But it makes it considerably less convenient to just config on.
> Because any time you want to push more than 2-3 refs at once you'll have
> to add --no-interactive.
> 
> It also increases the amount of reading - if I see all the branches at
> once that are being pushed I can immediately notice that I'm pushing two
> branches when I thought I was pushing one, without actually having to
> read the branch names.

I think it really depends on your workflow, and how many refs you are
typically pushing. So yeah, I can see that the iterative asking is not
really a replacement for what you are asking for.

-Peff
