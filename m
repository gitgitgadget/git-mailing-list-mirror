Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3440AC433DF
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 17:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 142FE20767
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 17:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rVi0GQBY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgHXRyQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 13:54:16 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50335 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbgHXRyM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 13:54:12 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 621A3D9119;
        Mon, 24 Aug 2020 13:54:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JpbKTCVSFMvpD2U/pHPAeSD7zVk=; b=rVi0GQ
        BYN3bRtsIM5g5fR/ZYSHOSVg6Zbu1ODvwnPFfjvrtNerOoOucNnuPao01IU+swsG
        UxkF8O0y74DHZ6x3L5uVXK5YrN0nJsIpaBtZM2fNyjeCNy5GP1iOMPpjrAm9yBJH
        oUX+7iVXXTMzvtIOHJrCBD846x5UiYSoVnNB0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=m9hNt0WaDNF+BMWbK78FQzf+WFz/L9m5
        OrNQfKPODZ3iF625YwsDuTOeSai27YS3rm4kA8pPlKOIWwiEBXMMImh41T5OkvLh
        hqvn/5VFT16SWqr++OfpSkJWcJivIo8AVIviOem/ShpfxDYGl6kfDE96qW8PGd2S
        yXxekWX9J4Y=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5A168D9118;
        Mon, 24 Aug 2020 13:54:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A3DB3D9117;
        Mon, 24 Aug 2020 13:54:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     christian.couder@gmail.com, git@vger.kernel.org,
        Johannes.Schindelin@gmx.de, kaartic.sivaraam@gmail.com,
        liu.denton@gmail.com, Prathamesh Chavan <pc44800@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH v3 4/4] submodule: port submodule subcommand 'summary' from shell to C
References: <20200806164102.6707-1-shouryashukla.oo@gmail.com>
        <20200812194404.17028-1-shouryashukla.oo@gmail.com>
        <20200812194404.17028-5-shouryashukla.oo@gmail.com>
Date:   Mon, 24 Aug 2020 10:54:05 -0700
In-Reply-To: <20200812194404.17028-5-shouryashukla.oo@gmail.com> (Shourya
        Shukla's message of "Thu, 13 Aug 2020 01:14:04 +0530")
Message-ID: <xmqqo8n053r6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CDFD0110-E632-11EA-8BA1-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(A few miniscule things I noticed that are irrelevant to the code
structure discussion).

> +static char* verify_submodule_committish(const char *sm_path,

Style: in C, asterisk sticks to the identifier, not type, i.e.

    static char *verify_submodule_committish(const char *sm_path, ...);

> +static void print_submodule_summary(struct summary_cb *info, char* errmsg,

Likewise; "char *errmsg".

> +static void generate_submodule_summary(struct summary_cb *info,
> +				       struct module_cb *p)
> +{
> +	char *displaypath, *src_abbrev, *dst_abbrev;
> +	int missing_src = 0, missing_dst = 0;
> +	char *errmsg = NULL;
> +	int total_commits = -1;
> +
> +	if (!info->cached && oideq(&p->oid_dst, &null_oid)) {
> +		if (S_ISGITLINK(p->mod_dst)) {
> +...
> +		} else {
> +			/* for a submodule removal (mode:0000000), don't warn */
> +			if (p->mod_dst)
> +				warning(_("unexpected mode %d\n"), p->mod_dst);
> +		}
> +	}

Nobody can read mode bits written in decimal.  Use "%o" instead,
perhaps?

Thanks.
