From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-diff-tree -M performance regression in 'next'
Date: Mon, 13 Mar 2006 19:47:41 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603131941260.3618@g5.osdl.org>
References: <20060311172818.GB32609@c165.ib.student.liu.se>
 <7voe0bdeyr.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0603120858230.3618@g5.osdl.org>
 <7vk6azcv9y.fsf@assigned-by-dhcp.cox.net> <7vwtezw4ye.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0603121700410.3618@g5.osdl.org> <Pine.LNX.4.64.0603121710110.3618@g5.osdl.org>
 <7vwtezt202.fsf@assigned-by-dhcp.cox.net> <7vveuhohve.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 14 04:48:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJ0Vn-0002XK-FX
	for gcvg-git@gmane.org; Tue, 14 Mar 2006 04:47:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932566AbWCNDrx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Mar 2006 22:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932567AbWCNDrx
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Mar 2006 22:47:53 -0500
Received: from smtp.osdl.org ([65.172.181.4]:26757 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932566AbWCNDrw (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Mar 2006 22:47:52 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2E3liDZ015919
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 13 Mar 2006 19:47:44 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2E3lgbM008005;
	Mon, 13 Mar 2006 19:47:42 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vveuhohve.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17585>



On Mon, 13 Mar 2006, Junio C Hamano wrote:
> 
> Here is still an WIP but an insanely fast one (actually this is
> a modified version of what once was in next).  I haven't
> verified the sanity of its output fully, but from a cursory look
> what are found look sensible.  The same v2.6.12..v2.6.14 test on
> my Duron 750:

Heh. I did something similar, except I wanted mine to work with binary 
data too. Not that I know how _well_ it works, but assuming you have 
_some_ '\n' characters to fix up offset mismatches, it might do something.

Mine is a bit less hacky than yours, I believe. It doesn't skip 
whitespace, instead it just maintains a rolling 64-bit number, where each 
character shifts it left by 7 and then adds in the new character value 
(overflow in 32 bits just ignored).

Then it uses your old hash function, except it hides the length in the top 
byte.

It breaks the hashing on '\n' or on hitting a 64-byte sequence, whichever 
comes first.

It's fast and stupid, but doesn't seem to do any worse than your old one. 
The speed comes from the fact that it only does the hash comparisons at 
the "block boundaries", not at every byte.

Anyway, I don't think something like this is really any good for rename 
detection, but it might be good for deciding whether to do a real delta.

		Linus

----
diff --git a/diffcore-delta.c b/diffcore-delta.c
index 835d82c..4c6e512 100644
--- a/diffcore-delta.c
+++ b/diffcore-delta.c
@@ -127,7 +127,7 @@ static struct spanhash_top *add_spanhash
 
 static struct spanhash_top *hash_chars(unsigned char *buf, unsigned long sz)
 {
-	int i;
+	int i, n;
 	unsigned long accum1, accum2, hashval;
 	struct spanhash_top *hash;
 
@@ -137,19 +137,21 @@ static struct spanhash_top *hash_chars(u
 	hash->free = INITIAL_FREE(i);
 	memset(hash->data, 0, sizeof(struct spanhash) * (1<<i));
 
-	/* an 8-byte shift register made of accum1 and accum2.  New
-	 * bytes come at LSB of accum2, and shifted up to accum1
-	 */
-	for (i = accum1 = accum2 = 0; i < 7; i++, sz--) {
-		accum1 = (accum1 << 8) | (accum2 >> 24);
-		accum2 = (accum2 << 8) | *buf++;
-	}
+	n = 0;
+	accum1 = accum2 = 0;
 	while (sz) {
-		accum1 = (accum1 << 8) | (accum2 >> 24);
-		accum2 = (accum2 << 8) | *buf++;
+		unsigned long c = *buf++;
+		sz--;
+		accum1 = (accum1 << 7) | (accum2 >> 25);
+		accum2 = (accum2 << 7) | (accum1 >> 25);
+		accum1 += c;
+		if (++n < 64 && c != '\n')
+			continue;
 		hashval = (accum1 + accum2 * 0x61) % HASHBASE;
+		hashval |= (n << 24);
 		hash = add_spanhash(hash, hashval);
-		sz--;
+		n = 0;
+		accum1 = accum2 = 0;
 	}
 	return hash;
 }
@@ -166,9 +168,6 @@ int diffcore_count_changes(void *src, un
 	struct spanhash_top *src_count, *dst_count;
 	unsigned long sc, la;
 
-	if (src_size < 8 || dst_size < 8)
-		return -1;
-
 	src_count = dst_count = NULL;
 	if (src_count_p)
 		src_count = *src_count_p;
@@ -196,6 +195,8 @@ int diffcore_count_changes(void *src, un
 		src_cnt = s->cnt;
 		d = spanhash_find(dst_count, s->hashval);
 		dst_cnt = d ? d->cnt : 0;
+		dst_cnt *= (d->hashval >> 24);
+		src_cnt *= (d->hashval >> 24);
 		if (src_cnt < dst_cnt) {
 			la += dst_cnt - src_cnt;
 			sc += src_cnt;
