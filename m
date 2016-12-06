Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E09491FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 21:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752820AbcLFVxf (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 16:53:35 -0500
Received: from mail-pg0-f51.google.com ([74.125.83.51]:34030 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751895AbcLFVxN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 16:53:13 -0500
Received: by mail-pg0-f51.google.com with SMTP id x23so153560744pgx.1
        for <git@vger.kernel.org>; Tue, 06 Dec 2016 13:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mSRe+b5RVGWu7M+XOLA5gFOSlPJJ5MQLrUwyWYiDmzY=;
        b=BNrqHcddCCSQCadjXNk83mi6LHMu/oZMzcSot3zey1hOFEnhXdW/tQ8zhPvHkG665T
         aWiVctCErIAB6gnkOc3Nq2YA+A/Lext6RPH7FPUI4VCPyFAp/iguA9i+/76a0VmsI2f6
         qv17UvmT2jr0dnxLfsxh0gGcd7krZKl3IK5o1IHljWJdIB/VvFjTCSLHHUNPXm41LAsv
         f4xj5wwUCsUf5p9MHihz5XcwSmK0Zi8M9tugu+vqRR3wBgMQTm9E009ZDLOxURACG5Se
         hfvOsjzUITo8fnvat2Deah+20FYYjxPSkMSPab95SoFkqBsbjCfYbYURV3OjjDdf4nef
         mEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mSRe+b5RVGWu7M+XOLA5gFOSlPJJ5MQLrUwyWYiDmzY=;
        b=Sew1CBi3gi0NchZGajJ0fX3Q2NTfAMwHV4SpqZTJGWnN7GPTpwZ1K6mjpRKOFwxw2A
         fgZnIYr+qvrqohZ1qSuROiZjL3IdBw9UXgH3OdEtYEap83f3QKjxNZoJZsSrg2eYbLm4
         SPGHLCBI3iwooZ2Mg1aqZOjN+ZPIlNQvPnqN9vJHnVh/bywdBsDfl+4EX1DGzbMyoomB
         KrATbOY15PwOn59xIQwFUBlq/zeIPcqADFtsXafgoZV5uyCSaY+930PTPsiV0fhPZgZ1
         uggrSye1gB54atCmVJe+ILk/3b3jAvgLy/vDlfr8YWqKvDCRHDs2y7ueZM09ozN8uLf6
         axNA==
X-Gm-Message-State: AKaTC02jDx+euBzy/7WegjT5bG5Rh0lrfHG8VCIxQMjKVVPnh8nZiXX9NijK+E3pJZymiRCF
X-Received: by 10.99.7.210 with SMTP id 201mr114399954pgh.51.1481061154453;
        Tue, 06 Dec 2016 13:52:34 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id y89sm36940228pfk.83.2016.12.06.13.52.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Dec 2016 13:52:33 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, pclouds@gmail.com, gitster@pobox.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 13/17] pathspec: create parse_long_magic function
Date:   Tue,  6 Dec 2016 13:51:42 -0800
Message-Id: <1481061106-117775-14-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481061106-117775-1-git-send-email-bmwill@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
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
index d4d4839..1d28679 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -156,6 +156,60 @@ static int get_global_magic(int element_magic)
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
@@ -218,41 +272,9 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
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

