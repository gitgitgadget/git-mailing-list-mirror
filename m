Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D98102095B
	for <e@80x24.org>; Tue, 21 Mar 2017 18:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933868AbdCUSwC (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 14:52:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56949 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933281AbdCUSwA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 14:52:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 12D1D6F0C3;
        Tue, 21 Mar 2017 14:51:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=J5+FbJWKEVpr
        ikGlEi2Tsr8sPq4=; b=OfTKknZ9BPBXvmsK6CLvkMqOgqd7egWBjQs9aHx0IbvI
        zqs7xEDVaRwafHJSiDw8ivXgNPkQkYU104CVHwVSy9KdVA0hG4SPsiPi9UdCGp6t
        EH0DU1ngzzzT4ncfsU152WpQ7ozgEOPon0iydNqdc9vTkbey4DLoxYYHsHa9mUs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=g56Tld
        GZZ7PKOWQ1I2ifGRE+g1ZVNmbsv33au6b+bt2WS27kqdAeN8SYvzwOvW3x8OjrOu
        rddfjbqh7om0SsZcaUkuLLi1hJqG9liZMEgy1hDDNjt755v9EaNAsnwxS/J85q69
        h/4ClcvujntHGU5EsQ+KT0iFm2mZECBTQodhs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0A0F36F0C2;
        Tue, 21 Mar 2017 14:51:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 464BC6F0BF;
        Tue, 21 Mar 2017 14:51:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 13/16] ref-filter: add --no-contains option to tag/branch/for-each-ref
References: <20170321125901.10652-1-avarab@gmail.com>
        <20170321125901.10652-14-avarab@gmail.com>
Date:   Tue, 21 Mar 2017 11:51:57 -0700
In-Reply-To: <20170321125901.10652-14-avarab@gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 21 Mar 2017 12:58:58 +0000")
Message-ID: <xmqqbmsupinm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7615F2AA-0E67-11E7-A140-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the tag, branch & for-each-ref commands to have a --no-contains
> option in addition to their longstanding --contains options.
>
> This allows for finding the last-good rollout tag given a known-bad
> <commit>. Given a hypothetically bad commit cf5c7253e0, the git
> version to revert to can be found with this hacky two-liner:
>
>     (git tag -l 'v[0-9]*'; git tag -l --contains cf5c7253e0 'v[0-9]*') =
|
>         sort | uniq -c | grep -E '^ *1 ' | awk '{print $2}' | tail -n 1=
0
>
> With this new --no-contains option the same can be achieved with:
>
>     git tag -l --no-contains cf5c7253e0 'v[0-9]*' | sort | tail -n 10
>
> As the filtering machinery is shared between the tag, branch &
> for-each-ref commands, implement this for those commands too. A
> practical use for this with "branch" is e.g. finding branches which
> were branched off between v2.8.0 and v2.10.0:
>
>     git branch --contains v2.8.0 --no-contains v2.10.0
>
> The "describe" command also has a --contains option, but its semantics
> are unrelated to what tag/branch/for-each-ref use --contains for. A
> --no-contains option for "describe" wouldn't make any sense, other
> than being exactly equivalent to not supplying --contains at all,
> which would be confusing at best.

Nicely explained.  Thanks.

> diff --git a/parse-options.h b/parse-options.h
> index dcd8a0926c..0eac90b510 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -258,7 +258,9 @@ extern int parse_opt_passthru_argv(const struct opt=
ion *, const char *, int);
>  	  PARSE_OPT_LASTARG_DEFAULT | flag, \
>  	  parse_opt_commits, (intptr_t) "HEAD" \
>  	}
> -#define OPT_CONTAINS(v, h) _OPT_CONTAINS_OR_WITH("contains", v, h, 0)
> +#define OPT_CONTAINS(v, h) _OPT_CONTAINS_OR_WITH("contains", v, h, PAR=
SE_OPT_NONEG)
> +#define OPT_NO_CONTAINS(v, h) _OPT_CONTAINS_OR_WITH("no-contains", v, =
h, PARSE_OPT_NONEG)
>  #define OPT_WITH(v, h) _OPT_CONTAINS_OR_WITH("with", v, h, PARSE_OPT_H=
IDDEN)
> +#define OPT_WITHOUT(v, h) _OPT_CONTAINS_OR_WITH("without", v, h, PARSE=
_OPT_HIDDEN)

Doesn't OPT_WITHOUT() need PARSE_OPT_NONEG (in addition to HIDDEN),
just like OPT_NO_CONTAINS() uses one to reject "--no-no-contains"?
Does the code do a sensible thing when --no-without is given?
