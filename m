From: Sundararajan R <dyoucme@gmail.com>
Subject: [PATCH v4 1/2] reset: add '-' shorthand for '@{-1}'
Date: Fri, 27 Mar 2015 14:34:54 +0530
Message-ID: <1427447095-22851-1-git-send-email-dyoucme@gmail.com>
Cc: Sundararajan R <dyoucme@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 27 10:05:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbQCk-0004dL-2b
	for gcvg-git-2@plane.gmane.org; Fri, 27 Mar 2015 10:05:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753816AbbC0JFV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2015 05:05:21 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:32965 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753254AbbC0JFT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2015 05:05:19 -0400
Received: by pabxg6 with SMTP id xg6so90109157pab.0
        for <git@vger.kernel.org>; Fri, 27 Mar 2015 02:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=mcZ04q2FZLVHvDTaRZ9EQOSi3cVctM7qccP3qEDB/ZM=;
        b=Bw/hYmMvTE/OLMD5AdG8MDzeX2cR6tz+BCsIpfGRaQ1UjlVdTX41jGKPGG0T8h6ZoJ
         SpZppJiarBCcPlnnZc1KvrSnFCTYJ5L53YtMKIoTMYNV1udv7bxGT5xm7KRG6FzEWE9f
         KlhAwsh5yXsOOu5XJ74SMq1ZtPPXYG8+BTGMmOLh5VYNJ//e6z/0kb47bER/0OVFXnU3
         W+maleJjzCjqxI/jsz5gggObDgMPxIFaK7fBAbRvWiKkC03CidlcO/z85PP1qd4ydyN8
         WO1kZ+lrB6Sqk3MZ0QlQEszTrSXhcGOCF1UW02zj01c6+eYTIp1U7/qXVHTJR1VWnwQ4
         IAhg==
X-Received: by 10.70.0.176 with SMTP id 16mr34152883pdf.78.1427447118754;
        Fri, 27 Mar 2015 02:05:18 -0700 (PDT)
Received: from work.localdomain ([210.212.66.19])
        by mx.google.com with ESMTPSA id fm3sm1463962pdb.73.2015.03.27.02.05.16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Mar 2015 02:05:18 -0700 (PDT)
X-Mailer: git-send-email 2.1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266366>

Teaching reset the - shorthand involves checking if any file named '-' exists.
check_filename() is used to perform this check.

When the @{-1} branch does not exist then it can be safely assumed that the
user is referring to the file '-',if any. If this file exists then it is reset.
Otherwise, a bad flag error is shown.

But if the @{-1} branch exists then it becomes ambiguous without the explicit 
'--' disambiguation as to whether the user wants to reset the file '-' or if 
he wants to reset the working tree to the previous branch. Hence the program dies
with a message about the ambiguous argument.

When none of the above cases hold, - behaves like @{-1}.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Sundararajan R <dyoucme@gmail.com>
---
Corrected a minor style error.

 builtin/reset.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 4c08ddc..80dd5d5 100644
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
+			if (check_filename(prefix, "-"))
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
