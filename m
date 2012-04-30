From: Seth Robertson <in-gitvger@baka.org>
Subject: Re: Newbie grief
Date: Mon, 30 Apr 2012 19:31:50 -0400
Message-ID: <201204302331.q3UNVo7o032303@no.baka.org>
References: <4F9F128C.5020304@palm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Rich Pixley <rich.pixley@palm.com>
X-From: git-owner@vger.kernel.org Tue May 01 01:32:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SP04Y-0002dh-Cw
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 01:32:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757462Ab2D3Xb6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 19:31:58 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: from tsutomu.baka.org ([66.114.72.182]:55011 "EHLO tsutomu.baka.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757408Ab2D3Xb5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 19:31:57 -0400
Received: from no.baka.org (no.baka.org [IPv6:2001:470:88bb::2])
	by tsutomu.baka.org (8.14.4/8.14.4) with ESMTP id q3UNVq7a017505
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 30 Apr 2012 19:31:52 -0400
Received: from no.baka.org (localhost [127.0.0.1])
	by no.baka.org (8.14.4/8.14.0) with ESMTP id q3UNVo7o032303;
	Mon, 30 Apr 2012 19:31:52 -0400
In-reply-to: <4F9F128C.5020304@palm.com>
Comments: In reply to a message from "Rich Pixley <rich.pixley@palm.com>" dated "Mon, 30 Apr 2012 15:30:36 -0700."
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196636>


In message <4F9F128C.5020304@palm.com>, Rich Pixley writes:

    Hey.  I'm a newbie struggling to understand git.

    I'm trying to do what seems like a simple thing in darcs, monotone,
    mecurial, gnu arch, etc, but seems nearly impossible in git.  There=
's a
    central repository, a long ways away on the other side of the inter=
net.
    So I want a local repository cache.  I'm going to be working on a n=
umber
    of different features and different machines all simultaneously so =
I
    really don't want them all to be pulling from the central repositor=
y.

Are you working with anyone else locally?  If not, then what you are
probably really trying to do is save time on fetches, so that the
latest changes are more likely to be nearby than far away.

What I would do is set up a bare backup/--mirror repository of the
upstream locally and have it automatically kept up to date with cron
or something like that.  Then you can have your pull URL point to this
mirror and the push URL point to the real upstream.  This will work as
long as the real upstream and the local mirror are not out of date (if
they are, you will be forbidden to push without either pulling from
the real upstream or wait for the next cron fetch and pull from your
local mirror).

This works, but requires that you separate your fetch and push URLs.
Another option is to use git "alternates" to have your local
repository also look at the automatically updated repository so that
you would only fetch over-the-network-changes since the last automatic
fetch (which, unless you had the cache have an alternate for the
primary repository, would mean that the changes would be transferred
twice).

Alternates can be problematic if you start moving repositories around
or delete them or whatever since the repository with the dangling
alternate will then be bad (until the objects reappear one way or
another), so perhaps you just want a cron job to `git fetch` or `git
remote update -p` in your local repository every so often.  Then you
can just `git merge` or `git rebase` to get the latest changes instead
of `git pull [--rebase]`.  This is really the simplest solution.  No
extra repositories, no configuration changes, just straightforward git
operations.  The only trick would be race conditions between you (as a
human) reviewing the latest changes and then typing the command to
merge/rebase them into your local branch and the cron job updating the
remote=E2=80=94seeing what happened afterwords would of course work.  I=
 would
probably try this first and only start using the others if this became
problematic for some reason.

None of these cases specifically handles trying to automate pushes,
mostly because it cannot always be automatically resolved (and
depending on local standards on running test suites before any change
is pushed, perhaps should not ever be automatically resolved even for
trivial conflicts) if changes appear on the real upstream between your
last pull and your next push.

Could it be done?  Sure.  You can push to your local upstream and then
have it push out automatically, but if there are conflicts you will
need to deal with them, and I would suggest doing so with a bare
repository, essentially by having a static preference for the
real-upstream's changes and have the cron job send mail to you telling
you to re-pull and re-push if it failed to push out due to the remote
having changed (telling you the ref/SHA1 that it failed to push).

Of course, this isn't *that* different from just sticking a `git push`
into the background which sends mail/notifies if the push failed for
some reason, and again doing so would be much easier than an
intermediary repository solution.

    But with git, I can't push unless the cache repository is bare,
    but if the cache repository is bare, then a change to the central
    repository will cause the two to become wedged since neither can
    push or fetch the other.

Not strictly speaking true.  By default git will forbid pushes to
non-bare repositories (see receive.denyCurrentBranch in man
git-config) since without special automation the working directory
will get out of date.  See http://bare-vs-nonbare.gitrecipes.de/ for
more information.  However, I cannot think that having to perform
integration in this second repository would actually work.

    It seems that git is allergic to the dual head branch solution or
    something, which is surprising and disappointing.

Git tracks your version of master separately from each other remote's
master.  This is exactly dual/multiple heads.  What git *does* forbid
(by default) is:

1: Letting you update someone else's checked out (non-bare) repository
underneath them

2: Letting you update someone else's repository if they have more
recent changes than you do.

Both of these defaults are really good ideas, but you can disable them
if you think you know better.

					-Seth Robertson
