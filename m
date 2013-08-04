From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/RFC] add: support saving the last <n> versions of the index
Date: Sun,  4 Aug 2013 13:28:40 +0700
Message-ID: <1375597720-13236-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 04 08:28:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5rns-0007gT-Vj
	for gcvg-git-2@plane.gmane.org; Sun, 04 Aug 2013 08:28:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751841Ab3HDG2J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Aug 2013 02:28:09 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:48573 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599Ab3HDG2I (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Aug 2013 02:28:08 -0400
Received: by mail-pd0-f171.google.com with SMTP id bv13so2068590pdb.30
        for <git@vger.kernel.org>; Sat, 03 Aug 2013 23:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=mDCkpQuT5ipK0jx/X0/C3hfHDJzsuBWdyoFhBt2u3Dc=;
        b=vIFBQ5YNaZLOAIFXDk5rD2dHq03h3Jqeg1y6Un0+p5nbRxQwPbVMS3VzeXvsHZH12S
         B7tIizWC+t/WX74BARXfKMlZ2PCjB/TAa0f+X23fA7ZtIZnik7R8uSJJWVcNKBnwP8S2
         4PcGCAFdKXcjomLP20kIW07ZYEDrcoMDDj7TRcsqMjNsbr6iXgXkdwYUpxN0aO+RNlah
         r7WHCImCpzmuCnWi5EMChFbuWM3EmvwXqQ/Heddpr+7DAQ4n3wp7+qUMwakfS8s6WVEj
         U6KwZl8BkgRhse649wQDYIYZmtlUGTPD/4bZ965OiUGb5tqc4kdPVQkgYk4AzMXS5DLF
         NWwA==
X-Received: by 10.66.253.4 with SMTP id zw4mr18842398pac.119.1375597687771;
        Sat, 03 Aug 2013 23:28:07 -0700 (PDT)
Received: from lanh ([115.73.200.117])
        by mx.google.com with ESMTPSA id ar5sm18001636pbc.40.2013.08.03.23.28.04
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 03 Aug 2013 23:28:07 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 04 Aug 2013 13:28:42 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231621>

When you do "git add foo", change "foo" and "git add foo" again, the
previous foo version is still in the repository, but its SHA-1 may be
lost. "git fsck --lost-found" may help, but it may take more time to
find out which blob is the old "foo".

This patch adds support for saving old index files, so that people
could look back more easily. In the case of "old foo", the user could
use ls-files with the previous of the index to determine SHA-1 of "old
foo".

When core.indexlogsize is defined to <n>, every time the index
changes(**), the old version is stored as $GIT_DIR/index-<i>, where
<i> is from 0..<n>-1. <i> increased after every change and wrapped
around at <n>-1. The current <i> is stored in $GIT_DIR/index as new
ILOG extension. ILOG extension also contains HEAD's tree SHA-1 and a
line describing the change.

(**) The index can change in many ways, but only changes by "git add"
(and maybe "git update-index" as well) are backed up. Non-SHA1 updates
are not worth watching. SHA-1 changes that end up in a commit
are tracked by reflog already. "git mv" and "git rm" may be worth
watching too.
---
 http://thread.gmane.org/gmane.comp.version-control.git/231594 reminds
 me that I have had something like this for a long time but never
 finished it. So here we go again.

 I think the basic idea is ok (new index versions like v5 may have
 problems though). The UI is harder. We need something like "git
 reflog" and perhaps something like @{N} syntax to access old indexes.
 Being able to diff between two indexes are even better but that might
 be a lot of work, diff-ing "git ls-files --stage" output should be
 ok. Hmm?

 builtin/add.c |  9 ++++++++-
 cache.h       |  5 +++++
 config.c      |  5 +++++
 environment.c |  1 +
 lockfile.c    | 12 +++++++++++-
 read-cache.c  | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 6 files changed, 85 insertions(+), 3 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 8266a9c..90e580c 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -15,6 +15,7 @@
 #include "diffcore.h"
 #include "revision.h"
 #include "bulk-checkin.h"
+#include "quote.h"
 
 static const char * const builtin_add_usage[] = {
 	N_("git add [options] [--] <pathspec>..."),
@@ -454,9 +455,15 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	char *seen = NULL;
 	int implicit_dot = 0;
 	struct update_callback_data update_data;
+	struct strbuf log = STRBUF_INIT;
 
 	git_config(add_config, NULL);
 
+	if (index_log_size) {
+		strbuf_addf(&log, "[%s] add ", prefix ? prefix : "");
+		sq_quote_argv(&log, argv, 0);
+	}
+
 	argc = parse_options(argc, argv, prefix, builtin_add_options,
 			  builtin_add_usage, PARSE_OPT_KEEP_ARGV0);
 	if (patch_interactive)
@@ -600,7 +607,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
  finish:
 	if (active_cache_changed) {
-		if (write_cache(newfd, active_cache, active_nr) ||
+		if (write_index_with_log(&the_index, newfd, log.buf) ||
 		    commit_locked_index(&lock_file))
 			die(_("Unable to write new index file"));
 	}
diff --git a/cache.h b/cache.h
index 85b544f..7655c4b 100644
--- a/cache.h
+++ b/cache.h
@@ -274,9 +274,12 @@ struct index_state {
 	struct cache_tree *cache_tree;
 	struct cache_time timestamp;
 	unsigned name_hash_initialized : 1,
+		 log_updated : 1,
 		 initialized : 1;
 	struct hash_table name_hash;
 	struct hash_table dir_hash;
+	unsigned int log_index;
+	struct strbuf *log;
 };
 
 extern struct index_state the_index;
@@ -454,6 +457,7 @@ extern int read_index_from(struct index_state *, const char *path);
 extern int is_index_unborn(struct index_state *);
 extern int read_index_unmerged(struct index_state *);
 extern int write_index(struct index_state *, int newfd);
+extern int write_index_with_log(struct index_state *, int newfd, const char *log);
 extern int discard_index(struct index_state *);
 extern int unmerged_index(const struct index_state *);
 extern int verify_path(const char *path);
@@ -595,6 +599,7 @@ extern int fsync_object_files;
 extern int core_preload_index;
 extern int core_apply_sparse_checkout;
 extern int precomposed_unicode;
+extern unsigned long index_log_size;
 
 /*
  * The character that begins a commented line in user-editable file
diff --git a/config.c b/config.c
index e13a7b6..f5e40fb 100644
--- a/config.c
+++ b/config.c
@@ -831,6 +831,11 @@ static int git_default_core_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.indexlogsize")) {
+		index_log_size = git_config_ulong(var, value);
+		return 0;
+	}
+
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
 }
diff --git a/environment.c b/environment.c
index 5398c36..12f01f7 100644
--- a/environment.c
+++ b/environment.c
@@ -62,6 +62,7 @@ int merge_log_config = -1;
 int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
 struct startup_info *startup_info;
 unsigned long pack_size_limit_cfg;
+unsigned long index_log_size;
 
 /*
  * The character that begins a commented line in user-editable file
diff --git a/lockfile.c b/lockfile.c
index 8fbcb6a..880a4e4 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -267,8 +267,18 @@ int commit_locked_index(struct lock_file *lk)
 		lk->filename[0] = 0;
 		return 0;
 	}
-	else
+	else {
+		if (the_index.log_updated) {
+			char src[PATH_MAX], backup[PATH_MAX];
+			int len = strlen(lk->filename) - 5; /* .lock */
+			memcpy(src, lk->filename, len);
+			src[len] = 0;
+			memcpy(backup, lk->filename, len);
+			sprintf(backup+len, "-%u", the_index.log_index);
+			rename(src, backup); /* does it matter if it fails? */
+		}
 		return commit_lock_file(lk);
+	}
 }
 
 void rollback_lock_file(struct lock_file *lk)
