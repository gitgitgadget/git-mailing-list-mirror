Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB918C001B0
	for <git@archiver.kernel.org>; Sun, 23 Jul 2023 16:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjGWQ0P (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Jul 2023 12:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjGWQ0L (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jul 2023 12:26:11 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2CB1FDA
        for <git@vger.kernel.org>; Sun, 23 Jul 2023 09:25:46 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 895E02B247;
        Sun, 23 Jul 2023 12:24:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5OiW4I5s20DxxgpTkwJnozlvVMmTFLcSiF75bX
        uK6/s=; b=G2t4ThOXLoiIsVcu/9oftbah5e6Uo0qq8RZm6Dquosh0C0trlqANR0
        IL/HofUV20qHRirEvUmCEw7VvgeL1hQVLX+BzPXNpH2mlJOodvTpHUkZ/x7KJOme
        NIV4Bdz8hD/Qj6CuJ7viXUjCaLMW3g7nH+N7IEJSdr1JYF0tQ4kDo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 769092B246;
        Sun, 23 Jul 2023 12:24:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 08A022B242;
        Sun, 23 Jul 2023 12:24:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, "brian m. carlson" <bk2204@github.com>
Subject: Re: [PATCH] rerere: match the hash algorithm with its length
References: <xmqqa5vou9ar.fsf@gitster.g>
        <ZL1BNxVWKGx0Gi1b@tapette.crustytoothpaste.net>
Date:   Sun, 23 Jul 2023 09:24:39 -0700
In-Reply-To: <ZL1BNxVWKGx0Gi1b@tapette.crustytoothpaste.net> (brian
        m. carlson's message of "Sun, 23 Jul 2023 15:03:19 +0000")
Message-ID: <xmqqr0oyr3y0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6D868C64-2975-11EE-A678-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I agree consistency here is a good idea.  However, I should point out
> the definition of `get_sha1_hex`:
>
> int get_sha1_hex(const char *hex, unsigned char *sha1)
> {
> 	return get_hash_hex_algop(hex, sha1, the_hash_algo);
> }

Yeah, I think I lifted the inlining from there, and you are
absolutely right.  I think the main source of the confusion is that
get_sha1_hex(), while it was a perfectly good name before the
"struct object_id" world, has now become a misnomer.

I'd retract the patch you reviewed, but now I wonder if the
following is a good idea.

------- >8 ------------- >8 ------------- >8 -------
Subject: [PATCH] hex: retire get_sha1_hex()

The naming convention around get_sha1_hex() and its friends is
awkward these days (post "struct object_id".  There are three public
functions:

 * get_sha1_hex()       - use the implied the_hash_algo, fill uchar *
 * get_oid_hex()        - use the implied the_hash_algo, fill oid *
 * get_oid_hex_algop()  - use the passed algop, fill oid *

Between the latter two, the "_algop" suffix signals whether the
the_hash_algo is used as the implied algorithm or the caller should
pass an algorithm explicitly.  That is very much understandable and
is a good convention.

Between the former two, however, the "SHA1" vs "OID" in the names
differentiate in what type of variable the result is stored.

We could argue that it makes sense to use "SHA1" to mean "flat byte
buffer" to honor the historical practice in the days before "struct
object_id" was invented, but when we introduce and name the natural
fourth friend to the mix that takes an algop and fills a flat byte
buffer, it would get an awkward name: get_sha1_hex_algop().

Do we use the passed in algo, or are we limited to SHA-1 ;-)?

Correct the misnomer and use "hash" as "flat byte buffer that stores
binary (as opposed to hexadecimal) representation of the hash".  The
four (2x2) friends now become:

 * get_hash_hex()       - use the implied the_hash_algo, fill uchar *
 * get_oid_hex()        - use the implied the_hash_algo, fill oid *
 * get_hash_hex_algop() - use the passed algop, fill uchar *
 * get_oid_hex_algop()  - use the passed algop, fill oid *

As there are only two remaining calls to get_sha1_hex() in the
codebase right now, the blast radious is fairly small.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 hex.c      |  6 +++---
 hex.h      | 13 +++++++++----
 packfile.c |  2 +-
 rerere.c   |  2 +-
 4 files changed, 14 insertions(+), 9 deletions(-)

diff --git c/hex.c w/hex.c
index 7bb440e794..9ec4e674ad 100644
--- c/hex.c
+++ w/hex.c
@@ -49,8 +49,8 @@ int hex_to_bytes(unsigned char *binary, const char *hex, size_t len)
 	return 0;
 }
 
-static int get_hash_hex_algop(const char *hex, unsigned char *hash,
-			      const struct git_hash_algo *algop)
+int get_hash_hex_algop(const char *hex, unsigned char *hash,
+		       const struct git_hash_algo *algop)
 {
 	int i;
 	for (i = 0; i < algop->rawsz; i++) {
@@ -63,7 +63,7 @@ static int get_hash_hex_algop(const char *hex, unsigned char *hash,
 	return 0;
 }
 
-int get_sha1_hex(const char *hex, unsigned char *sha1)
+int get_hash_hex(const char *hex, unsigned char *sha1)
 {
 	return get_hash_hex_algop(hex, sha1, the_hash_algo);
 }
diff --git c/hex.h w/hex.h
index 7df4b3c460..9fa9c11fd0 100644
--- c/hex.h
+++ w/hex.h
@@ -20,14 +20,19 @@ static inline int hex2chr(const char *s)
 }
 
 /*
- * Try to read a SHA1 in hexadecimal format from the 40 characters
- * starting at hex.  Write the 20-byte result to sha1 in binary form.
+ * Try to read a hash (specified by the_hash_algo) in hexadecimal format from
+ * the 40 (or whatever length the hash algorithm uses) characters
+ * starting at hex.  Write the 20-byte (or the length of the hash) result to
+ * hash in binary form.
  * Return 0 on success.  Reading stops if a NUL is encountered in the
  * input, so it is safe to pass this function an arbitrary
  * null-terminated string.
  */
-int get_sha1_hex(const char *hex, unsigned char *sha1);
-int get_oid_hex(const char *hex, struct object_id *sha1);
+int get_hash_hex(const char *hex, unsigned char *hash);
+int get_oid_hex(const char *hex, struct object_id *oid);
+
+/* Like get_hash_hex, but for an arbitrary hash algorithm. */
+int get_hash_hex_algop(const char *hex, unsigned char *, const struct git_hash_algo *);
 
 /* Like get_oid_hex, but for an arbitrary hash algorithm. */
 int get_oid_hex_algop(const char *hex, struct object_id *oid, const struct git_hash_algo *algop);
diff --git c/packfile.c w/packfile.c
index 030b7ec7a8..3076fc8d6f 100644
--- c/packfile.c
+++ w/packfile.c
@@ -751,7 +751,7 @@ struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
 	p->pack_local = local;
 	p->mtime = st.st_mtime;
 	if (path_len < the_hash_algo->hexsz ||
-	    get_sha1_hex(path + path_len - the_hash_algo->hexsz, p->hash))
+	    get_hash_hex(path + path_len - the_hash_algo->hexsz, p->hash))
 		hashclr(p->hash);
 	return p;
 }
diff --git c/rerere.c w/rerere.c
index 7070f75014..725c1b6a95 100644
--- c/rerere.c
+++ w/rerere.c
@@ -204,7 +204,7 @@ static void read_rr(struct repository *r, struct string_list *rr)
 		const unsigned hexsz = the_hash_algo->hexsz;
 
 		/* There has to be the hash, tab, path and then NUL */
-		if (buf.len < hexsz + 2 || get_sha1_hex(buf.buf, hash))
+		if (buf.len < hexsz + 2 || get_hash_hex(buf.buf, hash))
 			die(_("corrupt MERGE_RR"));
 
 		if (buf.buf[hexsz] != '.') {
