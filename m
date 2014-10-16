From: Gabriel de Perthuis <g2p.code@gmail.com>
Subject: [PATCH] diff: Handle process substitution
Date: Thu, 16 Oct 2014 17:18:44 +0200
Message-ID: <543FE1D4.6020707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 16 17:19:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XempX-0004gF-5R
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 17:19:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbaJPPSu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2014 11:18:50 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:64252 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251AbaJPPSs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2014 11:18:48 -0400
Received: by mail-wi0-f175.google.com with SMTP id d1so1825167wiv.2
        for <git@vger.kernel.org>; Thu, 16 Oct 2014 08:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=pLymALQaMsz7bbS7EW8hiue0NIAJbp3QcMHPjsVaorI=;
        b=foQ3UjaS2WgWHGVHokK/3rWavAtIYxUXlXIOZqV3C5OIkLYxpNDSdQwhAiclYeWrS3
         VIXdxW8Phky2/3QJYloOB6ZwfOkwO1gUp4uIkVhwlcgePGsw502fp5XA3LFHTlnJdX/H
         lpx5FVU8f4rGq7KxWDgp81NVp10vV/gjsvJSMMibhpVCNxZAgNfvRixtHXgZnK+6p1uL
         H1Wi7dEr6qFOtUTiXIpkzHU4RA6MKCWQEljUL0DzQANTco8tGs5bddT11EwBAsQOLhkr
         fQfwErI/PTdLqqUmMc9ekDzzbXF3ubTHjUROC5Dju1arD3Kw6uRSzCSC93GMiswLBGze
         tjJQ==
X-Received: by 10.194.223.101 with SMTP id qt5mr3046380wjc.58.1413472727214;
        Thu, 16 Oct 2014 08:18:47 -0700 (PDT)
Received: from ?IPv6:2a01:e35:8a2c:b230:bc19:4780:33ca:e2ee? ([2a01:e35:8a2c:b230:bc19:4780:33ca:e2ee])
        by mx.google.com with ESMTPSA id w13sm27782970wjq.29.2014.10.16.08.18.45
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Oct 2014 08:18:46 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For example:

    git diff --color-words <(echo a b c) <(echo a d c)

Changes to struct diff_filespec:
- is_stdin renamed to skip_hashing, which is what it did
- follow_symlinks added, causing diff_populate_filespec to look at
  file contents instead of the readlink value

Paths that are handled specially (using
skip_hashing and follow_symlinks):

