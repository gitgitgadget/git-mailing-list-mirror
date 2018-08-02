Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F3791F597
	for <e@80x24.org>; Thu,  2 Aug 2018 14:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387570AbeHBQTH (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 12:19:07 -0400
Received: from ao2.it ([92.243.12.208]:54926 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387454AbeHBQTH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 12:19:07 -0400
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1flDv9-0006iD-5m; Thu, 02 Aug 2018 15:45:39 +0200
Received: from ao2 by jcn with local (Exim 4.91)
        (envelope-from <ao2@ao2.it>)
        id 1flDwR-0002hZ-I4; Thu, 02 Aug 2018 15:46:59 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?Daniel=20Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>, Antonio Ospite <ao2@ao2.it>
Subject: [RFC PATCH v2 11/12] dir: move is_empty_file() from builtin/am.c to dir.c and make it public
Date:   Thu,  2 Aug 2018 15:46:33 +0200
Message-Id: <20180802134634.10300-12-ao2@ao2.it>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180802134634.10300-1-ao2@ao2.it>
References: <20180802134634.10300-1-ao2@ao2.it>
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The is_empty_file() function can be generally useful, move it to dir.c
and make it public.

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---
 builtin/am.c | 15 ---------------
 dir.c        | 16 ++++++++++++++++
 dir.h        |  1 +
 3 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 6273ea5195..0c04312a50 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -33,21 +33,6 @@
 #include "string-list.h"
 #include "packfile.h"
 
-/**
- * Returns 1 if the file is empty or does not exist, 0 otherwise.
- */
-static int is_empty_file(const char *filename)
-{
-	struct stat st;
-
-	if (stat(filename, &st) < 0) {
-		if (errno == ENOENT)
-			return 1;
-		die_errno(_("could not stat %s"), filename);
-	}
-
-	return !st.st_size;
-}
 
 /**
  * Returns the length of the first line of msg.
diff --git a/dir.c b/dir.c
index 21e6f2520a..c1f7b90256 100644
--- a/dir.c
+++ b/dir.c
@@ -2412,6 +2412,22 @@ int is_empty_dir(const char *path)
 	return ret;
 }
 
+/**
+ * Returns 1 if the file is empty or does not exist, 0 otherwise.
+ */
+int is_empty_file(const char *filename)
+{
+	struct stat st;
+
+	if (stat(filename, &st) < 0) {
+		if (errno == ENOENT)
+			return 1;
+		die_errno(_("could not stat %s"), filename);
+	}
+
+	return !st.st_size;
+}
+
 static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up)
 {
 	DIR *dir;
diff --git a/dir.h b/dir.h
index f5fdedbab2..e45aa3f459 100644
--- a/dir.h
+++ b/dir.h
@@ -281,6 +281,7 @@ static inline int is_dot_or_dotdot(const char *name)
 }
 
 extern int is_empty_dir(const char *dir);
+extern int is_empty_file(const char *filename);
 
 extern void setup_standard_excludes(struct dir_struct *dir);
 
-- 
2.18.0

