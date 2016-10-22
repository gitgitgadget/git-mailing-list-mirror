Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39D0920986
	for <e@80x24.org>; Sat, 22 Oct 2016 23:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965099AbcJVXdf (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Oct 2016 19:33:35 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:32947 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965071AbcJVXdb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2016 19:33:31 -0400
Received: by mail-it0-f51.google.com with SMTP id k64so11506149itb.0
        for <git@vger.kernel.org>; Sat, 22 Oct 2016 16:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/k4Exoyax67rBZoRiRZqlC98zoJUozAqjzCqHBJRBGw=;
        b=n5lJ2gGe/uEPtzwkc3Fr7fwrj9R3PDVeZMiuxWGto1SrPKHpmcjoSTvg1asmXfvh2h
         nUK8VIOoxKc5hXpioOvHqdpFy+x26oPnyIyq24mah2FiP80h0jFXbXw/9CK2ve1EIDDQ
         zvs7NDAzhcJQYc33cFQ6/qn1wxgSf9Qh1QDElAHjrGwRDsI7jSyaQFMPVsSLFfUrV1PI
         ls9+keS0nZJVIpXDjeL5XhPbGFayVgrFehJ+uYmlIw4sIU5aV0iDe35ob44kJVSZU+Cc
         EEgiXQpQjY6oZGM8ocTeKu9YajBl6DJfgmdtrQcytUa9EyJbBqkjo/euHlrrxXdd901K
         lAGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/k4Exoyax67rBZoRiRZqlC98zoJUozAqjzCqHBJRBGw=;
        b=bgO3VtIXTS1OCwJGvnbspsZWLsOg7CLRNt6u2F210vv+se3yuUWDc7aefulPqsqocl
         7iBuKpuwLpnH9tsDtXTWy9mA1nK8PhzIS6bnZnvOdlwcQjmCeRcvLGwAxAGEM0ka1FX1
         xmSExa+Llklb12BikQNGh2WRGeTySXjPhLHEEWVuyYFpwLeZnsCkkfTmYPTsa5q84Y+x
         j2lMbvutBb0VkLLWJeUCwYNfUso7qX8m/vZRKWqYI4AXcdXWda38SHHi2PZtQ1cxH3Vy
         rTmR8QxtGEpbTi0fjQjB142FhC5T8Qh1vW0FJQmZl+gRHvh5HUsSD2jtzzSx6MYQc31i
         L9yQ==
X-Gm-Message-State: ABUngvfgTFs89IH7ds6sMjnaOLSZMkBc/NEtrEtyxhA9Btl+UwaGwuik6RjyVr1UCNnm+Y9Y
X-Received: by 10.107.159.5 with SMTP id i5mr7453710ioe.222.1477179209912;
        Sat, 22 Oct 2016 16:33:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:4ca0:b1d9:cc22:1c7b])
        by smtp.gmail.com with ESMTPSA id m31sm4549258ioi.40.2016.10.22.16.33.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 22 Oct 2016 16:33:29 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 30/36] pathspec: move long magic parsing out of prefix_pathspec
Date:   Sat, 22 Oct 2016 16:32:19 -0700
Message-Id: <20161022233225.8883-31-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.508.g6572022
In-Reply-To: <20161022233225.8883-1-sbeller@google.com>
References: <20161022233225.8883-1-sbeller@google.com>
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
index 86f2b44..67678fc 100644
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
2.10.1.508.g6572022

