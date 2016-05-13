From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/5] pathspec: move long magic parsing out of prefix_pathspec
Date: Fri, 13 May 2016 16:13:24 -0700
Message-ID: <20160513231326.8994-4-sbeller@google.com>
References: <20160513231326.8994-1-sbeller@google.com>
Cc: pclouds@gmail.com, gitster@pobox.com, git@vger.kernel.org,
	Jens.Lehmann@web.de, jrnieder@gmail.com,
	Stefan Beller <sbeller@google.com>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Sat May 14 01:13:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1MHD-0008KZ-Qv
	for gcvg-git-2@plane.gmane.org; Sat, 14 May 2016 01:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753552AbcEMXNj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 19:13:39 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36229 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753511AbcEMXNi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 19:13:38 -0400
Received: by mail-pf0-f175.google.com with SMTP id c189so48447893pfb.3
        for <git@vger.kernel.org>; Fri, 13 May 2016 16:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9HLC0E7cJRe1hhdxydKKTfiAlPzOqgTzCkcC9K30xuM=;
        b=bgZJCHtqKjB3SehkjHDMEJ5zfi1OFZNugoF5re+UULbveidmhtxHLB2zt/2gf/K6Qo
         WA2b2bq0bM4NbYRw/pAIiJPIOBKIiCmD3zzIIcB5Eh9IF/Y3zDWtZs5dGRKrfnDKJePA
         OaI4YGRYYLQOmUggNeeJKoMYPvmjdPJ4CnH3oy6n8j2dzxNKx33PGH5bdJl+VwglcswK
         RsTWyz9wPcfyqVDYMD26fUQEwal7MCerEatEuSv8mrDLMKRjFTFlWkQTYzGdiVYOziCw
         kfyYlqoStywYo3lis0EknKe7WyEIu9e7ga/Hw+66qTauzr2eVCyT6Ro8UvzZiOKCuO4R
         apjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9HLC0E7cJRe1hhdxydKKTfiAlPzOqgTzCkcC9K30xuM=;
        b=VU4tOTaJaiX/2ocFrcTAT2nQjiiH9JF3sfd3GunaTjeGFVk8k6K/nVD/hDYrd5V0g4
         5lNbpN8HMUjHjj8lMUDgk45zuQn42QjdWZMPil2ikKVJI5uqIsO2y6z19T//Df67iXZW
         sqyFqVyLrauihfm920NZvp5ydrnX5YtM3n5dSBB15Un7r5ZowNC9vVeycpdGjA3RPjei
         HUxJC3pVFEKtyfooDzfj0PYopD/wvl2baXirhN/rsvGmFBY1x7lMFVJjX766A27x92WI
         jhZ7W7iPgczLX2+7JSflJamRFSod+fQvyc4OoDZzn9BaKBucna69oKt5EQozNeA++MyC
         cTsQ==
X-Gm-Message-State: AOPr4FVtfAKaUL5R6S2cmyBOWZ1KXRTSAkCRc3X/hIOSINAljYZInLUTrpQObRrTcMrCVITJ
X-Received: by 10.98.18.80 with SMTP id a77mr26710384pfj.27.1463181217191;
        Fri, 13 May 2016 16:13:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:e84e:cb12:277e:4f09])
        by smtp.gmail.com with ESMTPSA id lz5sm29869593pab.34.2016.05.13.16.13.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 13 May 2016 16:13:36 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.401.g6647087.dirty
In-Reply-To: <20160513231326.8994-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294595>

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
2.8.2.401.g6647087.dirty
