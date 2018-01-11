Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F7B91FAE2
	for <e@80x24.org>; Thu, 11 Jan 2018 19:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754515AbeAKT1l (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jan 2018 14:27:41 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52150 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752253AbeAKT1l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jan 2018 14:27:41 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A6BF7C90BF;
        Thu, 11 Jan 2018 14:27:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ru9MPBvGg7Rb
        DBoIboUybCXfEqk=; b=Ay72RpVmPuGA3YVTAFwfjneaCUcH734cJ3uHGiv1vCpr
        HmLNnfsqMVQR3EsyUJIBXF+d4WJIyNs3mTiOTFfKri5q3yu99Y/gxcq4jsLObVD+
        4uEJwRQKOfyeJRKa28RDVNEr5F9MaDp6HclC/SFqpoDy1+ojUMy9nW79a5bZhm0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=hckmMQ
        rbmWnvxdwDbD4XFqMqwyJ0P8X644Bg2bno2Pd+IkiCr4BMxY/D8IWrlCuTAp/KXI
        FqjpxIuYQuXc/u9qW438Zowd5mp0yEffl7gWRlyba1mUrniv+pEsH2g8k3zVHpcs
        09Eg3OF80hJrYpew+H0oCKql9hCEIy8ffGaSM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9C7F5C90BE;
        Thu, 11 Jan 2018 14:27:40 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 177C8C90BD;
        Thu, 11 Jan 2018 14:27:40 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v2] run-command.c: print env vars when GIT_TRACE is set
References: <20180110104835.22905-1-pclouds@gmail.com>
        <20180111094712.2551-1-pclouds@gmail.com>
Date:   Thu, 11 Jan 2018 11:27:38 -0800
In-Reply-To: <20180111094712.2551-1-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Thu, 11 Jan 2018 16:47:12 +0700")
Message-ID: <xmqq4lnsyz4l.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7CF090B2-F705-11E7-BBAF-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Occasionally submodule code could execute new commands with GIT_DIR set
> to some submodule. GIT_TRACE prints just the command line which makes i=
t
> hard to tell that it's not really executed on this repository.
>
> Print modified env variables (compared to parent environment) in this
> case. Actually only modified or new variables are printed. Variable
> deletion is suppressed because ...

When I read the above, I imagined that you are reducing noise from
the output by showing only modified or new variables, but it appears
that the implementation of concatenate_env() just blindly copies the
variables without checking if they are setting the same value.

I wonder how common it would be to attempt exporting a variable with
the same value, and to attempt unsetting a variable that is not
exported, which might help you reduce the clutter by hiding stuff
that truly do not matter, while keeping what matters (possibly
including the "unset" part).

> +static void concatenate_env(struct strbuf *dst, const char *const *env=
)
> +{
> +	int i;
> +
> +	/* Copy into destination buffer. */
> +	strbuf_grow(dst, 255);
> +	for (i =3D 0; env[i]; ++i) {
> +		/*
> +		 * the main interesting is setting new vars

I'll do s/interesting/& part/ while queuing.

> +		 * e.g. GIT_DIR, ignore the unsetting to reduce noise.
> +		 */
> +		if (!strchr(env[i], '=3D'))
> +			continue;
> +		strbuf_addch(dst, ' ');
> +		sq_quote_buf(dst, env[i]);

I think you'd tweak the quoting around here in a later iteration,
based on the distinction between the two:

	$ 'GIT_DIR=3D.git' git foo
	$ GIT_DIR=3D'.git' git foo

that was pointed out in a near-by message.

Thanks.