/dev/stdin added as an alternative to -
/dev/fd/*
/proc/self/fd/*

The first two are standard ways to refer to file descriptors,
and there is precedence for handling them specially (bash
redirections for example).  The last one is there to support
zsh process substitution, which on Linux uses an OS-specific path.
---
 Documentation/git-diff.txt |  7 +++++++
 diff-no-index.c            |  8 +++++++-
 diff.c                     | 26 +++++++++++++++++++++-----
 diffcore.h                 |  8 +++++---
 4 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index bbab35f..f4ca476 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -99,10 +99,17 @@ include::diff-options.txt[]
  <path>...::
 	The <paths> parameters, when given, are used to limit
 	the diff to the named paths (you can give directory
 	names and get diff for all files under them).
+	+
+	With --no-index, or with paths outside the worktree,
+	some paths are handled specially: - and /dev/stdin
+	refer to standard input, and /dev/fd/* can be used
+	to refer to existing file descriptors, as in:
+
+	$ git diff --color-words <(echo a b c) <(echo a d c)
   include::diff-format.txt[]
  EXAMPLES
diff --git a/diff-no-index.c b/diff-no-index.c
index 265709b..586036b 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -70,11 +70,11 @@ static int populate_from_stdin(struct diff_filespec *s)
  	s->should_munmap = 0;
 	s->data = strbuf_detach(&buf, &size);
 	s->size = size;
 	s->should_free = 1;
-	s->is_stdin = 1;
+	s->skip_hashing = 1;
 	return 0;
 }
  static struct diff_filespec *noindex_filespec(const char *name, int mode)
 {
@@ -84,10 +84,16 @@ static struct diff_filespec *noindex_filespec(const
char *name, int mode)
 		name = "/dev/null";
 	s = alloc_filespec(name);
 	fill_filespec(s, null_sha1, 0, mode);
 	if (name == file_from_standard_input)
 		populate_from_stdin(s);
+	else if (!strcmp(name, "/dev/stdin") ||
+			 !strncmp(name, "/dev/fd/", 8) ||
+			 !strncmp(name, "/proc/self/fd/", 14)) {
+		s->skip_hashing = 1;
+		s->follow_symlinks = 1;
+	}
 	return s;
 }
  static int queue_diff(struct diff_options *o,
 		      const char *name1, const char *name2)
diff --git a/diff.c b/diff.c
index d7a5c81..c1150d7 100644
--- a/diff.c
+++ b/diff.c
@@ -2711,22 +2711,26 @@ int diff_populate_filespec(struct diff_filespec
*s, unsigned int flags)
 	    reuse_worktree_file(s->path, s->sha1, 0)) {
 		struct strbuf buf = STRBUF_INIT;
 		struct stat st;
 		int fd;
 -		if (lstat(s->path, &st) < 0) {
+		if (s->follow_symlinks)
+			err = stat(s->path, &st);
+		else
+			err = lstat(s->path, &st);
+		if (err < 0) {
 			if (errno == ENOENT) {
 			err_empty:
 				err = -1;
 			empty:
 				s->data = (char *)"";
 				s->size = 0;
 				return err;
 			}
 		}
 		s->size = xsize_t(st.st_size);
-		if (!s->size)
+		if (S_ISREG(st.st_mode) && !s->size)
 			goto empty;
 		if (S_ISLNK(st.st_mode)) {
 			struct strbuf sb = STRBUF_INIT;
  			if (strbuf_readlink(&sb, s->path, s->size))
@@ -2744,13 +2748,25 @@ int diff_populate_filespec(struct diff_filespec
*s, unsigned int flags)
 			return 0;
 		}
 		fd = open(s->path, O_RDONLY);
 		if (fd < 0)
 			goto err_empty;
-		s->data = xmmap(NULL, s->size, PROT_READ, MAP_PRIVATE, fd, 0);
+		if (S_ISREG(st.st_mode)) {
+			s->data = xmmap(NULL, s->size, PROT_READ, MAP_PRIVATE, fd, 0);
+			s->should_munmap = 1;
+		} else {
+			struct strbuf sb = STRBUF_INIT;
+			if (strbuf_read(&sb, fd, s->size) < 0) {
+				err = error("error while reading from %s: %s",
+				     s->path, strerror(errno));
+				goto err_empty;
+			}
+			s->data = strbuf_detach(&sb, &s->size);
+			s->should_munmap = 0;
+			s->should_free = 1;
+		}
 		close(fd);
-		s->should_munmap = 1;
  		/*
 		 * Convert from working tree format to canonical git format
 		 */
 		if (convert_to_git(s->path, s->data, s->size, &buf, crlf_warn)) {
@@ -3082,11 +3098,11 @@ static void run_diff_cmd(const char *pgm,
 static void diff_fill_sha1_info(struct diff_filespec *one)
 {
 	if (DIFF_FILE_VALID(one)) {
 		if (!one->sha1_valid) {
 			struct stat st;
-			if (one->is_stdin) {
+			if (one->skip_hashing) {
 				hashcpy(one->sha1, null_sha1);
 				return;
 			}
 			if (lstat(one->path, &st) < 0)
 				die_errno("stat '%s'", one->path);
diff --git a/diffcore.h b/diffcore.h
index 33ea2de..e19b379 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -32,20 +32,22 @@ struct diff_filespec {
 	unsigned long size;
 	int count;               /* Reference count */
 	int rename_used;         /* Count of rename users */
 	unsigned short mode;	 /* file mode */
 	unsigned sha1_valid : 1; /* if true, use sha1 and trust mode;
-				  * if false, use the name and read from
-				  * the filesystem.
+				  * if false, and skip_hashing is false, fill sha1
+				  * by using path and reading from the filesystem.
+				  * If skip_hashing is true, use null_sha1.
 				  */
 #define DIFF_FILE_VALID(spec) (((spec)->mode) != 0)
 	unsigned should_free : 1; /* data should be free()'ed */
 	unsigned should_munmap : 1; /* data should be munmap()'ed */
 	unsigned dirty_submodule : 2;  /* For submodules: its work tree is
dirty */
 #define DIRTY_SUBMODULE_UNTRACKED 1
 #define DIRTY_SUBMODULE_MODIFIED  2
-	unsigned is_stdin : 1;
+	unsigned skip_hashing : 1;
+	unsigned follow_symlinks : 1;
 	unsigned has_more_entries : 1; /* only appear in combined diff */
 	/* data should be considered "binary"; -1 means "don't know yet" */
 	signed int is_binary : 2;
 	struct userdiff_driver *driver;
 };
-- 
2.1.2.378.g50ea8b6
