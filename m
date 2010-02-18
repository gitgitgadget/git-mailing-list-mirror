From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach "git add" and friends to be paranoid
Date: Wed, 17 Feb 2010 21:36:15 -0800
Message-ID: <7vocjnqf5c.fsf@alter.siamese.dyndns.org>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org>
 <20100213121238.GA2559@progeny.tock> <20100213133951.GA14352@Knoppix>
 <201002131539.54142.trast@student.ethz.ch> <20100213162924.GA14623@Knoppix>
 <37fcd2781002131409r4166e496h9d12d961a2330914@mail.gmail.com>
 <20100213223733.GP24809@gibbs.hungrycats.org>
 <20100214011812.GA2175@dpotapov.dyndns.org>
 <7vljer1gyg.fsf_-_@alter.siamese.dyndns.org>
 <20100218013822.GB15870@coredump.intra.peff.net>
 <alpine.LFD.2.00.1002172350080.1946@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Dmitry Potapov <dpotapov@gmail.com>,
	Zygo Blaxell <zblaxell@esightcorp.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Feb 18 06:37:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nhz4f-0005RZ-Nr
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 06:37:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751707Ab0BRFhK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 00:37:10 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39192 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392Ab0BRFhG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 00:37:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 81A669B846;
	Thu, 18 Feb 2010 00:37:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=RbrCvo916ENXlwTcC08dkYqZGyQ=; b=XSrNv9gf6pL5P+S1aBoGjfk
	UcU0LKMA1W7K5b1CEk0PLeUNBzJeilh+fBKO9JFrJ9RfHLFuuju2uXjFZaM0s+b0
	sCOiC/oidCfcSsnRcXsXtjLAXdBuZdxyX6pKc7FfyzvdPwcF3Tr+pvRk5TBPnSGO
	0yGSVz3xNlUa8pdVOEUc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=mNWezESPXdUHuLbjCpP0UQlztw3zB1bwjCxiO8ssdDyvYKQYw
	GHoauWxZN0c7nwLPWk2mM018FnzrFhGN4kbLFfKxeBVBHAJKojKfZJ1JZRV9KRkX
	MCjA8ovJOIyy9LI2C7QCuMKcqHGefKuEbFZ22qMLwTN3NhOR36/v4hNxgQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EB36E9B83F;
	Thu, 18 Feb 2010 00:36:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F05779B82C; Thu, 18 Feb
 2010 00:36:34 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9F8EA3FA-1C4F-11DF-8256-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140299>

Nicolas Pitre <nico@fluxnic.net> writes:

> It is likely to have better performance if the buffer is small enough to 
> fit in the CPU L1 cache.  There are two sequencial passes over the 
> buffer: one for the SHA1 computation, and another for the compression, 
> and currently they're sure to trash the L1 cache on each pass.

I did a very unscientific test to hash about 14k paths (arch/ and fs/ from
the kernel source) using "git-hash-object -w --stdin-paths" into an empty
repository with varying sizes of paranoia buffer (quarter, 1, 4, 8 and
256kB) and saw 8-30% overhead.  256kB did hurt and around 4kB seemed to be
optimal for my this small sample load.

In any case, with any size of paranoia, this hurts the sane use case, so
I'd introduce an expert switch to disable it, like this.

-- >8 --
When creating a loose object, we normally mmap(2) the entire file, and
hash and then compress to write it out in two separate steps for
efficiency.

This is perfectly good for the intended use of git---nobody is supposed to
be insane enough to expect that it won't break anything to muck with the
contents of a file after telling git to index it and before getting the
control back from git.

But the nature of breakage caused by such an abuse is rather bad.  We will
end up with loose object files, whose names do not match what are stored
and recovered when uncompressed.

This teaches the index_mem() codepath to be paranoid and hash and compress
the data after reading it in core.  The contents hashed may not match the
contents of the file in an insane use case, but at least this way the
result will be internally consistent.

People with saner use of git can regain performance by setting a new
configuration variable 'core.volatilefiles' to false to disable this
check.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt |    7 ++++
 cache.h                  |    1 +
 config.c                 |    6 +++
 environment.c            |    1 +
 sha1_file.c              |   83 +++++++++++++++++++++++++++++++++++++--------
 5 files changed, 83 insertions(+), 15 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 52786c7..0295aee 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -117,6 +117,14 @@ core.fileMode::
 	the working copy are ignored; useful on broken filesystems like FAT.
 	See linkgit:git-update-index[1]. True by default.
 
