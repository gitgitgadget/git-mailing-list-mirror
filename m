From: Sudhanshu Shekhar <sudshekhar02@gmail.com>
Subject: [PATCH v3 1/2] reset: enable '-' short-hand for previous branch
Date: Wed, 11 Mar 2015 03:33:26 +0530
Message-ID: <1426025006-18669-1-git-send-email-sudshekhar02@gmail.com>
References: <CAPig+cSU7X=1Ket8bAXU2JivaSVWw7C_M9ttAhJ_gQur3utsUA@mail.gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, davvid@gmail.com,
	Matthieu.Moy@grenoble-inp.fr,
	Sudhanshu Shekhar <sudshekhar02@gmail.com>
To: sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Tue Mar 10 23:04:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVSFw-000498-67
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 23:04:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752878AbbCJWD7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 18:03:59 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:34808 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689AbbCJWD6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 18:03:58 -0400
Received: by pdno5 with SMTP id o5so5621469pdn.1
        for <git@vger.kernel.org>; Tue, 10 Mar 2015 15:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hhJdyE+9J3MBxrn3+8hcLHRZ9EnhQX84t7TtjGSdCzM=;
        b=whKhX7AZYlQF9bXyo8wCRY/yUUv/Yg0yRtCpbZ8ID22fUbUNNc+WNDx+0UG8wRVi6j
         xSstLHDVzfkfYgwnrbBOqhqCRozb5yBLf1rtEN4vYy9zoaSAnVmA9xIK7bSCi7M1j0db
         hLoUv8h04Gos4TrMDwFVHzrzqyIPg8i4kEj+tM6l59uDBhOi+5UG0ei/yau2+uUkO8AZ
         0gi/4D4jJrPLQfcArNKhUW3q80YSY17Kw3Hf76DBhe3YlFD+L+z1AA3aCn6SQb9UZiGy
         eCegfwnWjku/SLbCgRE5ALaJUW26Ijqv1MOy6HcJapeZLbNnsddtluudjb7xQEbaHK+b
         dyFg==
X-Received: by 10.70.88.41 with SMTP id bd9mr42948201pdb.41.1426025038027;
        Tue, 10 Mar 2015 15:03:58 -0700 (PDT)
Received: from shekhar-Inspiron-N5110.iiit.ac.in ([14.139.82.6])
        by mx.google.com with ESMTPSA id pu9sm2590608pdb.49.2015.03.10.15.03.54
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Mar 2015 15:03:56 -0700 (PDT)
X-Mailer: git-send-email 2.3.1.278.ge5c7b1f.dirty
In-Reply-To: <CAPig+cSU7X=1Ket8bAXU2JivaSVWw7C_M9ttAhJ_gQur3utsUA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265266>

git reset -' will reset to the previous branch. It will behave similar
to @{-1} except when a file named '@{-1}' is present. To refer to a file
named '-', use ./- or the -- flag.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Signed-off-by: Sudhanshu Shekhar <sudshekhar02@gmail.com>
---
Eric, I have added a user_input variable to record the input entered by the user. This way I can avoid the multiple 'if' clauses. Thank you for the suggestion.
I have also removed the unrelated change that I had unintentionally committed. I am sending this patch on the thread for further review. Once both the patches are reviewed and accepted, I will create a new mail for it. Hope that is okay.

Regards,
Sudhanshu

 builtin/reset.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 4c08ddc..b428241 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -192,6 +192,8 @@ static void parse_args(struct pathspec *pathspec,
 {
 	const char *rev = "HEAD";
 	unsigned char unused[20];
+	int substituted_minus = 0;
+	char *user_input = argv[0];
 	/*
 	 * Possible arguments are:
 	 *
@@ -205,6 +207,10 @@ static void parse_args(struct pathspec *pathspec,
 	 */
 
 	if (argv[0]) {
+		if (!strcmp(argv[0], "-")) {
+			argv[0] = "@{-1}";
+			substituted_minus = 1;
+		}
 		if (!strcmp(argv[0], "--")) {
 			argv++; /* reset to HEAD, possibly with paths */
 		} else if (argv[1] && !strcmp(argv[1], "--")) {
@@ -222,9 +228,12 @@ static void parse_args(struct pathspec *pathspec,
 			 * Ok, argv[0] looks like a commit/tree; it should not
 			 * be a filename.
 			 */
-			verify_non_filename(prefix, argv[0]);
+			verify_non_filename(prefix, user_input);
 			rev = *argv++;
 		} else {
+			/* We were treating "-" as a commit and not a file */
+			if (substituted_minus)
+				argv[0] = "-";
 			/* Otherwise we treat this as a filename */
 			verify_filename(prefix, argv[0], 1);
 		}
-- 
2.3.1.278.ge5c7b1f.dirty
