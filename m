From: Robert Zeh <robert.allan.zeh@gmail.com>
Subject: Re: [PATCH] inotify to minimize stat() calls
Date: Wed, 24 Apr 2013 12:20:21 -0500
Message-ID: <51781455.9090600@gmail.com>
References: <CALkWK0=EP0Lv1F_BArub7SpL9rgFhmPtpMOCgwFqfJmVE=oa=A@mail.gmail.com> <7vehgqzc2p.fsf@alter.siamese.dyndns.org> <7va9rezaoy.fsf@alter.siamese.dyndns.org> <7vsj56w5y9.fsf@alter.siamese.dyndns.org> <9AF8A28B-71FE-4BBC-AD55-1DD3FDE8FFC3@gmail.com> <CALkWK0mttn6E+D-22UBbvDCuNEy_jNOtBaKPS-a8mTbO2uAF3g@mail.gmail.com> <7vliaxwa9p.fsf@alter.siamese.dyndns.org> <CAKXa9=qQwJqxZLxhAS35QeF1+dwH+ukod0NfFggVCuUZHz-USg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 19:36:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV3cI-0002YW-Pe
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 19:36:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756218Ab3DXRgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 13:36:22 -0400
Received: from mail-qc0-f173.google.com ([209.85.216.173]:33635 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756091Ab3DXRgU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 13:36:20 -0400
Received: by mail-qc0-f173.google.com with SMTP id b12so1080615qca.18
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 10:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=UJu2ZuwL+gnulwYRVqXUgizEj82PUbjZInPZIajZNp8=;
        b=dLOIqhwBX+zTkomLe3+5e6hMRstLq4QAZS1lM5jksqfhhsgAF0DMa+SH7X9Zpq7+No
         bylTRAEi/xI9HOEqYeVBaioXcyoHwp5rZ0UUpXtlFoEp9NgdbHZhMsn6/nKNUqGpoVNZ
         yJjNr1+wLhjB4CI8wwH9QQHHVXmCBo694GcR1tGolNFzwk/lJD5f+dqjvUABOZIWqxo/
         pkd5AUPmCj5uOuYqCGylPq0mFrtdaMhpV8QCYBO33Dbufh1jdAftjPj2xXr73ETlAyZf
         2ub6AbHAavjciiTK3mO07qJTfSlD2f36URdpkxEdkJJ3HRQFtvhJDHmqWxxbBaeE4cGN
         i1BQ==
X-Received: by 10.49.16.233 with SMTP id j9mr36813611qed.12.1366824979375;
        Wed, 24 Apr 2013 10:36:19 -0700 (PDT)
Received: from [192.168.15.229] ([96.24.158.141])
        by mx.google.com with ESMTPSA id n3sm5870758qat.6.2013.04.24.10.36.16
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 24 Apr 2013 10:36:18 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130221 Thunderbird/17.0.3
In-Reply-To: <CAKXa9=qQwJqxZLxhAS35QeF1+dwH+ukod0NfFggVCuUZHz-USg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222278>

Here is a patch that creates a daemon that tracks file
state with inotify, writes it out to a file upon request,
and changes most of the calls to stat to use said cache.

It has bugs, but I figured it would be smarter to see
if the approach was acceptable at all before spending the
time to root the bugs out.

I've implemented the communication with a file, and not a socket, 
because I think implementing a socket is going to create
security issues on multiuser systems.  For example, would a
socket allow stat information to cross user boundaries?


Most stat calls are redirected to a cache that is maintained by a
daemon that maintains file system state via inotify.

Signed-off-by: Robert Zeh <robert.allan.zeh@gmail.com>
---
  abspath.c            |   9 ++-
  bisect.c             |   3 +-
  check-racy.c         |   2 +-
  combine-diff.c       |   3 +-
  command-list.txt     |   1 +
  config.c             |   3 +-
  copy.c               |   3 +-
  diff-lib.c           |   3 +-
  diff-no-index.c      |   3 +-
  diff.c               |   9 ++-
  diffcore-order.c     |   3 +-
  dir.c                |   4 +-
  filechange-cache.c   | 203 
+++++++++++++++++++++++++++++++++++++++++++++++++++
  filechange-cache.h   |  20 +++++
  filechange-daemon.c  | 164 +++++++++++++++++++++++++++++++++++++++++
  filechange-printer.c |  13 ++++
  git.c                |  27 +++++++
  ll-merge.c           |   3 +-
  merge-recursive.c    |   5 +-
  name-hash.c          |   3 +-
  name-hash.h          |   1 +
  notes-merge.c        |   3 +-
  path.c               |   5 +-
  read-cache.c         |  11 +--
  rerere.c             |   7 +-
  setup.c              |   5 +-
  test-chmtime.c       |   2 +-
  test-wildmatch.c     |   2 +-
  unpack-trees.c       |   6 +-
  29 files changed, 486 insertions(+), 40 deletions(-)
  create mode 100644 filechange-cache.c
  create mode 100644 filechange-cache.h
  create mode 100644 filechange-daemon.c
  create mode 100644 filechange-printer.c
  create mode 100644 name-hash.h

diff --git a/abspath.c b/abspath.c
index 40cdc46..798c005 100644
--- a/abspath.c
+++ b/abspath.c
@@ -1,3 +1,4 @@
+#include "filechange-cache.h"
  #include "cache.h"

  /*
@@ -8,7 +9,7 @@
  int is_directory(const char *path)
  {
  	struct stat st;
-	return (!stat(path, &st) && S_ISDIR(st.st_mode));
+	return (!cached_stat(path, &st) && S_ISDIR(st.st_mode));
  }

  /* We allow "recursive" symbolic links. Only within reason, though. */
@@ -117,7 +118,7 @@ static const char *real_path_internal(const char 
*path, int die_on_error)
  			last_elem = NULL;
  		}

