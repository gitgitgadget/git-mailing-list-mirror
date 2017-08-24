Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 117A920285
	for <e@80x24.org>; Thu, 24 Aug 2017 21:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753872AbdHXV4K (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 17:56:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57445 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753854AbdHXV4F (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 17:56:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C9FF9A0945;
        Thu, 24 Aug 2017 17:56:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=tZH50vb925a/
        EONPZ6bIHvKzUFI=; b=T46X3gHIEVMZfzhIuRWMQY7VppFRZ2RpwwTV/nzOI5bj
        LHJ3aGV21xE0DxfFLOiEcP8cCvqcWb08AKfEQ8SFF0MmcdTSEBt+Umb84HSzrtVI
        4FXJH7TBpnf3Py24n6gEe5XVbWap67EHTwvgnS/V3zR4xdPtAa9u+Y4mMVC5mbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=wkxoKh
        hdJ1EgbK3goA+TcGGenl75FlUjxODL/dCzxqs84jPvVDhnNjpWBo4Ro/4RIND2gb
        dHNEHNRwOC/J4KrJcFCPxb4b2WRa4CkVerZcJOm8dYEjSDiMm7JdREwCphXB9Hi5
        bF9yz8mU33b/6rIF0DCaKXqmLYPM94um8FUuk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C151BA0944;
        Thu, 24 Aug 2017 17:56:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 26CA6A0943;
        Thu, 24 Aug 2017 17:56:04 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v4 08/16] revision.c: use refs_for_each*() instead of for_each_*_submodule()
References: <20170823123704.16518-1-pclouds@gmail.com>
        <20170823123704.16518-9-pclouds@gmail.com>
Date:   Thu, 24 Aug 2017 14:56:02 -0700
In-Reply-To: <20170823123704.16518-9-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Wed, 23 Aug 2017 19:36:56 +0700")
Message-ID: <xmqqbmn4vde5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 06574470-8917-11E7-ABFB-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
.com>
> ---

So... the idea is that the caller gives a ref-store and tells these
functions to iterate over refs in it, and the existing submodule
related callers can prepare a ref-store for the submodule---that
way, refs.[ch] layer does not have to _care_ that the set of refs it
was asked to look at is for submodule processing.

Nice.  Very nice.

> @@ -2120,8 +2129,14 @@ static int handle_revision_pseudo_opt(const char=
 *submodule,
>  {
>  	const char *arg =3D argv[0];
>  	const char *optarg;
> +	struct ref_store *refs;
>  	int argcount;
> =20
> +	if (submodule) {
> +		refs =3D get_submodule_ref_store(submodule);
> +	} else
> +		refs =3D get_main_ref_store();
> +

