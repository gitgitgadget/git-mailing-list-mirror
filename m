From: David Rientjes <rientjes@google.com>
Subject: [PATCH] make inline is_null_sha1 global
Date: Tue, 15 Aug 2006 13:37:19 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608151335020.1475@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Aug 15 22:37:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GD5fG-0002up-Ag
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 22:37:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbWHOUh1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Aug 2006 16:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750969AbWHOUh0
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Aug 2006 16:37:26 -0400
Received: from smtp-out.google.com ([216.239.45.12]:35669 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750899AbWHOUh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Aug 2006 16:37:26 -0400
Received: from zps76.corp.google.com (zps76.corp.google.com [172.25.146.76])
	by smtp-out.google.com with ESMTP id k7FKbKVI025778
	for <git@vger.kernel.org>; Tue, 15 Aug 2006 13:37:20 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:subject:message-id:
	mime-version:content-type;
	b=ogE/WeCD6SisMmikFxRmYot2pbk3mdmXz5ufLGO5tbp+qdbu8+BxwxSNX7wL9gHuO
	jCKFsbkEkJd75HHBRZPrw==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps76.corp.google.com with ESMTP id k7FKbJcx008224
	for <git@vger.kernel.org>; Tue, 15 Aug 2006 13:37:19 -0700
Received: by localhost (Postfix, from userid 24081)
	id AB5A187D71; Tue, 15 Aug 2006 13:37:19 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id A5FCA87D70
	for <git@vger.kernel.org>; Tue, 15 Aug 2006 13:37:19 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25480>

Replace sha1 comparisons to null_sha1 with a global inline (which previously an 
unused static inline in builtin-apply.c)

		David

Signed-off-by: David Rientjes <rientjes@google.com>
---
 builtin-apply.c |    7 +------
 builtin-diff.c  |    3 +--
 cache.h         |    4 ++++
 combine-diff.c  |    4 ++--
 diff.c          |    2 +-
 fsck-objects.c  |    2 +-
 sha1_name.c     |    2 +-
 7 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 4573c9a..1c1d16f 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1684,7 +1684,7 @@ static int apply_binary(struct buffer_de
 	}
 
 	get_sha1_hex(patch->new_sha1_prefix, sha1);
-	if (!memcmp(sha1, null_sha1, 20)) {
+	if (is_null_sha1(sha1)) {
 		free(desc->buffer);
 		desc->alloc = desc->size = 0;
 		desc->buffer = NULL;
@@ -1916,11 +1916,6 @@ static int check_patch_list(struct patch
 	return error;
 }
 
-static inline int is_null_sha1(const unsigned char *sha1)
-{
-	return !memcmp(sha1, null_sha1, 20);
-}
-
 static void show_index_list(struct patch *list)
 {
 	struct patch *patch;
diff --git a/builtin-diff.c b/builtin-diff.c
index 82afce7..9003d55 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -68,8 +68,7 @@ static void stuff_change(struct diff_opt
 {
 	struct diff_filespec *one, *two;
 
-	if (memcmp(null_sha1, old_sha1, 20) &&
-	    memcmp(null_sha1, new_sha1, 20) &&
+	if (is_null_sha1(old_sha1) && is_null_sha1(new_sha1) &&
 	    !memcmp(old_sha1, new_sha1, 20))
 		return;
 
diff --git a/cache.h b/cache.h
index af77402..c738299 100644
--- a/cache.h
+++ b/cache.h
@@ -210,6 +210,10 @@ extern char *sha1_pack_name(const unsign
 extern char *sha1_pack_index_name(const unsigned char *sha1);
 extern const char *find_unique_abbrev(const unsigned char *sha1, int);
 extern const unsigned char null_sha1[20];
+static inline int is_null_sha1(const unsigned char *sha1)
+{
+	return !memcmp(sha1, null_sha1, 20);
+}
 
 int git_mkstemp(char *path, size_t n, const char *template);
 
diff --git a/combine-diff.c b/combine-diff.c
index 4c6bfed..ce063b4 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -94,7 +94,7 @@ static char *grab_blob(const unsigned ch
 {
 	char *blob;
 	char type[20];
-	if (!memcmp(sha1, null_sha1, 20)) {
+	if (is_null_sha1(sha1)) {
 		/* deleted blob */
 		*size = 0;
 		return xcalloc(1, 1);
@@ -611,7 +611,7 @@ static void show_patch_diff(struct combi
 	struct sline *sline; /* survived lines */
 	int mode_differs = 0;
 	int i, show_hunks;
-	int working_tree_file = !memcmp(elem->sha1, null_sha1, 20);
+	int working_tree_file = is_null_sha1(elem->sha1);
 	int abbrev = opt->full_index ? 40 : DEFAULT_ABBREV;
 	mmfile_t result_file;
 
diff --git a/diff.c b/diff.c
index 2327e60..6a8c0c9 100644
--- a/diff.c
+++ b/diff.c
@@ -1102,7 +1102,7 @@ void fill_filespec(struct diff_filespec 
 	if (mode) {
 		spec->mode = canon_mode(mode);
 		memcpy(spec->sha1, sha1, 20);
-		spec->sha1_valid = !!memcmp(sha1, null_sha1, 20);
+		spec->sha1_valid = !is_null_sha1(sha1);
 	}
 }
 
diff --git a/fsck-objects.c b/fsck-objects.c
index 4ba3377..b0e882a 100644
--- a/fsck-objects.c
+++ b/fsck-objects.c
@@ -452,7 +452,7 @@ static int fsck_head_link(void)
 	if (strncmp(git_refs_heads_master + pfxlen, "refs/heads/", 11))
 		return error("HEAD points to something strange (%s)",
 			     git_refs_heads_master + pfxlen);
-	if (!memcmp(null_sha1, sha1, 20))
+	if (is_null_sha1(sha1))
 		return error("HEAD: not a valid git pointer");
 	return 0;
 }
diff --git a/sha1_name.c b/sha1_name.c
index c5a05fa..f567454 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -191,7 +191,7 @@ const char *find_unique_abbrev(const uns
 	int status, is_null;
 	static char hex[41];
 
-	is_null = !memcmp(sha1, null_sha1, 20);
+	is_null = is_null_sha1(sha1);
 	memcpy(hex, sha1_to_hex(sha1), 40);
 	if (len == 40 || !len)
 		return hex;
-- 
1.4.2.g460c-dirty
