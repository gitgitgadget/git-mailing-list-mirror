From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv9 2/4] pathspec: move long magic parsing out of prefix_pathspec
Date: Thu, 19 May 2016 16:23:21 -0700
Message-ID: <20160519232323.12775-3-sbeller@google.com>
References: <20160519232323.12775-1-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Fri May 20 01:23:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3XI4-0005pv-T7
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 01:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755087AbcESXXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 19:23:34 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33103 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754904AbcESXXc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 19:23:32 -0400
Received: by mail-pf0-f171.google.com with SMTP id 206so34974507pfu.0
        for <git@vger.kernel.org>; Thu, 19 May 2016 16:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fmSroPms5+GGwmLGD1XiRjJEiLQX4mK3RE6Rf+nKEcE=;
        b=F9VznNSfr/BocIOMN0pzniFkQ27xf89Yw17h6cPsTYdqHctKulAqfpEB2FTDn4Gdfb
         nPnMNdobP0V/V14kbWfr96tkYPJ4ITvF9yN8Txg4LGHNC5S/FGKn5mTri/zMNzoxqouN
         u4Fe5oYUJ8r2MSP2PZwHeIP6PH7J/yd1BpSgYDg6g6KrHK4eHrai9/Zjldpy74LpCxsf
         hChUpFn0uYzG1w5Ul75ozy0Q8YoDbAN4kQPi0Te0JTspqR09dQmqLBXFOKo7o8xOv2Qz
         jjsyl1IZ0jjb+lU8Jv/7eBesJEWo+ceG6TBgJ9EsV3X6bGQP5MkiywFlNrC7lUTpiWQB
         T73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fmSroPms5+GGwmLGD1XiRjJEiLQX4mK3RE6Rf+nKEcE=;
        b=ANJxd9xY/8Gzy521b+1DdTsP+GVCuHy05eN48IkJYzP0hMghRCafiy/JLozOCNGu4R
         ufReUw4VdsJpyO5Im1O8c2tj7ICy3UCUCVjfetCrroGfSPXFK07p84pUkqGKIPYKI4J8
         izDyZ4sJddJJiplWRQIDi5QfYXCc+GJqppM4LORp4RB87l0v6qz0HSOHsB5Trhd55Q2o
         bIJATJtb3xBHnR1WcKuY5HOELLqC8weCZKE+KPaoP7M/wUCCU+guSExH269rzCOw1Wsz
         uvrqesGwZdCsEYGVgLoTqeZKIC/WEfchtp8PWsru+gNYC/kqXRbSCEwy82eppQ4rw5gT
         fCIg==
X-Gm-Message-State: AOPr4FVBZ7u1C8n54zshMgBAvTl4NsCi7XYUyWHD0WcthudauF8zWJ0gwPJ1mfOk96ZyD0iu
X-Received: by 10.98.61.83 with SMTP id k80mr9228748pfa.73.1463700211213;
        Thu, 19 May 2016 16:23:31 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:acf4:8121:b728:8fc4])
        by smtp.gmail.com with ESMTPSA id u63sm22290710pfu.18.2016.05.19.16.23.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 19 May 2016 16:23:30 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.123.gb4ad9b6.dirty
In-Reply-To: <20160519232323.12775-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295130>

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
2.8.2.123.gb4ad9b6.dirty
