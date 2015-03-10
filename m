From: Sundararajan R <dyoucme@gmail.com>
Subject: [v2 PATCH 1/2] reset: add '-' shorthand for '@{-1}'
Date: Tue, 10 Mar 2015 21:08:02 +0530
Message-ID: <1426001883-6423-1-git-send-email-dyoucme@gmail.com>
Cc: Sundararajan R <dyoucme@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 10 16:38:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVMEl-0003qs-OD
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 16:38:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752489AbbCJPiX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 11:38:23 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:33491 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752183AbbCJPiW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 11:38:22 -0400
Received: by pdev10 with SMTP id v10so3210575pde.0
        for <git@vger.kernel.org>; Tue, 10 Mar 2015 08:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=TQmrg1dtL3PoQW5ugv/Nd/XxriWo0L0xxVuFizLQf4c=;
        b=JLy9nxbr7eZit/BIjn9JHsctLXsECUg5n2KCJZyGYs/mQbcIIYRXZ0Yg4UWsWSTePL
         kMaiUA5RPMrx/gXeeuATAWbt5U/ZM4f7q+Z+SdqlPJkaae3pJIEZKyAWROe+BuYxTURs
         li1xNx0SGUWTgKXa5+xTdRT8+fIK13rQ3ORk04SYFDtke49oACHJjpFQSvIAL19QETlC
         N8nwC+JAj8ezE5tASsjF2eRHzvQi0ckPbRXkYAxA0sP/Tc00+S6OEjzucc5V9bRQ9FG6
         AS2m3xDpw3vFPMnIxQQy1Gclvb71WA1EpZnkN1WgleRNwqJvSD+Vdef9vIocuQACeWy4
         Xlqw==
X-Received: by 10.66.154.162 with SMTP id vp2mr66456324pab.73.1426001902125;
        Tue, 10 Mar 2015 08:38:22 -0700 (PDT)
Received: from work.localdomain ([210.212.66.19])
        by mx.google.com with ESMTPSA id g11sm1641012pat.24.2015.03.10.08.38.19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Mar 2015 08:38:21 -0700 (PDT)
X-Mailer: git-send-email 2.1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265240>

Teaching reset the - shorthand involves checking if any file named '-' exists 
because it then becomes ambiguous as to whether the user wants to reset the
file '-' or if he wants to reset the working tree to the previous branch.

check_filename() is used to perform this check. A similar ambiguity occurs 
when the file @{-1} exits. Therefore, when the files '-' or '@{-1}' exist 
then the program dies with a message about the ambiguous argument.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Sundararajan R <dyoucme@gmail.com>
---
Have made the modifications suggest by you, Eric.
Removed the part where the user is told that he can use ./- instead.

 builtin/reset.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 4c08ddc..88ce0c5 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -192,6 +192,7 @@ static void parse_args(struct pathspec *pathspec,
 {
 	const char *rev = "HEAD";
 	unsigned char unused[20];
+	int file_named_minus = 0;
 	/*
 	 * Possible arguments are:
 	 *
@@ -205,6 +206,12 @@ static void parse_args(struct pathspec *pathspec,
 	 */
 
 	if (argv[0]) {
+		if (!strcmp(argv[0], "-") && !argv[1]) {
+			if (!check_filename(prefix, "-"))
+				argv[0] = "@{-1}";
+			else
+				file_named_minus = 1;
+		}
 		if (!strcmp(argv[0], "--")) {
 			argv++; /* reset to HEAD, possibly with paths */
 		} else if (argv[1] && !strcmp(argv[1], "--")) {
@@ -226,7 +233,13 @@ static void parse_args(struct pathspec *pathspec,
 			rev = *argv++;
 		} else {
 			/* Otherwise we treat this as a filename */
-			verify_filename(prefix, argv[0], 1);
+			if (file_named_minus) {
+				die(_("ambiguous argument '-': both revision and filename\n"
+					"Use '--' to separate paths from revisions, like this:\n"
+					"'git <command> [<revision>...] -- [<file>...]'"));
+			}
+			else
+				verify_filename(prefix, argv[0], 1);
 		}
 	}
 	*rev_ret = rev;
-- 
2.1.0
