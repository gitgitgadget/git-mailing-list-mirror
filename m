From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Implementing commit signing
Date: Thu, 9 Oct 2008 08:44:09 -0700
Message-ID: <20081009154409.GU8203@spearce.org>
References: <E74D836C8B2CEF4A89F47E8ACECEEF9B748C75@maildub1.misys.global.ad>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: "Balasubramaniam, Arunan" <Arunan.Balasubramaniam@misys.com>
X-From: git-owner@vger.kernel.org Thu Oct 09 17:48:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Knxha-00084g-VX
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 17:45:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753747AbYJIPoL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 11:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753571AbYJIPoL
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 11:44:11 -0400
Received: from george.spearce.org ([209.20.77.23]:52660 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753106AbYJIPoK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 11:44:10 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 681A238368; Thu,  9 Oct 2008 15:44:09 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <E74D836C8B2CEF4A89F47E8ACECEEF9B748C75@maildub1.misys.global.ad>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97861>

"Balasubramaniam, Arunan" <Arunan.Balasubramaniam@misys.com> wrote:
> I am looking at using Git within our organisation, and verifying the
> source of
> commits has been raised as a concern. GPG signing individual commits has
> been
> discussed at least once on this list [1].

Another approach is to use a central Git server with SSH
key authentication and install into every repository the
contrib/hooks/update-paranoid hook as $GIT_DIR/hooks/update.
This is actually what I did at my prior day-job.

The update-paranoid hook scrapes all new incoming commits and
verifies the "committer" line matches the name and email address
associated with the user who is executing the "git push".

If you use this under something like say "Gitosis" then users don't
even need direct UNIX access.  The SSH public keys are installed
into a common user account, and the user is only allowed to start
the Gitosis wrapper.  The wrapper verifies the command is only a
git server request, then starts Git.  The update hook can then use
data from Gitosis to verify the committer lines.

Actually at prior day-job we wrote our own scripts to do this, and
didn't use Gitosis at all.  If I recall correclty it was about 200
lines of Perl to automatically manage the ~git/.ssh/authorized_keys
file, verify commands, and create repositories with the
update-paranoid hook installed by default.  Too bad I couldn't get
them to let me open that code.

Security wise its the same as signing commits, except the only
way to verify commits are valid is to fetch them from the central,
trusted server.  If you get commits via any other path they cannot
be verified.  In a corporate setting this may be sufficient.  In an
open source setting its less so, as you want to avoid that central
point of failure.

> I got the impression from that
> thread
> that if a patch to implement it were submitted then it would probably
> get
> accepted.

Its possible.  I think some of the preconditions to it being accepted
would be:

- It must be off by default.

- It must be configured on by default per-project, via .git/config.

- It should be able to be a command line option to git-commit,
  like the current --signoff flag, so users can actively choose to
  activate it on a per-commit basis.

- It should be able to optionally use a GnuPG agent so keys can
  be unlocked in memory and used for signing without typing your
  password on every commit.

A problem with signed commits is you obviously cannot cherry-pick
them, or apply them with git-am, as the committer portion of the
commit should be incorporated into the signature calculation.

So maybe also:

- git format-patch / log --format=email must strip the signature
  as the output cannot be verified.

- cherry-pick must strip the signature when picking the commit.

- rebase -i must strip the signature when squashing commits together
  and one or more of them are signed.

- all three rebase implementations should support stripping or
  resigning all commits in the series it is rebasing.

But as I think about it more, if you signed the diff, excluding the
line offsets in the hunk headers (so file paths, context and -/+
lines), the "author" line and the message, leaving out the other
fields of the commit message, it may be possible to still include
the signature in an email formatted patch and carry it through a
"git format-patch | git am" pipeline and still have it verify.

> I have a few questions:
> 
>   1) Is that actually the case at present? I ask to avoid doing the work
> and
>      having it rejected.

Its difficult to guage rejection without seeing the code behind it
and considering the consequences of including that code.  A lot
of these hypothetical discussions start out with a question like
this, raise some good points, and then folks are waiting to see it
implemented, but no code comes about.

It may be faster to prototype this out in Perl or shell with a
very simple "git signcommit" sort of tool, so people can experiment
with the concept and see what works before committing to a longer
implementation that integrates it into the git core tools.

If you really want to try to implement this I would encourage you
to make an extremely simple "git signcommit" tool that doesn't
implement all of the git commit features, but that does provide
the signing system.  Here's a start:

  #!/bin/sh
  . git-sh-setup
  git status >.git/COMMIT_EDITMSG
  git_editor .git/COMMIT_EDITMSG
  tree=$(git write-tree) || die "write tree failed"
  raw=$(git commit-tree $tree -p HEAD <.git/COMMIT_EDITMSG)
  raw=$((cat .git/COMMIT_EDITMSG; git cat-file commit $raw | gpg -s)\
        | git commit-tree $tree -p HEAD)
  git update-ref HEAD $raw

Crude as heck, and maybe my gpg -s call isn't quite right, but
that's a basic git commit tool that you can experiment with.
 
>   2) If it were accepted into Git, would an equivalent patch be accepted
> into
>      jgit? Would patches for UI to use it be accepted into egit?

Yes, absolutely, so long as the implementation in Java was reasonably
sane.  E.g. we'd prefer you used a pure Java implementation of
GnuPG, rather than say forking out to a Python script that execs
some Haskell program to use a SOAP RPC to a remote signing service
written in Tcl... ;-)
 
-- 
Shawn.
