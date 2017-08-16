Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 836261F667
	for <e@80x24.org>; Wed, 16 Aug 2017 20:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752374AbdHPUcc (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 16:32:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54059 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752298AbdHPUcc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 16:32:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 53F11B1E16;
        Wed, 16 Aug 2017 16:32:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aJ7PRRUMwx8/VbgYVReyPiH3k9k=; b=DH5K6X
        fp7TAkYPs+NKNcZgVJ0lizgmbU9+Jn0nnachYaxoT26DoZxVKhu0mbGdK8inw3tX
        fOy+BHZ0n8cfOcvmGHd7padm/it1pMxt03oOGpcJ8JGPqJ6c1DrV7jPoF9I/fhP8
        8cDlG4CQfpfO8aVOEy2Z7MaDhaA4jx+kuYDpw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rWOs1ob0U2BBFqrmaZFAbc3P3/aCBzt3
        ahXcW5TEphgQ/F3wIrG+PzQZvGKZx8uQpeDceUx3kYZA6yFUm1dSXp2mZOnet4MS
        6jwL49nwuD1ubtnKzNft0+t/v+xZwe6jEhp8D685uWIq9IdlTn/fJEQar2dMRxDK
        Ze5haiDbLco=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4BA6BB1E15;
        Wed, 16 Aug 2017 16:32:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AB312B1E13;
        Wed, 16 Aug 2017 16:32:24 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, peartben@gmail.com
Subject: Re: [RFC PATCH] Updated "imported object" design
References: <20170804145113.5ceafafa@twelve2.svl.corp.google.com>
        <20170816003200.19992-1-jonathantanmy@google.com>
Date:   Wed, 16 Aug 2017 13:32:23 -0700
In-Reply-To: <20170816003200.19992-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Tue, 15 Aug 2017 17:32:00 -0700")
Message-ID: <xmqqa82zjlt4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 03353000-82C2-11E7-86E1-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Also, let me know if there's a better way to send out these patches for
> review. Some of the code here has been reviewed before, for example.
>
> [1] https://public-inbox.org/git/cover.1502241234.git.jonathantanmy@google.com/
>
> [2] https://public-inbox.org/git/ffb734d277132802bcc25baa13e8ede3490af62a.1501532294.git.jonathantanmy@google.com/
>
> [3] https://public-inbox.org/git/20170807161031.7c4eae50@twelve2.svl.corp.google.com/

... and some of the code exists only in the list archive, so we
don't know which other topic if any we may want to eject tentatively
if we wanted to give precedence to move this topic forward over
others.  I'll worry about it later but help from others is also
appreciated.

As to the contents of this patch, overall, everything makes sense,
except for one thing that makes me wonder.  It's not that I see
something specifically incorrect--it is just I do not yet quiet
fathom the implications of.

> +/*
> + * Objects that are believed to be loadable by the lazy loader, because
> + * they are referred to by an imported object. If an object that we have
> + * refers to such an object even though we don't have that object, it is
> + * not an error.
> + */
> +static struct oidset promises;
> +static int promises_prepared;
> +
> +static int add_promise(const struct object_id *oid, struct packed_git *pack,
> +		       uint32_t pos, void *data)
> +{
> +	struct object *obj = parse_object(oid);
> +	if (!obj)
> +		/*
> +		 * Error messages are given when packs are verified, so
> +		 * do not print any here.
> +		 */
> +		return 0;
> +	
> +	/*
> +	 * If this is a tree, commit, or tag, the objects it refers
> +	 * to are promises. (Blobs refer to no objects.)
> +	 */
> +	if (obj->type == OBJ_TREE) {
> +		struct tree *tree = (struct tree *) obj;
> +		struct tree_desc desc;
> +		struct name_entry entry;
> +		if (init_tree_desc_gently(&desc, tree->buffer, tree->size))
> +			/*
> +			 * Error messages are given when packs are
> +			 * verified, so do not print any here.
> +			 */
> +			return 0;
> +		while (tree_entry_gently(&desc, &entry))
> +			oidset_insert(&promises, entry.oid);
> +	} else if (obj->type == OBJ_COMMIT) {
> +		struct commit *commit = (struct commit *) obj;
> +		struct commit_list *parents = commit->parents;
> +
> +		oidset_insert(&promises, &commit->tree->object.oid);
> +		for (; parents; parents = parents->next)
> +			oidset_insert(&promises, &parents->item->object.oid);
> +	} else if (obj->type == OBJ_TAG) {
> +		struct tag *tag = (struct tag *) obj;
> +		oidset_insert(&promises, &tag->tagged->oid);
> +	}
> +	return 0;
> +}

This collects names of the objects that are _directly_ referred to
by imported objects.  An imported pack may have a commit, whose
top-level tree may or may not appear in the same pack, or the tree
may exist locally but not in the same pack.  Or the tree may not be
locally available at all.  In any of these four cases, the top-level
tree is listed in the "promises" set.  Same for trees and tags.

I wonder if all of the calls to oidset_insert() in this function
want to be guarded by "mark it as promised only when the referrent
is *not* locally available" to keep the promises set minimally
populated.  The only change needed to fsck in order to make it
refrain from treating a missing but promised object as an error
would be:

        -       if (object is missing)
        +       if (object is missing && object is not promised)
                        error("that object must be there but missing");

so there is no point in throwing something that we know we locally
have in this oidset, right?

On the other hand, cost of such additional checks in this function
may outweigh the savings of both memory pressure and look-up cost,
so I do not know how the tradeoff would turn out.

> +static int is_promise(const struct object_id *oid)
> +{
> +	if (!promises_prepared) {
> +		if (repository_format_lazy_object)
> +			for_each_packed_object(add_promise, NULL,
> +					       FOR_EACH_OBJECT_IMPORTED_ONLY);
> +		promises_prepared = 1;
> +	}
> +	return oidset_contains(&promises, oid);
> +}

Somehow I'm tempted to call this function "is_promised()" but that
is a minor naming issue.

>  static const char *describe_object(struct object *obj)
>  {
>  	static struct strbuf buf = STRBUF_INIT;
> @@ -410,7 +472,7 @@ static void fsck_handle_reflog_oid(const char *refname, struct object_id *oid,
>  					xstrfmt("%s@{%"PRItime"}", refname, timestamp));
>  			obj->used = 1;
>  			mark_object_reachable(obj);
> -		} else {
> +		} else if (!is_promise(oid)) {
>  			error("%s: invalid reflog entry %s", refname, oid_to_hex(oid));
>  			errors_found |= ERROR_REACHABLE;
>  		}

This is about certainly is one place we want to check if the missing
object is OK, but I'm a bit surprised if this were the only place.

Don't we need "while trying to follow all the outgoing links from
this tree object, and we found this object is not available locally;
normally we would mark it as an error but it turns out that the
missing one is in the promised set of objects, so it is OK" for the
normal connectivity traversal codepaths, for example?

