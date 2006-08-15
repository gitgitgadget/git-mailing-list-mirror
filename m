From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] make inline is_null_sha1 global
Date: Tue, 15 Aug 2006 15:11:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608151510120.5555@chino.corp.google.com>
References: <Pine.LNX.4.63.0608151335020.1475@chino.corp.google.com>
 <20060815215812.GB15797@diku.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 16 00:12:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GD78u-0001sx-SM
	for gcvg-git@gmane.org; Wed, 16 Aug 2006 00:12:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbWHOWLj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Aug 2006 18:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbWHOWLj
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Aug 2006 18:11:39 -0400
Received: from smtp-out.google.com ([216.239.45.12]:42641 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750747AbWHOWLj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Aug 2006 18:11:39 -0400
Received: from zps78.corp.google.com (zps78.corp.google.com [172.25.146.78])
	by smtp-out.google.com with ESMTP id k7FMBQJh025766;
	Tue, 15 Aug 2006 15:11:26 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:cc:subject:in-reply-to:
	message-id:references:mime-version:content-type;
	b=f+OqehuunbCdV6v4vf9u0hyyGDSyItmKBKAToOkPSEDfgC6dOLx1kzjfPnv8tCH1g
	4SpvJzn8958rl9hgVKF7w==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps78.corp.google.com with ESMTP id k7FMBGlu002399;
	Tue, 15 Aug 2006 15:11:16 -0700
Received: by localhost (Postfix, from userid 24081)
	id 4BA0B87D71; Tue, 15 Aug 2006 15:11:16 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id 4671C87D70;
	Tue, 15 Aug 2006 15:11:16 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: Jonas Fonseca <fonseca@diku.dk>
In-Reply-To: <20060815215812.GB15797@diku.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25488>

On Tue, 15 Aug 2006, Jonas Fonseca wrote:

> Looks like this should be !is_null_sha1(...) in both cases.
> 

Correct, thanks for pointing that out.  Please ack the following patch that 
fixes it.

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
index 82afce7..40e5c96 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -68,8 +68,7 @@ static void stuff_change(struct diff_opt
 {
 	struct diff_filespec *one, *two;
 
-	if (memcmp(null_sha1, old_sha1, 20) &&
-	    memcmp(null_sha1, new_sha1, 20) &&
+	if (!is_null_sha1(old_sha1) && !is_null_sha1(new_sha1) &&
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
