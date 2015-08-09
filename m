From: Jeff King <peff@peff.net>
Subject: Re: "git pull --rebase" fails if pager.pull is true, after producing
 a colorized diff it cannot apply
Date: Sun, 9 Aug 2015 19:42:39 -0400
Message-ID: <20150809234238.GB25769@sigill.intra.peff.net>
References: <CAP=KgsTp=D1cSPmudDVEe32Q8gHhfSfuL7+V9YGZ65F1ZDUFiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 01:42:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOaEq-0000Vg-DD
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 01:42:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751960AbbHIXmo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2015 19:42:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:42732 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750980AbbHIXmn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2015 19:42:43 -0400
Received: (qmail 24372 invoked by uid 102); 9 Aug 2015 23:42:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 09 Aug 2015 18:42:43 -0500
Received: (qmail 32708 invoked by uid 107); 9 Aug 2015 23:42:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 09 Aug 2015 19:42:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 09 Aug 2015 19:42:39 -0400
Content-Disposition: inline
In-Reply-To: <CAP=KgsTp=D1cSPmudDVEe32Q8gHhfSfuL7+V9YGZ65F1ZDUFiA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275558>

On Mon, Aug 03, 2015 at 05:21:43PM +0200, Per Cederqvist wrote:

> If you run:
> 
>     git config pager.pull true
> 
> in the hope of getting the output of "git pull" via a pager, you are
> in for a surpise the next time you run "git pull --rebase" and it has
> to rebase your work.  It will fail with a nonsensical error message:
> 
> > Applying: First B commit
> > fatal: unrecognized input
> > Repository lacks necessary blobs to fall back on 3-way merge.
> > Cannot fall back to three-way merge.
> > Patch failed at 0001 First B commit
> > The copy of the patch that failed is found in:
> >    /home/cederp/badcolor/repo-b/.git/rebase-apply/patch
> >
> > When you have resolved this problem, run "git rebase --continue".
> > If you prefer to skip this patch, run "git rebase --skip" instead.
> > To check out the original branch and stop rebasing, run "git rebase --abort".
> 
> Using "cat -vet" to look at the problematic patch, you can see that
> there are embedded escape codes that tries to colorize the patch.
> 
> This bug is dependent on the TERM setting.  On my system (Ubuntu
> 14.04) it reproduces if TERM=vt220 or TERM=rxvt-unicode, but not if
> TERM=dumb.  It might depend on the color.diff setting as well, but
> it does reproduce with the default setting.

It looks like the use of a pager is fooling our "should we colorize the
diff" check when generating the patches. Usually we check isatty(1) to
see if we should use color, so "git format-patch >patches" does the
right thing. But if a pager is in use, we have to override that check
(since stdout goes to the pager, but the pager is going to a tty). That
propagates to children via the GIT_PAGER_IN_USE environment variable.

We could work around this by having pull explicitly tell rebase that it
is not using a pager (by unsetting GIT_PAGER_IN_USE). Or by having
rebase tell it to format-patch. But I think the best thing is probably
to teach the low-level "are we going to a pager" check to only say "yes"
if stdout is still a pipe, like the patch below. That lets:

  git format-patch --stdout >patches

do the right thing; it knows that even if a pager is in use, its output
is not going to it, because stdout isn't a pipe.

Unfortunately this does not help:

  git format-patch --stdout | some_program

because it cannot tell the difference between the pipe to the original
pager. I wonder if we could do something even more clever, like putting
the inode number in the environment. Then we could check if we have the
_same_ pipe going to the pager.

diff --git a/pager.c b/pager.c
index 070dc11..5b3b3fd 100644
--- a/pager.c
+++ b/pager.c
@@ -95,9 +95,11 @@ void setup_pager(void)
 
 int pager_in_use(void)
 {
-	const char *env;
-	env = getenv("GIT_PAGER_IN_USE");
-	return env ? git_config_bool("GIT_PAGER_IN_USE", env) : 0;
+	struct stat st;
+
+	return git_env_bool("GIT_PAGER_IN_USE", 0) &&
+	       !fstat(1, &st) &&
+	       S_ISFIFO(st.st_mode);
 }
 
 /*
