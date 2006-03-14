From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-diff-tree -M performance regression in 'next'
Date: Mon, 13 Mar 2006 18:55:01 -0800
Message-ID: <7vveuhohve.fsf@assigned-by-dhcp.cox.net>
References: <20060311172818.GB32609@c165.ib.student.liu.se>
	<7voe0bdeyr.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603120858230.3618@g5.osdl.org>
	<7vk6azcv9y.fsf@assigned-by-dhcp.cox.net>
	<7vwtezw4ye.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603121700410.3618@g5.osdl.org>
	<Pine.LNX.4.64.0603121710110.3618@g5.osdl.org>
	<7vwtezt202.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 14 03:55:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIzgq-0008A5-Fb
	for gcvg-git@gmane.org; Tue, 14 Mar 2006 03:55:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbWCNCzH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Mar 2006 21:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752126AbWCNCzH
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Mar 2006 21:55:07 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:49844 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750798AbWCNCzF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Mar 2006 21:55:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060314025509.MGDJ25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 13 Mar 2006 21:55:09 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vwtezt202.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 12 Mar 2006 20:14:21 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17583>

While we are hacking away with weird ideas...

Here is still an WIP but an insanely fast one (actually this is
a modified version of what once was in next).  I haven't
verified the sanity of its output fully, but from a cursory look
what are found look sensible.  The same v2.6.12..v2.6.14 test on
my Duron 750:

        master  64.65user 0.17system 1:05.42elapsed
                0inputs+0outputs (0major+12511minor)

        next    40.69user 0.14system 0:40.98elapsed
                0inputs+0outputs (0major+19471minor)

        "this"  5.59user 0.09system 0:05.68elapsed
                0inputs+0outputs (0major+13015minor)

The hash used here is heavily optimized for handling text files
and nothing else.  Actually, it punts on a file that contains a
NUL byte.  The hash is computed by first skipping sequences of
whitespace letters (including LF); upon seeing a non whitespace,
we start hashing, while still ignoring whitespaces, until we hit
the next LF (or EOF).  Then we store the real number of bytes
along with the hash.  

When we find the matching hash value in the destination, we say
that many bytes (including the whitespaces we ignored while
hashing) were copied.

The patch should apply on top of the current "next".

---

diff --git a/diffcore-delta.c b/diffcore-delta.c
index 835d82c..0f4866e 100644
--- a/diffcore-delta.c
+++ b/diffcore-delta.c
@@ -3,25 +3,10 @@
 #include "diffcore.h"
 
 /*
- * Idea here is very simple.
- *
- * We have total of (sz-N+1) N-byte overlapping sequences in buf whose
- * size is sz.  If the same N-byte sequence appears in both source and
- * destination, we say the byte that starts that sequence is shared
- * between them (i.e. copied from source to destination).
- *
- * For each possible N-byte sequence, if the source buffer has more
- * instances of it than the destination buffer, that means the
- * difference are the number of bytes not copied from source to
- * destination.  If the counts are the same, everything was copied
- * from source to destination.  If the destination has more,
- * everything was copied, and destination added more.
- *
- * We are doing an approximation so we do not really have to waste
- * memory by actually storing the sequence.  We just hash them into
- * somewhere around 2^16 hashbuckets and count the occurrences.
- *
- * The length of the sequence is arbitrarily set to 8 for now.
+ * Record the hashes for "extended lines" in both source and destination,
+ * and compare how similar they are.  "Extended lines" hash is designed
+ * to work well on text files -- leading whitespaces and tabs, and consecutive
+ * LF characters are effectively ignored.
  */
 
 /* Wild guess at the initial hash size */
@@ -40,8 +25,9 @@
 #define HASHBASE 107927
 
 struct spanhash {
-	unsigned long hashval;
-	unsigned long cnt;
+	unsigned long hashval; /* hash for the line */
+	unsigned bytes; /* real number of bytes in such a line */
+	unsigned long cnt; /* occurrences */
 };
 struct spanhash_top {
 	int alloc_log2;
@@ -87,6 +73,7 @@ static struct spanhash_top *spanhash_reh
 			if (!h->cnt) {
 				h->hashval = o->hashval;
 				h->cnt = o->cnt;
+				h->bytes = o->bytes;
 				new->free--;
 				break;
 			}
@@ -99,7 +86,8 @@ static struct spanhash_top *spanhash_reh
 }
 
 static struct spanhash_top *add_spanhash(struct spanhash_top *top,
-					 unsigned long hashval)
+					 unsigned long hashval,
+					 unsigned bytes)
 {
 	int bucket, lim;
 	struct spanhash *h;
@@ -110,6 +98,7 @@ static struct spanhash_top *add_spanhash
 		h = &(top->data[bucket++]);
 		if (!h->cnt) {
 			h->hashval = hashval;
+			h->bytes = bytes;
 			h->cnt = 1;
 			top->free--;
 			if (top->free < 0)
@@ -117,6 +106,14 @@ static struct spanhash_top *add_spanhash
 			return top;
 		}
 		if (h->hashval == hashval) {
+			if (h->bytes != bytes) {
+				/* avg of h->cnt instances were h->bytes
+				 * now we are adding bytes
+				 */
+				h->bytes = ((h->cnt / 2 + bytes +
+					     h->cnt * h->bytes) /
+					    (h->cnt + 1));
+			}
 			h->cnt++;
 			return top;
 		}
@@ -125,11 +122,49 @@ static struct spanhash_top *add_spanhash
 	}
 }
 
