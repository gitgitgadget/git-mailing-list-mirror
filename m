Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BEA5C433DF
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 18:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F8C520675
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 18:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="skaiRb9e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgHLSZm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 14:25:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61799 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgHLSZm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 14:25:42 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 02D6B6F655;
        Wed, 12 Aug 2020 14:25:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MsSoCJPeNDchxWmEQDMkYXZ8D8A=; b=skaiRb
        9eTyuVYClgwcuZIeoPdy5DG1AkReHYhUmU8BBW4sZgBKQ/Z5djL/TJ2DDLcMf7R5
        8nQlvs71nvg3ybQ+5qtq/3FYmwibVPFnGVQqsVUNv1+WyO+3DZ1EmISgdaEc0X5g
        5W6LcFfIjCbtWFd+rFQcNin/EhNzG7DSWG5tc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sPxawlQxydVlcz32qDoizPlBnirkQspb
        aF6BBXLBj9hS635p5lNeDuS9mYJ1VmFIUvLT04Zr6ldtpJYi34owAxaPw24iD4Fe
        5kSlaUKk1/dwWX3CNZ890jSOnWqDjojNm7zsRBrzXnzPm27xrAin2O+92iaPjIov
        r5nNOM4HFZA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EF3856F654;
        Wed, 12 Aug 2020 14:25:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7AD686F652;
        Wed, 12 Aug 2020 14:25:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 5/7] fetch-pack: do not lazy-fetch during ref iteration
References: <20200724223844.2723397-1-jonathantanmy@google.com>
        <cover.1597184948.git.jonathantanmy@google.com>
        <d42e98ff0760932cffb021eb680b76da74e4461f.1597184949.git.jonathantanmy@google.com>
Date:   Wed, 12 Aug 2020 11:25:38 -0700
In-Reply-To: <d42e98ff0760932cffb021eb680b76da74e4461f.1597184949.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Tue, 11 Aug 2020 15:52:20 -0700")
Message-ID: <xmqqft8r7mcd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 393F577A-DCC9-11EA-AB5C-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Teach "fetch-pack" not to lazy fetch whenever iterating over
> refs. 

Don't readers need the reason why is it a good thing to do explained
here?

> This
> is done by using the raw form of ref iteration and by dereferencing tags
> ourselves.

Hmph.  The way this patch implements deref_without_lazy_fetch()
makes it hard to reuse in other contexts, as it mixes what is done
by mark_complete(), which is very much "git fetch" specific.

Would "git fetch" be the only user potentially benefit from being
able to dereference a tag that already exists locally and ignore
missing ones?  I wonder if teaching deref_tag() a new flag would be
a better alternative to keep the separation of concerns at different
layers.

> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  fetch-pack.c             | 79 ++++++++++++++++++++++------------------
>  t/t5616-partial-clone.sh | 20 ++++++++++
>  2 files changed, 64 insertions(+), 35 deletions(-)
>
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 80fb3bd899..707bbc31fd 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -108,24 +108,48 @@ static void for_each_cached_alternate(struct fetch_negotiator *negotiator,
>  		cb(negotiator, cache.items[i]);
>  }
>  
> +static struct commit *deref_without_lazy_fetch(const struct object_id *oid,
> +					       int mark_tags_complete)
> +{
> +	enum object_type type;
> +	struct object_info info = { .typep = &type };
> +
> +	while (1) {
> +		if (oid_object_info_extended(the_repository, oid, &info,
> +					     OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_QUICK))
> +			return NULL;
> +		if (type == OBJ_TAG) {
> +			struct tag *tag = (struct tag *)
> +				parse_object(the_repository, oid);
> +
> +			if (!tag->tagged)
> +				return NULL;
> +			if (mark_tags_complete)
> +				tag->object.flags |= COMPLETE;
> +			oid = &tag->tagged->oid;
> +		} else {
> +			break;
> +		}
> +	}
> +	if (type == OBJ_COMMIT)
> +		return (struct commit *) parse_object(the_repository, oid);
> +	return NULL;
> +}
> +
>  static int rev_list_insert_ref(struct fetch_negotiator *negotiator,
> -			       const char *refname,
>  			       const struct object_id *oid)
>  {
> -	struct object *o = deref_tag(the_repository,
> -				     parse_object(the_repository, oid),
> -				     refname, 0);
> -
> -	if (o && o->type == OBJ_COMMIT)
> -		negotiator->add_tip(negotiator, (struct commit *)o);
> +	struct commit *c = deref_without_lazy_fetch(oid, 0);
>  
> +	if (c)
> +		negotiator->add_tip(negotiator, c);
>  	return 0;
>  }
>  
>  static int rev_list_insert_ref_oid(const char *refname, const struct object_id *oid,
>  				   int flag, void *cb_data)
>  {
> -	return rev_list_insert_ref(cb_data, refname, oid);
> +	return rev_list_insert_ref(cb_data, oid);
>  }
>  
>  enum ack_type {
> @@ -201,7 +225,7 @@ static void send_request(struct fetch_pack_args *args,
>  static void insert_one_alternate_object(struct fetch_negotiator *negotiator,
>  					struct object *obj)
>  {
> -	rev_list_insert_ref(negotiator, NULL, &obj->oid);
> +	rev_list_insert_ref(negotiator, &obj->oid);
>  }
>  
>  #define INITIAL_FLUSH 16
> @@ -230,13 +254,12 @@ static void mark_tips(struct fetch_negotiator *negotiator,
>  	int i;
>  
>  	if (!negotiation_tips) {
> -		for_each_ref(rev_list_insert_ref_oid, negotiator);
> +		for_each_rawref(rev_list_insert_ref_oid, negotiator);
>  		return;
>  	}
>  
>  	for (i = 0; i < negotiation_tips->nr; i++)
> -		rev_list_insert_ref(negotiator, NULL,
> -				    &negotiation_tips->oid[i]);
> +		rev_list_insert_ref(negotiator, &negotiation_tips->oid[i]);
>  	return;
>  }
>  
> @@ -503,21 +526,11 @@ static struct commit_list *complete;
>  
>  static int mark_complete(const struct object_id *oid)
>  {
> -	struct object *o = parse_object(the_repository, oid);
> -
> -	while (o && o->type == OBJ_TAG) {
> -		struct tag *t = (struct tag *) o;
> -		if (!t->tagged)
> -			break; /* broken repository */
> -		o->flags |= COMPLETE;
> -		o = parse_object(the_repository, &t->tagged->oid);
> -	}
> -	if (o && o->type == OBJ_COMMIT) {
> -		struct commit *commit = (struct commit *)o;
> -		if (!(commit->object.flags & COMPLETE)) {
> -			commit->object.flags |= COMPLETE;
> -			commit_list_insert(commit, &complete);
> -		}
> +	struct commit *commit = deref_without_lazy_fetch(oid, 1);
> +
> +	if (commit && !(commit->object.flags & COMPLETE)) {
> +		commit->object.flags |= COMPLETE;
> +		commit_list_insert(commit, &complete);
>  	}
>  	return 0;
>  }
> @@ -702,7 +715,7 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
>  	 */
>  	trace2_region_enter("fetch-pack", "mark_complete_local_refs", NULL);
>  	if (!args->deepen) {
> -		for_each_ref(mark_complete_oid, NULL);
> +		for_each_rawref(mark_complete_oid, NULL);
>  		for_each_cached_alternate(NULL, mark_alternate_complete);
>  		commit_list_sort_by_date(&complete);
>  		if (cutoff)
> @@ -716,16 +729,12 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
>  	 */
>  	trace2_region_enter("fetch-pack", "mark_common_remote_refs", NULL);
>  	for (ref = *refs; ref; ref = ref->next) {
> -		struct object *o = deref_tag(the_repository,
> -					     lookup_object(the_repository,
> -					     &ref->old_oid),
> -					     NULL, 0);
> +		struct commit *c = deref_without_lazy_fetch(&ref->old_oid, 0);
>  
> -		if (!o || o->type != OBJ_COMMIT || !(o->flags & COMPLETE))
> +		if (!c || !(c->object.flags & COMPLETE))
>  			continue;
>  
> -		negotiator->known_common(negotiator,
> -					 (struct commit *)o);
> +		negotiator->known_common(negotiator, c);
>  	}
>  	trace2_region_leave("fetch-pack", "mark_common_remote_refs", NULL);
>  
> diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
> index 8a27452a51..e53492d595 100755
> --- a/t/t5616-partial-clone.sh
> +++ b/t/t5616-partial-clone.sh
> @@ -384,6 +384,26 @@ test_expect_success 'fetch lazy-fetches only to resolve deltas, protocol v2' '
>  	grep "want $(cat hash)" trace
>  '
>  
> +test_expect_success 'fetch does not lazy-fetch missing targets of its refs' '
> +	rm -rf server client trace &&
> +
> +	test_create_repo server &&
> +	test_config -C server uploadpack.allowfilter 1 &&
> +	test_config -C server uploadpack.allowanysha1inwant 1 &&
> +	test_commit -C server foo &&
> +
> +	git clone --filter=blob:none "file://$(pwd)/server" client &&
> +	# Make all refs point to nothing by deleting all objects.
> +	rm client/.git/objects/pack/* &&
> +
> +	test_commit -C server bar &&
> +	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
> +		--no-tags --recurse-submodules=no \
> +		origin refs/tags/bar &&
> +	FOO_HASH=$(git -C server rev-parse foo) &&
> +	! grep "want $FOO_HASH" trace
> +'
> +
>  # The following two tests must be in this order. It is important that
>  # the srv.bare repository did not have tags during clone, but has tags
>  # in the fetch.
