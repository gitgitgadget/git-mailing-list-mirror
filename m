Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9456F2035F
	for <e@80x24.org>; Fri, 28 Oct 2016 18:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034401AbcJ1S4w (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 14:56:52 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34499 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034315AbcJ1S4W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 14:56:22 -0400
Received: by mail-pf0-f170.google.com with SMTP id n85so41596961pfi.1
        for <git@vger.kernel.org>; Fri, 28 Oct 2016 11:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tuRVixOSEMuSRQoFsLmDUd9jdK4IrJPGc9A3Y5e+vbY=;
        b=Zfhv5eggmpjvsxDnOZiSxOU1BRldc0Td5SG9a0nf7ByDv7rWlOo/f8mqQbY7fVlexO
         mCm1lgNQ6pVJCq3k/sy8aDq/qExJh73gc9krsfz934kn20inAl1UzorIRleW0Ah/fhQx
         mQYxDoh00S3j2Pvhdp2l5QpSJOIDRbX/B6vEiDrFcyjgOuRj8L3ZHjQVauvXJamO3Mfq
         J24dYo3h17W1/5O3IdHpzLksK4hN4NcJp9TtJQ5mCV4GlfgW9dibvyR2+54mrVoxG6PB
         s6TKfo8Bvc8n0wGAOMNpuQNyrTBmIhn7WAC6EwtQuarMMfHqwErPtY9r6RKWSB9IZ3vm
         aR6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tuRVixOSEMuSRQoFsLmDUd9jdK4IrJPGc9A3Y5e+vbY=;
        b=ELxNeLNarc9X9mlXC5JLwmGxg+ey5CZ+OD6Inn8VEeG2/ifE9EXfLDbeAa0s9a0ElN
         DPnOyaHdbRWL9sgIHY9uuj8G6n+Ag0PsYSj6UD/aZ/Cr2O0xXr0VQTZP4CppfvZsAddz
         iHxO4nM7EtTvxHV/TzySRPAVp78Gvi+FepFfb0Y1XB54h8ozNPhQMeAou/1JoL1CDTUl
         epy8OYfcaSQdKl57fLyAkjfLSeCfy9G9QgMqx+fOj2wZcSCEg6hKy9CYOSHIAZOYM7jC
         wlB65xJehp2jsQi2ttuWlKDQxDUpdrWI41UFyoXeVk0q/idx38XmkYnM0uvjbJESCHqZ
         JKnw==
X-Gm-Message-State: ABUngvc7LYX6NX8j0339P6WINBjvMIY99BTBPg+EJJkMLCfLoNYPuh4uf07Z6z1BVodkZoz2
X-Received: by 10.98.149.149 with SMTP id c21mr27829967pfk.100.1477680980536;
        Fri, 28 Oct 2016 11:56:20 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:91ed:bb99:5319:17e9])
        by smtp.gmail.com with ESMTPSA id bu8sm20570819pab.46.2016.10.28.11.56.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 28 Oct 2016 11:56:20 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     bmwill@google.com, pclouds@gmail.com, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 30/36] pathspec: move long magic parsing out of prefix_pathspec
Date:   Fri, 28 Oct 2016 11:54:56 -0700
Message-Id: <20161028185502.8789-31-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.714.ge3da0db
In-Reply-To: <20161028185502.8789-1-sbeller@google.com>
References: <20161028185502.8789-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`prefix_pathspec` is quite a lengthy function and we plan on adding more.
Split it up for better readability. As we want to add code into the
inner loop of the long magic parsing, we also benefit from lower
indentation.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 pathspec.c | 84 +++++++++++++++++++++++++++++++++++---------------------------
 1 file changed, 47 insertions(+), 37 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index 22ca74a126..ad13556c82 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -88,6 +88,52 @@ static void prefix_short_magic(struct strbuf *sb, int prefixlen,
 	strbuf_addf(sb, ",prefix:%d)", prefixlen);
 }
 
+static void eat_long_magic(struct pathspec_item *item, const char *elt,
+		unsigned *magic, int *pathspec_prefix,
+		const char **copyfrom_, const char **long_magic_end)
+{
+	int i;
+	const char *copyfrom = *copyfrom_;
+	/* longhand */
+	const char *nextat;
+	for (copyfrom = elt + 2;
+	     *copyfrom && *copyfrom != ')';
+	     copyfrom = nextat) {
+		size_t len = strcspn(copyfrom, ",)");
+		if (copyfrom[len] == ',')
+			nextat = copyfrom + len + 1;
+		else
+			/* handle ')' and '\0' */
+			nextat = copyfrom + len;
+		if (!len)
+			continue;
+		for (i = 0; i < ARRAY_SIZE(pathspec_magic); i++) {
+			if (strlen(pathspec_magic[i].name) == len &&
+			    !strncmp(pathspec_magic[i].name, copyfrom, len)) {
+				*magic |= pathspec_magic[i].bit;
+				break;
+			}
+			if (starts_with(copyfrom, "prefix:")) {
+				char *endptr;
+				*pathspec_prefix = strtol(copyfrom + 7,
+							  &endptr, 10);
+				if (endptr - copyfrom != len)
+					die(_("invalid parameter for pathspec magic 'prefix'"));
+				/* "i" would be wrong, but it does not matter */
+				break;
+			}
+		}
+		if (ARRAY_SIZE(pathspec_magic) <= i)
+			die(_("Invalid pathspec magic '%.*s' in '%s'"),
+			    (int) len, copyfrom, elt);
+	}
+	if (*copyfrom != ')')
+		die(_("Missing ')' at the end of pathspec magic in '%s'"), elt);
+	*long_magic_end = copyfrom;
+	copyfrom++;
+	*copyfrom_ = copyfrom;
+}
+
 /*
  * Take an element of a pathspec and check for magic signatures.
  * Append the result to the prefix. Return the magic bitmap.
@@ -150,43 +196,7 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
 	    (flags & PATHSPEC_LITERAL_PATH)) {
 		; /* nothing to do */
 	} else if (elt[1] == '(') {
-		/* longhand */
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
-					magic |= pathspec_magic[i].bit;
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
-		long_magic_end = copyfrom;
-		copyfrom++;
+		eat_long_magic(item, elt, &magic, &pathspec_prefix, &copyfrom, &long_magic_end);
 	} else {
 		/* shorthand */
 		for (copyfrom = elt + 1;
-- 
2.10.1.714.ge3da0db