+core.volatilefiles::
+	If you modify a file after telling git to record it (e.g. with
+	"git add") but before git finishes the request and gives the
+	control back to you, you may create a broken object (and of course
+	you can keep both halves ;-).  Setting this option to true will
+	tell git to be extra careful to detect the situation and abort.
+	Defaults to true.
+
 core.ignoreCygwinFSTricks::
 	This option is only used by Cygwin implementation of Git. If false,
 	the Cygwin stat() and lstat() functions are used. This may be useful
diff --git a/cache.h b/cache.h
index 231c06d..e5a87cf 100644
--- a/cache.h
+++ b/cache.h
@@ -497,6 +497,7 @@ extern int trust_ctime;
 extern int quote_path_fully;
 extern int has_symlinks;
 extern int ignore_case;
+extern int worktree_files_are_volatile;
 extern int assume_unchanged;
 extern int prefer_symlink_refs;
 extern int log_all_ref_updates;
diff --git a/config.c b/config.c
index 790405a..9898041 100644
--- a/config.c
+++ b/config.c
@@ -360,6 +360,12 @@ static int git_default_core_config(const char *var, const char *value)
 		trust_executable_bit = git_config_bool(var, value);
 		return 0;
 	}
+
+	if (!strcmp(var, "core.volatilefiles")) {
+		worktree_files_are_volatile = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.trustctime")) {
 		trust_ctime = git_config_bool(var, value);
 		return 0;
diff --git a/environment.c b/environment.c
index e278bce..5d0faf3 100644
--- a/environment.c
+++ b/environment.c
@@ -22,6 +22,7 @@ int is_bare_repository_cfg = -1; /* unspecified */
 int log_all_ref_updates = -1; /* unspecified */
 int warn_ambiguous_refs = 1;
 int repository_format_version;
+int worktree_files_are_volatile = 1; /* yuck */
 const char *git_commit_encoding;
 const char *git_log_output_encoding;
 int shared_repository = PERM_UMASK;
diff --git a/sha1_file.c b/sha1_file.c
index 52d1ead..e126179 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2335,14 +2335,18 @@ static int create_tmpfile(char *buffer, size_t bufsiz, const char *filename)
 }
 
 static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
-			      void *buf, unsigned long len, time_t mtime)
+			      void *buf, unsigned long len, time_t mtime,
+			      int paranoid)
 {
 	int fd, size, ret;
 	unsigned char *compressed;
 	z_stream stream;
 	char *filename;
 	static char tmpfile[PATH_MAX];
+	git_SHA_CTX ctx;
 
+	if (!worktree_files_are_volatile)
+		paranoid = 0;
 	filename = sha1_file_name(sha1);
 	fd = create_tmpfile(tmpfile, sizeof(tmpfile), filename);
 	if (fd < 0) {
@@ -2366,12 +2370,41 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 	stream.next_in = (unsigned char *)hdr;
 	stream.avail_in = hdrlen;
 	while (deflate(&stream, 0) == Z_OK)
-		/* nothing */;
+		; /* nothing */
 
 	/* Then the data itself.. */
-	stream.next_in = buf;
-	stream.avail_in = len;
-	ret = deflate(&stream, Z_FINISH);
+	if (paranoid) {
+		unsigned char stablebuf[4096];
+		char *bufptr = buf;
+		unsigned long remainder = len;
+
+		git_SHA1_Init(&ctx);
+		git_SHA1_Update(&ctx, hdr, hdrlen);
+
+		ret = Z_OK;
+		while (remainder) {
+			unsigned long chunklen = remainder;
+
+			if (sizeof(stablebuf) <= chunklen)
+				chunklen = sizeof(stablebuf);
+			memcpy(stablebuf, bufptr, chunklen);
+			git_SHA1_Update(&ctx, stablebuf, chunklen);
+			stream.next_in = stablebuf;
+			stream.avail_in = chunklen;
+			do {
+				ret = deflate(&stream, Z_NO_FLUSH);
+			} while (ret == Z_OK);
+			bufptr += chunklen;
+			remainder -= chunklen;
+		}
+		if (ret != Z_STREAM_END)
+			ret = deflate(&stream, Z_FINISH);
+	} else {
+		stream.next_in = buf;
+		stream.avail_in = len;
+		ret = deflate(&stream, Z_FINISH);
+	}
+
 	if (ret != Z_STREAM_END)
 		die("unable to deflate new object %s (%d)", sha1_to_hex(sha1), ret);
 
@@ -2381,6 +2414,12 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 
 	size = stream.total_out;
 
+	if (paranoid) {
+		unsigned char paranoid_sha1[20];
+		git_SHA1_Final(paranoid_sha1, &ctx);
+		if (hashcmp(paranoid_sha1, sha1))
+			die("hashed file is volatile");
+	}
 	if (write_buffer(fd, compressed, size) < 0)
 		die("unable to write sha1 file");
 	close_sha1_file(fd);
@@ -2398,7 +2437,7 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 	return move_temp_to_file(tmpfile, filename);
 }
 
-int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned char *returnsha1)
+static int write_sha1_file_paranoid(void *buf, unsigned long len, const char *type, unsigned char *returnsha1, int paranoid)
 {
 	unsigned char sha1[20];
 	char hdr[32];
@@ -2412,7 +2451,12 @@ int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned cha
 		hashcpy(returnsha1, sha1);
 	if (has_sha1_file(sha1))
 		return 0;
-	return write_loose_object(sha1, hdr, hdrlen, buf, len, 0);
+	return write_loose_object(sha1, hdr, hdrlen, buf, len, 0, paranoid);
+}
+
+int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned char *returnsha1)
+{
+	return write_sha1_file_paranoid(buf, len, type, returnsha1, 0);
 }
 
 int force_object_loose(const unsigned char *sha1, time_t mtime)
