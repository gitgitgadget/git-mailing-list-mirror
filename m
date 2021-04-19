Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F329C433ED
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 23:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 206FF61279
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 23:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhDSXJh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 19:09:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59442 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhDSXJg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 19:09:36 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 95C5FC9184;
        Mon, 19 Apr 2021 19:09:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=g6Qh3SfmmURmNA4wQZ0Z7kLXlD8=; b=s92PWs
        ZgG2geh7Qx9+iPRw1XF6s01l8MBUFkdaLfnzaMGf9HmipVnmfV1gaK2QVILNhfkS
        9ov2Jt2zrNgCIxCEzjRlHO23KyJVKn8hf18anrvpN3tSaZcqUxx8clJmyqUm77OT
        UBvwfPbgGwCZ/QTXXgfcVTz+tj48zUrF4BpbU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GfM8jmWdeNITPI31Ny2bdmIxGg+xg8Ah
        gwRJetObNQwy4tpYavlo3/hqg4X0oBv9sVxwxDF35pdDJ17vfQAvotUJwY2gGfzC
        mcaB6GNtVnY/hGTu+VM6JSDb4AzKVR90y4vnXOH3JCMNO2zMi59TIAIoZEk5k/v+
        O2vmWPlaHsk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8AAC0C9183;
        Mon, 19 Apr 2021 19:09:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2F18FC9181;
        Mon, 19 Apr 2021 19:09:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 1/1] repack: avoid loosening promisor objects in
 partial clones
References: <20210414191403.4387-1-rafaeloliveira.cs@gmail.com>
        <20210418135749.27152-1-rafaeloliveira.cs@gmail.com>
        <20210418135749.27152-2-rafaeloliveira.cs@gmail.com>
Date:   Mon, 19 Apr 2021 16:09:03 -0700
In-Reply-To: <20210418135749.27152-2-rafaeloliveira.cs@gmail.com> (Rafael
        Silva's message of "Sun, 18 Apr 2021 15:57:49 +0200")
Message-ID: <xmqqa6pt98j4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3C1AB89E-A164-11EB-8799-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rafael Silva <rafaeloliveira.cs@gmail.com> writes:

> When `git repack -A -d` is run in a partial clone, `pack-objects`
> is invoked twice: once to repack all promisor objects, and once to
> repack all non-promisor objects. The latter `pack-objects` invocation
> is with --exclude-promisor-objects and --unpack-unreachable, which
> loosens all unused objects. Unfortunately, this includes promisor
> objects.
>
> Because the -d argument to `git repack` subsequently deletes all loose
> objects also in packs, these just-loosened promisor objects will be
> immediately deleted. However, this extra disk churn is unnecessary in
> the first place.  For example, a newly-clone partial repo that filters

"in a newly-cloned partial repo", I'd think.

> For testing, we need to validate whether any object was loosened.
> However, the "evidence" (loosened objects) is deleted during the
> process which prevents us from inspecting the object directory.
> Instead, let's teach `pack-objects` to count loosened objects and
> emit via trace2 thus allowing inspecting the debug events after the
> process is finished. This new event is used on the added regression
> test.

Nicely designed.

> +	uint32_t loosened_objects_nr = 0;
>  	struct object_id oid;
>  
>  	for (p = get_all_packs(the_repository); p; p = p->next) {
> @@ -3492,11 +3493,16 @@ static void loosen_unused_packed_objects(void)
>  			nth_packed_object_id(&oid, p, i);
>  			if (!packlist_find(&to_pack, &oid) &&
>  			    !has_sha1_pack_kept_or_nonlocal(&oid) &&
> -			    !loosened_object_can_be_discarded(&oid, p->mtime))
> +			    !loosened_object_can_be_discarded(&oid, p->mtime)) {
>  				if (force_object_loose(&oid, p->mtime))
>  					die(_("unable to force loose object"));
> +				loosened_objects_nr++;
> +			}
>  		}
>  	}
> +
> +	trace2_data_intmax("pack-objects", the_repository,
> +			   "loosen_unused_packed_objects/loosened", loosened_objects_nr);
>  }

OK, so this is just the "stats".

> diff --git a/builtin/repack.c b/builtin/repack.c
> index 2847fdfbab..5f9bc74adc 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -20,7 +20,7 @@ static int delta_base_offset = 1;
>  static int pack_kept_objects = -1;
>  static int write_bitmaps = -1;
>  static int use_delta_islands;
> -static char *packdir, *packtmp;
> +static char *packdir, *packtmp_name, *packtmp;
>  
>  static const char *const git_repack_usage[] = {
>  	N_("git repack [<options>]"),
> @@ -530,7 +530,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  	}
>  
>  	packdir = mkpathdup("%s/pack", get_object_directory());
> -	packtmp = mkpathdup("%s/.tmp-%d-pack", packdir, (int)getpid());
> +	packtmp_name = xstrfmt(".tmp-%d-pack", (int)getpid());
> +	packtmp = mkpathdup("%s/%s", packdir, packtmp_name);

Just a mental note, but we should move away from ".tmp-$$" that is a
remnant from the days back when this was a shell script, and use the
tempfile.h API (#leftoverbits).  Such a change must not be part of
this topic, of course.

Thanks.  Will queue and see what others say.

