From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git on Cygwin: Not a valid object name HEAD
Date: Tue, 7 Aug 2007 14:44:21 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708071439021.5037@woody.linux-foundation.org>
References: <f99cem$4a4$1@sea.gmane.org> <Pine.LNX.4.64.0708071257350.14781@racer.site>
 <f99nm6$9vi$1@sea.gmane.org> <f99rei$ou$1@sea.gmane.org>
 <20070807143616.GO9527@spearce.org> <20070807145825.GO21692@lavos.net>
 <66DD7425-6073-4CA8-BF01-BF07213A4804@zib.de>
 <30e4a070708071042g5623cb7ak724a8b8e588bd1da@mail.gmail.com>
 <07BB2580-4406-496F-8ACE-F6A03D1687BE@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Mark Levedahl <mlevedahl@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Sebastian Schuberth <sschuberth@gmail.com>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Tue Aug 07 23:47:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIWtn-00068B-R4
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 23:47:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966836AbXHGVpQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 17:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966917AbXHGVpP
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 17:45:15 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:37599 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S966779AbXHGVpM (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Aug 2007 17:45:12 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l77LiSqs024760
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 7 Aug 2007 14:44:29 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l77LiLTU006150;
	Tue, 7 Aug 2007 14:44:22 -0700
In-Reply-To: <07BB2580-4406-496F-8ACE-F6A03D1687BE@zib.de>
X-Spam-Status: No, hits=-4.519 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_44,J_CHICKENPOX_48,J_CHICKENPOX_62,J_CHICKENPOX_65,PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.20__
X-MIMEDefang-Filter: lf$Revision: 1.184 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55275>



On Tue, 7 Aug 2007, Steffen Prohaska wrote:
>
> Is there any chance that patches would be accepted that try to
> do so? Even if they add "b" to fopen and O_BINARY to open, which
> both are useless on Unix?

I certainly don't think it would be wrong to add O_BINARY to the open() 
parameters (and "b" to fopen() and friends), if it makes a difference.

Add a

	#ifndef O_BINARY
	#define O_BINARY 0
	#endif

and it should be harmless anywhere else.

So if you're willing to test, and extend on this, maybe something like 
this gets you started (I think the main issue will be the object files, 
no?)

		Linus
---
diff --git a/sha1_file.c b/sha1_file.c
index aca741b..0f613c0 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -23,6 +23,10 @@
 #endif
 #endif
 
+#ifndef O_BINARY
+#define O_BINARY 0
+#endif
+
 #ifdef NO_C99_FORMAT
 #define SZ_FMT "lu"
 #else
@@ -444,7 +448,7 @@ static int check_packed_git_idx(const char *path,  struct packed_git *p)
 	struct pack_idx_header *hdr;
 	size_t idx_size;
 	uint32_t version, nr, i, *index;
-	int fd = open(path, O_RDONLY);
+	int fd = open(path, O_BINARY | O_RDONLY);
 	struct stat st;
 
 	if (fd < 0)
@@ -631,7 +635,7 @@ static int open_packed_git_1(struct packed_git *p)
 	if (!p->index_data && open_pack_index(p))
 		return error("packfile %s index unavailable", p->pack_name);
 
-	p->pack_fd = open(p->pack_name, O_RDONLY);
+	p->pack_fd = open(p->pack_name, O_BINARY | O_RDONLY);
 	if (p->pack_fd < 0 || fstat(p->pack_fd, &st))
 		return -1;
 
@@ -983,12 +987,12 @@ static void *map_sha1_file(const unsigned char *sha1, unsigned long *size)
 		return NULL;
 	}
 
-	fd = open(filename, O_RDONLY | sha1_file_open_flag);
+	fd = open(filename, O_BINARY | O_RDONLY | sha1_file_open_flag);
 	if (fd < 0) {
 		/* See if it works without O_NOATIME */
 		switch (sha1_file_open_flag) {
 		default:
-			fd = open(filename, O_RDONLY);
+			fd = open(filename, O_BINARY | O_RDONLY);
 			if (fd >= 0)
 				break;
 		/* Fallthrough */
@@ -2023,6 +2027,12 @@ int move_temp_to_file(const char *tmpfile, const char *filename)
 	return 0;
 }
 
+static void close_or_die(int fd, const char *file)
+{
+	if (close(fd))
+		die("unable to close %s (%s)", file, strerror(errno));
+}
+
 static int write_buffer(int fd, const void *buf, size_t len)
 {
 	if (write_in_full(fd, buf, len) < 0)
@@ -2059,7 +2069,7 @@ int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned cha
 		hashcpy(returnsha1, sha1);
 	if (has_sha1_file(sha1))
 		return 0;
-	fd = open(filename, O_RDONLY);
+	fd = open(filename, O_BINARY | O_RDONLY);
 	if (fd >= 0) {
 		/*
 		 * FIXME!!! We might do collision checking here, but we'd
@@ -2112,11 +2122,9 @@ int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned cha
 
 	size = stream.total_out;
 
-	if (write_buffer(fd, compressed, size) < 0)
-		die("unable to write sha1 file");
+	write_or_die(fd, compressed, size);
 	fchmod(fd, 0444);
-	if (close(fd))
-		die("unable to write sha1 file");
+	close_or_die(fd, "sha1 file");
 	free(compressed);
 
 	return move_temp_to_file(tmpfile, filename);
@@ -2229,8 +2237,7 @@ int write_sha1_from_fd(const unsigned char *sha1, int fd, char *buffer,
 				SHA1_Update(&c, discard, sizeof(discard) -
 					    stream.avail_out);
 			} while (stream.avail_in && ret == Z_OK);
-			if (write_buffer(local, buffer, *bufposn - stream.avail_in) < 0)
-				die("unable to write sha1 file");
+			write_or_die(local, buffer, *bufposn - stream.avail_in);
 			memmove(buffer, buffer + *bufposn - stream.avail_in,
 				stream.avail_in);
 			*bufposn = stream.avail_in;
@@ -2251,8 +2258,7 @@ int write_sha1_from_fd(const unsigned char *sha1, int fd, char *buffer,
 	inflateEnd(&stream);
 
 	fchmod(local, 0444);
-	if (close(local) != 0)
-		die("unable to write sha1 file");
+	close_or_die(local, "sha1 file");
 	SHA1_Final(real_sha1, &c);
 	if (ret != Z_STREAM_END) {
 		unlink(tmpfile);
@@ -2412,7 +2418,7 @@ int index_path(unsigned char *sha1, const char *path, struct stat *st, int write
 
 	switch (st->st_mode & S_IFMT) {
 	case S_IFREG:
-		fd = open(path, O_RDONLY);
+		fd = open(path, O_BINARY | O_RDONLY);
 		if (fd < 0)
 			return error("open(\"%s\"): %s", path,
 				     strerror(errno));
