Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6805C433FE
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 02:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A68D323A33
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 02:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgLHCQw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 21:16:52 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54225 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgLHCQw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 21:16:52 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AB6D18E18A;
        Mon,  7 Dec 2020 21:16:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ihuyly+gIBK6r8b8H4GhKcDrH5U=; b=dFRURI
        XGE9o25j+cUyS4HdcQ37RIjgHjbAGTZtwLKQI8WQ2i6aJiY7bQ7Af1vkW6aRA7a/
        dWZ16Fhwslo0E2hSn1tgmciOK63U1hcTcC1apvNs6pj5qMJR4X6A7vLHfv65kcti
        Z7HiNLW4vBnu32vmgyOUjrR4/j5KilJJsCJ+M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fen2waS6GYeCg3KENWPOgUG6SUvMT2sX
        mxOhg+Skvzfoy26Tx+l8wjXVxco4MYbHsmfzfUvahQacPK5DvKTKhOOcBpASbkGs
        cObd311E2JZQ2l4UzZuxjvsmcFhDerPJ6//iVDGOPkKk1/PdA60C/ByYhZGzwFiS
        o+pqUI98jt8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A3CF58E189;
        Mon,  7 Dec 2020 21:16:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 212898E188;
        Mon,  7 Dec 2020 21:16:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: Cloning empty repository uses locally configured default branch
 name
References: <20201208013121.677494-1-jonathantanmy@google.com>
Date:   Mon, 07 Dec 2020 18:16:07 -0800
In-Reply-To: <20201208013121.677494-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Mon, 7 Dec 2020 17:31:20 -0800")
Message-ID: <xmqq7dpt82l4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5527905E-38FB-11EB-B2D9-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Has anyone looked into solutions for this? Both protocol v0 and v2 do
> not send symref information about unborn branches (v0 because, as
> protocol-capabilities.txt says, "servers SHOULD include this capability
> for the HEAD symref if it is one of the refs being sent"; v2 because
> a symref is included only if it refers to one of the refs being sent).
> In protocol v2, this could be done by adding a capability to ls-remote
> (maybe, "unborn"), and in protocol v0, this could be done either by
> updating the existing "symref" capability to be written even when the
> target branch is unborn (which is potentially backwards incompatible) or
> introducing a new capability which is like "symref".

Thanks for looking into this (I think this came up again today
during my reviews of some topic).

It would be a backward incompatible change to add to v0, but at this
point shouldn't we be leaving v0 as-is and move everybody to v2?

If it is a simple and safe enough change, though, saying "why not"
is very tempting, though.

> A small issue is that upload-pack protocol v0 doesn't even write the
> blank ref line ("000...000 capabilities^{}") if HEAD points to an unborn
> branch, but that can be fixed as in the patch below.

I think the codepaths we have today in process_capabilities() and
process_dummy_ref() (both in connect.c) would do the right thing
when it sees a blank ref line even when nothing gets transported,
but I smell that the rewrite of this state machine is fairly recent
(say in the past few years) and I do not offhand know if clients
before the rewrite of the state machine (say in v2.18.0) would be OK
with the change.  It should be easy to check, though.

> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  upload-pack.c | 40 +++++++++++++++++++++++++++-------------
>  1 file changed, 27 insertions(+), 13 deletions(-)
>
> diff --git a/upload-pack.c b/upload-pack.c
> index 1006bebd50..d2359a8560 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -1179,18 +1179,15 @@ static void format_symref_info(struct strbuf *buf, struct string_list *symref)
>  		strbuf_addf(buf, " symref=%s:%s", item->string, (char *)item->util);
>  }
>  
> -static int send_ref(const char *refname, const struct object_id *oid,
> -		    int flag, void *cb_data)
> +static const char *capabilities = "multi_ack thin-pack side-band"
> +	" side-band-64k ofs-delta shallow deepen-since deepen-not"
> +	" deepen-relative no-progress include-tag multi_ack_detailed";
> +
> +static void write_ref_lines(const char *refname_nons,
> +			    const struct object_id *oid,
> +			    const struct object_id *peeled,
> +			    struct upload_pack_data *data)
>  {
> -	static const char *capabilities = "multi_ack thin-pack side-band"
> -		" side-band-64k ofs-delta shallow deepen-since deepen-not"
> -		" deepen-relative no-progress include-tag multi_ack_detailed";
> -	const char *refname_nons = strip_namespace(refname);
> -	struct object_id peeled;
> -	struct upload_pack_data *data = cb_data;
> -
> -	if (mark_our_ref(refname_nons, refname, oid))
> -		return 0;
>  
>  	if (capabilities) {
>  		struct strbuf symref_info = STRBUF_INIT;
> @@ -1213,8 +1210,23 @@ static int send_ref(const char *refname, const struct object_id *oid,
>  		packet_write_fmt(1, "%s %s\n", oid_to_hex(oid), refname_nons);
>  	}
>  	capabilities = NULL;
> -	if (!peel_ref(refname, &peeled))
> -		packet_write_fmt(1, "%s %s^{}\n", oid_to_hex(&peeled), refname_nons);
> +	if (peeled)
> +		packet_write_fmt(1, "%s %s^{}\n", oid_to_hex(peeled), refname_nons);
> +}
> +
> +static int send_ref(const char *refname, const struct object_id *oid,
> +		    int flag, void *cb_data)
> +{
> +	const char *refname_nons = strip_namespace(refname);
> +	struct object_id peeled;
> +	struct upload_pack_data *data = cb_data;
> +
> +	if (mark_our_ref(refname_nons, refname, oid))
> +		return 0;
> +	write_ref_lines(refname_nons,
> +			oid,
> +			peel_ref(refname, &peeled) ? NULL : &peeled,
> +			data);
>  	return 0;
>  }
>  
> @@ -1332,6 +1344,8 @@ void upload_pack(struct upload_pack_options *options)
>  		reset_timeout(data.timeout);
>  		head_ref_namespaced(send_ref, &data);
>  		for_each_namespaced_ref(send_ref, &data);
> +		if (capabilities)
> +			write_ref_lines("capabilities^{}", &null_oid, NULL, &data);
>  		advertise_shallow_grafts(1);
>  		packet_flush(1);
>  	} else {
