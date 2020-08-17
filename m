Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FCEC433DF
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 17:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F8C420716
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 17:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HDCQXfIT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbgHQRfC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:35:02 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56066 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731286AbgHQQdt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 12:33:49 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5561DD9D13;
        Mon, 17 Aug 2020 12:33:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=z1i3SxVomYpPSIrhb9JChfs2XTg=; b=HDCQXf
        ITFl9W54pinqJBUc8VYZpjJsP6XPUVwtDetw74iUDlLeGxF18STadJSNYNxYhreW
        9G4tAYLpBXeTi9foPdx+KwXTJjYgITIC4HXETlWu8Il99hg6b0VprSvnY7I6OyuY
        ZkrufiVoShySV+hAy6k0yV0v6/uVpDZ4dvsvI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=t6A7kUQzNFAEPRv7p4mbNDCXIt/5Iy9A
        BqLpQbysl2hX2M3MCAnB3VRx/S3si2C6ZXi/O4+O/XGnLy8yv9wzGeV2+P4EqmaR
        z1Co84+oBjUoa5i/kDqhv/tF6fStM1lckC917aAF1gkNPNS9cvHEtumfIPpbt/xN
        sNBWo7V3P+s=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4E497D9D11;
        Mon, 17 Aug 2020 12:33:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 986AED9D0D;
        Mon, 17 Aug 2020 12:33:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [RFC 2/3] refspec: make sure stack refspec_item variables are zeroed
References: <20200815002509.2467645-1-jacob.e.keller@intel.com>
        <20200815002509.2467645-2-jacob.e.keller@intel.com>
Date:   Mon, 17 Aug 2020 09:33:40 -0700
In-Reply-To: <20200815002509.2467645-2-jacob.e.keller@intel.com> (Jacob
        Keller's message of "Fri, 14 Aug 2020 17:25:08 -0700")
Message-ID: <xmqqd03p44gr.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 69BD4AF6-E0A7-11EA-A184-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> From: Jacob Keller <jacob.keller@gmail.com>
>
> A couple of functions that used struct refspec_item did not zero out the
> structure memory. This can result in unexpected behavior, especially if
> additional parameters are ever added to refspec_item in the future. Use
> memset to ensure that unset structure members are zero.
>
> It may make sense to convert most of these uses of struct refspec_item
> to use either struct initializers or refspec_item_init_or_die. However,
> other similar code uses memset. Converting all of these uses has been
> left as a future exercise.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
>  builtin/remote.c | 1 +
>  transport.c      | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/builtin/remote.c b/builtin/remote.c
> index c8240e9fcd58..542f56e3878b 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -478,6 +478,7 @@ static int get_head_names(const struct ref *remote_refs, struct ref_states *stat
>  	struct ref *fetch_map = NULL, **fetch_map_tail = &fetch_map;
>  	struct refspec_item refspec;
>  
> +	memset(&refspec, 0, sizeof(refspec));
>  	refspec.force = 0;
>  	refspec.pattern = 1;
>  	refspec.src = refspec.dst = "refs/heads/*";

The original leaves .matching and .exact_sha1 bitfields
uninitialized.  As .pattern is set to true, .exact_sha1
that is not initialized does not make get_fetch_map()
misbehave, and .matching is not used there, so the code
currently happens to be OK, but futureproofing is always
good.

> diff --git a/transport.c b/transport.c
> index 2d4fd851dc0f..419be0b6ea4b 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -443,6 +443,7 @@ void transport_update_tracking_ref(struct remote *remote, struct ref *ref, int v
>  	if (ref->status != REF_STATUS_OK && ref->status != REF_STATUS_UPTODATE)
>  		return;
>  
> +	memset(&rs, 0, sizeof(rs));
>  	rs.src = ref->name;
>  	rs.dst = NULL;

The original here passes the rs to remote_find_tracking() with only
its .src and .dst filled.  The function is to find, given a concrete
ref, where the refspec tells it to go on the other end of the
connection, so the code currently happend to be OK without all other
fields, but again, futureproofing is good.
