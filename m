From: Ben Hoskings <ben@hoskings.net>
Subject: [RFC/PATCH] Proof-of-concept streamed hashing, demoed in `git hash-object`
Date: Wed, 18 Feb 2009 00:31:35 +1000
Message-ID: <0984029E-57D0-4EFA-A060-E0B6FFA77D58@hoskings.net>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 17 15:33:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZR0a-0000TR-JM
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 15:33:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752062AbZBQObo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 09:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752054AbZBQObn
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 09:31:43 -0500
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:56291 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752046AbZBQObn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 09:31:43 -0500
Received: from ppp118-208-44-248.lns3.bne1.internode.on.net ([118.208.44.248] helo=[10.0.1.2])
	by mho-02-bos.mailhop.org with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <ben@hoskings.net>)
	id 1LZQz7-0005XM-1p
	for git@vger.kernel.org; Tue, 17 Feb 2009 14:31:42 +0000
X-Mail-Handler: MailHop Outbound by DynDNS
X-Originating-IP: 118.208.44.248
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/mailhop/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1+kItttYEjGFBiLa0NYBUgW
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110391>

Hi folks,

This patch adds a proof-of-concept implementation of streaming SHA1  
calculation in sha1_file.c, as demoed with `git hash-object <large  
input file>`. Instead of the command's memory footprint being equal to  
the input file's size, this caps it at SHA1_CHUNK_SIZE (currently 64MB).

Capping memory use this easily seems like a win, but then all this  
code does is stream-calculate a SHA1 and print it to stdout. There  
seem to be a lot of disparate places throughout the codebase where  
objects have their SHA1 calculated.

Then again, I presume most of these are working with blobs and not  
entire files, and hence wouldn't require streaming anyway. (I'm  
assuming blobs don't grow large enough to warrant it - is that  
necessarily true?)

The memory usage can be verified by running
while true; do ps aux | grep hash-object | grep -v grep; sleep 0.2; done

and then running `git hash-object <large input file>` in a second  
terminal. The memory use stays at or below SHA1_CHUNK_SIZE until the  
streamed hash is printed on the terminal and the non-streamed hash is  
subsequently calculated.

On my machine, the original implementation hashed a 700MB file in  
5.8sec. My patch does it in 6.2sec with SHA1_CHUNK_SIZE set to 64MB.

Cheers
Ben Hoskings

---
  sha1_file.c |   47 +++++++++++++++++++++++++++++++++++++++++++++++
  1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 5b6e0f6..59f0adb 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -33,6 +33,8 @@ static unsigned long sz_fmt(size_t s) { return  
(unsigned long)s; }
  static size_t sz_fmt(size_t s) { return s; }
  #endif

+#define SHA1_CHUNK_SIZE (size_t)(1024*1024*64)
+
  const unsigned char null_sha1[20];

  const signed char hexval_table[256] = {
@@ -2242,6 +2244,39 @@ static void write_sha1_file_prepare(const void  
*buf, unsigned long len,
  	git_SHA1_Final(sha1, &c);
  }

+inline void write_sha1_fd_process_chunk(int fd, unsigned long len,
+                                        unsigned long offset,  
git_SHA_CTX *c,
+                                        void *buf)
+{
+  buf = xmmap(NULL, len, PROT_READ, MAP_PRIVATE, fd, offset);
+  git_SHA1_Update(c, buf, len);
+  munmap(buf, len);
+}
+
+static void write_sha1_fd_prepare(int fd, unsigned long len,
+                                  const char *type, unsigned char  
*sha1,
+                                  char *hdr, int *hdrlen)
+{
+	git_SHA_CTX c;
+	void *buf = NULL;
+	unsigned long offset = 0;
+
+	*hdrlen = sprintf(hdr, "%s %lu", type, len)+1;
+
+	git_SHA1_Init(&c);
+	git_SHA1_Update(&c, hdr, *hdrlen);
+
+	for (; offset + SHA1_CHUNK_SIZE <= len; offset += SHA1_CHUNK_SIZE) {
+		write_sha1_fd_process_chunk(fd, SHA1_CHUNK_SIZE, offset, &c, buf);
+	}
+
+	if (len % SHA1_CHUNK_SIZE) {
+		write_sha1_fd_process_chunk(fd, len % SHA1_CHUNK_SIZE, offset, &c,  
buf);
+	}
+
+	git_SHA1_Final(sha1, &c);
+}
+
  /*
   * Move the just written object into its final resting place
   */
@@ -2294,6 +2329,15 @@ int hash_sha1_file(const void *buf, unsigned  
long len, const char *type,
  	return 0;
  }

+int hash_sha1_fd(int fd, unsigned long len, const char *type,
+                 unsigned char *sha1)
+{
+	char hdr[32];
+	int hdrlen;
+	write_sha1_fd_prepare(fd, len, type, sha1, hdr, &hdrlen);
+	return 0;
+}
+
  /* Finalize a file on disk, and close it. */
  static void close_sha1_file(int fd)
  {
@@ -2523,6 +2567,9 @@ int index_fd(unsigned char *sha1, int fd, struct  
stat *st, int write_object,
  			ret = -1;
  		strbuf_release(&sbuf);
  	} else if (size) {
+		hash_sha1_fd(fd, size, typename(type), sha1);
+		printf("%s <- chunked hash\n", sha1_to_hex(sha1));
+
  		void *buf = xmmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
  		ret = index_mem(sha1, buf, size, write_object, type, path);
  		munmap(buf, size);
-- 
1.6.1.2
