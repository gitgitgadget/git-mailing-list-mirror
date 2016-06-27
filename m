Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 202321FF40
	for <e@80x24.org>; Mon, 27 Jun 2016 05:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbcF0FiT (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 01:38:19 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36519 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894AbcF0FiS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 01:38:18 -0400
Received: by mail-wm0-f68.google.com with SMTP id c82so21566627wme.3
        for <git@vger.kernel.org>; Sun, 26 Jun 2016 22:38:17 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=TVjmJlKSj0lbFOiK3l0THRYBEURjSSl9vPZw1EMPY5I=;
        b=VXAm80OSXr7FJeo0zmDGSI3/uh/L2vxgjEmg//cI40VqFEviVblXPdohf9HG1reJ9V
         ZMA3DowYIyaJTVEj6fNcGeT+SS/NxzV4WlS+rBrNFoc+2pVQY1oPMis2H6sKnAISp8j5
         LK1/lRYCJauIGEIFSH6mCIqKDIOQfAC+p/5CPMhJTNVRBFYyKavge9Wm1trfqg2I++Dj
         +7AzR8XnJI7rP2+E/FFJgoHH8gFfxjDdf8ANIrdftfSc8uuLhnSl8KVqzFHOMTWEcF/c
         dgCsIKDTIephSJC51X4m465Zchc9+Xfpl0ARQKOYYnQwYlBfkgw0A6KvwWqnTqLB/wRc
         rcDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TVjmJlKSj0lbFOiK3l0THRYBEURjSSl9vPZw1EMPY5I=;
        b=HBo9e/+dUJCuWkYD4ZCOvC8Qwm2LujmiXJJKSFb2X8JrGxfKph8gtdvE4EsSB9NvBF
         DWIEi1MnEw7YzaMFNCPSeLvyXaUo8RHmso5pVbtPDEHQuuaXb6mTgkHKkhWv+VtGzFp4
         qLjA5ue/zgAqKGgdFfw/mZRFU1u1QPBqN5HSCWqV9T+uwBnciVlEb+wmC7CTRZ+1PL11
         l8P7Hsu3DTGyHI3X+MtVyyh1HGDXeefKEDn3mPySiVUcNmgP9w/kvaZYVR93D3C44pbH
         LLFMm90mSKwRBhBwbgHY/6ivl4t8x7scKXji3LPPoJyM4GWHtEs4zohxNyRBoAkB5Lpk
         r48g==
X-Gm-Message-State: ALyK8tJ6HcDvkz/kk9YvezAnZ1KhIEWxgMaDG3mY4KNARYmF4DWqjrh0wgbQ84ENftFaLw==
X-Received: by 10.194.114.106 with SMTP id jf10mr15963863wjb.48.1467005896213;
        Sun, 26 Jun 2016 22:38:16 -0700 (PDT)
Received: from slxBook3.fritz.box (p5DDB4A71.dip0.t-ipconnect.de. [93.219.74.113])
        by smtp.gmail.com with ESMTPSA id bb4sm12797660wjb.32.2016.06.26.22.38.15
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 26 Jun 2016 22:38:15 -0700 (PDT)
From:	larsxschneider@gmail.com
To:	git@vger.kernel.org
Cc:	Lars Schneider <larsxschneider@gmail.com>
Subject: [RFC] Native access to Git LFS cache
Date:	Mon, 27 Jun 2016 07:38:33 +0200
Message-Id: <1467005913-6503-1-git-send-email-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.5.1
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Hi,

I found a way to make Git LFS faster up to a factor of 100x in
repositories with a large number of Git LFS files. I am looking
for comments if my approach would be acceptable by the Git community.

## What is Git LFS?
Git LFS [1] is an extension to Git that handles large files for Git
repositories. The project gained quite some momentum as almost all major
Git hosting services support it (GitHub [1], Atlassian Bitbucket [2],
GitLab [4]).

## What is the problem with Git LFS?
Git LFS is an application that is executed via Git clean/smudge filter.
The process invocation of these filters requires noticeable time (especially
on Windows) even if the Git LFS executable only accesses its local cache.

Based on my previous findings [5] Steve Streeting (@sinbad) improved the
clone times of Git LFS repositories with a lot of files by a factor of 10
or more [6][7].

Unfortunately that fix helps only with cloning. Any local Git operation
that invokes the clean/smudge filter (e.g. switching branches) is still
slow. Even on the Git mailing list a user reported that issue [8].


## Proposed solution
Git LFS caches its objects under .git/lfs/objects. Most of the time Git
LFS objects are already available in the cache (e.g. if you switch branches
back and forth). I implemented these "cache hits" natively in Git.
Please note that this implementation is just a quick and dirty proof of
concept. If the Git community agrees that this kind of approach would be
acceptable then I will start to work on a proper patch series with cross
platform support and unit tests.


## Performance tests
I executed both test runs on a 2,5 GHz Intel Core i7 with SSD and OS X.
A test run is the consecutive execution of four Git commands:
 1. clone the repo
 2. checkout to the "removed-files" branch
 3. timed: checkout the "master" branch
 4. timed: checkout "removed-files" branch

Test command:
set -x; git lfs clone https://github.com/larsxschneider/lfstest-manyfiles.git repo; cd repo; git checkout removed-files; time git checkout master; time git checkout removed-files

I compiled Git with the following flags:
NO_GETTEXT=YesPlease NEEDS_SSL_WITH_CRYPTO=YesPlease make -j 8 CFLAGS="-I/usr/local/opt/openssl/include" LDFLAGS="-L/usr/local/opt/openssl/lib"


### TEST RUN A -- Default Git 2.9 (ab7797d) and Git LFS 1.2.1
+ git lfs clone https://github.com/larsxschneider/lfstest-manyfiles.git repo
Cloning into 'repo'...
warning: templates not found /Users/lars/share/git-core/templates
remote: Counting objects: 15012, done.
remote: Total 15012 (delta 0), reused 0 (delta 0), pack-reused 15012
Receiving objects: 100% (15012/15012), 2.02 MiB | 1.77 MiB/s, done.
Checking connectivity... done.
Checking out files: 100% (15001/15001), done.
Git LFS: (15000 of 15000 files) 0 B / 77.04 KB
+ cd repo
+ git checkout removed-files
Branch removed-files set up to track remote branch removed-files from origin.
Switched to a new branch 'removed-files'
+ git checkout master
Checking out files: 100% (12000/12000), done.
Switched to branch 'master'
Your branch is up-to-date with 'origin/master'.

real    6m2.979s
user    2m39.066s
sys 2m41.610s
+ git checkout removed-files
Switched to branch 'removed-files'
Your branch is up-to-date with 'origin/removed-files'.

real    0m1.310s
user    0m0.385s
sys 0m0.881s


### TEST RUN B -- Default Git 2.9 with native LFS cache and Git LFS 1.2.1
https://github.com/larsxschneider/git/tree/lfs-cache
+ git lfs clone https://github.com/larsxschneider/lfstest-manyfiles.git repo
Cloning into 'repo'...
warning: templates not found /Users/lars/share/git-core/templates
remote: Counting objects: 15012, done.
remote: Total 15012 (delta 0), reused 0 (delta 0), pack-reused 15012
Receiving objects: 100% (15012/15012), 2.02 MiB | 1.44 MiB/s, done.
Checking connectivity... done.
Git LFS: (15001 of 15000 files) 0 B / 77.04 KB
+ cd repo
+ git checkout removed-files
Branch removed-files set up to track remote branch removed-files from origin.
Switched to a new branch 'removed-files'
+ git checkout master
Checking out files: 100% (12000/12000), done.
Switched to branch 'master'
Your branch is up-to-date with 'origin/master'.

real    0m2.267s
user    0m0.295s
sys 0m1.948s
+ git checkout removed-files
Switched to branch 'removed-files'
Your branch is up-to-date with 'origin/removed-files'.

real    0m0.715s
user    0m0.072s
sys 0m0.672s


### Results
Default Git:                      6m2.979s + 0m1.310s = 364s
Git with native LFS cache access: 0m2.267s + 0m0.715s = 4s

The native cache solution is almost 100x faster when switching branches
on my local machine with a test repository containing 15,000 Git LFS files.
Based on my previous experience with Git LFS clone I expect even more
dramatic results on Windows.

Thanks,
Lars

[1] https://git-lfs.github.com/
[2] https://github.com/blog/1986-announcing-git-large-file-storage-lfs
[3] http://blogs.atlassian.com/2016/02/git-lfs-for-designers-game-developers-architects/
[4] https://about.gitlab.com/2015/11/23/announcing-git-lfs-support-in-gitlab/
[5] https://github.com/github/git-lfs/issues/931#issuecomment-172939381
[6] https://github.com/github/git-lfs/pull/988
[7] https://developer.atlassian.com/blog/2016/04/git-lfs-12-clone-faster/
[8] http://article.gmane.org/gmane.comp.version-control.git/297809


---
 cache.h     |   2 +
 convert.c   | 145 ++++++++++++++++++++++++++++++++++++++++++++++++++----------
 csum-file.c |  31 +++++++++++++
 csum-file.h |   2 +
 hex.c       |  16 +++++++
 5 files changed, 172 insertions(+), 24 deletions(-)

diff --git a/cache.h b/cache.h
index 6049f86..57fdb18 100644
--- a/cache.h
+++ b/cache.h
@@ -1196,6 +1196,8 @@ extern char *sha1_to_hex_r(char *out, const unsigned char *sha1);
 extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
 extern char *oid_to_hex(const struct object_id *oid);	/* same static buffer as sha1_to_hex */

+extern char *sha256_to_hex_r(char *out, const unsigned char *sha1);
+
 extern int interpret_branch_name(const char *str, int len, struct strbuf *);
 extern int get_sha1_mb(const char *str, unsigned char *sha1);

diff --git a/convert.c b/convert.c
index b1614bf..006e9c4 100644
--- a/convert.c
+++ b/convert.c
@@ -18,6 +18,10 @@
 #define CONVERT_STAT_BITS_TXT_CRLF  0x2
 #define CONVERT_STAT_BITS_BIN       0x4

+const char *LFS_VERSION_MARKER = "version https://git-lfs.github.com/spec/v1\n";
+const char *LFS_OID_MARKER = "oid sha256:";
+
+
 enum crlf_action {
 	CRLF_UNDEFINED,
 	CRLF_BINARY,
@@ -427,6 +431,79 @@ static int filter_buffer_or_fd(int in, int out, void *data)
 	return (write_err || status);
 }

+static int cached_lfs_smudge(const char *src, const char *cmd,
+							 struct strbuf *lfsbuf)
+{
+	int ret = 0;
+	if (src &&
+		strlen(src) > strlen(LFS_VERSION_MARKER) &&
+		!strncmp(LFS_VERSION_MARKER, src, strlen(LFS_VERSION_MARKER)) &&
+		!strcmp("git-lfs smudge %f", cmd)
+	) {
+		const char *lfs_oid_found = strstr(src, LFS_OID_MARKER);
+		if (lfs_oid_found) {
+			const char *lfs_oid = lfs_oid_found + strlen(LFS_OID_MARKER);
+
+			// Construct path to LFS object
+			strbuf_reset(lfsbuf);
+			strbuf_addstr(lfsbuf, git_pathdup("lfs/objects/"));
+			strbuf_add(lfsbuf, lfs_oid, 2);
+			strbuf_addch(lfsbuf, '/');
+			strbuf_add(lfsbuf, lfs_oid+2, 2);
+			strbuf_addch(lfsbuf, '/');
+			strbuf_add(lfsbuf, lfs_oid, 64);
+
+			if (access(lfsbuf->buf, F_OK) != -1) {
+				// LFS object found in local LFS cache
+				ret = 1;
+			}
+		}
+	}
+	return ret;
+}
+
+static int cached_lfs_clean(const char *path, const char *cmd,
+							struct strbuf *lfsbuf)
+{
+	int ret = 0;
+	if (path && !strcmp("git-lfs clean %f", cmd)) {
+
+		// TODO: Is there an easy way to access the content of the last
+		// known committed state of this file in the Git repo? If yes,
+		// then we could read the last known Git LFS OID, construct a
+		// path in the Git LFS cache and compare this file against "path".
+		// If both files are equal then we can use the last known committed
+		// state as "clean" and we could get rid of the SHA256 dependency
+		// here.
+		ssize_t file_size;
+		unsigned char sha256[64];
+		sha256fd(path, &sha256, &file_size);
+
+		char lfs_oid[64];
+		sha256_to_hex_r(lfs_oid, sha256);
+
+		// Construct path to LFS object
+		strbuf_reset(lfsbuf);
+		strbuf_addstr(lfsbuf, git_pathdup("lfs/objects/"));
+		strbuf_add(lfsbuf, lfs_oid, 2);
+		strbuf_addch(lfsbuf, '/');
+		strbuf_add(lfsbuf, lfs_oid+2, 2);
+		strbuf_addch(lfsbuf, '/');
+		strbuf_add(lfsbuf, lfs_oid, 64);
+
+		if (access(lfsbuf->buf, F_OK) != -1) {
+			// LFS object found in local LFS cache
+			strbuf_reset(lfsbuf);
+			strbuf_addstr(lfsbuf, LFS_VERSION_MARKER);
+			strbuf_addstr(lfsbuf, LFS_OID_MARKER);
+			strbuf_add(lfsbuf, lfs_oid, 64);
+			strbuf_addf(lfsbuf, "\nsize %d\n", file_size);
+			ret = 1;
+		}
+	}
+	return ret;
+}
+
 static int apply_filter(const char *path, const char *src, size_t len, int fd,
                         struct strbuf *dst, const char *cmd)
 {
@@ -437,6 +514,7 @@ static int apply_filter(const char *path, const char *src, size_t len, int fd,
 	 * (child --> cmd) --> us
 	 */
 	int ret = 1;
+	struct strbuf lfsbuf = STRBUF_INIT;
 	struct strbuf nbuf = STRBUF_INIT;
 	struct async async;
 	struct filter_params params;
@@ -447,37 +525,56 @@ static int apply_filter(const char *path, const char *src, size_t len, int fd,
 	if (!dst)
 		return 1;

-	memset(&async, 0, sizeof(async));
-	async.proc = filter_buffer_or_fd;
-	async.data = &params;
-	async.out = -1;
-	params.src = src;
-	params.size = len;
-	params.fd = fd;
-	params.cmd = cmd;
-	params.path = path;
-
-	fflush(NULL);
-	if (start_async(&async))
-		return 0;	/* error was already reported */
-
-	if (strbuf_read(&nbuf, async.out, len) < 0) {
-		error("read from external filter %s failed", cmd);
-		ret = 0;
-	}
-	if (close(async.out)) {
-		error("read from external filter %s failed", cmd);
-		ret = 0;
+	// TODO: check if git config "lfs.native-cache" is true
+	if (cached_lfs_smudge(src, cmd, &lfsbuf)) {
+		fd = open(lfsbuf.buf, O_RDONLY);
+		if (strbuf_read(&nbuf, fd, len) < 0) {
+			error("reading from cached LFS object failed", lfsbuf.buf);
+			ret = 0;
+		}
+		if (close(fd)) {
+			error("closing cached LFS object failed", lfsbuf.buf);
+			ret = 0;
+		}
 	}
-	if (finish_async(&async)) {
-		error("external filter %s failed", cmd);
-		ret = 0;
+	// TODO: check if git config "lfs.native-cache" is true
+	else if (cached_lfs_clean(path, cmd, &lfsbuf)) {
+		strbuf_reset(&nbuf);
+		strbuf_addstr(&nbuf, lfsbuf.buf);
+	} else {
+		memset(&async, 0, sizeof(async));
+		async.proc = filter_buffer_or_fd;
+		async.data = &params;
+		async.out = -1;
+		params.src = src;
+		params.size = len;
+		params.fd = fd;
+		params.cmd = cmd;
+		params.path = path;
+
+		fflush(NULL);
+		if (start_async(&async))
+			return 0;	/* error was already reported */
+
+		if (strbuf_read(&nbuf, async.out, len) < 0) {
+			error("read from external filter %s failed", cmd);
+			ret = 0;
+		}
+		if (close(async.out)) {
+			error("read from external filter %s failed", cmd);
+			ret = 0;
+		}
+		if (finish_async(&async)) {
+			error("external filter %s failed", cmd);
+			ret = 0;
+		}
 	}

 	if (ret) {
 		strbuf_swap(dst, &nbuf);
 	}
 	strbuf_release(&nbuf);
+	strbuf_release(&lfsbuf);
 	return ret;
 }

diff --git a/csum-file.c b/csum-file.c
index a172199..2ca4d7f 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -11,6 +11,37 @@
 #include "progress.h"
 #include "csum-file.h"

+void sha256fd(const char *name, unsigned char *sha256, ssize_t *file_size)
+{
+	int fd;
+	struct stat st;
+	fd = open(name, O_RDONLY);
+	if (fd < 0)
+		die_errno("unable to open '%s'", name);
+	fstat(fd, &st);
+	size_t size = xsize_t(st.st_size);
+	*file_size = size;
+
+	SHA256_CTX ctx;
+	SHA256_Init(&ctx);
+	unsigned char fd_buffer[8192];
+
+	while (size > 0) {
+		ssize_t rsize = size < sizeof(fd_buffer) ? size : sizeof(fd_buffer);
+		ssize_t ret = read_in_full(fd, fd_buffer, rsize);
+
+		if (ret < 0)
+			die_errno("%s: sha256 file read error", name);
+		if (ret != rsize)
+			die("failed to read %d bytes from '%s'", (int)rsize, name);
+		SHA256_Update(&ctx, fd_buffer, rsize);
+		size -= rsize;
+	}
+
+	SHA256_Final(sha256, &ctx);
+	close(fd);
+}
+
 static void flush(struct sha1file *f, const void *buf, unsigned int count)
 {
 	if (0 <= f->check_fd && count)  {
diff --git a/csum-file.h b/csum-file.h
index 7530927..bad9262 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -39,6 +39,8 @@ extern void sha1flush(struct sha1file *f);
 extern void crc32_begin(struct sha1file *);
 extern uint32_t crc32_end(struct sha1file *);

+extern void sha256fd(const char *name, unsigned char *sha256, ssize_t *file_size);
+
 static inline void sha1write_u8(struct sha1file *f, uint8_t data)
 {
 	sha1write(f, &data, sizeof(data));
diff --git a/hex.c b/hex.c
index 0519f85..73e2077 100644
--- a/hex.c
+++ b/hex.c
@@ -88,3 +88,19 @@ char *oid_to_hex(const struct object_id *oid)
 {
 	return sha1_to_hex(oid->hash);
 }
+
+char *sha256_to_hex_r(char *buffer, const unsigned char *sha1)
+{
+	static const char hex[] = "0123456789abcdef";
+	char *buf = buffer;
+	int i;
+
+	for (i = 0; i < 32; i++) {
+		unsigned int val = *sha1++;
+		*buf++ = hex[val >> 4];
+		*buf++ = hex[val & 0xf];
+	}
+	*buf = '\0';
+
+	return buffer;
+}
--
2.5.1

