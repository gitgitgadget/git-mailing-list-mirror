From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH] Fix buffer overflow in git diff
Date: Wed, 16 Jul 2008 18:54:02 +0400
Message-ID: <1216220043-27678-1-git-send-email-dpotapov@gmail.com>
References: <37fcd2780807160733o156e49c6m51314ff18764ccd5@mail.gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dmitry Potapov <dpotapov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 16:55:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJ8PQ-00010g-Pi
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 16:55:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756829AbYGPOyL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 10:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756834AbYGPOyL
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 10:54:11 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:3274 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753608AbYGPOyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 10:54:09 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2454971fgg.17
        for <git@vger.kernel.org>; Wed, 16 Jul 2008 07:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=oUAiCER7u41kICSyWNDvG068elf341CiRB2juUZvbWw=;
        b=YhEBZbYE58mlPQwpVMMs3SYKMfpkkn+bhVhS7rvMg1xWMYscpsuN/2CZC22DHPcUUR
         nYrOukn/7+FLEg6xaQMPH0moOQXkq97Ey7UxSblYlUcdiQ/iXYlVBW1TlNYcPUdSvDI+
         RK4II0RloZmd81WgXyebXXet1e6P7XPlFvNTY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=QFE5JFoWQeOoN8Vrp56+ws6wREwZpQFyFjuvjzOldpDAWC3HNl17yVjRcoSXKTHhvS
         FQxfd/NxM15Ajd6tQCyEtZcOSB8RPMTUDJJgAqBbD8P5+6pGSwFK+/0m+wk1khBWnTk7
         GxZe6bpqg58UrptKlGceP/EA+DLUXUhfGbUbg=
Received: by 10.86.63.19 with SMTP id l19mr2151767fga.77.1216220047661;
        Wed, 16 Jul 2008 07:54:07 -0700 (PDT)
Received: from localhost ( [85.141.237.219])
        by mx.google.com with ESMTPS id 4sm1386479fge.5.2008.07.16.07.54.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 16 Jul 2008 07:54:06 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3.3.gfcafb
In-Reply-To: <37fcd2780807160733o156e49c6m51314ff18764ccd5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88685>

If PATH_MAX on your system is smaller than a path stored, it may cause
buffer overflow and stack corruption in diff_addremove() and diff_change()
functions when running git-diff

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---
 diff-lib.c  |    8 ++++----
 diff.c      |   11 ++---------
 diff.h      |    9 ++++-----
 revision.c  |    4 ++--
 tree-diff.c |   26 ++++++++++++++++++++++----
 5 files changed, 34 insertions(+), 24 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index b17722d..e7eaff9 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -171,7 +171,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			if (silent_on_removed)
 				continue;
 			diff_addremove(&revs->diffopt, '-', ce->ce_mode,
-				       ce->sha1, ce->name, NULL);
+				       ce->sha1, ce->name);
 			continue;
 		}
 		changed = ce_match_stat(ce, &st, ce_option);
@@ -184,7 +184,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 		newmode = ce_mode_from_stat(ce, st.st_mode);
 		diff_change(&revs->diffopt, oldmode, newmode,
 			    ce->sha1, (changed ? null_sha1 : ce->sha1),
-			    ce->name, NULL);
+			    ce->name);
 
 	}
 	diffcore_std(&revs->diffopt);
@@ -208,7 +208,7 @@ static void diff_index_show_file(struct rev_info *revs,
 				 const unsigned char *sha1, unsigned int mode)
 {
 	diff_addremove(&revs->diffopt, prefix[0], mode,
-		       sha1, ce->name, NULL);
+		       sha1, ce->name);
 }
 
 static int get_stat_data(struct cache_entry *ce,
@@ -312,7 +312,7 @@ static int show_modified(struct oneway_unpack_data *cbdata,
 		return 0;
 
 	diff_change(&revs->diffopt, oldmode, mode,
-		    old->sha1, sha1, old->name, NULL);
+		    old->sha1, sha1, old->name);
 	return 0;
 }
 