diff --git a/read-cache.c b/read-cache.c
index c3d5e35..9d8300a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -33,6 +33,7 @@ static struct cache_entry *refresh_cache_entry(struct cache_entry *ce, int reall
 #define CACHE_EXT(s) ( (s[0]<<24)|(s[1]<<16)|(s[2]<<8)|(s[3]) )
 #define CACHE_EXT_TREE 0x54524545	/* "TREE" */
 #define CACHE_EXT_RESOLVE_UNDO 0x52455543 /* "REUC" */
+#define CACHE_EXT_INDEX_LOG 0x494C4F47	  /* "ILOG" */
 
 struct index_state the_index;
 
@@ -1297,6 +1298,18 @@ static int read_index_extension(struct index_state *istate,
 	case CACHE_EXT_RESOLVE_UNDO:
 		istate->resolve_undo = resolve_undo_read(data, sz);
 		break;
+	case CACHE_EXT_INDEX_LOG:
+		if (!istate->log) {
+			istate->log = xmalloc(sizeof(struct strbuf *));
+			strbuf_init(istate->log, 128);
+		}
+		strbuf_add(istate->log, data, sz);
+		if (sscanf(istate->log->buf, "%u", &istate->log_index) != 1) {
+			strbuf_release(istate->log);
+			free(istate->log);
+			istate->log = NULL;
+		}
+		break;
 	default:
 		if (*ext < 'A' || 'Z' < *ext)
 			return error("index uses %.4s extension, which we do not understand",
@@ -1538,6 +1551,15 @@ int discard_index(struct index_state *istate)
 	free(istate->cache);
 	istate->cache = NULL;
 	istate->cache_alloc = 0;
+	istate->log_updated = 0;
+	istate->log_index = 0;
+	if (istate->log) {
+		strbuf_release(istate->log);
+		free(istate->log);
+		istate->log = NULL;
+	}
+
+	/* no need to throw away allocated active_cache */
 	return 0;
 }
 
@@ -1771,7 +1793,8 @@ void update_index_if_able(struct index_state *istate, struct lock_file *lockfile
 		rollback_lock_file(lockfile);
 }
 
-int write_index(struct index_state *istate, int newfd)
+int write_index_with_log(struct index_state *istate, int newfd,
+			 const char *log)
 {
 	git_SHA_CTX c;
 	struct cache_header hdr;
@@ -1847,6 +1870,32 @@ int write_index(struct index_state *istate, int newfd)
 			return -1;
 	}
 
+	if (index_log_size) {
+		unsigned char sha1[20];
+		if (log) {
+			istate->log_index = (istate->log_index + 1) % index_log_size;
+			istate->log_updated = 1;
+		} else
+			log = "";
+		if (get_sha1("HEAD^{tree}", sha1))
+			hashclr(sha1);
+		if (!istate->log) {
+			istate->log = xmalloc(sizeof(struct strbuf *));
+			strbuf_init(istate->log, 128);
+		} else
+			strbuf_reset(istate->log);
+		strbuf_addf(istate->log, "%u %s %s %s",
+			    istate->log_index, sha1_to_hex(sha1),
+			    git_committer_info(0), log);
+
+		err = write_index_ext_header(&c, newfd, CACHE_EXT_INDEX_LOG,
+					     istate->log->len) < 0
+			|| ce_write(&c, newfd, istate->log->buf,
+				    istate->log->len) < 0;
+		if (err)
+			return -1;
+	}
+
 	if (ce_flush(&c, newfd) || fstat(newfd, &st))
 		return -1;
 	istate->timestamp.sec = (unsigned int)st.st_mtime;
@@ -1854,6 +1903,11 @@ int write_index(struct index_state *istate, int newfd)
 	return 0;
 }
 
+int write_index(struct index_state *istate, int newfd)
+{
+	return write_index_with_log(istate, newfd, NULL);
+}
+
 /*
  * Read the index file that is potentially unmerged into given
  * index_state, dropping any unmerged entries.  Returns true if
-- 
1.8.2.83.gc99314b
