Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98F3920451
	for <e@80x24.org>; Tue, 13 Dec 2016 23:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752756AbcLMXWB (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 18:22:01 -0500
Received: from mail-pg0-f41.google.com ([74.125.83.41]:36206 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752674AbcLMXWA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 18:22:00 -0500
Received: by mail-pg0-f41.google.com with SMTP id f188so804855pgc.3
        for <git@vger.kernel.org>; Tue, 13 Dec 2016 15:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X9BPAB3XmnHMXmRfQEWf9f8EC5PTzZLeM6lfcUmHcak=;
        b=gctnBn1KgpEdEIMGCbpLHSqi9ITFq/EDEaFUFY2e6+FXX0shuUXGWYeeSKYQBcUK6s
         PcAvDNGCEqIaYk3Obyv4OphuO5djbioAwvpVNFRplrnP5V7usBN0rdTo0RC8JqPQaOfJ
         9k47khkebRlcthX8rspMW93y20ct5OSjUEF+G9C/dhkprDDy+JDDojKZockRjhdmxSKF
         maUK9o7/fKhJCvh/5rwvLHpZM22CgGH75a2UvemAYbOFmU2KJ9yWIbQ5JdjBtXeRc9P3
         pbk3rPm543aLttzcuk6Q5yJaB1q2lIpbQHpWV888vXJ/kWGZHU6VuOzBuITzz8TW/l/4
         vPHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X9BPAB3XmnHMXmRfQEWf9f8EC5PTzZLeM6lfcUmHcak=;
        b=CQgtqtb5p7mVzZCHSp4shetct+CxhRIMFYvxLOn4w2ziLOCLr81Epo6V6/ha3CS2+N
         XFqlAR8D0mdSFXHBM5Fal0mhjAIks/RrPXVRm0tcwAY95KLrJ+VrTS0ERaTIn7bgO1gZ
         ms5CVtn2poUmGcLahw6aFb+1zqmQmTWavU3jsvxGS/nNJtgWzU59vkyeRFwGWotD5C2r
         Z0PNYP6pLCNyhttIRcVBhWsY8VTo8rxoSjl/VeIclvfbgkZGttUoD8sE0G/xF2y83jJU
         HFJkgkDfWYhDnf7/faCTacmoKkl7oJ3DPN/qYnu/+Pl6eatgb/83GdCCX6vW/ufRwvku
         hqZA==
X-Gm-Message-State: AKaTC03WHaX7zQW4TymFJkXN9gvcX1lXoXzpDk15j06MuPtNiMmY6alXCnVeUSoECIJSECSi
X-Received: by 10.84.204.133 with SMTP id b5mr48343152ple.49.1481670898393;
        Tue, 13 Dec 2016 15:14:58 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id c15sm82308567pfd.36.2016.12.13.15.14.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Dec 2016 15:14:56 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v3 12/16] pathspec: create parse_long_magic function
Date:   Tue, 13 Dec 2016 15:14:26 -0800
Message-Id: <1481670870-66754-13-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481670870-66754-1-git-send-email-bmwill@google.com>
References: <1481223550-65277-1-git-send-email-bmwill@google.com>
 <1481670870-66754-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Factor out the logic responsible for parsing long magic into its own
function.  As well as hoist the prefix check logic outside of the inner
loop as there isn't anything that needs to be done after matching
"prefix:".

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 pathspec.c | 92 ++++++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 57 insertions(+), 35 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index 94ec201..c77be17 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -157,6 +157,60 @@ static int get_global_magic(int element_magic)
 }
 
 /*
+ * Parse the pathspec element looking for long magic
+ *
+ * saves all magic in 'magic'
+ * if prefix magic is used, save the prefix length in 'prefix_len'
+ * returns the position in 'elem' after all magic has been parsed
+ */
+static const char *parse_long_magic(unsigned *magic, int *prefix_len,
+				    const char *elem)
+{
+	const char *pos;
+	const char *nextat;
+
+	for (pos = elem + 2; *pos && *pos != ')'; pos = nextat) {
+		size_t len = strcspn(pos, ",)");
+		int i;
+
+		if (pos[len] == ',')
+			nextat = pos + len + 1; /* handle ',' */
+		else
+			nextat = pos + len; /* handle ')' and '\0' */
+
+		if (!len)
+			continue;
+
+		if (starts_with(pos, "prefix:")) {
+			char *endptr;
+			*prefix_len = strtol(pos + 7, &endptr, 10);
+			if (endptr - pos != len)
+				die(_("invalid parameter for pathspec magic 'prefix'"));
+			continue;
+		}
+
+		for (i = 0; i < ARRAY_SIZE(pathspec_magic); i++) {
+			if (strlen(pathspec_magic[i].name) == len &&
+			    !strncmp(pathspec_magic[i].name, pos, len)) {
+				*magic |= pathspec_magic[i].bit;
+				break;
+			}
+		}
+
+		if (ARRAY_SIZE(pathspec_magic) <= i)
+			die(_("Invalid pathspec magic '%.*s' in '%s'"),
+			    (int) len, pos, elem);
+	}
+
+	if (*pos != ')')
+		die(_("Missing ')' at the end of pathspec magic in '%s'"),
+		    elem);
+	pos++;
+
+	return pos;
+}
+
+/*
  * Parse the pathspec element looking for short magic
  *
  * saves all magic in 'magic'
@@ -218,41 +272,9 @@ static unsigned prefix_pathspec(struct pathspec_item *item, unsigned flags,
 		; /* nothing to do */
 	} else if (elt[1] == '(') {
 		/* longhand */
-		const char *nextat;
-		for (copyfrom = elt + 2;
-		     *copyfrom && *copyfrom != ')';
-		     copyfrom = nextat) {
-			size_t len = strcspn(copyfrom, ",)");
-			if (copyfrom[len] == ',')
-				nextat = copyfrom + len + 1;
-			else
-				/* handle ')' and '\0' */
-				nextat = copyfrom + len;
-			if (!len)
-				continue;
-			for (i = 0; i < ARRAY_SIZE(pathspec_magic); i++) {
-				if (strlen(pathspec_magic[i].name) == len &&
-				    !strncmp(pathspec_magic[i].name, copyfrom, len)) {
-					element_magic |= pathspec_magic[i].bit;
-					break;
-				}
-				if (starts_with(copyfrom, "prefix:")) {
-					char *endptr;
-					pathspec_prefix = strtol(copyfrom + 7,
-								 &endptr, 10);
-					if (endptr - copyfrom != len)
-						die(_("invalid parameter for pathspec magic 'prefix'"));
-					/* "i" would be wrong, but it does not matter */
-					break;
-				}
-			}
-			if (ARRAY_SIZE(pathspec_magic) <= i)
-				die(_("Invalid pathspec magic '%.*s' in '%s'"),
-				    (int) len, copyfrom, elt);
-		}
-		if (*copyfrom != ')')
-			die(_("Missing ')' at the end of pathspec magic in '%s'"), elt);
-		copyfrom++;
+		copyfrom = parse_long_magic(&element_magic,
+					    &pathspec_prefix,
+					    elt);
 	} else {
 		/* shorthand */
 		copyfrom = parse_short_magic(&element_magic, elt);
-- 
2.8.0.rc3.226.g39d4020

