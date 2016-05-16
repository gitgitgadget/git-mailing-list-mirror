From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 3/5] pathspec: move long magic parsing out of prefix_pathspec
Date: Mon, 16 May 2016 11:05:37 -0700
Message-ID: <20160516180539.4114-4-sbeller@google.com>
References: <20160516180539.4114-1-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Mon May 16 20:06:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2MuQ-0005lN-1s
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 20:06:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754024AbcEPSGW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 14:06:22 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36493 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753348AbcEPSGU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 14:06:20 -0400
Received: by mail-pa0-f43.google.com with SMTP id bt5so66548942pac.3
        for <git@vger.kernel.org>; Mon, 16 May 2016 11:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NsgmQXKd1h0EdGj4HCWEFqZXzSSxsRi/Hi2w+e4sPco=;
        b=cZmluDDTWKAKuZIW2Nut9CBrgxg1EtQL7K1H/1oulJFFRQKAjqC1rUamF56eNPrS8Q
         nU6okTihiv4Ktd4DGyeH0xDPEoqQcr+jnj+hGAmLQzGwYTRzJDJTsBwdCHlKCsHKy3hS
         Hr7lCtZP7G1awdlKsrLsQoYzbVZPVz07U8PvUhNDzPgSrikxqgwyNRcVRXE0iWFOJhBC
         abOcutcsJ1hkdvMTs0hwjT8rRq3mNYqfbfA2VlA39t3lf3UMKvY8sLaiOxosadIM6Tcc
         vl4/D5EZNJ9NidBXGdIMo2IrHxvpHipXH27jgWbU6jhqrVD8czhA5bj1ewI8+4mrCvzM
         EaBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NsgmQXKd1h0EdGj4HCWEFqZXzSSxsRi/Hi2w+e4sPco=;
        b=V5no1Q2L5n+rIVIcldYefh6dKJe6OHTTur2TIs/NswY9ib8TqEilmRLIbEKScP2X5Y
         AF2ArV2X9ZeFEgDBpdSb8bNhBJSN6deQQ7d6XL/qM0U/wJLsGD6yWH1XF9M1nE1cv7tH
         D9Ui3u7J7WjNFm2TAQKvYdsfN5auYVekLKI8Ozvimgh+xgz4gcCmmehN3ohZbYZWt+WO
         HlFmF3dSgQCG4OL7giXw6Ugg4J/PxdCTSDLber8IUoHENyUGpFqehGDw365NrX9V4lDK
         q+WcVQHALoR0l7UnomDYjhvc5nwmZuUBOwr04rvxjsaO2zPxXMuPmVQN/l4d39JwruYE
         Ov5g==
X-Gm-Message-State: AOPr4FVZW4TYx1GilyQB86o8S8PpoyVYvw6bp11pJPLNN8N3yQbgzDL7/HYgp/yK9E1oZIpf
X-Received: by 10.66.152.201 with SMTP id va9mr47298712pab.73.1463421947132;
        Mon, 16 May 2016 11:05:47 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:d9b2:8bac:9e16:6023])
        by smtp.gmail.com with ESMTPSA id pw3sm2954096pac.6.2016.05.16.11.05.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 16 May 2016 11:05:46 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.401.gb49ffe6.dirty
In-Reply-To: <20160516180539.4114-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294771>

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
2.8.2.401.gb49ffe6.dirty
