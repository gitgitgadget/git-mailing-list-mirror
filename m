Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A82092042F
	for <e@80x24.org>; Thu, 17 Nov 2016 01:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2992446AbcKQBfx (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Nov 2016 20:35:53 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61962 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2992442AbcKQBfv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 20:35:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1CF625009B;
        Wed, 16 Nov 2016 20:35:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=D3m1EQMGXzAZ8bm9J625yMLQIBM=; b=hLPXwJ
        13SjZypYEY/RnR/tnQX8lxEiPFDv4eUCUbeSx0mHGPagqHK7J73x37QqXd9zRItl
        UNP7ykjmCqTenEL3Qo75Zuovl1g5qNXuokmLGrDEzCYt4QkXUbUop2we4f0fjLhm
        45xdnkKznxmX8Dk591B+pHsgBmxKnY08fcaeA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rG8Q9AXj89qvVcPJkMHikMUvpdP0ELiZ
        SHzbMt3/Dtob73SsvazBcOiHixTRMPi/5JmgshSNmEZE/Oa9GSSz8TFiFfVVvN5C
        bOj0MRWSSkMTcZKSTcbmP7F+MXOc/6gkc5d2wSXw1uLCM7ASZl371xZDQwmHN6Ay
        1DGG+PeNjsI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 14DD85009A;
        Wed, 16 Nov 2016 20:35:50 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 709E250099;
        Wed, 16 Nov 2016 20:35:49 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Matt McCutchen <matt@mattmccutchen.net>, git <git@vger.kernel.org>
Subject: Re* Protecting old temporary objects being reused from concurrent "git gc"?
References: <1479219194.2406.73.camel@mattmccutchen.net>
        <20161115170634.ichqrqbhmpv2dsiw@sigill.intra.peff.net>
        <1479231184.2406.88.camel@mattmccutchen.net>
        <20161115174028.zvohfcw4jse3jrmm@sigill.intra.peff.net>
        <xmqq1sybqmjt.fsf@gitster.mtv.corp.google.com>
        <20161117010449.6k3cwo3njvrid4jy@sigill.intra.peff.net>
Date:   Wed, 16 Nov 2016 17:35:47 -0800
In-Reply-To: <20161117010449.6k3cwo3njvrid4jy@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 16 Nov 2016 17:04:50 -0800")
Message-ID: <xmqqvavmopl8.fsf_-_@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2B51B668-AC66-11E6-8E22-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think the case that is helped here is somebody who runs "git
> write-tree" and expects that the timestamp on those trees is fresh. So
> even more a briefly used index, like:
>
>   export GIT_INDEX_FILE=/tmp/foo
>   git read-tree ...
>   git write-tree
>   rm -f $GIT_INDEX_FILE
>
> we'd expect that a "git gc" which runs immediately after would see those
> trees as recent and avoid pruning them (and transitively, any blobs that
> are reachable from the trees). But I don't think that write-tree
> actually freshens them (it sees "oh, we already have these; there is
> nothing to write").

OK, here is what I have queued.

-- >8 --
Subject: cache-tree: make sure to "touch" tree objects the cache-tree records

The cache_tree_fully_valid() function is called by callers that want
to know if they need to call cache_tree_update(), i.e. as an attempt
to optimize. They all want to have a fully valid cache-tree in the
end so that they can write a tree object out.

We used to check if the cached tree object is up-to-date (i.e. the
index entires covered by the cache-tree entry hasn't been changed
since the roll-up hash was computed for the cache-tree entry) and
made sure the tree object is already in the object store.  Since the
top-level tree we would soon be asked to write out (and would find
in the object store) may not be anchored to any refs or commits
immediately, freshen the tree object when it happens.

Similarly, when we actually compute the cache-tree entries in
cache_tree_update(), we refrained from writing a tree object out
when it already exists in the object store.  We would want to
freshen the tree object in that case to protect it from premature
pruning.

Strictly speaking, freshing these tree objects at each and every
level is probably unnecessary, given that anything reachable from a
young object inherits the youth from the referring object to be
protected from pruning.  It should be sufficient to freshen only the
very top-level tree instead.  Benchmarking and optimization is left
as an exercise for later days.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache-tree.c | 6 +++---
 cache.h      | 1 +
 sha1_file.c  | 9 +++++++--
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 3ebf9c3aa4..c8c74a1e07 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -225,7 +225,7 @@ int cache_tree_fully_valid(struct cache_tree *it)
 	int i;
 	if (!it)
 		return 0;
-	if (it->entry_count < 0 || !has_sha1_file(it->sha1))
+	if (it->entry_count < 0 || !freshen_object(it->sha1))
 		return 0;
 	for (i = 0; i < it->subtree_nr; i++) {
 		if (!cache_tree_fully_valid(it->down[i]->cache_tree))
@@ -253,7 +253,7 @@ static int update_one(struct cache_tree *it,
 
 	*skip_count = 0;
 
-	if (0 <= it->entry_count && has_sha1_file(it->sha1))
+	if (0 <= it->entry_count && freshen_object(it->sha1))
 		return it->entry_count;
 
 	/*
@@ -393,7 +393,7 @@ static int update_one(struct cache_tree *it,
 	if (repair) {
 		unsigned char sha1[20];
 		hash_sha1_file(buffer.buf, buffer.len, tree_type, sha1);
-		if (has_sha1_file(sha1))
+		if (freshen_object(sha1))
 			hashcpy(it->sha1, sha1);
 		else
 			to_invalidate = 1;
diff --git a/cache.h b/cache.h
index 4ff196c259..72c0b321ac 100644
--- a/cache.h
+++ b/cache.h
@@ -1077,6 +1077,7 @@ extern int sha1_object_info(const unsigned char *, unsigned long *);
 extern int hash_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *sha1);
 extern int write_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *return_sha1);
 extern int hash_sha1_file_literally(const void *buf, unsigned long len, const char *type, unsigned char *sha1, unsigned flags);
+extern int freshen_object(const unsigned char *);
 extern int pretend_sha1_file(void *, unsigned long, enum object_type, unsigned char *);
 extern int force_object_loose(const unsigned char *sha1, time_t mtime);
 extern int git_open_noatime(const char *name);
diff --git a/sha1_file.c b/sha1_file.c
index d0f2aa029b..9acce3d3b8 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3151,6 +3151,11 @@ static int freshen_packed_object(const unsigned char *sha1)
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
@@ -3160,7 +3165,7 @@ int write_sha1_file(const void *buf, unsigned long len, const char *type, unsign
 	 * it out into .git/objects/??/?{38} file.
 	 */
 	write_sha1_file_prepare(buf, len, type, sha1, hdr, &hdrlen);
-	if (freshen_packed_object(sha1) || freshen_loose_object(sha1))
+	if (freshen_object(sha1))
 		return 0;
 	return write_loose_object(sha1, hdr, hdrlen, buf, len, 0);
 }
@@ -3178,7 +3183,7 @@ int hash_sha1_file_literally(const void *buf, unsigned long len, const char *typ
 
 	if (!(flags & HASH_WRITE_OBJECT))
 		goto cleanup;
-	if (freshen_packed_object(sha1) || freshen_loose_object(sha1))
+	if (freshen_object(sha1))
 		goto cleanup;
 	status = write_loose_object(sha1, header, hdrlen, buf, len, 0);
 
-- 
2.11.0-rc1-156-g07127df5c1

