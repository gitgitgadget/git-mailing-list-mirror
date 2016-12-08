Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F6781FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 18:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932407AbcLHS7s (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 13:59:48 -0500
Received: from mail-pg0-f44.google.com ([74.125.83.44]:34346 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932140AbcLHS7m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 13:59:42 -0500
Received: by mail-pg0-f44.google.com with SMTP id x23so176765657pgx.1
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 10:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7bN374UBr49j16yMj0BlwNxWRM3DCE6hKx5D9ep3wyk=;
        b=h6L91+TEdMkfqWX1VDpgvqZWBDprOsdaBIPHiQWm+hruLARKFxvBLXib8azUxCG+1F
         uJaE64ZD9+wtp0EjFuoRvJUD/TwK0GAh+n48fEtBMlP5Jte6bDRgDOJn346bIQpCemzG
         ae0jZ0/k0RIrz2Lz31rWfTmPHTbxEiGU9PlkHMbvaCTfh+TaWA38y9ITMP9rV+ALuvRV
         AksZATSrd6ZHxxDREQTBYH1fzCeFTVTQy2CWfn7OFLqgANsVJdTvL6WTm8Y1nSfUM5aG
         E8eV/FNItzljIK4YgBzdynQIDGNmNgYitSAESj5iQcKfNgPdn9cJusVok6xPM8puu/5g
         15Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7bN374UBr49j16yMj0BlwNxWRM3DCE6hKx5D9ep3wyk=;
        b=K3m/eGjpPZSZi7LvmHYQZByEJ9VywiAEcKylRG8Dmh40QmwK0644dmTCv9XOoAqsnD
         qtOWFtVpi1ZhF5e3C3pT4s7hzYtl8bEMeyy2zfN93KU71OBMJ7uwogRvyKK/XC6lqTEK
         wfqE4Ywvz35k90oaFTy1qb1cqpullf4A6oBELLTXRFr4XI0FIi/2i0C8LPmWrJhBRe90
         Sw0HbKODmsdV2Nsy8rPwfGXJQ3lmn/oKyLv2aTznORcQmPVj2vUAwtJVCWEceZgoiRrs
         6LNBHj77d6JIpY28qtOVgCrPHsQlam79susj7lVxwv41dWm1DyKPYoHAmIFrVqLYQ2/c
         IzXA==
X-Gm-Message-State: AKaTC01pkMT68cxMorbiX2sdlETSKcR3A7e4SYPBxEyWZiJRAW1Ez0EnnX3dmikwsvBgmrXv
X-Received: by 10.98.74.142 with SMTP id c14mr76643477pfj.139.1481223581111;
        Thu, 08 Dec 2016 10:59:41 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id p64sm51815634pfi.88.2016.12.08.10.59.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Dec 2016 10:59:40 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v2 12/16] pathspec: create parse_long_magic function
Date:   Thu,  8 Dec 2016 10:59:06 -0800
Message-Id: <1481223550-65277-13-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481223550-65277-1-git-send-email-bmwill@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
 <1481223550-65277-1-git-send-email-bmwill@google.com>
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
index 29054d2..6e9555e 100644
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

