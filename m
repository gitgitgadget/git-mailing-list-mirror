From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv7 3/5] pathspec: move long magic parsing out of prefix_pathspec
Date: Wed, 18 May 2016 12:02:20 -0700
Message-ID: <20160518190222.28105-4-sbeller@google.com>
References: <20160518190222.28105-1-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed May 18 21:02:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b36k1-0002BJ-5t
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 21:02:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753970AbcERTCk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 15:02:40 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35572 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752272AbcERTCh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 15:02:37 -0400
Received: by mail-pf0-f171.google.com with SMTP id b66so596689pfb.2
        for <git@vger.kernel.org>; Wed, 18 May 2016 12:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dzAcR9vMGe9Cnu4nNTboSG6BU/xw55Q5yzR0EuG9NYk=;
        b=exrCyz8I1RVicI7t1j/8n0g/IsIQrHs/R6hIVyT9UYN39tCWwFz4ZftjyoYzQ6/0WP
         Kb0kRk0IZeKjHjkNik5HCMzt4l2MKm6DavtPE2ChXxFrXTEoA12KfMUkhELXMojhDY2N
         6rZaKMf1pDAGXn3NuDvV4bMWlmq4Yr9E/ebyArPoGnq5jsYfcXl413wRWKJovf4xVgfX
         mceWoE9fLxLs5SrilhRwtcyapBwphCuCYkI4sWPMeT4dDiqZwPvnq5gIbFHRXdO/Ip21
         MOOrgUxcgbEyQkRh5ei98ZcLS7MNwdMA039LU7xa+gxT4tqIhlm9oj8tnEI74LP47gFR
         95Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dzAcR9vMGe9Cnu4nNTboSG6BU/xw55Q5yzR0EuG9NYk=;
        b=Ui99zxQpTwe0Ljt+62MbXcB+MHc8wYh4HLuKnsBXKd1lKANLGcfgDJY4uYqe3t7FJC
         omJK+4gWQorIsEFrqoZp5602Rlg02E30/qTrkF8k2tnxZ6SDJqPfMTne295sBfsZeac+
         r1ZWcWh4dWT4/2SJhkuhFOd53WwsJARzcN3j/7saTrx/FTUIAG38YHzjFLktwFrXbZIs
         uEpul7u/LGSrpiWg5HGU6UjXDI4ylA21InD8jfnaFaH37C7Fk0zvHZSlZsIrlEl1pGu5
         smBfwGgBZ2DPlx4EH6JFyEhFpMSATVQVsJlx/35KdujXsnMu7zegFRx2FPy8XI3Vw05/
         daSQ==
X-Gm-Message-State: AOPr4FXtM4nE1AHr6iNgd7wyKAl1B/tbkgPxhw2ailSu9pi8RfWuGNAb0PX7KGYF7SuCRPXE
X-Received: by 10.98.2.14 with SMTP id 14mr13228370pfc.148.1463598151632;
        Wed, 18 May 2016 12:02:31 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:d468:afb3:b0f0:947e])
        by smtp.gmail.com with ESMTPSA id b64sm14013936pfa.48.2016.05.18.12.02.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 18 May 2016 12:02:30 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.121.ga97fb08
In-Reply-To: <20160518190222.28105-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294991>

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
2.8.2.121.ga97fb08
