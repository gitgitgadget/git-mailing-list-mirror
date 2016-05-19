From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv8 3/5] pathspec: move long magic parsing out of prefix_pathspec
Date: Wed, 18 May 2016 18:09:33 -0700
Message-ID: <20160519010935.27856-4-sbeller@google.com>
References: <20160519010935.27856-1-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu May 19 03:10:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3CTQ-00057i-Ak
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 03:10:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752521AbcESBJx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 21:09:53 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:34760 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752329AbcESBJv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 21:09:51 -0400
Received: by mail-pf0-f182.google.com with SMTP id y69so23930086pfb.1
        for <git@vger.kernel.org>; Wed, 18 May 2016 18:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Gkp9vFkaf4qONA0jpWVWVTA3DO/4OF8BphqGUIHPSfo=;
        b=TiaaefQynm8qhgb5e0P/+69Epklvb1IVaPhKXiw+e+R+NKvXKNa3/qcA0OoFEl+TuC
         qkGjS6n/mnuxYSUIqDELACssq2WOw+bTuT4fZlit85jJCIxYa7ZjfrTP0fyI3S3q1JuR
         f8rOaYGsdAf/TyTDe1i8BLo1AOtQ46ae0xZnHTw9vKUocTdslOtE0yhNn4W55L9GwFv2
         EvKRx2zHMFqIa6Lz53SghN4WydQanW0QRdT9OduP/Ru0tAJ98BrR1pBk1V6cevnMTute
         vqe6oVWZrvFAHOotggazKA0lQNENlV4JezwNzaJWaJ9uUSvn3Rx3gJXSqfWRqQDHWOK8
         RdYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Gkp9vFkaf4qONA0jpWVWVTA3DO/4OF8BphqGUIHPSfo=;
        b=e6ggviVjFj2Gzj1p9dckOQGI/q0Ao95kPfO48/7MjzflAC+mYP9VbDVseCWA4MaEuN
         ZIFZgJkWHGlfbzzajkkltRzemNcYDnqrn15eYneYsg+Y5+kfsez6XDZliKol5X5Rrhij
         lfzs51GpsSSmvnrfhMyzR3pPEEh0DT3wGRI33eaA0jEiARF51wFKAuaR2zJfgCkvf0mx
         lHyCuyN6l3mf92ndPwlZcU5euZehi9BoL4YQCVZuAjeQOycllQilL2UoOtBTi1i7YniH
         H9f2ea/inTTdznKFUqowVnWV8V/YiyWotgJqvDoKfWr6hzahaWKTSWll3gLEA7c4MPx1
         +0Zg==
X-Gm-Message-State: AOPr4FX6kAxIulIaD/yiDgLiLpcY58ZK6BseYIs6fWyKD4p1lty/km5a8BEFOPYIaSN7b2bl
X-Received: by 10.98.3.4 with SMTP id 4mr15335744pfd.33.1463620189671;
        Wed, 18 May 2016 18:09:49 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:d468:afb3:b0f0:947e])
        by smtp.gmail.com with ESMTPSA id f67sm14984315pff.62.2016.05.18.18.09.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 18 May 2016 18:09:49 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.123.g3bde101
In-Reply-To: <20160519010935.27856-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295034>

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
2.8.2.123.g3bde101
