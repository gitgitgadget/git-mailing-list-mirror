From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] fix pread()'s short read in index-pack
Date: Thu, 09 Oct 2008 22:08:51 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0810092140500.26244@xanadu.home>
References: <20081009195518.GA1497@blimp.localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 10 04:10:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ko7SD-0006di-VQ
	for gcvg-git-2@gmane.org; Fri, 10 Oct 2008 04:10:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753142AbYJJCI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 22:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752429AbYJJCI6
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 22:08:58 -0400
Received: from relais.videotron.ca ([24.201.245.36]:50716 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752146AbYJJCI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 22:08:58 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K8I00C4639SQKB0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 09 Oct 2008 22:08:16 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20081009195518.GA1497@blimp.localhost>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97907>


Since v1.6.0.2~13^2~ the completion of a thin pack uses sha1write() for 
its ability to compute a SHA1 on the written data.  This also provides 
data buffering which, along with commit 92392b4a45, will confuse pread() 
whenever an appended object is 1) freed due to memory pressure because 
of the depth-first delta processing, and 2) needed again because it has 
many delta children, and 3) its data is still buffered by sha1write().

Let's fix the issue by simply forcing cached data out when such an 
object is written so it can be pread()'d at leisure.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

On Thu, 9 Oct 2008, Alex Riesen wrote:

> Somehow I got my gnulib mirror to a strange state where I can't fetch
> anything from it:
> 
>     $ cd gnulib
>     $ git fetch -f ../gnulib.git 'refs/heads/*:refs/remotes/origin/*'
>     remote: Counting objects: 2202, done.
>     remote: Compressing objects: 100% (633/633), done.
>     remote: Total 1769 (delta 1448), reused 1455 (delta 1134)
>     Receiving objects: 100% (1769/1769), 404.11 KiB, done.
>     fatal: premature end of pack file, 1745 bytes missing
>     fatal: index-pack failed
> 
> This is with current Shawn's master (Junio's master erroneously gives
> an error). Bisect points at ac0463ed44e859c84e354cd0ae47d9b5b124e112

Thanks for providing a good test data set.  As you can see above, this 
is something that is tricky to reproduce otherwise.  This patch is meant 
for the maint branch but should be included in master as well.

diff --git a/csum-file.c b/csum-file.c
index bb70c75..3b3e090 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -11,7 +11,7 @@
 #include "progress.h"
 #include "csum-file.h"
 
-static void sha1flush(struct sha1file *f, void *buf, unsigned int count)
+static void flush(struct sha1file *f, void *buf, unsigned int count)
 {
 	for (;;) {
 		int ret = xwrite(f->fd, buf, count);
@@ -30,22 +30,28 @@ static void sha1flush(struct sha1file *f, void *buf, unsigned int count)
 	}
 }
 
-int sha1close(struct sha1file *f, unsigned char *result, unsigned int flags)
+void sha1flush(struct sha1file *f)
 {
-	int fd;
 	unsigned offset = f->offset;
 
 	if (offset) {
 		SHA1_Update(&f->ctx, f->buffer, offset);
-		sha1flush(f, f->buffer, offset);
+		flush(f, f->buffer, offset);
 		f->offset = 0;
 	}
+}
+
+int sha1close(struct sha1file *f, unsigned char *result, unsigned int flags)
+{
+	int fd;
+
+	sha1flush(f);
 	SHA1_Final(f->buffer, &f->ctx);
 	if (result)
 		hashcpy(result, f->buffer);
 	if (flags & (CSUM_CLOSE | CSUM_FSYNC)) {
 		/* write checksum and close fd */
-		sha1flush(f, f->buffer, 20);
+		flush(f, f->buffer, 20);
 		if (flags & CSUM_FSYNC)
 			fsync_or_die(f->fd, f->name);
 		if (close(f->fd))
@@ -83,7 +89,7 @@ int sha1write(struct sha1file *f, void *buf, unsigned int count)
 		left -= nr;
 		if (!left) {
 			SHA1_Update(&f->ctx, data, offset);
-			sha1flush(f, data, offset);
+			flush(f, data, offset);
 			offset = 0;
 		}
 		f->offset = offset;
diff --git a/csum-file.h b/csum-file.h
index 72c9487..01f13b5 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -24,6 +24,7 @@ extern struct sha1file *sha1fd(int fd, const char *name);
 extern struct sha1file *sha1fd_throughput(int fd, const char *name, struct progress *tp);
 extern int sha1close(struct sha1file *, unsigned char *, unsigned int);
 extern int sha1write(struct sha1file *, void *, unsigned int);
+extern void sha1flush(struct sha1file *f);
 extern void crc32_begin(struct sha1file *);
 extern uint32_t crc32_end(struct sha1file *);
 
diff --git a/index-pack.c b/index-pack.c
index 530d820..ca72329 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -704,6 +704,7 @@ static struct object_entry *append_obj_to_pack(struct sha1file *f,
 	obj[1].idx.offset = obj[0].idx.offset + n;
 	obj[1].idx.offset += write_compressed(f, buf, size);
 	obj[0].idx.crc32 = crc32_end(f);
+	sha1flush(f);
 	hashcpy(obj->idx.sha1, sha1);
 	return obj;
 }
