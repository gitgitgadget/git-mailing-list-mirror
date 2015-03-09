From: Sundararajan R <dyoucme@gmail.com>
Subject: [PATCH 1/2] Adding - shorthand for @{-1} in RESET command
Date: Tue, 10 Mar 2015 02:16:49 +0530
Message-ID: <1425934010-8780-1-git-send-email-dyoucme@gmail.com>
Cc: Sundararajan R <dyoucme@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 09 21:47:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YV4a1-00044o-8Q
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 21:47:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754096AbbCIUrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2015 16:47:09 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:40873 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753582AbbCIUrH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 16:47:07 -0400
Received: by pdbfp1 with SMTP id fp1so60333532pdb.7
        for <git@vger.kernel.org>; Mon, 09 Mar 2015 13:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=UZsq4knEC+y5r65YmgamZ/5PQtu752bd3IjGFmJHzW4=;
        b=zcdQV4cxJD8+F1j/SD/rwMgIy9KWf7hulRAm0lonKZ9UN8GB4CBGrJ6wpn9ThiW0AV
         uehVL/AqDasBg/mtEZKoxzM2XmW04TBVb3P4zcJGCRSXjCtv2AuLBo8Vp5rr9ikkGXvV
         7WT1Wg0LewQZLCO2qygD7GeRKAxMO2kC+27mfR+kUwBTZwE24oPOMWLntYDjRTrl4fbX
         y5M8XSqCmfcstf9sG2xqqjqB9tIaRWr4uGtaY+TaKpXEGPHcKz3msfD2QSv5dnEnRluK
         +2wDUxQ+JBSzk7LkckqP1zcSWmFhtR671gNmOSPpyXrMEi33yVKv1btvr2J+gMVEiVbu
         3qSA==
X-Received: by 10.70.52.131 with SMTP id t3mr57048130pdo.110.1425934026601;
        Mon, 09 Mar 2015 13:47:06 -0700 (PDT)
Received: from work.localdomain ([210.212.66.19])
        by mx.google.com with ESMTPSA id fi8sm11495520pdb.43.2015.03.09.13.47.04
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Mar 2015 13:47:06 -0700 (PDT)
X-Mailer: git-send-email 2.1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265194>

Please give feedback and suggest things I may have missed out on. 
I hope I have incorporated all the suggestions.

Signed-off-by: Sundararajan R <dyoucme@gmail.com>
Thanks-to: Junio C Hamano
---
I have attempted to resolve the ambiguity when there exists a file named -
by communicating to the user that he/she can use ./- when he/she wants to refer
to the - file. I perform this check using the check_filename() function.

 builtin/reset.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 4c08ddc..2bdd5cd 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -192,6 +192,7 @@ static void parse_args(struct pathspec *pathspec,
 {
 	const char *rev = "HEAD";
 	unsigned char unused[20];
+	int file_named_minus=0;
 	/*
 	 * Possible arguments are:
 	 *
@@ -205,6 +206,12 @@ static void parse_args(struct pathspec *pathspec,
 	 */
 
 	if (argv[0]) {
+		if (!strcmp(argv[0], "-") && !argv[1]) {
+			if(!check_filename(prefix,"-"))
+				argv[0]="@{-1}";
+			else 
+				file_named_minus=1;
+		}
 		if (!strcmp(argv[0], "--")) {
 			argv++; /* reset to HEAD, possibly with paths */
 		} else if (argv[1] && !strcmp(argv[1], "--")) {
@@ -226,7 +233,14 @@ static void parse_args(struct pathspec *pathspec,
 			rev = *argv++;
 		} else {
 			/* Otherwise we treat this as a filename */
-			verify_filename(prefix, argv[0], 1);
+			if(file_named_minus) {
+				die(_("ambiguous argument '-': both revision and filename\n"
+					"Use ./- for file named -\n"
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
