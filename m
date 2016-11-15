Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A82532021E
	for <e@80x24.org>; Tue, 15 Nov 2016 20:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751496AbcKOUBj (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 15:01:39 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56329 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752105AbcKOUBi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 15:01:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 279764D71C;
        Tue, 15 Nov 2016 15:01:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1Ncm4/rtonqdRImleWPLuzASO8E=; b=WmX5RL
        VXBDDlTwxxgfySY0fWAvwJOXycZlrXSM3gRrMckRvNWqKdKncxIYntU5qjy2NVf9
        2xxrnv6FZGw4WGgywCVa/N6i5OkZbnM389RuTrYs7xrsNtQr+a0H9lM+AU7r1YPh
        qky9I5d/6TndUZhHkV/LNaN6qg2UmthgUxdPs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MZFjM8Ctg6WgfTujD9ZNhJXLth1B7gDL
        zdYeia/PXnvyVAyZIYk1XvciajO/0NZn7BOqfOw+2L1thyf+FoaDVTkUntNCkaQT
        eIsBZJAs0CmrtWOOyqWHjP2fJ/H0Md+kERxd+l/GCpBnjks4hcdKd+LORDv7UXCs
        /0kPcW1XIK0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1E66C4D71A;
        Tue, 15 Nov 2016 15:01:37 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 88C394D719;
        Tue, 15 Nov 2016 15:01:36 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Matt McCutchen <matt@mattmccutchen.net>, git <git@vger.kernel.org>
Subject: Re: Protecting old temporary objects being reused from concurrent "git gc"?
References: <1479219194.2406.73.camel@mattmccutchen.net>
        <20161115170634.ichqrqbhmpv2dsiw@sigill.intra.peff.net>
        <1479231184.2406.88.camel@mattmccutchen.net>
        <20161115174028.zvohfcw4jse3jrmm@sigill.intra.peff.net>
Date:   Tue, 15 Nov 2016 12:01:35 -0800
In-Reply-To: <20161115174028.zvohfcw4jse3jrmm@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 15 Nov 2016 12:40:29 -0500")
Message-ID: <xmqqk2c4tsv4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5071F064-AB6E-11E6-8EBA-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I suspect the issue is that read-tree populates the cache-tree index
> extension, and then write-tree omits the object write before it even
> gets to write_sha1_file(). The solution is that it should probably be
> calling one of the freshen() functions (possibly just replacing
> has_sha1_file() with check_and_freshen(), but I haven't looked).

I think the final writing always happens via write_sha1_file(), but
an earlier cache-tree update that says "if we have a tree object
already, then use it, otherwise even though we know the object name
for this subtree, do not record it in the cache-tree" codepath may
decide to record the subtree's sha1 without refreshing the referent.

A fix may look like this.

 cache-tree.c | 2 +-
 cache.h      | 1 +
 sha1_file.c  | 9 +++++++--
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 345ea35963..3ae6d056b4 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -401,7 +401,7 @@ static int update_one(struct cache_tree *it,
 	if (repair) {
 		unsigned char sha1[20];
 		hash_sha1_file(buffer.buf, buffer.len, tree_type, sha1);
-		if (has_sha1_file(sha1))
+		if (freshen_object(sha1))
 			hashcpy(it->sha1, sha1);
 		else
 			to_invalidate = 1;
diff --git a/cache.h b/cache.h
index 5cdea6833e..1f5694f308 100644
--- a/cache.h
+++ b/cache.h
@@ -1126,6 +1126,7 @@ extern int sha1_object_info(const unsigned char *, unsigned long *);
 extern int hash_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *sha1);
 extern int write_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *return_sha1);
 extern int hash_sha1_file_literally(const void *buf, unsigned long len, const char *type, unsigned char *sha1, unsigned flags);
+extern int freshen_object(const unsigned char *);
 extern int pretend_sha1_file(void *, unsigned long, enum object_type, unsigned char *);
 extern int force_object_loose(const unsigned char *sha1, time_t mtime);
 extern int git_open_cloexec(const char *name, int flags);
diff --git a/sha1_file.c b/sha1_file.c
index e030805497..1daeb05dcd 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3275,6 +3275,11 @@ static int freshen_packed_object(const unsigned char *sha1)
 	return 1;
 }
 
+int freshen_object(const unsigned char *sha1)
+{
+	return freshen_packed_object(sha1) || freshen_loose_object(sha1);
+}
+
 int write_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *sha1)
 {
 	char hdr[32];
@@ -3284,7 +3289,7 @@ int write_sha1_file(const void *buf, unsigned long len, const char *type, unsign
 	 * it out into .git/objects/??/?{38} file.
 	 */
 	write_sha1_file_prepare(buf, len, type, sha1, hdr, &hdrlen);
-	if (freshen_packed_object(sha1) || freshen_loose_object(sha1))
+	if (freshen_object(sha1))
 		return 0;
 	return write_loose_object(sha1, hdr, hdrlen, buf, len, 0);
 }
@@ -3302,7 +3307,7 @@ int hash_sha1_file_literally(const void *buf, unsigned long len, const char *typ
 
 	if (!(flags & HASH_WRITE_OBJECT))
 		goto cleanup;
-	if (freshen_packed_object(sha1) || freshen_loose_object(sha1))
+	if (freshen_object(sha1))
 		goto cleanup;
 	status = write_loose_object(sha1, header, hdrlen, buf, len, 0);
 
