From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 1/2] Make pack creation always fsync() the result
Date: Fri, 30 May 2008 09:08:11 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0805300905080.3141@woody.linux-foundation.org>
References: <20080529205743.GC17123@redhat.com> <alpine.LFD.1.10.0805291656260.3141@woody.linux-foundation.org> <20080530152527.GF4032@redhat.com> <alpine.LFD.1.10.0805300844310.3141@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linuxfoundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Frank Ch. Eigler" <fche@redhat.com>
X-From: git-owner@vger.kernel.org Fri May 30 18:10:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K27Bn-0002Ui-FL
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 18:10:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752957AbYE3QJz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 12:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752970AbYE3QJy
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 12:09:54 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:46228 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752287AbYE3QJx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 May 2008 12:09:53 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4UG8DIg001020
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 30 May 2008 09:08:14 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4UG8BYa000358;
	Fri, 30 May 2008 09:08:12 -0700
In-Reply-To: <alpine.LFD.1.10.0805300844310.3141@woody.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.897 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83314>



From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 30 May 2008 08:42:16 -0700

This means that we can depend on packs always being stable on disk,
simplifying a lot of the object serialization worries.  And unlike loose
objects, serializing pack creation IO isn't going to be a performance
killer.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

Ok, so this is pretty straightforward. I haven't given it a *lot* of 
testing, but while it can certainly also have bugs, it's not even trying 
to be "clever" like my previous attempt. 

I was always a bit leery about doing a 'fsync()' on a read-only file 
descriptor, and in general about doing an fsync() on a file that was 
created by something else. 

 builtin-pack-objects.c |    4 +++-
 cache.h                |    1 +
 csum-file.c            |    7 +++++--
 csum-file.h            |    6 +++++-
 fast-import.c          |    2 +-
 index-pack.c           |    1 +
 pack-write.c           |    2 +-
 write_or_die.c         |    7 +++++++
 8 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 70d2f5d..4c2e0cd 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -515,10 +515,12 @@ static void write_pack_file(void)
 		 * If so, rewrite it like in fast-import
 		 */
 		if (pack_to_stdout || nr_written == nr_remaining) {
-			sha1close(f, sha1, 1);
+			unsigned flags = pack_to_stdout ? CSUM_CLOSE : CSUM_FSYNC;
+			sha1close(f, sha1, flags);
 		} else {
 			int fd = sha1close(f, NULL, 0);
 			fixup_pack_header_footer(fd, sha1, pack_tmp_name, nr_written);
+			fsync_or_die(fd, pack_tmp_name);
 			close(fd);
 		}
 
diff --git a/cache.h b/cache.h
index eab1a17..092a997 100644
--- a/cache.h
+++ b/cache.h
@@ -761,6 +761,7 @@ extern ssize_t write_in_full(int fd, const void *buf, size_t count);
 extern void write_or_die(int fd, const void *buf, size_t count);
 extern int write_or_whine(int fd, const void *buf, size_t count, const char *msg);
 extern int write_or_whine_pipe(int fd, const void *buf, size_t count, const char *msg);
+extern void fsync_or_die(int fd, const char *);
 
 /* pager.c */
 extern void setup_pager(void);
diff --git a/csum-file.c b/csum-file.c
index 9728a99..ace64f1 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -32,21 +32,24 @@ static void sha1flush(struct sha1file *f, unsigned int count)
 	}
 }
 
-int sha1close(struct sha1file *f, unsigned char *result, int final)
+int sha1close(struct sha1file *f, unsigned char *result, unsigned int flags)
 {
 	int fd;
 	unsigned offset = f->offset;
+
 	if (offset) {
 		SHA1_Update(&f->ctx, f->buffer, offset);
 		sha1flush(f, offset);
 		f->offset = 0;
 	}
-	if (final) {
+	if (flags & (CSUM_CLOSE | CSUM_FSYNC)) {
 		/* write checksum and close fd */
 		SHA1_Final(f->buffer, &f->ctx);
 		if (result)
 			hashcpy(result, f->buffer);
 		sha1flush(f, 20);
+		if (flags & CSUM_FSYNC)
+			fsync_or_die(f->fd, f->name);
 		if (close(f->fd))
 			die("%s: sha1 file error on close (%s)",
 			    f->name, strerror(errno));
diff --git a/csum-file.h b/csum-file.h
index 1af7656..72c9487 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -16,9 +16,13 @@ struct sha1file {
 	unsigned char buffer[8192];
 };
 
+/* sha1close flags */
+#define CSUM_CLOSE	1
+#define CSUM_FSYNC	2
+
 extern struct sha1file *sha1fd(int fd, const char *name);
 extern struct sha1file *sha1fd_throughput(int fd, const char *name, struct progress *tp);
-extern int sha1close(struct sha1file *, unsigned char *, int);
+extern int sha1close(struct sha1file *, unsigned char *, unsigned int);
 extern int sha1write(struct sha1file *, void *, unsigned int);
 extern void crc32_begin(struct sha1file *);
 extern uint32_t crc32_end(struct sha1file *);
diff --git a/fast-import.c b/fast-import.c
index 93119bb..e72b286 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -890,7 +890,7 @@ static char *create_index(void)
 		SHA1_Update(&ctx, (*c)->sha1, 20);
 	}
 	sha1write(f, pack_data->sha1, sizeof(pack_data->sha1));
-	sha1close(f, NULL, 1);
+	sha1close(f, NULL, CSUM_FSYNC);
 	free(idx);
 	SHA1_Final(pack_data->sha1, &ctx);
 	return tmpfile;
diff --git a/index-pack.c b/index-pack.c
index aaba944..5ac91ba 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -694,6 +694,7 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 	if (!from_stdin) {
 		close(input_fd);
 	} else {
+		fsync_or_die(output_fd, curr_pack_name);
 		err = close(output_fd);
 		if (err)
 			die("error while closing pack file: %s", strerror(errno));
diff --git a/pack-write.c b/pack-write.c
index c66c8af..f52cabe 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -139,7 +139,7 @@ char *write_idx_file(char *index_name, struct pack_idx_entry **objects,
 	}
 
 	sha1write(f, sha1, 20);
-	sha1close(f, NULL, 1);
+	sha1close(f, NULL, CSUM_FSYNC);
 	SHA1_Final(sha1, &ctx);
 	return index_name;
 }
diff --git a/write_or_die.c b/write_or_die.c
index 32f9914..630be4c 100644
--- a/write_or_die.c
+++ b/write_or_die.c
@@ -78,6 +78,13 @@ ssize_t write_in_full(int fd, const void *buf, size_t count)
 	return total;
 }
 
+void fsync_or_die(int fd, const char *msg)
+{
+	if (fsync(fd) < 0) {
+		die("%s: fsync error (%s)", msg, strerror(errno));
+	}
+}
+
 void write_or_die(int fd, const void *buf, size_t count)
 {
 	if (write_in_full(fd, buf, count) < 0) {
-- 
1.5.6.rc0.48.g5eea
