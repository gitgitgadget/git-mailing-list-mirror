From: Sudhanshu Shekhar <sudshekhar02@gmail.com>
Subject: [PATCH 1/2] Teach reset the same short-hand as checkout
Date: Sun,  8 Mar 2015 20:28:39 +0530
Message-ID: <1425826720-5899-1-git-send-email-sudshekhar02@gmail.com>
References: <vpqioeb22y8.fsf@anie.imag.fr>
Cc: Matthieu.Moy@grenoble-inp.fr, gitster@pobox.com,
	Sudhanshu Shekhar <sudshekhar02@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 08 15:59:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUcg2-0000Fy-0t
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 15:59:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752441AbbCHO7a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 10:59:30 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:40849 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824AbbCHO73 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 10:59:29 -0400
Received: by pdbfp1 with SMTP id fp1so51396045pdb.7
        for <git@vger.kernel.org>; Sun, 08 Mar 2015 07:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GQUv3xGbbnb/MZIPmP1Czt2oL/p8raRV8KouI2Z+TK8=;
        b=SpgyvaYAPAq6K4rKXiYwftWQJkGxJ+ZOl1++KMQjZNxV9eLY9nEz8rZbOq9QSrbLuM
         a+VUXS80m8Np3vyd1oRmQ5HIYlE/ahYRu/RqhCwe9qSEBU5EeRUTf3Wt/Hdt/QTiis3f
         TgbDcKxDBa083fiC8Ah1zvVZjKUT9c0PjcnY6zhGUnNx8GODQmxWvYOPwmeJaY6WyRq5
         h0a0aiUOg3QwDA/bFlZSwGnRTWazRlduKPWnQd9URuVlylcO4nJB8En06G0CAyzXjh98
         PlpDjWheKyQJXPkagMYvAJAbSHvMmdt8yo3N0R5McrbsrXs1r2kQfYtqYUkLP3Gbw2LV
         x4ag==
X-Received: by 10.66.97.7 with SMTP id dw7mr43145697pab.56.1425826768822;
        Sun, 08 Mar 2015 07:59:28 -0700 (PDT)
Received: from shekhar-Inspiron-N5110.iiit.ac.in ([14.139.82.6])
        by mx.google.com with ESMTPSA id 1sm6975875pdi.38.2015.03.08.07.59.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 08 Mar 2015 07:59:27 -0700 (PDT)
X-Mailer: git-send-email 2.3.1.168.g0c82976.dirty
In-Reply-To: <vpqioeb22y8.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265090>

"-" now means the previous branch.

Signed-off-by: Sudhanshu Shekhar <sudshekhar02@gmail.com>
Thanks-to: Junio C Hamano, Matthieu Moy, Eric Sunshine
---
Thank you all for your feedback. Please let me know if I am missing out on anything else.


 builtin/reset.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 4c08ddc..02f33ef 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -192,6 +192,7 @@ static void parse_args(struct pathspec *pathspec,
 {
 	const char *rev = "HEAD";
 	unsigned char unused[20];
+	int substituted_minus = 0;
 	/*
 	 * Possible arguments are:
 	 *
@@ -205,6 +206,10 @@ static void parse_args(struct pathspec *pathspec,
 	 */
 
 	if (argv[0]) {
+		if (!strcmp(argv[0], "-")) {
+			argv[0] = "@{-1}";
+			substituted_minus = 1;
+		}
 		if (!strcmp(argv[0], "--")) {
 			argv++; /* reset to HEAD, possibly with paths */
 		} else if (argv[1] && !strcmp(argv[1], "--")) {
@@ -225,12 +230,14 @@ static void parse_args(struct pathspec *pathspec,
 			verify_non_filename(prefix, argv[0]);
 			rev = *argv++;
 		} else {
+			/* We were treating "-" as a commit and not a file */
+			if (substituted_minus)
+				argv[0] = "-";
 			/* Otherwise we treat this as a filename */
 			verify_filename(prefix, argv[0], 1);
 		}
 	}
 	*rev_ret = rev;
-
 	if (read_cache() < 0)
 		die(_("index file corrupt"));
 
-- 
2.3.1.168.g0c82976.dirty
