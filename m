Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CAFC433ED
	for <git@archiver.kernel.org>; Wed, 19 May 2021 04:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A07761002
	for <git@archiver.kernel.org>; Wed, 19 May 2021 04:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353263AbhESE3a (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 00:29:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62190 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbhESE3a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 00:29:30 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 71E53D1C17;
        Wed, 19 May 2021 00:28:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=72c7DrD+nXAZEpBrtl7Bhb2ux8r7eaIOKQxKNJ
        ziN4s=; b=RrSxO3L1wqBnzsoWyI+lSJkkn1wJ5qiXbjA3Vu/RHpAiU5beCLAsjd
        bELuzLWIM/+F3UdG1EZ0z++QweHgDEd7pDMOyq0o5r7Jiwi96QW/zQuvWPeTfsF/
        Q88KoNCu1ELMj9YdTuXs5bk6yEh1tDzj+EC5qGBZ5LbEhqwcNZ2n8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6AC1ED1C16;
        Wed, 19 May 2021 00:28:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E6530D1C15;
        Wed, 19 May 2021 00:28:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, avarab@gmail.com
Subject: Re: [PATCH v2 1/3] packfile-uris: support for excluding commit object
References: <cover.1621327467.git.dyroneteng@gmail.com>
        <73e64147b17cb382d34357c913616095b6169650.1621327467.git.dyroneteng@gmail.com>
Date:   Wed, 19 May 2021 13:28:09 +0900
In-Reply-To: <73e64147b17cb382d34357c913616095b6169650.1621327467.git.dyroneteng@gmail.com>
        (Teng Long's message of "Tue, 18 May 2021 16:49:51 +0800")
Message-ID: <xmqq5yzfz6sm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9DD74798-B85A-11EB-902D-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> On the server, more sophisticated means of excluding objects should be
> supported, such as commit object. This commit introduces a new
> configuration `uploadpack.excludeobject` for this.

This "should" is not justfied at all, it seems?  What is lacking in
what we already have?  What new things does it all us to do by
adding a new configuration variable?

> The old configuration `uploadpack.blobpackfileuri` is only support to
> exclude blobs and the name has no abstract meaning, so the configruation
> name changes, to support more object types. Compatibility issues will
> not be considered because packfile-uris now is an experimental feature.

I'll let Jonathan speak up, but even for an experimental feature,
whatever new and incompatible way to do things should have a clear
advantage compared to the old way.  Sell the backward incomptibility
along that line---"it is an experimental so I'll trash it" is not,
but "by doing this it gets this much better, and migrating existing
users won't be too taxing (it is just this simple thing)" is an
acceptable way to justify such a change.

Note that I am not opposed to the proposed change (and I am not
supporting it, either).  I do have a problem with the way the change
is sold, though.

>  builtin/pack-objects.c | 53 ++++++++++++++++++++++++++++++------------
>  fetch-pack.c           |  5 ++++
>  upload-pack.c          |  5 ++--
>  3 files changed, 45 insertions(+), 18 deletions(-)

Even though the name of the configuration variable changed, and the
semantics of the value of it changed, there is no documentation
change, because...?

Because the original didn't even document the variable properly?  It
may be another reason why changing it may not impact the existing
users too much.

> @@ -132,6 +134,7 @@ struct configured_exclusion {
>  	struct oidmap_entry e;
>  	char *pack_hash_hex;
>  	char *uri;
> +	int recursively:1;
>  };
>  static struct oidmap configured_exclusions;
>  
> @@ -1291,10 +1294,16 @@ static int want_object_in_pack_one(struct packed_git *p,
>   * and its offset in these variables.
>   */
>  static int want_object_in_pack(const struct object_id *oid,
> +			       enum object_type type,
>  			       int exclude,
>  			       struct packed_git **found_pack,
>  			       off_t *found_offset)
>  {
> +	if (exclude_until_next_commit && type != OBJ_COMMIT)
> +		return 0;
> +	if (type == OBJ_COMMIT)
> +		exclude_until_next_commit = 0 ;

Lose SP before the semicolon.

Our codebase does not allow statements before declarations.  Move
all of the above down to be below the block of decls at the
beginning of the function.

>  	int want;
>  	struct list_head *pos;
>  	struct multi_pack_index *m;

> @@ -1345,6 +1354,8 @@ static int want_object_in_pack(const struct object_id *oid,
>  						&p) &&
>  				    *p == ':') {
>  					oidset_insert(&excluded_by_config, oid);
> +					if(ex->recursively && type == OBJ_COMMIT)
> +						exclude_until_next_commit = 1;

This depends on a new file-scope global variable, which means two
things.

 * if two or more threads are deciding which object to pack and not
   to pack, this code will horribly break, as they are traversing
   totally different parts of the object DAG to find out which
   objects to pack, but one thread hitting a commit to be excluded
   and setting this flag will cause other thread skip unrelated
   blobs and trees that it discovers, doesn't it?

 * even if we assume there is no concurrency and reentrancy issues
   (e.g. by forcing single-threaded operation when this feature is
   in use), the code _assumes_ a concrete order in which this helper
   function gets called, namely, non-commit objects fed to this
   helper after the helper gets a single commit object *all* belong
   to that commit.  With the current code that feeds objects as they
   are discovered during depth first traversal of the top-level tree
   starting at each commit, that assumption might hold, but it feels
   that the assumption is too much to be healty.  For example, would
   it be possible for the bitmap code to cause this helper to be
   called in different order (i.e. it might find it more convenent
   to feed a tree, a blob or a tag that is unrelated to the commit
   that was last fed to the helper)?  If so, the logic in this code
   will constrain the caller too much.

I'll stop reading for now at this place; review of the remainder may
come at a later time, but not now.

Thanks.
