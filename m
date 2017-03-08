Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D96D20135
	for <e@80x24.org>; Wed,  8 Mar 2017 21:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754329AbdCHVRh (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 16:17:37 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61328 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753773AbdCHVRf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 16:17:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 466A76F2BD;
        Wed,  8 Mar 2017 16:16:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nbpLMeDyjngvSFJqD0SsoH6JT5I=; b=DOJOmm
        Ns9RHAZIpPWQMy4WOoyLOC8v7oVdSlzl/oSLOur9qfcWkzpslQ90DrkYEF3kkVqN
        I/dgXao8Pmo5FR4MazyZQLLB/N3xG2zq8tpMqaedf54v/xOQek8Fjv4igNrNrrHw
        VOD5/cY8ZUTsX5cuWHwWq089rZNCajOhGk9Nc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LY2BPx1aU8q0VtxRs6XeMYAgunpKIymV
        pWPXK2yVU6xA1nIzRb21ZM6rmJc1cmiBA4xF2fGT+JXWFU7fgqI3KwwBVZOb9LCv
        GBkHDEcintJR42ZTW5DnehIJXl7vqi7eyZv32KeQyYysdso5PF4dUWgeq3C7umOL
        gK5lixNuunA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F4FD6F2BC;
        Wed,  8 Mar 2017 16:16:22 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A2C326F2B7;
        Wed,  8 Mar 2017 16:16:21 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] Fix callsites of real_pathdup() that wanted it to die on error
References: <cover.1488987786.git.johannes.schindelin@gmx.de>
        <0c0abc667d9b8dff299aa61aeb29a7e9e7316b66.1488987786.git.johannes.schindelin@gmx.de>
        <81f1e30b-e0e1-d587-4a4b-4848beffd38c@web.de>
        <20170308183840.GA130604@google.com>
Date:   Wed, 08 Mar 2017 13:16:20 -0800
In-Reply-To: <20170308183840.GA130604@google.com> (Brandon Williams's message
        of "Wed, 8 Mar 2017 10:38:40 -0800")
Message-ID: <xmqq4lz331wb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7A7D935C-0444-11E7-BD0C-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

>> > diff --git a/abspath.c b/abspath.c
>> > index 2f0c26e0e2c..b02e068aa34 100644
>> > --- a/abspath.c
>> > +++ b/abspath.c
>> > @@ -214,12 +214,12 @@ const char *real_path_if_valid(const char *path)
>> >  	return strbuf_realpath(&realpath, path, 0);
>> >  }
>> >  
>> > -char *real_pathdup(const char *path)
>> > +char *real_pathdup(const char *path, int die_on_error)
>> 
>> Adding a gentle variant (with the current implementation) and making
>> real_pathdup() die on error would be nicer, as it doesn't require
>> callers to pass magic flag values.  Most cases use the dying variant,
>> so such a patch would have to touch less places:
>
> I agree with Junio and Rene that a gentle version would make the api
> slightly nicer (and more consistant with some of the other api's we have
> in git).
>
> This is exactly what I should have done back when I originally made the
> change.  Sorry for missing this!

While I agree that the shape of the code Rene gave us here is what
we would have liked to have in the original, it is a bit too late
for that.

As I already mentioned, as a regression fix patch, I find what Dscho
posted more sensible, because it makes it obvious that all existing
callsites were looked at while constructing the patch and more
importantly, it forces somebody to look at all the new callers of
the function that were added by the topics in flight, by changing
the func-signature and forcing compilation failure.

It may be somewhat unfortunate that that somebody needs to be me,
but that is what maintainers are for, so ... ;-)

Once the dust settles, let's do the clean-up along the lines of
Rene's patch.

Thanks.

