From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH] diff: exit(1) if 'diff --quiet <repo file> <external file>' finds changes
Date: Fri, 15 Jun 2012 13:31:03 -0400
Message-ID: <1339781463-13536-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 15 19:31:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfaN4-0000eY-La
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 19:31:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756423Ab2FORb2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jun 2012 13:31:28 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:34221 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756294Ab2FORb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2012 13:31:26 -0400
Received: by gglu4 with SMTP id u4so2542303ggl.19
        for <git@vger.kernel.org>; Fri, 15 Jun 2012 10:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=cVu0/0WY32QSej0gfTLMNdk7DS/CiEcbsPOADWp53I8=;
        b=RZ373u/3xPz/yc1OfX0OSnO5+XIRE74YRl/0eqyO0CYTNGyOMSTA2aOm9o1hPHg9aT
         85BagNEM26MTrQGf32WiYZrEKcjG+NvkFLsNRM01M3uLIA/kkmCd7e6eViofr8mJIvqk
         UdVHging7NOutv5ItZvgKO/3Y0go6lHaq4bP9yQhnlaLdx1PUNRkaItT6KLYTdQGFTAI
         PbVDmkdp6xvyNR8t64Z+9SkInCasRRfWI1u0PgTbwK+P69G1luDdc36L8PNvhPSNVHix
         VfbPMbevGIs3diV9oRdDKAZndoBvL1bc7yO6ya6L9r0G6hGrlYlygXP9I6TzuFnw+5ZD
         //nA==
Received: by 10.43.48.8 with SMTP id uu8mr237992icb.31.1339781485832;
        Fri, 15 Jun 2012 10:31:25 -0700 (PDT)
Received: from localhost (adsl-99-38-69-118.dsl.sfldmi.sbcglobal.net. [99.38.69.118])
        by mx.google.com with ESMTPS id ud8sm2909733igb.4.2012.06.15.10.31.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 15 Jun 2012 10:31:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.rc3.6.g501bf14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200067>

When running 'git diff --quiet <file1> <file2>', if file1 or file2
is outside the repository, it will exit(0) even if the files differ.
It should exit(1) when they differ.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---

This was the least invasive fix that I found.  I considered adding
the following when the '--quiet' option is parsed instead:

+   DIFF_OPT_SET(options, EXIT_WITH_STATUS)
+   DIFF_OPT_SET(options, DIFF_FROM_CONTENTS)


 diff.c                | 5 +++--
 t/t4035-diff-quiet.sh | 5 +++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 77edd50..b1d74fe 100644
--- a/diff.c
+++ b/diff.c
@@ -4432,9 +4432,10 @@ void diff_flush(struct diff_options *options)
 		separator++;
 	}
 
-	if (output_format & DIFF_FORMAT_NO_OUTPUT &&
+	if ((output_format & DIFF_FORMAT_NO_OUTPUT &&
 	    DIFF_OPT_TST(options, EXIT_WITH_STATUS) &&
-	    DIFF_OPT_TST(options, DIFF_FROM_CONTENTS)) {
+	    DIFF_OPT_TST(options, DIFF_FROM_CONTENTS)) ||
+		DIFF_OPT_TST(options, QUICK)) {
 		/*
 		 * run diff_flush_patch for the exit status. setting
 		 * options->file to /dev/null should be safe, becaue we
diff --git a/t/t4035-diff-quiet.sh b/t/t4035-diff-quiet.sh
index cdb9202..e14e676 100755
--- a/t/t4035-diff-quiet.sh
+++ b/t/t4035-diff-quiet.sh
@@ -77,4 +77,9 @@ test_expect_success 'git diff-index --cached HEAD' '
 	}
 '
 
+test_expect_success 'git diff <tracked file> <file outside repo>' '
+	git diff --quiet c /dev/null
+	test $? = 1
+'
+
 test_done
-- 
1.7.11.rc3.6.g501bf14