@@ -2430,7 +2474,7 @@ int force_object_loose(const unsigned char *sha1, time_t mtime)
 	if (!buf)
 		return error("cannot read sha1_file for %s", sha1_to_hex(sha1));
 	hdrlen = sprintf(hdr, "%s %lu", typename(type), len) + 1;
-	ret = write_loose_object(sha1, hdr, hdrlen, buf, len, mtime);
+	ret = write_loose_object(sha1, hdr, hdrlen, buf, len, mtime, 0);
 	free(buf);
 
 	return ret;
@@ -2467,10 +2511,15 @@ int has_sha1_file(const unsigned char *sha1)
 	return has_loose_object(sha1);
 }
 
+#define INDEX_MEM_WRITE_OBJECT  01
+#define INDEX_MEM_PARANOID      02
+
 static int index_mem(unsigned char *sha1, void *buf, size_t size,
-		     int write_object, enum object_type type, const char *path)
+		     enum object_type type, const char *path, int flag)
 {
 	int ret, re_allocated = 0;
+	int write_object = flag & INDEX_MEM_WRITE_OBJECT;
+	int paranoid = flag & INDEX_MEM_PARANOID;
 
 	if (!type)
 		type = OBJ_BLOB;
@@ -2488,9 +2537,11 @@ static int index_mem(unsigned char *sha1, void *buf, size_t size,
 	}
 
 	if (write_object)
-		ret = write_sha1_file(buf, size, typename(type), sha1);
+		ret = write_sha1_file_paranoid(buf, size, typename(type),
+					       sha1, paranoid);
 	else
 		ret = hash_sha1_file(buf, size, typename(type), sha1);
+
 	if (re_allocated)
 		free(buf);
 	return ret;
@@ -2499,23 +2550,25 @@ static int index_mem(unsigned char *sha1, void *buf, size_t size,
 int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object,
 	     enum object_type type, const char *path)
 {
-	int ret;
+	int ret, flag;
 	size_t size = xsize_t(st->st_size);
 
+	flag = write_object ? INDEX_MEM_WRITE_OBJECT : 0;
 	if (!S_ISREG(st->st_mode)) {
 		struct strbuf sbuf = STRBUF_INIT;
 		if (strbuf_read(&sbuf, fd, 4096) >= 0)
-			ret = index_mem(sha1, sbuf.buf, sbuf.len, write_object,
-					type, path);
+			ret = index_mem(sha1, sbuf.buf, sbuf.len,
+					type, path, flag);
 		else
 			ret = -1;
 		strbuf_release(&sbuf);
 	} else if (size) {
 		void *buf = xmmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
-		ret = index_mem(sha1, buf, size, write_object, type, path);
+		flag |= INDEX_MEM_PARANOID;
+		ret = index_mem(sha1, buf, size, type, path, flag);
 		munmap(buf, size);
 	} else
-		ret = index_mem(sha1, NULL, size, write_object, type, path);
+		ret = index_mem(sha1, NULL, size, type, path, flag);
 	close(fd);
 	return ret;
 }
-- 
1.7.0.81.g58679
