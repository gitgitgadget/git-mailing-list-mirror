From: Stefan Beller <sbeller@google.com>
Subject: [RFC-PATCHv6 2/4] pathspec: move long magic parsing out of prefix_pathspec
Date: Mon, 16 May 2016 20:13:51 -0700
Message-ID: <20160517031353.23707-3-sbeller@google.com>
References: <20160517031353.23707-1-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Tue May 17 05:15:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2VTJ-0007NJ-1x
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 05:15:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754505AbcEQDOX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 23:14:23 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35494 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754393AbcEQDOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 23:14:09 -0400
Received: by mail-pa0-f46.google.com with SMTP id gj5so1594405pac.2
        for <git@vger.kernel.org>; Mon, 16 May 2016 20:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wdFLGCnq5h5ezLcbKUQhtGOnliqFrDJoWsjrHP2d6EQ=;
        b=kBDHxBMgI0Y7OFaMZjVuzkuGScYKNzxLRnRD3S2jWFU9p+ciLuGBaVXlWDdYNMpWn4
         TB5h6SX3lhen6IIXh1uWSpw6ATGqH0aqBaLTRY35QqYftREavfTmPNNjRMpWDPma1UWE
         dfj35MT6QFI0YKvz8rX4xZDX+1s+P0X+1MOtrjiQwvWS/oRwequ2N8+1/V2KU2iLcoCK
         1vehSO2MLbiIVw9bR1MCTllbBXo29OQgE5XaohVh/8MxBMiLOXALtB28V/a0qAKAgKq8
         Cs3DPMWE7Tyg/6kdMNt2NbTH5XfHBiOCyRGr/seM6/PDJU0Q9oVJ3ycHDFWUayWiriHb
         VkwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wdFLGCnq5h5ezLcbKUQhtGOnliqFrDJoWsjrHP2d6EQ=;
        b=f3InMWw08/JieA8NzR4Z3x8t5QtGy3E41XkOzeLtUFMBGKMojkf1Mo3OjVtHeBBf5b
         behZluuGo67pRVIbKEeQkAW55AZ0Lo42l8/w1Bk/XOqo3G+j8VT6VaRgYbNiL4EH9hoY
         /rP680Ew4smy3MyMEkpqItdyON4Z1p3TnAB2HfjL5yxdqfRKwubeD3U+y6II22kmDrNT
         Rd9MmjyyGJh9mJ5ZkZCAfY/zs022mhswyJsjEpzpeSj8Z1s+MdYm35GbHX0w2PZSYeMh
         ZUq8GjjUhQTnw1CMExFYs+gowirPvYU9KH2rMx4SsU4fe9KqThJHUPP1qoKxO+4RnNUE
         7iiw==
X-Gm-Message-State: AOPr4FX8CtxhlOlcxUlXwFe/Ja/FbDAx6E9cO6ykcd0KyXc4m2H81mfmiqCD0vPfKo5u0aNo
X-Received: by 10.66.182.161 with SMTP id ef1mr49335879pac.40.1463454841067;
        Mon, 16 May 2016 20:14:01 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:d9b2:8bac:9e16:6023])
        by smtp.gmail.com with ESMTPSA id d184sm508495pfc.27.2016.05.16.20.14.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 16 May 2016 20:14:00 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.401.g9c0faef
In-Reply-To: <20160517031353.23707-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294837>

`prefix_pathspec` is quite a lengthy function and we plan on adding more.
Split it up for better readability. As we want to add code into the
inner loop of the long magic parsing, we also benefit from lower
indentation.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 pathspec.c | 84 +++++++++++++++++++++++++++++++++++---------------------------
 1 file changed, 47 insertions(+), 37 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index c9e9b6c..eba37c2 100644
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
2.8.2.401.g9c0faef