-		if (!lstat(buf, &st) && S_ISLNK(st.st_mode)) {
+		if (!cached_lstat(buf, &st) && S_ISLNK(st.st_mode)) {
  			ssize_t len = readlink(buf, next_buf, PATH_MAX);
  			if (len < 0) {
  				if (die_on_error)
@@ -167,9 +168,9 @@ static const char *get_pwd_cwd(void)
  		return NULL;
  	pwd = getenv("PWD");
  	if (pwd && strcmp(pwd, cwd)) {
-		stat(cwd, &cwd_stat);
+		cached_stat(cwd, &cwd_stat);
  		if ((cwd_stat.st_dev || cwd_stat.st_ino) &&
-		    !stat(pwd, &pwd_stat) &&
+		    !cached_stat(pwd, &pwd_stat) &&
  		    pwd_stat.st_dev == cwd_stat.st_dev &&
  		    pwd_stat.st_ino == cwd_stat.st_ino) {
  			strlcpy(cwd, pwd, PATH_MAX);
diff --git a/bisect.c b/bisect.c
index bd1b7b5..d4b1af7 100644
--- a/bisect.c
+++ b/bisect.c
@@ -1,6 +1,7 @@
  #include "cache.h"
  #include "commit.h"
  #include "diff.h"
+#include "filechange-cache.h"
  #include "revision.h"
  #include "refs.h"
  #include "list-objects.h"
@@ -649,7 +650,7 @@ static int is_expected_rev(const unsigned char *sha1)
  	FILE *fp;
  	int res = 0;

-	if (stat(filename, &st) || !S_ISREG(st.st_mode))
+	if (cached_stat(filename, &st) || !S_ISREG(st.st_mode))
  		return 0;

  	fp = fopen(filename, "r");
diff --git a/check-racy.c b/check-racy.c
index 00d92a1..c54be01 100644
--- a/check-racy.c
+++ b/check-racy.c
@@ -11,7 +11,7 @@ int main(int ac, char **av)
  		struct cache_entry *ce = active_cache[i];
  		struct stat st;

-		if (lstat(ce->name, &st)) {
+		if (cached_lstat(ce->name, &st)) {
  			error("lstat(%s): %s", ce->name, strerror(errno));
  			continue;
  		}
diff --git a/combine-diff.c b/combine-diff.c
index 35d41cd..b6a09a5 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -3,6 +3,7 @@
  #include "blob.h"
  #include "diff.h"
  #include "diffcore.h"
+#include "filechange-cache.h"
  #include "quote.h"
  #include "xdiff-interface.h"
  #include "log-tree.h"
@@ -806,7 +807,7 @@ static void show_patch_diff(struct combine_diff_path 
*elem, int num_parent,
  		struct stat st;
  		int fd = -1;

-		if (lstat(elem->path, &st) < 0)
+		if (cached_lstat(elem->path, &st) < 0)
  			goto deleted_file;

  		if (S_ISLNK(st.st_mode)) {
diff --git a/command-list.txt b/command-list.txt
index bf83303..9dec5e1 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -29,6 +29,7 @@ git-count-objects 
ancillaryinterrogators
  git-credential                          purehelpers
  git-credential-cache                    purehelpers
  git-credential-store                    purehelpers
+git-filechange-daemon			purehelpers
  git-cvsexportcommit                     foreignscminterface
  git-cvsimport                           foreignscminterface
  git-cvsserver                           foreignscminterface
diff --git a/config.c b/config.c
index aefd80b..99749fe 100644
--- a/config.c
+++ b/config.c
@@ -7,6 +7,7 @@
   */
  #include "cache.h"
  #include "exec_cmd.h"
+#include "filechange-cache.h"
  #include "strbuf.h"
  #include "quote.h"

@@ -1436,7 +1437,7 @@ int git_config_set_multivar_in_file(const char 
*config_filename,
  			goto out_free;
  		}

-		fstat(in_fd, &st);
+		cached_fstat(in_fd, &st);
  		contents_sz = xsize_t(st.st_size);
  		contents = xmmap(NULL, contents_sz, PROT_READ,
  			MAP_PRIVATE, in_fd, 0);
diff --git a/copy.c b/copy.c
index a7f58fd..972fabe 100644
--- a/copy.c
+++ b/copy.c
@@ -1,3 +1,4 @@
+#include "filechange-cache.h"
  #include "cache.h"

  int copy_fd(int ifd, int ofd)
@@ -39,7 +40,7 @@ static int copy_times(const char *dst, const char *src)
  {
  	struct stat st;
  	struct utimbuf times;
-	if (stat(src, &st) < 0)
+	if (cached_stat(src, &st) < 0)
  		return -1;
  	times.actime = st.st_atime;
  	times.modtime = st.st_mtime;
diff --git a/diff-lib.c b/diff-lib.c
index f35de0f..8d5a005 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -2,6 +2,7 @@
   * Copyright (C) 2005 Junio C Hamano
   */
  #include "cache.h"
+#include "filechange-cache.h"
  #include "quote.h"
  #include "commit.h"
  #include "diff.h"
@@ -27,7 +28,7 @@
   */
  static int check_removed(const struct cache_entry *ce, struct stat *st)
  {
-	if (lstat(ce->name, st) < 0) {
+	if (cached_lstat(ce->name, st) < 0) {
  		if (errno != ENOENT && errno != ENOTDIR)
  			return -1;
  		return 1;
diff --git a/diff-no-index.c b/diff-no-index.c
index 74da659..d3fb354 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -7,6 +7,7 @@
  #include "cache.h"
  #include "color.h"
  #include "commit.h"
+#include "filechange-cache.h"
  #include "blob.h"
  #include "tag.h"
  #include "diff.h"
@@ -51,7 +52,7 @@ static int get_mode(const char *path, int *mode)
  #endif
  	else if (path == file_from_standard_input)
  		*mode = create_ce_mode(0666);
-	else if (lstat(path, &st))
+	else if (cached_lstat(path, &st))
  		return error("Could not access '%s'", path);
  	else
  		*mode = st.st_mode;
diff --git a/diff.c b/diff.c
index 156fec4..a5be122 100644
--- a/diff.c
+++ b/diff.c
@@ -5,6 +5,7 @@
  #include "quote.h"
  #include "diff.h"
  #include "diffcore.h"
+#include "filechange-cache.h"
  #include "delta.h"
  #include "xdiff-interface.h"
  #include "color.h"
@@ -2629,7 +2630,7 @@ static int reuse_worktree_file(const char *name, 
const unsigned char *sha1, int
  	 * If ce matches the file in the work tree, we can reuse it.
  	 */
  	if (ce_uptodate(ce) ||
-	    (!lstat(name, &st) && !ce_match_stat(ce, &st, 0)))
+	    (!cached_lstat(name, &st) && !ce_match_stat(ce, &st, 0)))
  		return 1;

  	return 0;
@@ -2684,7 +2685,7 @@ int diff_populate_filespec(struct diff_filespec 
*s, int size_only)
  		struct stat st;
  		int fd;

-		if (lstat(s->path, &st) < 0) {
+		if (cached_lstat(s->path, &st) < 0) {
  			if (errno == ENOENT) {
  			err_empty:
  				err = -1;
@@ -2826,7 +2827,7 @@ static struct diff_tempfile 
*prepare_temp_file(const char *name,
  	if (!one->sha1_valid ||
  	    reuse_worktree_file(name, one->sha1, 1)) {
  		struct stat st;
-		if (lstat(name, &st) < 0) {
+		if (cached_lstat(name, &st) < 0) {
  			if (errno == ENOENT)
  				goto not_a_valid_file;
  			die_errno("stat(%s)", name);
@@ -3043,7 +3044,7 @@ static void diff_fill_sha1_info(struct 
diff_filespec *one)
  				hashcpy(one->sha1, null_sha1);
  				return;
  			}
-			if (lstat(one->path, &st) < 0)
+			if (cached_lstat(one->path, &st) < 0)
  				die_errno("stat '%s'", one->path);
  			if (index_path(one->sha1, one->path, &st, 0))
  				die("cannot hash %s", one->path);
diff --git a/diffcore-order.c b/diffcore-order.c
index 23e9385..636be01 100644
--- a/diffcore-order.c
+++ b/diffcore-order.c
@@ -4,6 +4,7 @@
  #include "cache.h"
  #include "diff.h"
  #include "diffcore.h"
+#include "filechange-cache.h"

  static char **order;
  static int order_cnt;
@@ -22,7 +23,7 @@ static void prepare_order(const char *orderfile)
  	fd = open(orderfile, O_RDONLY);
  	if (fd < 0)
  		return;
-	if (fstat(fd, &st)) {
+	if (cached_fstat(fd, &st)) {
  		close(fd);
  		return;
  	}
diff --git a/dir.c b/dir.c
index 57394e4..a67a592 100644
--- a/dir.c
+++ b/dir.c
@@ -476,7 +476,7 @@ int add_excludes_from_file_to_list(const char *fname,
  	char *buf, *entry;

  	fd = open(fname, O_RDONLY);
-	if (fd < 0 || fstat(fd, &st) < 0) {
+	if (fd < 0 || cached_fstat(fd, &st) < 0) {
  		if (errno != ENOENT)
  			warn_on_inaccessible(fname);
  		if (0 <= fd)
@@ -1551,7 +1551,7 @@ static int remove_dir_recurse(struct strbuf *path, 
int flag, int *kept_up)

  		strbuf_setlen(path, len);
  		strbuf_addstr(path, e->d_name);
-		if (lstat(path->buf, &st))
+		if (cached_lstat(path->buf, &st))
  			; /* fall thru */
  		else if (S_ISDIR(st.st_mode)) {
  			if (!remove_dir_recurse(path, flag, &kept_down))
diff --git a/filechange-cache.c b/filechange-cache.c
new file mode 100644
index 0000000..80c698f
--- /dev/null
+++ b/filechange-cache.c
@@ -0,0 +1,203 @@
+#include <unistd.h>
+#include <stdio.h>
+#include "builtin.h"
+#include "hash.h"
+#include "name-hash.h"
+#include "strbuf.h"
+#include "filechange-cache.h"
+
+
+static struct hash_table stat_cache;
+static const int CACHE_ENTRY_FILE_SIZE =
+	sizeof(struct stat) + /* sizeof(stat_cache_entry.st) */
+	sizeof(int); /* sizeof(stat_cache_entry.stat_return) */
+
+static void insert_stat_cache_entry(const char *path,
+				    struct stat_cache_entry *new_entry);
+
+void setup_stat_cache()
+{
+	init_hash(&stat_cache);
+}
+
+static int write_stat_cache_entry(void *void_stat_cache_entry, void 
*void_fp)
+{
+	FILE *fp = (FILE*)(void_fp);
+	const struct stat_cache_entry *entry =
+		(struct stat_cache_entry*)(void_stat_cache_entry);
+
+	for (; entry; entry = entry->next) {
+		if (fprintf(fp, "%s\n", entry->path) < 0)
+			die_errno("Unable to write to %s",
+				  git_path("WT_STATUS_TMP"));
+		if (fwrite(&entry->stat_return,
+			   CACHE_ENTRY_FILE_SIZE, 1, fp) < 0)
+			die_errno("Unable to write to %s",
+				  git_path("WT_STATUS_TMP"));
+	}
+	return 0;
+}
+
+void write_stat_cache()
+{
+	const char *status_tmp = git_path("WT_STATUS_TMP");
+	const char *status_output = git_path("WT_STATUS");
+	FILE *fp = fopen(status_tmp, "w");
+	if (!fp)
+		die_errno("Unable to create %s", status_tmp);
+	if (fprintf(fp, "version_format=1\n") < 0)
+		die_errno("Unable to write to %s", status_tmp);
+	for_each_hash(&stat_cache, write_stat_cache_entry, fp);
+	if (fclose(fp) < 0)
+		die_errno("Unable to close %s", status_tmp);
+	if (rename(status_tmp, status_output) < 0)
+		die_errno("Unable to rename %s to %s", status_tmp,
+			  status_output);
+}
+
+static void read_stat_cache_file()
+{
+	struct strbuf line = STRBUF_INIT;
+	const char *status_output = git_path("WT_STATUS");
+	int read_version = 0;
+
+	FILE *fp = fopen(status_output, "r");
+	if (!fp)
+		die_errno("Unable to read %s", status_output);
+	
+	if (strbuf_getline(&line, fp, '\n') != EOF) {
+		sscanf(line.buf, "version_format=%d\n", &read_version);
+		if (read_version != 1) {
+			die("Expected version 1 of stat_cache file");
+		}
+	}
+
+	while (strbuf_getline(&line, fp, '\n') != EOF) {
+		struct stat_cache_entry *entry =
+			(struct stat_cache_entry*)(xcalloc(1, sizeof(*entry)));
+		entry->path = xstrdup(line.buf);
+		if (fread(&entry->stat_return,
+			  CACHE_ENTRY_FILE_SIZE, 1, fp) != 1) {
+			die_errno("Unable to read stat_cache file");
+		}
+		insert_stat_cache_entry(entry->path, entry);
+	}
+
+	strbuf_release(&line);
+}
+
+static int request_stat_cache_file()
+{
+	int count = 0;
+	int stat_return_code = 0;
+	const char *request_path = git_path("REQUEST_WT_STATUS");
+	const char *status_output = git_path("WT_STATUS");
+	struct stat stat_buf;
+
+	char buffer[1] = { 0 };
+	FILE *fp = NULL;
+
+	if (0 != stat(request_path, &stat_buf))
+		return 0;
+	
+	if (unlink(status_output) != 0 && (errno != ENOENT))
+		die_errno("Unable to remove %s", status_output);
+
+	fp = fopen(request_path, "w");
+	if (!fp) {
+		die_errno("Unable to open %s", request_path);
+	}
+
+	if (fwrite(&buffer, 0, 0, fp) != 0)
+		die_errno("Unable to write to %s", request_path);
+	
+	for (count = 0;
+	     (count < 10) &&
+		     ((stat_return_code = stat(status_output, &stat_buf)) != 0) &&
+		     (errno == ENOENT);
+	     count++) {
+		usleep(1000);
+	}
+
+	return stat_return_code == 0;
+}
+
+void read_stat_cache()
+{
+	static int read_cache = 1;
+	if (read_cache && request_stat_cache_file()) {
+		read_stat_cache_file();
+		read_cache = 0;
+	}
+	read_cache = 0;
+}
+
+struct stat_cache_entry *get_stat_cache_entry(const char *path)
+{
+	const unsigned int hash = hash_name(path, strlen(path));
+	struct stat_cache_entry *entry = NULL;
+	for(entry = lookup_hash(hash, &stat_cache); entry;
+	    entry = entry->next) {
+		if (!strcmp(path, entry->path)) return entry;
+	}
+	return NULL;
+}
+
+static void insert_stat_cache_entry(const char *path,
+				    struct stat_cache_entry *new_entry)
+{
+	assert(get_stat_cache_entry(path) == NULL);
+
+	void **insert_result =
+		insert_hash(hash_name(path, strlen(path)), (void*)new_entry,
+			    &stat_cache);
+	if (!insert_result) return;
+	struct stat_cache_entry *existing_entry =
+		(struct stat_cache_entry*)(*insert_result);
+	while(existing_entry->next) {
+		existing_entry = existing_entry->next;
+	}
+	assert(!existing_entry->next);
+	existing_entry->next = new_entry;
+}
+
+void update_stat_cache(const char *path)
+{
+	struct stat_cache_entry *entry = get_stat_cache_entry(path);
+	if (!entry) {
+		entry = (struct stat_cache_entry*)(xcalloc(1, sizeof(*entry)));
+		entry->path = xstrdup(path);
+		insert_stat_cache_entry(path, entry);
+	}
+	
+	entry->stat_return = lstat(path, &entry->st);
+}
+
+int cached_stat(const char *path, struct stat *buf)
+{
+	return stat(path, buf);
+}
+
+int cached_fstat(int fd, struct stat *buf)
+{
+	return fstat(fd, buf);
+}
+
+int cached_lstat(const char *path, struct stat *buf)
+{
+	int stat_return_value = 0;
+	struct stat_cache_entry *entry = 0;
+
+	read_stat_cache();
+
+	entry = get_stat_cache_entry(path);
+
+	stat_return_value = lstat(path, buf);
+	
+	if (entry && (stat_return_value != entry->stat_return) &&
+	    (memcpy(&entry->st, buf, sizeof(*buf)))) {
+		abort();
+	}
+	
+	return stat_return_value;
+}
diff --git a/filechange-cache.h b/filechange-cache.h
new file mode 100644
index 0000000..75a9f79
--- /dev/null
+++ b/filechange-cache.h
@@ -0,0 +1,20 @@
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
+
+struct stat_cache_entry {
+	const char *path;
+	struct stat_cache_entry *next;
+	int stat_return;
+	struct stat st;
+};
+
+extern void write_stat_cache();
+extern void read_stat_cache();
+extern void setup_stat_cache();
+extern struct stat_cache_entry *get_stat_cache_entry(const char *path);
+extern void update_stat_cache(const char *path);
+
+extern int cached_stat(const char *path, struct stat *buf);
+extern int cached_fstat(int fd, struct stat *buf);
+extern int cached_lstat(const char *path, struct stat *buf);
diff --git a/filechange-daemon.c b/filechange-daemon.c
new file mode 100644
index 0000000..df6f0d3
--- /dev/null
+++ b/filechange-daemon.c
@@ -0,0 +1,164 @@
+#include <stdio.h>
+#include <libgen.h>
+#include <x86_64-linux-gnu/sys/inotify.h>
+
+#include "filechange-cache.h"
+#include "builtin.h"
+#include "dir.h"
+#include "hash.h"
+
+static int request_watch_descriptor = -1;
+static int root_directory_watch_descriptor = -1;
+
+static void setup_environment()
+{
+	setup_stat_cache();
+}
+
+static int setup_inotify()
+{
+	int inotify_fd = inotify_init();
+	if (inotify_fd < 0) {
+		die_errno("Unable to create inotify watch");
+	}
+	return inotify_fd;
+}
+
+static void restart()
+{
+
+}
+
+
+static void watch_control(int inotify_fd)
+{
+	struct stat stat_buf;
+	const char *request_path = git_path("REQUEST_WT_STATUS");
+
+	if ((stat(request_path, &stat_buf) == -1) && (errno == ENOENT)) {
+		FILE *out = fopen(request_path, "w");
+		if (out == NULL)
+			die_errno("Unable to create %s", request_path);
+	}
+
+	request_watch_descriptor = inotify_add_watch(inotify_fd,
+						     request_path, IN_MODIFY);
+	
+	if (request_watch_descriptor < 0)
+		die_errno("Unable to watch %s", get_git_dir());
+}
+
+static void watch_file(int inotify_fd, const char *path)
+{
+	int watch_descriptor = 0;
+	char *path_copy = xstrdup(path);
+	char *dir = dirname(path_copy);
+	const int interest_set =
+		IN_MODIFY  | IN_DELETE | IN_CREATE  |
+		IN_DELETE_SELF | IN_MOVE_SELF |
+		IN_MOVED_TO;
+
+	watch_descriptor = inotify_add_watch(inotify_fd, dir, interest_set);
+	if (watch_descriptor < 0)
+		die_errno("Unable to create inotify watch for %s", dir);
+
+	watch_descriptor = inotify_add_watch(inotify_fd, path, interest_set);
+	if (watch_descriptor < 0)
+		die_errno("Unable to create inotify watch for %s", dir);
+	update_stat_cache(path);
+
+	free(path_copy);
+}
+
+static void watch_directory(int inotify_fd)
+{
+	char buf[PATH_MAX];
+
+	if (!getcwd(buf, sizeof(buf)))
+		die_errno("Unable to get current directory");
+
+	int i = 0;
+	struct dir_struct dir;
+	const char *pathspec[1] = { buf, NULL };
+
+	memset(&dir, 0, sizeof(dir));
+	setup_standard_excludes(&dir);
+
+	fill_directory(&dir, pathspec);
+	for(i = 0; i < dir.nr; i++) {
+		struct dir_entry *ent = dir.entries[i];
+		watch_file(inotify_fd, ent->name);
+		free(ent);
+	}
+
+	free(dir.entries);
+	free(dir.ignored);
+}
+
+static void watch_root_directory(int inotify_fd)
+{
+	char buf[PATH_MAX];
+
+	if (!getcwd(buf, sizeof(buf)))
+		die_errno("Unable to get current directory");
+
+	root_directory_watch_descriptor =
+		inotify_add_watch(inotify_fd, buf, IN_DELETE);
+	if (root_directory_watch_descriptor < 0)
+		die_errno("Unable to watch %s directory", buf);
+}
+
+#define INOTIFY_EVENT_SIZE  (sizeof (struct inotify_event)  + PATH_MAX + 1)
+
+static void remove_request_file(void)
+{
+	const char *request_path = git_path("REQUEST_WT_STATUS");
+	if (unlink(request_path)) {
+		die_errno("Unable to remove %s on exit",
+			  request_path);
+	}
+}
+
+static void loop(int inotify_fd)
+{
+	char buffer[INOTIFY_EVENT_SIZE * 10];
+	int length = 0;
+	
+	while (1) {
+		int i = 0;
+		length = read(inotify_fd, buffer, sizeof(buffer));
+		for(i = 0; i < length; ) {
+			struct inotify_event *event =
+				(struct inotify_event*)(buffer+i);
+			/* printf("event: %d %x %d %s\n", event->wd, event->mask,
+			   event->len, event->name); */
+			if (request_watch_descriptor == event->wd) {
+				write_stat_cache();
+			} else if (root_directory_watch_descriptor
+				   == event->wd) {
+				printf("root directory died!\n");
+				exit(0);
+			} else if (event->mask & IN_Q_OVERFLOW) {
+				restart();
+			} else if (event->mask & IN_MODIFY) {
+				if (event->len)
+					update_stat_cache(event->name);
+			}
+			
+			i += sizeof(struct inotify_event) + event->len;
+		}
+	}
+}
+
+int main(int argc, const char **argv)
+{
+	const int inotify_fd = setup_inotify();
+
+	atexit(remove_request_file);
+	setup_environment();
+	watch_control(inotify_fd);
+	watch_root_directory(inotify_fd);
+	watch_directory(inotify_fd);
+	loop(inotify_fd);
+	return 0;
+}
diff --git a/filechange-printer.c b/filechange-printer.c
new file mode 100644
index 0000000..fe43d80
--- /dev/null
+++ b/filechange-printer.c
@@ -0,0 +1,13 @@
+#include <stdio.h>
+#include "filechange-cache.h"
+
+int main()
+{
+	struct stat_cache_entry *entry = NULL;
+	const char *missing = "t/t7201-co.sh";
+	read_stat_cache();
+	
+	entry = get_stat_cache_entry(missing);
+	printf("%p\n", entry);
+	return 0;
+}
diff --git a/git.c b/git.c
index b10c18b..ea92a65 100644
--- a/git.c
+++ b/git.c
@@ -504,6 +504,31 @@ static int run_argv(int *argcp, const char ***argv)
  }


+static void fork_filechange_daemon()
+{
+	struct stat stat_buf;
+	FILE *log = fopen("/tmp/foo.txt", "a");
+	fprintf(log, "cwd = %s\n", get_current_dir_name());
+
+	if (stat(git_path("REQUEST_WT_STATUS"), &stat_buf) == -1) {
+		pid_t child = 0;
+
+		child = fork();
+		fprintf(log, "starting %d\n", (int)child);
+		if (!child) {
+			fclose(log);
+			execl("/home/razeh/src/git/git-filechange-daemon",
+			      "/home/razeh/src/git/git-filechange-daemon",
+			      get_current_dir_name(),
+			      (char*) NULL);
+			die_errno("Unable to launch file change daemon");
+		}
+	} else {
+		fprintf(log, "already running\n");
+	}
+
+}
+
  int main(int argc, const char **argv)
  {
  	const char *cmd;
@@ -558,6 +583,8 @@ int main(int argc, const char **argv)
  	 */
  	setup_path();

+	fork_filechange_daemon();
+
  	while (1) {
  		static int done_help = 0;
  		static int was_alias = 0;
diff --git a/ll-merge.c b/ll-merge.c
index fb61ea6..7ced2bb 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -6,6 +6,7 @@

  #include "cache.h"
  #include "attr.h"
+#include "filechange-cache.h"
  #include "xdiff-interface.h"
  #include "run-command.h"
  #include "ll-merge.h"
@@ -195,7 +196,7 @@ static int ll_ext_merge(const struct ll_merge_driver 
*fn,
  	fd = open(temp[1], O_RDONLY);
  	if (fd < 0)
  		goto bad;
-	if (fstat(fd, &st))
+	if (cached_fstat(fd, &st))
  		goto close_bad;
  	result->size = st.st_size;
  	result->ptr = xmalloc(result->size + 1);
diff --git a/merge-recursive.c b/merge-recursive.c
index ea9dbd3..7d371d6 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -12,6 +12,7 @@
  #include "tree-walk.h"
  #include "diff.h"
  #include "diffcore.h"
+#include "filechange-cache.h"
  #include "tag.h"
  #include "unpack-trees.h"
  #include "string-list.h"
@@ -606,7 +607,7 @@ static char *unique_path(struct merge_options *o, 
const char *path, const char *
  			*p = '_';
  	while (string_list_has_string(&o->current_file_set, newpath) ||
  	       string_list_has_string(&o->current_directory_set, newpath) ||
-	       lstat(newpath, &st) == 0)
+	       cached_lstat(newpath, &st) == 0)
  		sprintf(p, "_%d", suffix++);

  	string_list_insert(&o->current_file_set, newpath);
@@ -634,7 +635,7 @@ static int dir_in_way(const char *path, int 
check_working_copy)
  	}

  	free(dirpath);
-	return check_working_copy && !lstat(path, &st) && S_ISDIR(st.st_mode);
+	return check_working_copy && !cached_lstat(path, &st) && 
S_ISDIR(st.st_mode);
  }

  static int was_tracked(const char *path)
diff --git a/name-hash.c b/name-hash.c
index d8d25c2..d88185f 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -7,6 +7,7 @@
   */
  #define NO_THE_INDEX_COMPATIBILITY_MACROS
  #include "cache.h"
+#include "name-hash.h"

  /*
   * This removes bit 5 if bit 6 is set.
@@ -20,7 +21,7 @@ static inline unsigned char icase_hash(unsigned char c)
  	return c & ~((c & 0x40) >> 1);
  }

-static unsigned int hash_name(const char *name, int namelen)
+unsigned int hash_name(const char *name, int namelen)
  {
  	unsigned int hash = 0x123;

diff --git a/name-hash.h b/name-hash.h
new file mode 100644
index 0000000..3355d94
--- /dev/null
+++ b/name-hash.h
@@ -0,0 +1 @@
+extern unsigned int hash_name(const char *name, int namelen);
diff --git a/notes-merge.c b/notes-merge.c
index 0f67bd3..f792f83 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -3,6 +3,7 @@
  #include "refs.h"
  #include "diff.h"
  #include "diffcore.h"
+#include "filechange-cache.h"
  #include "xdiff-interface.h"
  #include "ll-merge.h"
  #include "dir.h"
@@ -731,7 +732,7 @@ int notes_merge_commit(struct notes_merge_options *o,

  		strbuf_addstr(&path, e->d_name);
  		/* write file as blob, and add to partial_tree */
-		if (stat(path.buf, &st))
+		if (cached_stat(path.buf, &st))
  			die_errno("Failed to stat '%s'", path.buf);
  		if (index_path(blob_sha1, path.buf, &st, HASH_WRITE_OBJECT))
  			die("Failed to write blob object from '%s'", path.buf);
diff --git a/path.c b/path.c
index d3d3f8b..6844d2d 100644
--- a/path.c
+++ b/path.c
@@ -11,6 +11,7 @@
   * which is what it's designed for.
   */
  #include "cache.h"
+#include "filechange-cache.h"
  #include "strbuf.h"
  #include "string-list.h"

@@ -360,7 +361,7 @@ const char *enter_repo(const char *path, int strict)
  		for (i = 0; suffix[i]; i++) {
  			struct stat st;
  			strcpy(used_path + len, suffix[i]);
-			if (!stat(used_path, &st) &&
+			if (!cached_stat(used_path, &st) &&
  			    (S_ISREG(st.st_mode) ||
  			    (S_ISDIR(st.st_mode) && is_git_directory(used_path)))) {
  				strcat(validated_path, suffix[i]);
@@ -400,7 +401,7 @@ int set_shared_perm(const char *path, int mode)
  		return 0;
  	}
  	if (!mode) {
-		if (lstat(path, &st) < 0)
+		if (cached_lstat(path, &st) < 0)
  			return -1;
  		mode = st.st_mode;
  		orig_mode = mode;
diff --git a/read-cache.c b/read-cache.c
index 827ae55..508ddc1 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -8,6 +8,7 @@
  #include "cache-tree.h"
  #include "refs.h"
  #include "dir.h"
+#include "filechange-cache.h"
  #include "tree.h"
  #include "commit.h"
  #include "blob.h"
@@ -672,7 +673,7 @@ int add_to_index(struct index_state *istate, const 
char *path, struct stat *st,
  int add_file_to_index(struct index_state *istate, const char *path, 
int flags)
  {
  	struct stat st;
-	if (lstat(path, &st))
+	if (cached_lstat(path, &st))
  		die_errno("unable to stat '%s'", path);
  	return add_to_index(istate, path, &st, flags);
  }
@@ -1032,7 +1033,7 @@ static struct cache_entry 
*refresh_cache_ent(struct index_state *istate,
  		return ce;
  	}

-	if (lstat(ce->name, &st) < 0) {
+	if (cached_lstat(ce->name, &st) < 0) {
  		if (err)
  			*err = errno;
  		return NULL;
@@ -1430,7 +1431,7 @@ int read_index_from(struct index_state *istate, 
const char *path)
  		die_errno("index file open failed");
  	}

-	if (fstat(fd, &st))
+	if (cached_fstat(fd, &st))
  		die_errno("cannot stat the open index");

  	mmap_size = xsize_t(st.st_size);
@@ -1618,7 +1619,7 @@ static void ce_smudge_racily_clean_entry(struct 
cache_entry *ce)
  	 */
  	struct stat st;

-	if (lstat(ce->name, &st) < 0)
+	if (cached_lstat(ce->name, &st) < 0)
  		return;
  	if (ce_match_stat_basic(ce, &st))
  		return;
@@ -1830,7 +1831,7 @@ int write_index(struct index_state *istate, int newfd)
  			return -1;
  	}

-	if (ce_flush(&c, newfd) || fstat(newfd, &st))
+	if (ce_flush(&c, newfd) || cached_fstat(newfd, &st))
  		return -1;
  	istate->timestamp.sec = (unsigned int)st.st_mtime;
  	istate->timestamp.nsec = ST_MTIME_NSEC(st);
diff --git a/rerere.c b/rerere.c
index a6a5cd5..5115d0e 100644
--- a/rerere.c
+++ b/rerere.c
@@ -1,4 +1,5 @@
  #include "cache.h"
+#include "filechange-cache.h"
  #include "string-list.h"
  #include "rerere.h"
  #include "xdiff-interface.h"
@@ -28,7 +29,7 @@ const char *rerere_path(const char *hex, const char *file)
  static int has_rerere_resolution(const char *hex)
  {
  	struct stat st;
-	return !stat(rerere_path(hex, "postimage"), &st);
+	return !cached_stat(rerere_path(hex, "postimage"), &st);
  }

  static void read_rr(struct string_list *rr)
@@ -681,13 +682,13 @@ int rerere_forget(const char **pathspec)
  static time_t rerere_created_at(const char *name)
  {
  	struct stat st;
-	return stat(rerere_path(name, "preimage"), &st) ? (time_t) 0 : 
st.st_mtime;
+	return cached_stat(rerere_path(name, "preimage"), &st) ? (time_t) 0 : 
st.st_mtime;
  }

  static time_t rerere_last_used_at(const char *name)
  {
  	struct stat st;
-	return stat(rerere_path(name, "postimage"), &st) ? (time_t) 0 : 
st.st_mtime;
+	return cached_stat(rerere_path(name, "postimage"), &st) ? (time_t) 0 : 
st.st_mtime;
  }

  static void unlink_rr_item(const char *name)
diff --git a/setup.c b/setup.c
index 2e1521b..690987a 100644
--- a/setup.c
+++ b/setup.c
@@ -1,5 +1,6 @@
  #include "cache.h"
  #include "dir.h"
+#include "filechange-cache.h"
  #include "string-list.h"

  static int inside_git_dir = -1;
@@ -74,7 +75,7 @@ int check_filename(const char *prefix, const char *arg)
  		name = prefix_filename(prefix, strlen(prefix), arg);
  	else
  		name = arg;
-	if (!lstat(name, &st))
+	if (!cached_lstat(name, &st))
  		return 1; /* file exists */
  	if (errno == ENOENT || errno == ENOTDIR)
  		return 0; /* file does not exist */
@@ -638,7 +639,7 @@ static const char *setup_nongit(const char *cwd, int 
*nongit_ok)
  static dev_t get_device_or_die(const char *path, const char *prefix, 
int prefix_len)
  {
  	struct stat buf;
-	if (stat(path, &buf)) {
+	if (cached_stat(path, &buf)) {
  		die_errno("failed to stat '%*s%s%s'",
  				prefix_len,
  				prefix ? prefix : "",
diff --git a/test-chmtime.c b/test-chmtime.c
index 92713d1..bb5f22a 100644
--- a/test-chmtime.c
+++ b/test-chmtime.c
@@ -81,7 +81,7 @@ int main(int argc, const char *argv[])
  		struct stat sb;
  		struct utimbuf utb;

-		if (stat(argv[i], &sb) < 0) {
+		if (cached_stat(argv[i], &sb) < 0) {
  			fprintf(stderr, "Failed to stat %s: %s\n",
  			        argv[i], strerror(errno));
  			return -1;
diff --git a/test-wildmatch.c b/test-wildmatch.c
index a3e2643..838ff69 100644
--- a/test-wildmatch.c
+++ b/test-wildmatch.c
@@ -19,7 +19,7 @@ static int perf(int ac, char **av)
  	if (lang && strcmp(lang, "C"))
  		die("Please test it on C locale.");

-	if ((fd = open(file, O_RDONLY)) == -1 || fstat(fd, &st))
+	if ((fd = open(file, O_RDONLY)) == -1 || cached_fstat(fd, &st))
  		die_errno("file open");

  	buffer = xmalloc(st.st_size + 2);
diff --git a/unpack-trees.c b/unpack-trees.c
index 09e53df..fc20be4 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1430,13 +1430,13 @@ static int verify_absent_1(struct cache_entry *ce,
  		char path[PATH_MAX + 1];
  		memcpy(path, ce->name, len);
  		path[len] = 0;
-		if (lstat(path, &st))
+		if (cached_lstat(path, &st))
  			return error("cannot stat '%s': %s", path,
  					strerror(errno));

  		return check_ok_to_remove(path, len, DT_UNKNOWN, NULL, &st,
  				error_type, o);
-	} else if (lstat(ce->name, &st)) {
+	} else if (cached_lstat(ce->name, &st)) {
  		if (errno != ENOENT)
  			return error("cannot stat '%s': %s", ce->name,
  				     strerror(errno));
@@ -1838,7 +1838,7 @@ int oneway_merge(struct cache_entry **src, struct 
unpack_trees_options *o)
  		int update = 0;
  		if (o->reset && o->update && !ce_uptodate(old) && 
!ce_skip_worktree(old)) {
  			struct stat st;
-			if (lstat(old->name, &st) ||
+			if (cached_lstat(old->name, &st) ||
  			    ie_match_stat(o->src_index, old, &st, 
CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE))
  				update |= CE_UPDATE;
  		}
-- 
1.8.2.rc0.29.g3a0aba8.dirty
