From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH] blame: allow -L n,m to have an m bigger than the file's line count
Date: Tue,  9 Feb 2010 23:27:44 -0800
Message-ID: <1265786864-5460-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 10 08:34:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nf75V-00008C-JW
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 08:34:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752127Ab0BJHeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 02:34:11 -0500
Received: from mail-yx0-f200.google.com ([209.85.210.200]:53580 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751934Ab0BJHeK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 02:34:10 -0500
X-Greylist: delayed 380 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Feb 2010 02:34:10 EST
Received: by yxe38 with SMTP id 38so4930545yxe.4
        for <git@vger.kernel.org>; Tue, 09 Feb 2010 23:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=308FoEmE3z29McU+K54DFGUejd896aU7ojirNTn9smk=;
        b=RYjtc/mKtx1uTY+DES8UFSdKF4L5s00CMFsDMqJyP/ii7d6iTuI1GX55l/EiGUvXut
         wtsY1d/Lq3sNrsdYtcRPCGRXBsyHbAvYH/3+nPLXIGOSY1+dvdmXwDGSgo+ScwutF/az
         hRJw96UAj0wVh/9EH9M4uxgTy5nA3iwuGa2Cc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=kC+GFC5+m1wlzQbL+LIyysKQ8PJn4Y+HrDFpBKEH/W4lh+fgRRmijTKIvwpBgaOBSp
         ro6LNifFBNqFDnz/TFd7BKwLzeEtJmxuARk/WcVcR2sUNu50rSbAEVfdHk7oTgthsiAe
         J50HH7Ux6Fn1aTbPi1uAxjnA8vNPQPeV65xF4=
Received: by 10.101.187.7 with SMTP id o7mr6553213anp.0.1265786867639;
        Tue, 09 Feb 2010 23:27:47 -0800 (PST)
Received: from localhost (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 7sm354609yxg.68.2010.02.09.23.27.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Feb 2010 23:27:47 -0800 (PST)
X-Mailer: git-send-email 1.7.0.rc2.13.g8b233
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139498>

Sometimes I want to blame a file starting at some point and ending at
the end of the file. In my haste I'll write something like this:

$ git blame -L5,2342343 -- builtin-blame.c

and be greeted by a die message telling me that my end range is greater
than the number of lines in the file. Obviously I can do:

$ git blame -L5, -- builtin-blame.c

and get what I want but that isn't very discoverable. If the range is
greater than the number of lines just truncate the range to go up to
the end of the file.

Update the docs to more accurately reflect the defaults for n and m too.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

I realize this is late in the game for 1.7.0 so I'll resend if this
isn't picked up.

 Documentation/blame-options.txt |    4 +++-
 builtin-blame.c                 |    4 +++-
 t/t8003-blame.sh                |    4 ++--
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index 4833cac..620660d 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -9,7 +9,7 @@
 --show-stats::
 	Include additional statistics at the end of blame output.
 
--L <start>,<end>::
+-L [<start>],[<end>]::
 	Annotate only the given line range.  <start> and <end> can take
 	one of these forms:
 
@@ -31,6 +31,8 @@ starting at the line given by <start>.
 This is only valid for <end> and will specify a number
 of lines before or after the line given by <start>.
 +
+Note: if <start> is not given it defaults to 1 and if <end> is not given it
+defaults to the number of lines in the file.
 
 -l::
 	Show long rev (Default: off).
diff --git a/builtin-blame.c b/builtin-blame.c
index 10f7eac..77b7323 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -1962,6 +1962,8 @@ static void prepare_blame_range(struct scoreboard *sb,
 		term = parse_loc(term + 1, sb, lno, *bottom + 1, top);
 		if (*term)
 			usage(blame_usage);
+		if (lno < *top)
+			*top = lno;
 	}
 	if (*term)
 		usage(blame_usage);
@@ -2238,7 +2240,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "contents", &contents_from, "file", "Use <file>'s contents as the final image"),
 		{ OPTION_CALLBACK, 'C', NULL, &opt, "score", "Find line copies within and across files", PARSE_OPT_OPTARG, blame_copy_callback },
 		{ OPTION_CALLBACK, 'M', NULL, &opt, "score", "Find line movements within and across files", PARSE_OPT_OPTARG, blame_move_callback },
-		OPT_CALLBACK('L', NULL, &bottomtop, "n,m", "Process only line range n,m, counting from 1", blame_bottomtop_callback),
+		OPT_CALLBACK('L', NULL, &bottomtop, "[n],[m]", "Process only line range n,m, counting from 1", blame_bottomtop_callback),
 		OPT_END()
 	};
 
diff --git a/t/t8003-blame.sh b/t/t8003-blame.sh
index 4a8db74..0ba150e 100755
--- a/t/t8003-blame.sh
+++ b/t/t8003-blame.sh
@@ -161,8 +161,8 @@ test_expect_success 'blame -L with invalid start' '
 	test_must_fail git blame -L5 tres 2>&1 | grep "has only 2 lines"
 '
 
-test_expect_success 'blame -L with invalid end' '
-	git blame -L1,5 tres 2>&1 | grep "has only 2 lines"
+test_expect_success 'blame -L with invalid end truncates automatically' '
+	git blame -L1,5 tres
 '
 
 test_done
-- 
1.7.0.rc2.13.g8b233
