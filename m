Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61CA520756
	for <e@80x24.org>; Wed,  4 Jan 2017 18:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965789AbdADSEv (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jan 2017 13:04:51 -0500
Received: from mail-pg0-f52.google.com ([74.125.83.52]:35366 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761464AbdADSEh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2017 13:04:37 -0500
Received: by mail-pg0-f52.google.com with SMTP id i5so164989056pgh.2
        for <git@vger.kernel.org>; Wed, 04 Jan 2017 10:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t1+qiqamjOXrOm+FSea4YrST+xoEK1kwl64YcQ4TPPg=;
        b=DfunJeLbm53LpRbdi8Nt20zYHocaWGq2yvpPhdbqx2HInp/3ZGEMjOHW8oD3w5UHRq
         hQQJ7M75f2tydn8cGN8IejNzUbk8bzfkO/w0J7Yj11qXlDLh16gc21P+FGrvt82hrgxw
         ZURVhW17V8zJBLqs/0Dz7eir3/tTyX0kf0BfGx9vMRrFNms9O00QgDxIlC0VVZyVNUWI
         9YrRaqAOaa5k7RCqIHodmVyme4LHkkEKJqQsb/Fp+it+J40uGs44KE+6p16mgeVITCyC
         pNsbRsr3OLnnDY1e+hQKIPokg/i4m5dBaJPS6TgeC4yiyxINkaeKMuDKP6KpobdbltUN
         pkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t1+qiqamjOXrOm+FSea4YrST+xoEK1kwl64YcQ4TPPg=;
        b=eK3PkVgI6GH89MQ8wRKxNMejPGaeDs7FswMZur/JBV0EWcW9lobsYN0qokKgwmj91J
         cqzmqjxFiwIAE+cpzne3T3JORuccczF0Fbd/v5S+mOSn7GTgO3ty74WKvuAZrr6bE6+X
         WKmKpY1fSzDnS8q/Qs1W8UjgSmt9P+FEBEIlTH9VLErjI8WBn73xwtwVZjVMBLSCjm+w
         GYuaM7e5dygts+mocFnKfA7YZ5r587bXnyjiQKujaMyv+fNYof676lJovsNeSGsoA7cf
         0AXd49oP5P7riEkNbpecXemA6n04VG44+v91ALzOvm+xAuhO+r2JHYLOIqOFCxlJ9tc6
         lwEg==
X-Gm-Message-State: AIkVDXIL5GNE8x/BFzhpqvPNvh/s+Pat04bbxwsm9w10Z5uTIBu8IaP4mNBr+PkT10fuSKJo
X-Received: by 10.98.74.142 with SMTP id c14mr63470546pfj.139.1483553076814;
        Wed, 04 Jan 2017 10:04:36 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id o68sm148337150pfb.42.2017.01.04.10.04.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Jan 2017 10:04:35 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v5 12/16] pathspec: create parse_long_magic function
Date:   Wed,  4 Jan 2017 10:04:07 -0800
Message-Id: <20170104180411.150000-13-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170104180411.150000-1-bmwill@google.com>
References: <20170103184241.128409-1-bmwill@google.com>
 <20170104180411.150000-1-bmwill@google.com>
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
index 1b0901848..f6356bde1 100644
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
2.11.0.390.gc69c2f50cf-goog

