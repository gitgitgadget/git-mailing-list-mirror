From: Sundararajan R <dyoucme@gmail.com>
Subject: [v3 PATCH 1/2] reset: add '-' shorthand for '@{-1}'
Date: Wed, 18 Mar 2015 13:59:44 +0530
Message-ID: <1426667384-26288-1-git-send-email-dyoucme@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Sundararajan R <dyoucme@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 18 09:30:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YY9Mb-0006vG-UT
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 09:30:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754950AbbCRIaB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 04:30:01 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35387 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753500AbbCRI37 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 04:29:59 -0400
Received: by pabyw6 with SMTP id yw6so35950420pab.2
        for <git@vger.kernel.org>; Wed, 18 Mar 2015 01:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=MBitQM4Pk7j3RVlWwnBTfuETf/xFgEV4DYeizlyQNEw=;
        b=AKjjPkQ3uE7r1/7Us+pduVoOB+r7TlaC/pD3EFbbMHVDjNIsOyEMmuez3BN+i6QodF
         jMg+sroqVDevBE6FmXPd0YydyDufa3b6UPT7UPpVRvKvWA15trMadaJOJoH0TB11FNvS
         iHLSFwP/v44gzk6YwzzjwHMJpMnX29AcWYUe28cLIU3HNqVQ8gKV0qRslSHILAISHbG2
         C9/nEMCCe0Qd+ixbZLqOySqUs4oB5DNEDLcGdnjNXtvZR5m5Cpt6J2LmHp/Ftdky+Aq4
         uXSMFt+OnaV0BFrPkKFor8qzH1n4TYPJrHGTTYcjF7juELaLjvw1PKbWEVn9JzvO/yYZ
         OQyw==
X-Received: by 10.70.48.97 with SMTP id k1mr29586814pdn.159.1426667398578;
        Wed, 18 Mar 2015 01:29:58 -0700 (PDT)
Received: from work.localdomain ([210.212.66.19])
        by mx.google.com with ESMTPSA id om6sm26182731pdb.40.2015.03.18.01.29.56
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Mar 2015 01:29:58 -0700 (PDT)
X-Mailer: git-send-email 2.1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265695>

Teaching reset the - shorthand involves checking if any file named '-' exists.
check_filename() is used to perform this check.

When the @{-1} branch does not exist then it can be safely assumed that the
user is referring to the file '-',if any. If this file exists then it is reset or else
a bad flag error is shown.

But if the @{-1} branch exists then it becomes ambiguous without the explicit 
'--' disambiguation as to whether the user wants to reset the file '-' or if 
he wants to reset the working tree to the previous branch. Hence the program dies
with a message about the ambiguous argument.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Sundararajan R <dyoucme@gmail.com>
---
Thank you Eric and Junio for your patient feedback.
As verify_filename() and verify_non_filename() die and return,respectively when 
passed the argument '-' without actually checking if such a file exists, 
check_filename() has been used to perform this check. I hope it is okay.

 builtin/reset.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 4c08ddc..a126b38 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -192,6 +192,8 @@ static void parse_args(struct pathspec *pathspec,
 {
 	const char *rev = "HEAD";
 	unsigned char unused[20];
+	int file_named_minus = 0;
+	int shorthand = 0;
 	/*
 	 * Possible arguments are:
 	 *
@@ -205,6 +207,12 @@ static void parse_args(struct pathspec *pathspec,
 	 */
 
 	if (argv[0]) {
+		if (!strcmp(argv[0], "-") && !argv[1]) {
+			argv[0] = "@{-1}";
+			shorthand = 1;
+			if(check_filename(prefix, "-"))
+				file_named_minus = 1;
+		}
 		if (!strcmp(argv[0], "--")) {
 			argv++; /* reset to HEAD, possibly with paths */
 		} else if (argv[1] && !strcmp(argv[1], "--")) {
@@ -222,11 +230,20 @@ static void parse_args(struct pathspec *pathspec,
 			 * Ok, argv[0] looks like a commit/tree; it should not
 			 * be a filename.
 			 */
-			verify_non_filename(prefix, argv[0]);
+			if (file_named_minus) {
+				die(_("ambiguous argument '-': both revision and filename\n"
+				"Use '--' to separate paths from revisions, like this:\n"
+				"'git <command> [<revision>...] -- [<file>...]'"));
+			}
+			else if (!shorthand) 
+				verify_non_filename(prefix, argv[0]);
 			rev = *argv++;
 		} else {
 			/* Otherwise we treat this as a filename */
-			verify_filename(prefix, argv[0], 1);
+			if (shorthand)
+				argv[0] = "-";
+			if (!file_named_minus)
+				verify_filename(prefix, argv[0], 1);
 		}
 	}
 	*rev_ret = rev;
-- 
2.1.0
