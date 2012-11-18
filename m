X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/4] pathspec: do exact comparison on the leading non-wildcard part
Date: Sun, 18 Nov 2012 16:13:07 +0700
Message-ID: <1353229989-13075-3-git-send-email-pclouds@gmail.com>
References: <1353229989-13075-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sun, 18 Nov 2012 09:13:24 +0000 (UTC)
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ZVyjKiMfOhfAm2ANo708yugNImmUY+J8DexzIbwYpZs=;
        b=v0Shap1ttGfAsaHCFr3t30rjepQiH70hZDC78r/HKcdVPd7xlu6dXJZe0YbRWe8Qad
         V6a3EMZgVdels5Cjr42A9mB3Y1Of0I55F07DGJ5WGdL3+4cWSllXso5t7cOqA99kbnF5
         2aPS3ViihfIMvirKt98nU33L/Rh5rxJZcHfdPaPtFXqNFctdsjSdfAg8MPwEck1y9Dvy
         Whh/6qf96ITn7wwtPa04YiK8Xgcopn6TxRKhm5YBr2zaZAiQp4Zymv0d92VmnZDGgd50
         ZyrZT0vctSyvNEjmoAvbHb86h00vj+XMqY2I6Azsp4f0yUT4EFb9e/aCZ8ObmhZqcyx1
         8nFQ==
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1353229989-13075-1-git-send-email-pclouds@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210000>
Received: from vger.kernel.org ([209.132.180.67]) by plane.gmane.org with
 esmtp (Exim 4.69) (envelope-from <git-owner@vger.kernel.org>) id
 1Ta0wX-0005us-UI for gcvg-git-2@plane.gmane.org; Sun, 18 Nov 2012 10:13:34
 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751613Ab2KRJNQ convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Nov 2012 04:13:16 -0500
Received: from mail-da0-f46.google.com ([209.85.210.46]:32812 "EHLO
 mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1751569Ab2KRJNO (ORCPT <rfc822;git@vger.kernel.org>); Sun, 18 Nov
 2012 04:13:14 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so313271dak.19 for
 <git@vger.kernel.org>; Sun, 18 Nov 2012 01:13:13 -0800 (PST)
Received: by 10.66.78.169 with SMTP id c9mr27271556pax.30.1353229993617; Sun,
 18 Nov 2012 01:13:13 -0800 (PST)
Received: from lanh ([115.74.37.170]) by mx.google.com with ESMTPS id
 t1sm4162171paw.11.2012.11.18.01.13.10 (version=TLSv1/SSLv3 cipher=OTHER);
 Sun, 18 Nov 2012 01:13:13 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 18 Nov 2012 16:13:21 +0700
Sender: git-owner@vger.kernel.org


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c       | 18 +++++++++++++++++-
 dir.h       |  8 ++++++++
 tree-walk.c |  6 ++++--
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/dir.c b/dir.c
index c391d46..e4e6ca1 100644
--- a/dir.c
+++ b/dir.c
@@ -34,6 +34,21 @@ int fnmatch_icase(const char *pattern, const char *s=
tring, int flags)
 	return fnmatch(pattern, string, flags | (ignore_case ? FNM_CASEFOLD :=
 0));
 }
=20
+inline int git_fnmatch(const char *pattern, const char *string,
+		       int flags, int prefix)
+{
+	int fnm_flags =3D 0;
+	if (flags & GF_PATHNAME)
+		fnm_flags |=3D FNM_PATHNAME;
+	if (prefix > 0) {
+		if (strncmp(pattern, string, prefix))
+			return FNM_NOMATCH;
+		pattern +=3D prefix;
+		string +=3D prefix;
+	}
+	return fnmatch(pattern, string, fnm_flags);
+}
+
 static size_t common_prefix_len(const char **pathspec)
 {
 	const char *n, *first;
@@ -230,7 +245,8 @@ static int match_pathspec_item(const struct pathspe=
c_item *item, int prefix,
 			return MATCHED_RECURSIVELY;
 	}
=20
-	if (item->nowildcard_len < item->len && !fnmatch(match, name, 0))
+	if (item->nowildcard_len < item->len &&
+	    !git_fnmatch(match, name, 0, item->nowildcard_len - prefix))
 		return MATCHED_FNMATCH;
=20
 	return 0;
diff --git a/dir.h b/dir.h
index f5c89e3..4cd5074 100644
--- a/dir.h
+++ b/dir.h
@@ -139,4 +139,12 @@ extern int strcmp_icase(const char *a, const char =
*b);
 extern int strncmp_icase(const char *a, const char *b, size_t count);
 extern int fnmatch_icase(const char *pattern, const char *string, int =
flags);
=20
+/*
+ * The prefix part of pattern must not contains wildcards.
+ */
+#define GF_PATHNAME 1
+
+extern int git_fnmatch(const char *pattern, const char *string,
+		       int flags, int prefix);
+
 #endif
diff --git a/tree-walk.c b/tree-walk.c
index af871c5..2fcf3c0 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -627,7 +627,8 @@ enum interesting tree_entry_interesting(const struc=
t name_entry *entry,
 				return entry_interesting;
=20
 			if (item->nowildcard_len < item->len) {
-				if (!fnmatch(match + baselen, entry->path, 0))
+				if (!git_fnmatch(match + baselen, entry->path,
+						 0, item->nowildcard_len - baselen))
 					return entry_interesting;
=20
 				/*
@@ -652,7 +653,8 @@ match_wildcards:
=20
 		strbuf_add(base, entry->path, pathlen);
=20
-		if (!fnmatch(match, base->buf + base_offset, 0)) {
+		if (!git_fnmatch(match, base->buf + base_offset,
+				 0, item->nowildcard_len)) {
 			strbuf_setlen(base, base_offset + baselen);
 			return entry_interesting;
 		}
--=20
1.8.0.rc2.23.g1fb49df
