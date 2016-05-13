From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/4] pathspec: move long magic parsing out of prefix_pathspec
Date: Thu, 12 May 2016 17:19:34 -0700
Message-ID: <20160513001936.7623-3-sbeller@google.com>
References: <20160513001936.7623-1-sbeller@google.com>
Cc: pclouds@gmail.com, git@vger.kernel.org, jrnieder@gmail.com,
	Jens.Lehmann@web.de, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri May 13 02:19:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b10pc-0006f2-8x
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 02:19:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbcEMATp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 20:19:45 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:32819 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006AbcEMATo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 20:19:44 -0400
Received: by mail-pf0-f173.google.com with SMTP id 206so36090082pfu.0
        for <git@vger.kernel.org>; Thu, 12 May 2016 17:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HVBjqm9ZWgjLmm3M0SGJtmpfYpcqv8AUuwuzBBXejIw=;
        b=LL92iWFtpc9r3gyUF655K4prbBje34QryeInO1bgDxtgxjcbO2Y+u0iRnqGvhyI8ld
         7rF6Hc0vc8AchOnbKVNFr5lmEApwCmOOrPozoZeDpn69PvQm+IPcL2T25y2B3DARcjQD
         THyNLAxTRE4rbIis4usKv5UHiQ2DceGW76toAvVUqmjCg/9fJRzmsWXKh+4dWkkQVwzd
         6KshZq09LBvxcQN9eEglVqFbH7M0Cvce61iA9bX88TdTxbp4C4cOb9p78yDR4scQ9NbY
         ebLj3SetnB5c/oRa+87uYBDWoZjeP4c4iF0YtZPLxLPS7bkAM4WH6oLVejFk8E3s6vMB
         hDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HVBjqm9ZWgjLmm3M0SGJtmpfYpcqv8AUuwuzBBXejIw=;
        b=fRpHCux0sm1idYUKP74Cc+VTCN5yLcjigVpNfRDyfOEwwJOpzBHitKcGLlRi6sjfT8
         T1OsaAiTA2pW7SSDcPX09OVjvIYdoT9HiZtpTEqpxmaEDVonMjJsHTBMTPoFJiu1ap9G
         Y9NJnp0hG+Ft4UlMSgWr8to2O5WjHUrQW3S1ux1ETFNw1PcaSHCiWKELuub/dF+Yy0QC
         Qb5rfHYPiToaXfXHHBlmnQ/uk8xxHWtyg/qScmW11dStUZvfjKaCoP/0qTauFpvw2UiX
         KdpmGuHtg4zfYPHJJ0RuAKD9r/wZw7leov7q8cuqBmYzem/tQdxdKbI0i1Fwq5ggCft3
         Y25Q==
X-Gm-Message-State: AOPr4FX/kqw7dQk4GcoHzCvdW6SxavXxCskTEaTs9IAwAmG/mjyaGmEYk1MiJngCdiiXnxHD
X-Received: by 10.98.38.130 with SMTP id m124mr18355277pfm.14.1463098783090;
        Thu, 12 May 2016 17:19:43 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:c9fc:8b37:8cb7:4400])
        by smtp.gmail.com with ESMTPSA id m86sm14760486pfj.77.2016.05.12.17.19.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 12 May 2016 17:19:42 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.400.g8bfb85c.dirty
In-Reply-To: <20160513001936.7623-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294492>

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
2.8.2.400.g66c4903.dirty
