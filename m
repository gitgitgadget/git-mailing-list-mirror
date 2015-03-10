From: Sudhanshu Shekhar <sudshekhar02@gmail.com>
Subject: [PATCH v3 1/2] reset: enable '-' short-hand for previous branch
Date: Tue, 10 Mar 2015 16:22:07 +0530
Message-ID: <1425984728-27996-1-git-send-email-sudshekhar02@gmail.com>
Cc: Matthieu.Moy@grenoble-inp.fr, gitster@pobox.com, davvid@gmail.com,
	sunshine@sunshineco.com, Sudhanshu Shekhar <sudshekhar02@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 10 11:52:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVHmS-0002ue-GN
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 11:52:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbbCJKww (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 06:52:52 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:39303 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097AbbCJKwv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 06:52:51 -0400
Received: by pdbft15 with SMTP id ft15so859310pdb.6
        for <git@vger.kernel.org>; Tue, 10 Mar 2015 03:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=cjTXPqdQrDFijLQ5K+ShtyyFYSO6OGMCsB1x5acm3V8=;
        b=DpTJ5tRM527KKFnDZoKccPkyEdLhqoD9Xcb2yXDlnM2BHugzAi312Raov1GjhZRkZ9
         sf7pTTSOjBQUTE1nhJBRT4b2XZFO9plAnGXgMfz+KrNAOkMuO3DHc6RQnuZEGt6uWvet
         3Q73p0ED0sFbdoe3+tVDi6JmDoRYojS+EVlAdKc07efpurervMX9W3NgjRwheQl7aZ2X
         lwtwHxdwASm7lCyDwVaWZ4k/bMMK1RnsXxxZmTC8EL9Cbut/R8i8sHugk2nVcXW5GH+u
         hvn31+1vF13eCRP4HnOK3jGMnpQccRtRxsLkqQyv3ruK7860wB1UR7o2FzVXWZQqMmOu
         /y6g==
X-Received: by 10.70.96.145 with SMTP id ds17mr64376355pdb.153.1425984770818;
        Tue, 10 Mar 2015 03:52:50 -0700 (PDT)
Received: from shekhar-Inspiron-N5110.iiit.ac.in ([14.139.82.6])
        by mx.google.com with ESMTPSA id um16sm453888pab.7.2015.03.10.03.52.47
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Mar 2015 03:52:49 -0700 (PDT)
X-Mailer: git-send-email 2.3.1.279.gd534259
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265226>

'git reset -' will reset to the previous branch. It will behave similar
to @{-1} except when a file named '@{-1}' is present. To refer to a file
named '-', use ./- or the -- flag.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Signed-off-by: Sudhanshu Shekhar <sudshekhar02@gmail.com>
---
Thank you all for your feedback. I have made changes and I hope this patch meets community standards. Please let me know if any further changes are required.

Regards,
Sudhanshu

 builtin/reset.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 4c08ddc..8abd300 100644
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
@@ -222,15 +227,21 @@ static void parse_args(struct pathspec *pathspec,
 			 * Ok, argv[0] looks like a commit/tree; it should not
 			 * be a filename.
 			 */
+			if (substituted_minus)
+				argv[0] = "-";
 			verify_non_filename(prefix, argv[0]);
+			if (substituted_minus)
+				argv[0] = "@{-1}";
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
2.3.1.279.gd534259
