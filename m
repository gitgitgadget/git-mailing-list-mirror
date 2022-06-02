Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFC1C433EF
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 18:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238258AbiFBSvC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 14:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238267AbiFBSvA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 14:51:00 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B961BEA9
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 11:50:59 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 250A512680B;
        Thu,  2 Jun 2022 14:50:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=O5oSlqoPkPjT
        wSzFIucWRUV2QrUBrxs6uZf8wrJuyco=; b=Qke4MqWv20k0aBT/8EEZqTeQqT/X
        UQqto9ry+3pwfuhMtfRDVtdAOVtjwaKYbaSieQ5nHD9zD+pNq7VoX9kB4UjS8z50
        TCjJW6svfgraaGecpGyD56tnil0yoG6K19rs0jI7s1aMRhxCIlOHlC9xXWs7tiel
        AkLEkM1Jzta3ErM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1832512680A;
        Thu,  2 Jun 2022 14:50:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4E882126806;
        Thu,  2 Jun 2022 14:50:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jason Yundt <jason@jasonyundt.email>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2] gitweb: switch to an XHTML5 DOCTYPE
References: <20220601012647.1439480-1-jason@jasonyundt.email>
        <20220602114305.5915-1-jason@jasonyundt.email>
Date:   Thu, 02 Jun 2022 11:50:55 -0700
In-Reply-To: <20220602114305.5915-1-jason@jasonyundt.email> (Jason Yundt's
        message of "Thu, 2 Jun 2022 07:43:05 -0400")
Message-ID: <xmqqv8tinblc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EF90FC8A-E2A4-11EC-BF41-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jason Yundt <jason@jasonyundt.email> writes:

> Subject: Re: [PATCH v2] gitweb: switch to an XHTML5 DOCTYPE
>
> According to the HTML Standard FAQ:
>
> 	=E2=80=9CWhat is the DOCTYPE for modern HTML documents?
> ...
> Compared to the first version of this patch, this version:
> 1. makes it clear that XML parsers may used the linked DTD like brian
>    mentioned.
> 2. mentions HTML5 like Bagas suggested.

So, is it XHTML5, or HTML5, we want to see on the title?

> +proper_doctype() {
> +	gitweb_run "$@" &&
> +	grep -F "<!DOCTYPE html [" gitweb.body &&
> +	grep "<!ENTITY nbsp" gitweb.body &&
> +	grep "<!ENTITY sdot" gitweb.body
> +}

Hmph, this test does not care what other cruft appears in the file,
does not care in what order the three lines that match the patterns
appear, and the second and third patterns are even allowed to match
the same line.  I think that is OK (we do not even mind if the two
ENTITY definitions get squashed on the same line).

> +test_expect_success 'Proper DOCTYPE with entity declarations' '
> +	proper_doctype &&
> +	proper_doctype "p=3D.git" &&
> +	proper_doctype "p=3D.git;a=3Dlog" &&
> +	proper_doctype "p=3D.git;a=3Dtree"
> +'

As far as I can tell, git_header_html() is the only helper that
deals with DOCTYPE, and responses to any request must call
git_header_html() to produce the header (or the handler for a
particular request type is buggy), but I do not think it is part of
this topic's job to ensure that all request handlers call the
git_header_html().  So we _could_ do with just a single test without
trying different request types if we wanted to, as long as there are
existing tests that make sure everybody uses git_header_html().

Was there a particular reason why these four requests were chosen?
Do they have different entry points and show the doctype from
different codepath?

Thanks.
