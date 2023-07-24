Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121D3EB64DD
	for <git@archiver.kernel.org>; Mon, 24 Jul 2023 23:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjGXXLM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jul 2023 19:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjGXXLL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2023 19:11:11 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D3810FA
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 16:11:08 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2F5022A648;
        Mon, 24 Jul 2023 19:11:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=shQHZ/6Pe9uvs0R3sDYLzP2w28wc7SmcjDKqu3
        qp8EU=; b=W29TcH5J+fODxRniNdtHoFdXKwBO9PhBeHS+0m0hAJs5kC0ZTh/zaU
        031A7vv+rX3YuXbBnbxQI9E564FDI9JdkmouS9XJoiV8YmTTSA7EOVFnWISO7ZZ1
        lT15KOPsUgIMgQc9Y2BTMwjZPQKf1aR+F86/mwSlG3M12NB5+zuVY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 27ADF2A647;
        Mon, 24 Jul 2023 19:11:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 466152A646;
        Mon, 24 Jul 2023 19:11:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, "brian m. carlson" <bk2204@github.com>
Subject: Re* [PATCH] rerere: match the hash algorithm with its length
References: <xmqqa5vou9ar.fsf@gitster.g>
        <ZL1BNxVWKGx0Gi1b@tapette.crustytoothpaste.net>
        <xmqqr0oyr3y0.fsf@gitster.g>
        <ZL7rn+LTVjSFzrI8@tapette.crustytoothpaste.net>
Date:   Mon, 24 Jul 2023 16:11:03 -0700
In-Reply-To: <ZL7rn+LTVjSFzrI8@tapette.crustytoothpaste.net> (brian
        m. carlson's message of "Mon, 24 Jul 2023 21:22:39 +0000")
Message-ID: <xmqq1qgwoqgo.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5CE4E718-2A77-11EE-946C-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> I'd retract the patch you reviewed, but now I wonder if the
>> following is a good idea.
>
> Yeah, I think that's a great idea, especially since now there are only a
> handful of those calls left.

There are exactly two ;-).

I've toned it down somewhat, as the fourth friend in the group
already exists and there is no need to make it public.  So here is
what I am going to queue.

Thanks.

---- >8 -----
Subject: [PATCH v2] hex: retire get_sha1_hex()

The naming convention around get_sha1_hex() and its friends is
awkward these days, after "struct object_id" was introduced.

There are three public functions around this area:

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
object_id" was invented, but the natural fourth friend of the above
group would take an algop and fill a flat byte buffer, and it would
be strange to name it get_sha1_hex_algop().  Do we use the passed in
algo, or are we limited to SHA-1 ;-)?

In fact, such a function exists, albeit as a private helper function
used by the implementation of these functions, and is named a lot
more sensibly: get_hash_hex_algop().

Correct the misnomer of get_sha1_hex() and use "hash", instead of
"sha1", as "flat byte buffer that stores binary (as opposed to
hexadecimal) representation of the hash".

The four (2x2) friends now become:

 * get_hash_hex()       - use the implied the_hash_algo, fill uchar *
 * get_oid_hex()        - use the implied the_hash_algo, fill oid *
 * get_hash_hex_algop() - use the passed algop, fill uchar *
 * get_oid_hex_algop()  - use the passed algop, fill oid *

As there are only two remaining calls to get_sha1_hex() in the
codebase right now, the blast radious of this change is fairly
small.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 hex.c      |  2 +-
 hex.h      | 10 ++++++----
 packfile.c |  2 +-
 rerere.c   |  2 +-
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/hex.c b/hex.c
index 7bb440e794..01f17fe5c9 100644
--- a/hex.c
+++ b/hex.c
@@ -63,7 +63,7 @@ static int get_hash_hex_algop(const char *hex, unsigned char *hash,
 	return 0;
 }
 
-int get_sha1_hex(const char *hex, unsigned char *sha1)
+int get_hash_hex(const char *hex, unsigned char *sha1)
 {
 	return get_hash_hex_algop(hex, sha1, the_hash_algo);
 }
diff --git a/hex.h b/hex.h
index 7df4b3c460..87abf66602 100644
--- a/hex.h
+++ b/hex.h
@@ -20,14 +20,16 @@ static inline int hex2chr(const char *s)
 }
 
 /*
- * Try to read a SHA1 in hexadecimal format from the 40 characters
- * starting at hex.  Write the 20-byte result to sha1 in binary form.
+ * Try to read a hash (specified by the_hash_algo) in hexadecimal
+ * format from the 40 (or whatever length the hash algorithm uses)
+ * characters starting at hex.  Write the 20-byte (or the length of
+ * the hash) result to hash in binary form.
  * Return 0 on success.  Reading stops if a NUL is encountered in the
  * input, so it is safe to pass this function an arbitrary
  * null-terminated string.
  */
-int get_sha1_hex(const char *hex, unsigned char *sha1);
-int get_oid_hex(const char *hex, struct object_id *sha1);
+int get_hash_hex(const char *hex, unsigned char *hash);
+int get_oid_hex(const char *hex, struct object_id *oid);
 
 /* Like get_oid_hex, but for an arbitrary hash algorithm. */
 int get_oid_hex_algop(const char *hex, struct object_id *oid, const struct git_hash_algo *algop);
diff --git a/packfile.c b/packfile.c
index fd083c86e0..aa7a7ad8c3 100644
--- a/packfile.c
+++ b/packfile.c
@@ -753,7 +753,7 @@ struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
 	p->pack_local = local;
 	p->mtime = st.st_mtime;
 	if (path_len < the_hash_algo->hexsz ||
-	    get_sha1_hex(path + path_len - the_hash_algo->hexsz, p->hash))
+	    get_hash_hex(path + path_len - the_hash_algo->hexsz, p->hash))
 		hashclr(p->hash);
 	return p;
 }
diff --git a/rerere.c b/rerere.c
index e968d413d6..228af65a5b 100644
--- a/rerere.c
+++ b/rerere.c
@@ -204,7 +204,7 @@ static void read_rr(struct repository *r, struct string_list *rr)
 		const unsigned hexsz = the_hash_algo->hexsz;
 
 		/* There has to be the hash, tab, path and then NUL */
-		if (buf.len < hexsz + 2 || get_sha1_hex(buf.buf, hash))
+		if (buf.len < hexsz + 2 || get_hash_hex(buf.buf, hash))
 			die(_("corrupt MERGE_RR"));
 
 		if (buf.buf[hexsz] != '.') {
-- 
2.41.0-394-ge43f4fd0bd

