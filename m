From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/5] Implement new get_pathspec()
Date: Sat,  9 Apr 2011 23:54:19 +0700
Message-ID: <1302368060-23827-5-git-send-email-pclouds@gmail.com>
References: <1302368060-23827-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Apr 09 18:55:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8bRE-0004sZ-Hv
	for gcvg-git-2@lo.gmane.org; Sat, 09 Apr 2011 18:55:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754895Ab1DIQzA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2011 12:55:00 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33520 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754329Ab1DIQy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2011 12:54:59 -0400
Received: by mail-iy0-f174.google.com with SMTP id 14so4332135iyb.19
        for <git@vger.kernel.org>; Sat, 09 Apr 2011 09:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=hth2+EgS7iES7MrdxWh1z1NX/7JSHKoKUVeV1HQZTho=;
        b=K7qVRJmnr08r65LO5hpX/xcNI/uAY4JqLePHfgoktaGaAIc2U3mQivAvgXxbrTMJzU
         WAn4CqsPKCyMNgwyZquJ6fkKfSxCryXfTbc3cQOGbdsJmINUKNQ0CzmdmjyrZFmv/0ES
         dUPCfeYlS6OFmU2RQ6OOganGwFDxIngAAjkgY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=DO8oa7/Mzyo2++QKc/8ptmaSP+w8tPU+ndsMaquV7+/MbeIEVSoIHNrbjN5bFeqjch
         R2WPcdpyh+Yi7Pgr7dJOL50Mq8Oehb9hsaX6qrVzjjopGF5cwrUT5YU5QVGoyAjRyGld
         rX5OMe1UJkAyhzsAmns2G2BeaLM8AhnCs+sHg=
Received: by 10.43.69.136 with SMTP id yc8mr4988859icb.159.1302368099463;
        Sat, 09 Apr 2011 09:54:59 -0700 (PDT)
Received: from tre ([115.73.238.90])
        by mx.google.com with ESMTPS id c1sm2758352ibe.0.2011.04.09.09.54.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 09 Apr 2011 09:54:58 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Sat, 09 Apr 2011 23:54:52 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1302368060-23827-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171199>

This function is as same as get_pathspec_old() except that it produces
struct pathspec directly.

no_prefix code path is necessary because init_pathspec() can be called
without get_pathspec_old() in "diff --no-index" case. Without this
exception, prefix_path() will be eventually called and die because
there is not worktree.
---
 cache.h |    1 +
 dir.c   |   74 ++++++++++++++++++++++++++++++++++++++++++++++----------------
 2 files changed, 56 insertions(+), 19 deletions(-)

diff --git a/cache.h b/cache.h
index 08b4633..de57dff 100644
--- a/cache.h
+++ b/cache.h
@@ -534,6 +534,7 @@ struct pathspec {
 };
 
 extern int init_pathspec(struct pathspec *, const char **);
+extern int get_pathspec(struct pathspec *, const char *, int, const char **);
 extern void free_pathspec(struct pathspec *);
 extern int ce_path_match(const struct cache_entry *ce, const struct pathspec *pathspec);
 extern int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object, enum object_type type, const char *path, int format_check);
diff --git a/dir.c b/dir.c
index 58cedd3..64348a1 100644
--- a/dir.c
+++ b/dir.c
@@ -1265,33 +1265,59 @@ static int pathspec_item_cmp(const void *a_, const void *b_)
 	return strcmp(a->match, b->match);
 }
 
-int init_pathspec(struct pathspec *pathspec, const char **paths)
+extern int prefix_pathspec(struct pathspec_item *item, const char *prefix,
+			   int prefixlen, const char *elt);
+const char *no_prefix = "We do not want outside repository check.";
+int get_pathspec(struct pathspec *pathspec, const char *prefix,
+		 int argc, const char **argv)
 {
-	const char **p = paths;
-	int i;
+	struct pathspec_item *pitem;
+	const char **dst;
+	int prefixlen;
 
 	memset(pathspec, 0, sizeof(*pathspec));
-	if (!p)
+
+	if ((!prefix || prefix == no_prefix) && !argc)
 		return 0;
-	while (*p)
-		p++;
-	pathspec->raw = paths;
-	pathspec->nr = p - paths;
-	if (!pathspec->nr)
+
+	if (!argc) {
+		static const char *spec[2];
+		spec[0] = prefix;
+		spec[1] = NULL;
+		init_pathspec(pathspec, spec);
+		pathspec->items[0].plain_len = pathspec->items[0].len;
 		return 0;
+	}
 
-	pathspec->items = xmalloc(sizeof(struct pathspec_item)*pathspec->nr);
-	memset(pathspec->items, 0, sizeof(struct pathspec_item)*pathspec->nr);
-	for (i = 0; i < pathspec->nr; i++) {
-		struct pathspec_item *item = pathspec->items+i;
-		const char *path = paths[i];
+	if (!strcmp(*argv, ":"))
+		return 0;
 
-		item->match = path;
-		item->len = strlen(path);
-		if (no_wildcard(path))
-			item->magic |= PATHSPEC_NOGLOB;
+	prefixlen = prefix && prefix != no_prefix ? strlen(prefix) : 0;
+	pathspec->nr = argc; /* be optimistic, lower it later if necessary */
+	pathspec->items = xmalloc(sizeof(struct pathspec_item) * argc);
+	pathspec->raw = argv;
+	pitem = pathspec->items;
+	dst = argv;
+
+	while (*argv) {
+		if (prefix == no_prefix) {
+			memset(pitem, 0, sizeof(*pitem));
+			pitem->match = *argv;
+			pitem->len = strlen(pitem->match);
+		}
+		else
+			prefix_pathspec(pitem, prefix, prefixlen, *argv);
+		*dst = *argv++;
+		if (pitem->match) {
+			if (no_wildcard(pitem->match + pitem->plain_len))
+				pitem->magic |= PATHSPEC_NOGLOB;
+			else
+				pathspec->use_wildcard = 1;
+			pitem++;
+			dst++;
+		}
 		else
-			pathspec->use_wildcard = 1;
+			pathspec->nr--;
 	}
 
 	qsort(pathspec->items, pathspec->nr,
@@ -1300,6 +1326,16 @@ int init_pathspec(struct pathspec *pathspec, const char **paths)
 	return 0;
 }
 
+int init_pathspec(struct pathspec *pathspec, const char **paths)
+{
+	const char **p = paths;
+
+	while (p && *p)
+		p++;
+
+	return get_pathspec(pathspec, no_prefix, p - paths, paths);
+}
+
 void free_pathspec(struct pathspec *pathspec)
 {
 	free(pathspec->items);
-- 
1.7.4.74.g639db
