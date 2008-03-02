From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/5] Builtin "git remote"
Date: Sun, 2 Mar 2008 15:15:00 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0803021511420.22527@racer.site>
References: <alpine.LSU.1.00.0802290144130.22527@racer.site> <7vwsoofrue.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0802282104500.19665@iabervon.org> <alpine.LSU.1.00.0802291118540.22527@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Mar 02 16:16:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVpvK-0003KO-LQ
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 16:16:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804AbYCBPPq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 10:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751651AbYCBPPp
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 10:15:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:59436 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751550AbYCBPPp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 10:15:45 -0500
Received: (qmail invoked by alias); 02 Mar 2008 15:15:43 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp013) with SMTP; 02 Mar 2008 16:15:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19os4szSvBo05OVJXjL7KwuSwc+ISJtCeI9MKxQFp
	0Nlgz5acrvy6Is
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LSU.1.00.0802291118540.22527@racer.site>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75786>

[PATCH] format-patch: use the diff options for the cover letter, too

Earlier, when you called "git format-patch --cover-letter -M", the
diffstat in the cover letter would not inherit the "-M".  Now it does.

While at it, add a few "|| break" statements in the test's loops;
otherwise, breakages inside the loops would not be caught.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Fri, 29 Feb 2008, Johannes Schindelin wrote:

	> On Thu, 28 Feb 2008, Daniel Barkalow wrote:
	> 
	> > On Thu, 28 Feb 2008, Junio C Hamano wrote:
	> > 
	> > > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
	> > > 
	> > > > It also demonstrates that format-patch --cover-letter 
	> > > > should default to -M for the diffstat (search for 
	> > > > "git-remote.perl"...).
	> > > 
	> > > It probably should inherit the settings for the primary 
	> > > part. You did generate the series with -M, especially [PATCH 
	> > > 4/5], didn't you?
	> > 
	> > Obviously not the output_format, but everything else, I 
	> > assume? Easy enough to pass the main diff options into 
	> > make_cover_letter() and use them to initialize the diff 
	> > options there.

	Voila.

	I thought that the changes in the for loops do not merit an own
	patch, but if you think otherwise, let me know, and I'll resend.

 builtin-log.c           |    2 +-
 t/t4014-format-patch.sh |   18 ++++++++++++++----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index bbadbc0..17e491b 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -694,7 +694,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	if (!origin)
 		return;
 
-	diff_setup(&opts);
+	memcpy(&opts, &rev->diffopt, sizeof(opts));
 	opts.output_format |= DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT;
 
 	diff_setup_done(&opts);
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 16aa99d..6d86b7d 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -147,7 +147,7 @@ test_expect_success 'thread' '
 	for i in patches/0002-* patches/0003-*
 	do
 	  grep "References: $FIRST_MID" $i &&
-	  grep "In-Reply-To: $FIRST_MID" $i
+	  grep "In-Reply-To: $FIRST_MID" $i || break
 	done
 '
 
@@ -160,7 +160,7 @@ test_expect_success 'thread in-reply-to' '
 	for i in patches/*
 	do
 	  grep "References: $FIRST_MID" $i &&
-	  grep "In-Reply-To: $FIRST_MID" $i
+	  grep "In-Reply-To: $FIRST_MID" $i || break
 	done
 '
 
@@ -173,7 +173,7 @@ test_expect_success 'thread cover-letter' '
 	for i in patches/0001-* patches/0002-* patches/0003-* 
 	do
 	  grep "References: $FIRST_MID" $i &&
-	  grep "In-Reply-To: $FIRST_MID" $i
+	  grep "In-Reply-To: $FIRST_MID" $i || break
 	done
 '
 
@@ -186,7 +186,7 @@ test_expect_success 'thread cover-letter in-reply-to' '
 	for i in patches/*
 	do
 	  grep "References: $FIRST_MID" $i &&
-	  grep "In-Reply-To: $FIRST_MID" $i
+	  grep "In-Reply-To: $FIRST_MID" $i || break
 	done
 '
 
@@ -201,4 +201,14 @@ test_expect_success 'excessive subject' '
 	ls patches/0004-This-is-an-excessively-long-subject-line-for-a-messa.patch
 '
 
+test_expect_success 'cover-letter inherits diff options' '
+
+	git mv file foo &&
+	git commit -m foo &&
+	git format-patch --cover-letter -1 &&
+	! grep "file => foo .* 0 *$" 0000-cover-letter.patch &&
+	git format-patch --cover-letter -1 -M &&
+	grep "file => foo .* 0 *$" 0000-cover-letter.patch
+
+'
 test_done
-- 
1.5.4.3.510.g7cdd

