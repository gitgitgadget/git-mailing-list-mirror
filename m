Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 197841F45A
	for <e@80x24.org>; Fri, 16 Aug 2019 19:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfHPT7R (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Aug 2019 15:59:17 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53462 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727565AbfHPT7Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Aug 2019 15:59:16 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B51F57E65E;
        Fri, 16 Aug 2019 15:59:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eGzE/sbMoullAZugSndwTq5tt/g=; b=HzBOlE
        mY73TXsre6BxScA6FjTHFJomJDkNtsIgvi8I8wR2R3DqSaGqzBE4tES+Wc5Oo6Xa
        nU2gj42npONUuMzigpMnuweuDHsxBa7dW0R+FnvXfqyvobNfy/RY+ordAWAp0RCk
        ZbITqVTURPZ3mHOkstTzZlvpOEKs0KzRUkiHE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ufJxuxfyV96M5C2XON1QsrR/ZtbUp2G+
        l231+OPgIlqxS7Gn18H/A9l9TIMv0NssOK//9aBd/u5bPbOgjtBk3BuPE+PeLkCw
        dWXr6/4Lm5wMHBKSttSDF7FXBh+AI5qySoT4jJRG5xmxDNzMzRVpmpJiyi5C4qo5
        FQnKkFn7m9o=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AEE117E65D;
        Fri, 16 Aug 2019 15:59:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 916F97E658;
        Fri, 16 Aug 2019 15:59:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 23/24] merge-recursive: add sanity checks for relevant merge_options
References: <20190726155258.28561-1-newren@gmail.com>
        <20190815214053.16594-1-newren@gmail.com>
        <20190815214053.16594-24-newren@gmail.com>
Date:   Fri, 16 Aug 2019 12:59:08 -0700
In-Reply-To: <20190815214053.16594-24-newren@gmail.com> (Elijah Newren's
        message of "Thu, 15 Aug 2019 14:40:52 -0700")
Message-ID: <xmqq8srs286r.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 502E7A6E-C060-11E9-877F-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/merge-recursive.c b/merge-recursive.c
> index 647b1f25c3..bc0da608c4 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -3620,6 +3620,29 @@ static int merge_start(struct merge_options *opt, struct tree *head)
>  ...
> +	assert(opt->buffer_output >= 0 && opt->buffer_output <= 2);

The field is unsigned, so >=0 side triggers "-Werror=type-limits" warning.

Material for squashing I have collected so far...

 cache-tree.c      | 2 +-
 merge-recursive.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 00eda3e537..ef8c9f5e04 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -608,7 +608,7 @@ static struct cache_tree *cache_tree_find(struct cache_tree *it, const char *pat
 	return it;
 }
 
-int write_index_as_tree_internal(struct object_id *oid, struct index_state *index_state, int cache_tree_valid, int flags, const char *prefix)
+static int write_index_as_tree_internal(struct object_id *oid, struct index_state *index_state, int cache_tree_valid, int flags, const char *prefix)
 {
 	if (flags & WRITE_TREE_IGNORE_CACHE_TREE) {
 		cache_tree_free(&index_state->cache_tree);
diff --git a/merge-recursive.c b/merge-recursive.c
index d3dc3d8a49..3d126dcc48 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3638,7 +3638,7 @@ static int merge_start(struct merge_options *opt, struct tree *head)
 	       opt->recursive_variant <= MERGE_VARIANT_THEIRS);
 
 	assert(opt->verbosity >= 0 && opt->verbosity <= 5);
-	assert(opt->buffer_output >= 0 && opt->buffer_output <= 2);
+	assert(opt->buffer_output <= 2);
 	assert(opt->obuf.len == 0);
 
 	assert(opt->priv == NULL);
