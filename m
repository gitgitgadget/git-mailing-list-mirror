From: Jeff King <peff@peff.net>
Subject: Re: [RFC] a tale of Git 2.5, ssh transport and GIT_* environment
 variables
Date: Fri, 4 Sep 2015 08:54:49 -0400
Message-ID: <20150904125448.GA25501@sigill.intra.peff.net>
References: <CAOxFTcx9E_FtYD_Jn3+S3j-rwGO+hJSVXUC2S5ZBB6der7dUuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 14:54:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXqW7-0005of-PK
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 14:54:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758864AbbIDMyw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 08:54:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:54926 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753790AbbIDMyv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 08:54:51 -0400
Received: (qmail 16048 invoked by uid 102); 4 Sep 2015 12:54:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Sep 2015 07:54:51 -0500
Received: (qmail 21366 invoked by uid 107); 4 Sep 2015 12:54:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Sep 2015 08:54:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Sep 2015 08:54:49 -0400
Content-Disposition: inline
In-Reply-To: <CAOxFTcx9E_FtYD_Jn3+S3j-rwGO+hJSVXUC2S5ZBB6der7dUuw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277303>

On Fri, Sep 04, 2015 at 12:52:45PM +0200, Giuseppe Bilotta wrote:

> Trying to push any changes with 2.5 resulted in this kind of failure:
> 
> user@clientmachine:~/some/git/workdir $ git push
> Counting objects: 6, done.
> Delta compression using up to 8 threads.
> Compressing objects: 100% (5/5), done.
> Writing objects: 100% (6/6), 841 bytes | 0 bytes/s, done.
> Total 6 (delta 2), reused 0 (delta 0)
> fatal: Could not switch to '/home/user/some/git': No such file or directory
> error: unpack failed: unpack-objects abnormal exit
> fatal: Could not switch to '/home/user/some/git': No such file or directory
> To git@remote.machine:remote-repo
> ! [remote rejected] master -> master (n/a (unpacker error))
> error: failed to push some refs to 'git@remote.machine:remote-repo'
>
> Notice two things: the messages refer to the worktree updir of the
> CLIENT machine, and even though it's _completely not obvious_ due to
> the missing 'remote:' lines, the messages actually come from the
> SERVER. The lack of indicator lines _alone_ took me hours of debugging
> before I finally understood that they were coming from the other side

Older versions of receive-pack would let unpack-objects output go
straight to stderr, but that changed in a22e6f8 (receive-pack: send
pack-processing stderr over sideband, 2012-09-21), which is in git
v1.7.12.3. What version of git is running on the remote server?

E.g., even without going over ssh, if I do:

  git init
  echo content >file && git add file && git commit -m foo
  git init --bare dst.git
  # force unpacker to fail
  chmod -w dst.git/objects
  git push dst.git

I get:

  Counting objects: 3, done.
  Writing objects: 100% (3/3), 205 bytes | 0 bytes/s, done.
  Total 3 (delta 0), reused 0 (delta 0)
  remote: error: insufficient permission for adding an object to repository database ./objects
  remote: fatal: failed to write object
  error: unpack failed: unpack-objects abnormal exit
  To dst.git
   ! [remote rejected] master -> master (unpacker error)
  error: failed to push some refs to 'dst.git'

The "unpack failed" line _does_ come from the remote, but comes straight
from receive-pack, not the child unpack-objects. Receive-pack
distinguishes between errors which should go to the client and which
just go to stderr for debugging (remember that not all transports
actually propagate stderr to the client; ssh is special here). It's
possible we could switch the "unpack failed" to go to the client, but it
is redundant with the "unpacker error" which _does_ go to the client.

> I still couldn't do much on the SERVER to debug due to a variety of
> reasons, but I finally had a suspicion: it was almost as if the SERVER
> was getting the GIT_DIR information from the CLIENT. And why the heck
> would _that_ be the case?
> 
> I then remembered that the server was actually configured to AcceptEnv
> GIT_* in sshd_config, for reasons related to git identity preservation
> despite single login account (please don't ask). Turning the AcceptEnv
> to a stricter GIT_AUTHOR* and GIT_COMMITTER* solved the issue.

I couldn't reproduce this problem, either during a local push, or across
an ssh session (where the client has "SendEnv GIT_*" and the server has
"AcceptEnv GIT_*").

In the local case, we explicitly unset GIT_DIR and related variables in
connect.c:git_connect. We don't seem to do so for the ssh case, though.
I can confirm that the variable makes it across to the remote:

  GIT_DIR=$PWD git push \
    --receive-pack='echo >&2 GIT_DIR=$GIT_DIR; git-receive-pack' \
    remote-host:remote-repo

shows our local $PWD on the remote side (though note that you have to
explicitly set $GIT_DIR; git-push does not do so normally).

On the receiving side, git-receive-pack takes an argument for the repo
path, and calls enter_repo. That should result in calling set_git_dir(),
which overwrites $GIT_DIR in the environment. AFAICT, it has always done
so. So I'm not sure how GIT_DIR would leak through, even on an older
version of git.

> 1. since when have git internals started exporting GIT_* variables
> related to the git dir and worktree location?

It has done so for a long time, though the exact rules for doing so
changes from time to time. Browsing "git log", I couldn't find any
recent changes in this area. It would help if you could bisect the
problem, as I can't manage to replicate it.

> 2. is it worth making sure that these don't get propagated via ssh?

It seems like a reasonable idea for git_connect() to do so in the ssh
case, as well as the local case. That _could_ be a regression for
somebody who uses an ssh-wrapper whose behavior changes based on some
$GIT_* variable, but that seems a bit far-fetched.

It shouldn't be necessary for $GIT_DIR, but it makes sense for other git
variables. E.g., with "AcceptEnv GIT_*", "git -c" config is propagated.
E.g.:

  # make a syntactically bogus commit
  commit=$(git cat-file commit HEAD |
           sed 's/>/>>/' |
	   git hash-object -t commit -w --stdin)
  git update-ref HEAD $commit
  # confirm that git complains
  git fsck

  # confirm that it gets blocked by receive.fsckObjects; the "-c" is
  # applied to the receive-pack directly, so we are already in the
  # "remote" repo.
  git push --receive-pack='git -c receive.fsckobjects=true receive-pack' dst.git

  # now let's try it with a local "-c". This doesn't get propagated, as
  # we clean out any environment-level config before running
  # receive-pack in the "remote". As a result, the push succeeds.
  git -c receive.fsckobjects=true push dst.git

  # and now the same thing over ssh; this _will_ complain, as we
  # propagated the config.
  git -c receive.fsckObjects=true push remote:dst.git

-Peff
