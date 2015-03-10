From: Sudhanshu Shekhar <sudshekhar02@gmail.com>
Subject: [PATCH v3 1/2] reset: enable '-' short-hand for previous branch
Date: Wed, 11 Mar 2015 03:42:15 +0530
Message-ID: <1426025535-18857-1-git-send-email-sudshekhar02@gmail.com>
References: <CAPig+cQdSHQTVwOwb9hee6On_Bv4qrh0MhiR-aRDMXqhw5L9wQ@mail.gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, davvid@gmail.com,
	Matthieu.Moy@grenoble-inp.fr,
	Sudhanshu Shekhar <sudshekhar02@gmail.com>
To: sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Tue Mar 10 23:12:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVSO9-0004e0-RP
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 23:12:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752477AbbCJWM3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 18:12:29 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:38799 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752183AbbCJWM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 18:12:29 -0400
Received: by pdbfl12 with SMTP id fl12so5619860pdb.5
        for <git@vger.kernel.org>; Tue, 10 Mar 2015 15:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hhJdyE+9J3MBxrn3+8hcLHRZ9EnhQX84t7TtjGSdCzM=;
        b=i8BFapZTnChSwCg7oBl1IdfpxDAvehKns6zM+9TCsxoCv8ING9sK2lP9fxKKq25y2m
         ja5L22g+liuOte0QIvxqCU/WVMB8CsM7lAbyyImKMLxXKtjZqqPLxVXXiL63aHxBwPGA
         OyS4Io2ohhFq6XjG8gGCJLqqWAzFbnzzKZj+e2Cx8pPlYC7c/LQy1jehirHY0I8xCrOa
         HWhirULLW4t85c1+vU/hnT343cci9WGihdrLvNfNG+lGa2Ff99N3wMkvPDa+5KTvZdG2
         9pkvtToUrpeth0V1N6AFyKFmyZyT1VpwQo3SPJc98kdBq3YGhLgEBEzOMs7pl+NF9eCo
         ZKTQ==
X-Received: by 10.66.101.73 with SMTP id fe9mr71398323pab.156.1426025548446;
        Tue, 10 Mar 2015 15:12:28 -0700 (PDT)
Received: from shekhar-Inspiron-N5110.iiit.ac.in ([14.139.82.6])
        by mx.google.com with ESMTPSA id pm9sm2582373pdb.59.2015.03.10.15.12.24
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Mar 2015 15:12:27 -0700 (PDT)
X-Mailer: git-send-email 2.3.1.278.ge5c7b1f.dirty
In-Reply-To: <CAPig+cQdSHQTVwOwb9hee6On_Bv4qrh0MhiR-aRDMXqhw5L9wQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265269>

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