diff --git a/diff.c b/diff.c
index 78c4d3a..386de82 100644
--- a/diff.c
+++ b/diff.c
@@ -3356,9 +3356,8 @@ int diff_result_code(struct diff_options *opt, int status)
 void diff_addremove(struct diff_options *options,
 		    int addremove, unsigned mode,
 		    const unsigned char *sha1,
-		    const char *base, const char *path)
+		    const char *concatpath)
 {
-	char concatpath[PATH_MAX];
 	struct diff_filespec *one, *two;
 
 	if (DIFF_OPT_TST(options, IGNORE_SUBMODULES) && S_ISGITLINK(mode))
@@ -3380,9 +3379,6 @@ void diff_addremove(struct diff_options *options,
 		addremove = (addremove == '+' ? '-' :
 			     addremove == '-' ? '+' : addremove);
 
-	if (!path) path = "";
-	sprintf(concatpath, "%s%s", base, path);
-
 	if (options->prefix &&
 	    strncmp(concatpath, options->prefix, options->prefix_length))
 		return;
@@ -3403,9 +3399,8 @@ void diff_change(struct diff_options *options,
 		 unsigned old_mode, unsigned new_mode,
 		 const unsigned char *old_sha1,
 		 const unsigned char *new_sha1,
-		 const char *base, const char *path)
+		 const char *concatpath)
 {
-	char concatpath[PATH_MAX];
 	struct diff_filespec *one, *two;
 
 	if (DIFF_OPT_TST(options, IGNORE_SUBMODULES) && S_ISGITLINK(old_mode)
@@ -3418,8 +3413,6 @@ void diff_change(struct diff_options *options,
 		tmp = old_mode; old_mode = new_mode; new_mode = tmp;
 		tmp_c = old_sha1; old_sha1 = new_sha1; new_sha1 = tmp_c;
 	}
-	if (!path) path = "";
-	sprintf(concatpath, "%s%s", base, path);
 
 	if (options->prefix &&
 	    strncmp(concatpath, options->prefix, options->prefix_length))
diff --git a/diff.h b/diff.h
index 5dc0cb5..50fb5dd 100644
--- a/diff.h
+++ b/diff.h
@@ -14,12 +14,12 @@ typedef void (*change_fn_t)(struct diff_options *options,
 		 unsigned old_mode, unsigned new_mode,
 		 const unsigned char *old_sha1,
 		 const unsigned char *new_sha1,
-		 const char *base, const char *path);
+		 const char *fullpath);
 
 typedef void (*add_remove_fn_t)(struct diff_options *options,
 		    int addremove, unsigned mode,
 		    const unsigned char *sha1,
-		    const char *base, const char *path);
+		    const char *fullpath);
 
 typedef void (*diff_format_fn_t)(struct diff_queue_struct *q,
 		struct diff_options *options, void *data);
@@ -164,14 +164,13 @@ extern void diff_addremove(struct diff_options *,
 			   int addremove,
 			   unsigned mode,
 			   const unsigned char *sha1,
-			   const char *base,
-			   const char *path);
+			   const char *fullpath);
 
 extern void diff_change(struct diff_options *,
 			unsigned mode1, unsigned mode2,
 			const unsigned char *sha1,
 			const unsigned char *sha2,
-			const char *base, const char *path);
+			const char *fullpath);
 
 extern void diff_unmerge(struct diff_options *,
 			 const char *path,
diff --git a/revision.c b/revision.c
index fc66755..8dc3ca7 100644
--- a/revision.c
+++ b/revision.c
@@ -259,7 +259,7 @@ static int tree_difference = REV_TREE_SAME;
 static void file_add_remove(struct diff_options *options,
 		    int addremove, unsigned mode,
 		    const unsigned char *sha1,
-		    const char *base, const char *path)
+		    const char *fullpath)
 {
 	int diff = REV_TREE_DIFFERENT;
 
@@ -285,7 +285,7 @@ static void file_change(struct diff_options *options,
 		 unsigned old_mode, unsigned new_mode,
 		 const unsigned char *old_sha1,
 		 const unsigned char *new_sha1,
-		 const char *base, const char *path)
+		 const char *fullpath)
 {
 	tree_difference = REV_TREE_DIFFERENT;
 	DIFF_OPT_SET(options, HAS_CHANGES);
diff --git a/tree-diff.c b/tree-diff.c
index e1e2e6c..4c67ea5 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -15,6 +15,15 @@ static char *malloc_base(const char *base, int baselen, const char *path, int pa
 	return newbase;
 }
 
+static char *malloc_fullname(const char *base, int baselen, const char *path, int pathlen)
+{
+	char *fullname = xmalloc(baselen + pathlen + 1);
+	memcpy(fullname, base, baselen);
+	memcpy(fullname + baselen, path, pathlen);
+	fullname[baselen + pathlen] = 0;
+	return fullname;
+}
+
 static void show_entry(struct diff_options *opt, const char *prefix, struct tree_desc *desc,
 		       const char *base, int baselen);
 
@@ -24,6 +33,7 @@ static int compare_tree_entry(struct tree_desc *t1, struct tree_desc *t2, const
 	const char *path1, *path2;
 	const unsigned char *sha1, *sha2;
 	int cmp, pathlen1, pathlen2;
+	char *fullname;
 
 	sha1 = tree_entry_extract(t1, &path1, &mode1);
 	sha2 = tree_entry_extract(t2, &path2, &mode2);
@@ -56,14 +66,20 @@ static int compare_tree_entry(struct tree_desc *t1, struct tree_desc *t2, const
 		int retval;
 		char *newbase = malloc_base(base, baselen, path1, pathlen1);
 		if (DIFF_OPT_TST(opt, TREE_IN_RECURSIVE))
+		{
+			newbase[baselen + pathlen1] = 0;
 			opt->change(opt, mode1, mode2,
-				    sha1, sha2, base, path1);
+				    sha1, sha2, newbase);
+			newbase[baselen + pathlen1] = '/';
+		}
 		retval = diff_tree_sha1(sha1, sha2, newbase, opt);
 		free(newbase);
 		return retval;
 	}
 
-	opt->change(opt, mode1, mode2, sha1, sha2, base, path1);
+	fullname = malloc_fullname(base, baselen, path1, pathlen1);
+	opt->change(opt, mode1, mode2, sha1, sha2, fullname);
+	free(fullname);
 	return 0;
 }
 
@@ -205,10 +221,10 @@ static void show_entry(struct diff_options *opt, const char *prefix, struct tree
 	unsigned mode;
 	const char *path;
 	const unsigned char *sha1 = tree_entry_extract(desc, &path, &mode);
+	int pathlen = tree_entry_len(path, sha1);
 
 	if (DIFF_OPT_TST(opt, RECURSIVE) && S_ISDIR(mode)) {
 		enum object_type type;
-		int pathlen = tree_entry_len(path, sha1);
 		char *newbase = malloc_base(base, baselen, path, pathlen);
 		struct tree_desc inner;
 		void *tree;
@@ -224,7 +240,9 @@ static void show_entry(struct diff_options *opt, const char *prefix, struct tree
 		free(tree);
 		free(newbase);
 	} else {
-		opt->add_remove(opt, prefix[0], mode, sha1, base, path);
+		char *fullname = malloc_fullname(base, baselen, path, pathlen);
+		opt->add_remove(opt, prefix[0], mode, sha1, fullname);
+		free(fullname);
 	}
 }
 
-- 
1.5.6.3.3.gfcafb
