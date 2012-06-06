From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/6] path_excluded(): update API to less cache-entry centric
Date: Tue,  5 Jun 2012 22:45:16 -0700
Message-ID: <1338961519-30970-4-git-send-email-gitster@pobox.com>
References: <1338961519-30970-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 06 07:46:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sc94N-0002JF-68
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 07:46:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754251Ab2FFFpq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jun 2012 01:45:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45615 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753899Ab2FFFp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2012 01:45:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 104C15FFF
	for <git@vger.kernel.org>; Wed,  6 Jun 2012 01:45:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=k9Iy
	xV/K/h1FOll2e3p/EAIC8OA=; b=Sd70dNY96d92XcnIcuYVJauHznZE6HPUBvUP
	bMbLgvOXx1YM3/b8uy0E6ABOvRMLFRlzwflfuamgXrrQY1h88N2fY85vP9laETtN
	Vc6XRnQ22ygloHRUTqp8tebItuIfmrujOz1ngEj9XNhlXH1gE2hVNy9t/e1xKN60
	ZaP1Y1o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=ve61Z8
	mSVI+l8RCbsE7IWHRN6sX5lNryKvLSwAmtICymUnYyq66x9H5tHLtsXyW4YokPCM
	Urs05WvlEq9B72DprLyqo1zYvKgAMyyYjBhiVeESfkfhVk7P9u3wUiCv8Vrmyegm
	7tDD2xu7LngTJhsUahHqAy4cOSScKZG88x/AU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0871F5FFE
	for <git@vger.kernel.org>; Wed,  6 Jun 2012 01:45:27 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4A2F75FFD for
 <git@vger.kernel.org>; Wed,  6 Jun 2012 01:45:26 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.rc1.37.g09843ac
In-Reply-To: <1338961519-30970-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D0F18404-AF9A-11E1-9138-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199301>

It was stupid of me to make the API too much cache-entry specific;
the caller may want to check arbitrary pathname without having a
corresponding cache-entry to see if a path is ignored.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/ls-files.c | 10 ++++++++--
 dir.c              | 32 ++++++++++++++++++++------------
 dir.h              |  3 ++-
 3 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 90dc360..31b3f2d 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -200,6 +200,12 @@ static void show_ru_info(void)
 	}
 }
 
+static int ce_excluded(struct path_exclude_check *check, struct cache_entry *ce)
+{
+	int dtype = ce_to_dtype(ce);
+	return path_excluded(check, ce->name, ce_namelen(ce), &dtype);
+}
+
 static void show_files(struct dir_struct *dir)
 {
 	int i;
@@ -220,7 +226,7 @@ static void show_files(struct dir_struct *dir)
 		for (i = 0; i < active_nr; i++) {
 			struct cache_entry *ce = active_cache[i];
 			if ((dir->flags & DIR_SHOW_IGNORED) &&
-			    !path_excluded(&check, ce))
+			    !ce_excluded(&check, ce))
 				continue;
 			if (show_unmerged && !ce_stage(ce))
 				continue;
@@ -236,7 +242,7 @@ static void show_files(struct dir_struct *dir)
 			struct stat st;
 			int err;
 			if ((dir->flags & DIR_SHOW_IGNORED) &&
-			    !path_excluded(&check, ce))
+			    !ce_excluded(&check, ce))
 				continue;
 			if (ce->ce_flags & CE_UPDATE)
 				continue;
diff --git a/dir.c b/dir.c
index 839bc9f..7ab7fc5 100644
--- a/dir.c
+++ b/dir.c
@@ -593,31 +593,40 @@ void path_exclude_check_clear(struct path_exclude_check *check)
 }
 
 /*
- * Is the ce->name excluded?  This is for a caller like show_files() that
+ * Is this name excluded?  This is for a caller like show_files() that
  * do not honor directory hierarchy and iterate through paths that are
  * possibly in an ignored directory.
  *
  * A path to a directory known to be excluded is left in check->path to
  * optimize for repeated checks for files in the same excluded directory.
  */
-int path_excluded(struct path_exclude_check *check, struct cache_entry *ce)
+int path_excluded(struct path_exclude_check *check,
+		  const char *name, int namelen, int *dtype)
 {
-	int i, dtype;
+	int i;
 	struct strbuf *path = &check->path;
 
+	/*
+	 * we allow the caller to pass namelen as an optimization; it
+	 * must match the length of the name, as we eventually call
+	 * excluded() on the whole name string.
+	 */
+	if (namelen < 0)
+		namelen = strlen(name);
+
 	if (path->len &&
-	    path->len <= ce_namelen(ce) &&
-	    !memcmp(ce->name, path->buf, path->len) &&
-	    (!ce->name[path->len] || ce->name[path->len] == '/'))
+	    path->len <= namelen &&
+	    !memcmp(name, path->buf, path->len) &&
+	    (!name[path->len] || name[path->len] == '/'))
 		return 1;
 
 	strbuf_setlen(path, 0);
-	for (i = 0; ce->name[i]; i++) {
-		int ch = ce->name[i];
+	for (i = 0; name[i]; i++) {
+		int ch = name[i];
 
 		if (ch == '/') {
-			dtype = DT_DIR;
-			if (excluded(check->dir, path->buf, &dtype))
+			int dt = DT_DIR;
+			if (excluded(check->dir, path->buf, &dt))
 				return 1;
 		}
 		strbuf_addch(path, ch);
@@ -626,8 +635,7 @@ int path_excluded(struct path_exclude_check *check, struct cache_entry *ce)
 	/* An entry in the index; cannot be a directory with subentries */
 	strbuf_setlen(path, 0);
 
-	dtype = ce_to_dtype(ce);
-	return excluded(check->dir, ce->name, &dtype);
+	return excluded(check->dir, name, dtype);
 }
 
 static struct dir_entry *dir_entry_new(const char *pathname, int len)
diff --git a/dir.h b/dir.h
index 7378e69..36a82b3 100644
--- a/dir.h
+++ b/dir.h
@@ -92,7 +92,8 @@ struct path_exclude_check {
 };
 extern void path_exclude_check_init(struct path_exclude_check *, struct dir_struct *);
 extern void path_exclude_check_clear(struct path_exclude_check *);
-extern int path_excluded(struct path_exclude_check *, struct cache_entry *);
+extern int path_excluded(struct path_exclude_check *, const char *, int namelen, int *dtype);
+
 
 extern int add_excludes_from_file_to_list(const char *fname, const char *base, int baselen,
 					  char **buf_p, struct exclude_list *which, int check_index);
-- 
1.7.11.rc1.37.g09843ac
