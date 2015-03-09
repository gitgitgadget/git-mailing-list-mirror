From: Sudhanshu Shekhar <sudshekhar02@gmail.com>
Subject: [PATCH v2 1/2] Teach reset the same short-hand as checkout
Date: Mon,  9 Mar 2015 13:45:35 +0530
Message-ID: <1425888936-23370-1-git-send-email-sudshekhar02@gmail.com>
Cc: Matthieu.Moy@grenoble-inp.fr, gitster@pobox.com, davvid@gmail.com,
	sunshine@sunshineco.com, Sudhanshu Shekhar <sudshekhar02@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 09 09:16:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUsrJ-0001Nt-5x
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 09:16:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509AbbCIIQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2015 04:16:12 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:33951 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751668AbbCIIPu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 04:15:50 -0400
Received: by pdno5 with SMTP id o5so19132130pdn.1
        for <git@vger.kernel.org>; Mon, 09 Mar 2015 01:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=baWHmAYH8WYTQShBqLXwZ8H9pczJBOWvm5zdkbIld24=;
        b=XLfgTEmpAXmcMMqBgE7jwwiinWL3P13bWv4h8d3dAzpixvJrrSSUk09WjJ33zo0WJm
         gi05kBZE9JXPFEllse7yztlO/ujCdWHWM3tMqnpLDrmdd36e7r2lM9WreZohUTomLG0q
         1Atn+BKUwQcuB7tNc9tDve411SL9liOjHOCa+FTL9shSk8sYqKxfXT0gg79EuxQw9Duo
         oV9aC2UsGTM14a3ah1f/fELKrBhggQsIQAt1fsvyADWva3ZhZmSFOSplr/Ef7iQyxEDV
         mQ5GMTB54vNGwOoed6LAweT9Iphey/OLT+kzgv/2QKFeD+SYQjLj75/riiz/0dFukkrD
         pI+w==
X-Received: by 10.66.160.197 with SMTP id xm5mr50995421pab.51.1425888950386;
        Mon, 09 Mar 2015 01:15:50 -0700 (PDT)
Received: from shekhar-Inspiron-N5110.iiit.ac.in ([14.139.82.6])
        by mx.google.com with ESMTPSA id d4sm17782033pdm.50.2015.03.09.01.15.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Mar 2015 01:15:48 -0700 (PDT)
X-Mailer: git-send-email 2.3.1.168.g0c82976.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265136>

"-" now means the previous branch.

Signed-off-by: Sudhanshu Shekhar <sudshekhar02@gmail.com>
Thanks-to: Eric Sunshine, Junio C Hamano, Matthieu Moy
---
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