-static struct spanhash_top *hash_chars(unsigned char *buf, unsigned long sz)
+static unsigned long hash_extended_line(const unsigned char **buf_p,
+					unsigned long left)
+{
+	/* An extended line is zero or more whitespace letters (including LF)
+	 * followed by one non whitespace letter followed by zero or more
+	 * non LF, and terminated with by a LF (or EOF).
+	 */
+	const unsigned char *bol = *buf_p;
+	const unsigned char *buf = bol;
+	unsigned long hashval = 0;
+	while (left) {
+		unsigned c = *buf++;
+		if (!c)
+			goto binary;
+		left--;
+		if (' ' < c) {
+			hashval = c;
+			break;
+		}
+	}
+	while (left) {
+		unsigned c = *buf++;
+		if (!c)
+			goto binary;
+		left--;
+		if (c == '\n')
+			break;
+		if (' ' < c)
+			hashval = hashval * 11 + c;
+	}
+	*buf_p = buf;
+	return hashval;
+
+ binary:
+	*buf_p = NULL;
+	return 0;
+}
+
+static struct spanhash_top *hash_lines(const unsigned char *buf, unsigned long sz)
 {
 	int i;
-	unsigned long accum1, accum2, hashval;
 	struct spanhash_top *hash;
+	const unsigned char *eobuf = buf + sz;
 
 	i = INITIAL_HASH_SIZE;
 	hash = xmalloc(sizeof(*hash) + sizeof(struct spanhash) * (1<<i));
@@ -137,19 +172,14 @@ static struct spanhash_top *hash_chars(u
 	hash->free = INITIAL_FREE(i);
 	memset(hash->data, 0, sizeof(struct spanhash) * (1<<i));
 
-	/* an 8-byte shift register made of accum1 and accum2.  New
-	 * bytes come at LSB of accum2, and shifted up to accum1
-	 */
-	for (i = accum1 = accum2 = 0; i < 7; i++, sz--) {
-		accum1 = (accum1 << 8) | (accum2 >> 24);
-		accum2 = (accum2 << 8) | *buf++;
-	}
-	while (sz) {
-		accum1 = (accum1 << 8) | (accum2 >> 24);
-		accum2 = (accum2 << 8) | *buf++;
-		hashval = (accum1 + accum2 * 0x61) % HASHBASE;
-		hash = add_spanhash(hash, hashval);
-		sz--;
+	while (buf < eobuf) {
+		const unsigned char *ptr = buf;
+		unsigned long hashval = hash_extended_line(&buf, eobuf-ptr);
+		if (!buf) {
+			free(hash);
+			return NULL;
+		}
+		hash = add_spanhash(hash, hashval, buf-ptr);
 	}
 	return hash;
 }
@@ -166,21 +196,18 @@ int diffcore_count_changes(void *src, un
 	struct spanhash_top *src_count, *dst_count;
 	unsigned long sc, la;
 
-	if (src_size < 8 || dst_size < 8)
-		return -1;
-
 	src_count = dst_count = NULL;
 	if (src_count_p)
 		src_count = *src_count_p;
 	if (!src_count) {
-		src_count = hash_chars(src, src_size);
+		src_count = hash_lines(src, src_size);
 		if (src_count_p)
 			*src_count_p = src_count;
 	}
 	if (dst_count_p)
 		dst_count = *dst_count_p;
 	if (!dst_count) {
-		dst_count = hash_chars(dst, dst_size);
+		dst_count = hash_lines(dst, dst_size);
 		if (dst_count_p)
 			*dst_count_p = dst_count;
 	}
@@ -193,9 +220,9 @@ int diffcore_count_changes(void *src, un
 		unsigned dst_cnt, src_cnt;
 		if (!s->cnt)
 			continue;
-		src_cnt = s->cnt;
 		d = spanhash_find(dst_count, s->hashval);
-		dst_cnt = d ? d->cnt : 0;
+		src_cnt = s->cnt * s->bytes;
+		dst_cnt = d ? (d->cnt * d->bytes) : 0;
 		if (src_cnt < dst_cnt) {
 			la += dst_cnt - src_cnt;
 			sc += src_cnt;
