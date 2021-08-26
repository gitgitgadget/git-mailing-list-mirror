Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3463EC432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 16:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1707D60FD9
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 16:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243132AbhHZQeB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 12:34:01 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60692 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243145AbhHZQeA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 12:34:00 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 999F114A2A6;
        Thu, 26 Aug 2021 12:33:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KAVUAcEGW2HLPuF8b5opWqIDEtKm17eJCDHvVB
        2Hors=; b=jml8i6YO0Md9l5I4kriFnZT4YCdfCdTHwVTO2r7DsUwPed7MB/YWhP
        /NebeOLN6Yt+E5hMrlqyGBl2QaMr3eDaIpnAlF7et7EnVkG2RdXrVXa2HqsK0dBx
        CrKp4tLsl1x89DuJb4meLhskM4Ipnw+0zupU2FwTb9axT28NnmTTQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9328A14A2A4;
        Thu, 26 Aug 2021 12:33:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DC0EF14A2A3;
        Thu, 26 Aug 2021 12:33:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Vosmaer <jacob@gitlab.com>
Cc:     peff@peff.net, me@ttaylorr.com, git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH 2/2] upload-pack: use stdio in send_ref callbacks
References: <CADMWQoMpURczcnZne=0cr2vavoLm_VT5eEMg4FCu3VeSg_UJaQ@mail.gmail.com>
        <20210826100648.10333-1-jacob@gitlab.com>
        <20210826100648.10333-2-jacob@gitlab.com>
Date:   Thu, 26 Aug 2021 09:33:08 -0700
In-Reply-To: <20210826100648.10333-2-jacob@gitlab.com> (Jacob Vosmaer's
        message of "Thu, 26 Aug 2021 12:06:48 +0200")
Message-ID: <xmqqpmu0f9ob.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4CBAA704-068B-11EC-A004-FA11AF6C5138-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Vosmaer <jacob@gitlab.com> writes:

> In both protocol v0 and v2, upload-pack writes one pktline packet per
> advertised ref to stdout. That means one or two write(2) syscalls per
> ref. This is problematic if these writes become network sends with
> high overhead.
>
> This commit changes both send_ref callbacks to use buffered IO using
> stdio. The default buffer size is usually 4KB, but with musl libc it
> is only 1KB. So for consistent results we need to set a buffer size
> ourselves. During startup of upload-pack, we set the stdout buffer
> size to LARGE_PACKET_MAX, i.e. just shy of 64KB.
>
> To give an example of the impact: I set up a single-threaded loop that
> calls ls-remote (with HTTP and protocol v2) on a local GitLab
> instance, on a repository with 11K refs. When I switch from Git
> v2.32.0 to this patch, I see a 50% reduction in CPU time for Git, and
> 75% for Gitaly (GitLab's Git RPC service).
>
> So using buffered IO not only saves syscalls in upload-pack, it also
> saves time in things that consume upload-pack's output.
>
> Signed-off-by: Jacob Vosmaer <jacob@gitlab.com>
> ---

Nicely explained.

> +	/*
> +	 * Increase the stdio buffer size for stdout, for the benefit of ref
> +	 * advertisement writes. We are only allowed to call setvbuf(3) "after
> +	 * opening a stream and before any other operations have been performed
> +	 * on it", so let's call it before we have written anything to stdout.
> +	 */
> +	if (setvbuf(stdout, xmalloc(LARGE_PACKET_MAX), _IOFBF,
> +			LARGE_PACKET_MAX))
> +		die_errno("failed to grow stdout buffer");

Nice to see a comment on the tricky part.  I do not think we mind if
we rounded up the allocation size to the next power of two here, but
there probably won't be any measurable benefit for doing so.

> diff --git a/ls-refs.c b/ls-refs.c
> index 88f6c3f60d..83f2948fc3 100644
> --- a/ls-refs.c
> +++ b/ls-refs.c
> @@ -105,7 +105,7 @@ static int send_ref(const char *refname, const struct object_id *oid,
>  	}
>  
>  	strbuf_addch(&refline, '\n');
> -	packet_write(1, refline.buf, refline.len);
> +	packet_fwrite(stdout, refline.buf, refline.len);
>  
>  	strbuf_release(&refline);
>  	return 0;
> @@ -171,6 +171,9 @@ int ls_refs(struct repository *r, struct strvec *keys,
>  		strvec_push(&data.prefixes, "");
>  	for_each_fullref_in_prefixes(get_git_namespace(), data.prefixes.v,
>  				     send_ref, &data, 0);
> +	/* Call fflush because send_ref uses stdio. */
> +	if (fflush(stdout))
> +		die_errno(_("write failure on standard output"));

There is maybe_flush_or_die() helper that does a bit too much (I do
not think this code path needs to worry about GIT_FLUSH) but does
call check_pipe(errno) like packet_write_fmt() does upon seeing a
write failure.

>  	packet_flush(1);

I briefly wondered if all the operations on refline can be turned
into direct operations on stdout, but the answer obviously is no.
We still need to have a strbuf to assemble a single packet and
measure its final length before we can send it out to stdout.

> diff --git a/upload-pack.c b/upload-pack.c
> index 297b76fcb4..b592ac6cfb 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -58,6 +58,7 @@ enum allow_uor {
>   */
>  struct upload_pack_data {
>  	struct string_list symref;				/* v0 only */
> +	struct strbuf send_ref_buf;				/* v0 only */
>  	struct object_array want_obj;
>  	struct object_array have_obj;
>  	struct oid_array haves;					/* v2 only */
> @@ -126,6 +127,7 @@ static void upload_pack_data_init(struct upload_pack_data *data)
>  	struct string_list uri_protocols = STRING_LIST_INIT_DUP;
>  	struct object_array extra_edge_obj = OBJECT_ARRAY_INIT;
>  	struct string_list allowed_filters = STRING_LIST_INIT_DUP;
> +	struct strbuf send_ref_buf = STRBUF_INIT;

IIUC, the most notable difference between this round and the
previous one is that now we are no longer buffering more than one
packet worth of data because we let the stdio to accumulate them.
I was a bit surprised that we still want to have a strbuf inside
this structure (which is there only because it wants to persist
during the whole conversation with the other side).

Ahh, sorry, scratch that.  I do remember the discussion/patch that
it was hurting to make calls to strbuf-init/strbuf-release once per
ref, and it is an easy way to have the structure here to reuse it.

OK.  This step looks quite sensible, other than the same "do we want
check_pipe() before dying upon fflush() failure?" we see in the last
hunk below.  I didn't mention this in the review of 1/2, but the new
fwrite_or_die() helper function may also have the same issue.

Thanks.

> @@ -1348,6 +1354,9 @@ void upload_pack(struct upload_pack_options *options)
>  		reset_timeout(data.timeout);
>  		head_ref_namespaced(send_ref, &data);
>  		for_each_namespaced_ref(send_ref, &data);
> +		/* Call fflush because send_ref uses stdio. */
> +		if (fflush(stdout))
> +			die_errno(_("write failure on standard output"));
>  		advertise_shallow_grafts(1);
>  		packet_flush(1);
>  	} else {
