Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7D1C433F5
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 23:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242628AbhLMXJW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 18:09:22 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52571 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234834AbhLMXJV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 18:09:21 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 34551111CF7;
        Mon, 13 Dec 2021 18:09:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Emwautj7Qr/j
        NtrIzeecto1/ofcyftZ1BL/XXfAF86o=; b=NG1o4/xkcUhsf0OrMw1OMap28gd9
        se/GjpDcxIYbuaYzOKp243zef3ShsBeOFo5XVckIqOGqU2CMBOM+GWKKcX4Nsevd
        xFSjpPYFfH4TE0UenUqCQBNQRxA544NhFcFiEoG9rL8F/O4YZbUgHP0HKyP+IP2s
        bPbSu/YFAfHQZ30=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2A0BB111CF6;
        Mon, 13 Dec 2021 18:09:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 869CD111CF4;
        Mon, 13 Dec 2021 18:09:20 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH v4 14/23] Makefile: re-add and use the "shellquote" macros
References: <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
        <cover-v4-00.23-00000000000-20211117T101807Z-avarab@gmail.com>
        <patch-v4-14.23-13cbb851d32-20211117T101807Z-avarab@gmail.com>
Date:   Mon, 13 Dec 2021 15:09:19 -0800
In-Reply-To: <patch-v4-14.23-13cbb851d32-20211117T101807Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 17 Nov
 2021 11:20:13
        +0100")
Message-ID: <xmqq4k7c9k68.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B42AEB5E-5C69-11EC-B20A-E10CCAD8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Re-add and use, and expand on "shellquote" macros added in
> 4769948afe7 (Deal with $(bindir) and friends with whitespaces.,
> 2005-10-10).
>
> We avoided using them due to the "$(call)" feature of GNU make being
> relatively new at the time, but it isn't anymore. We hard depend on
> GNU make versions that have it.
>
> The use of "$(call)" was removed in 39c015c556f (Fixes for ancient
> versions of GNU make, 2006-02-18) and 7ffe7098dca (Fix installation of
> templates on ancient systems., 2006-07-29) due to those
> incompatibilities with older GNU make versions, and we've used the
> more verbose *_SQ pattern ever since.
>
> The "$(call)" feature was introduced in GNU make version 3.78,
> released on the 22nd of September, 1999. That release also introduced
> "$(error)" and "$(warning)", which we've been making use of since
> f2fabbf76e4 (Teach Makefile to check header dependencies, 2010-01-26).
>
> This extends upon the macros added in 4769948afe7: We now have macros
> for quoting a ' inside '', and a ' with no surrounding '' as before.
>
> Additionally provide and use a "shelldquote" macro along with
> "shellquote" for the common case of wanting to quote a C string we
> pass to the compiler with a -D flag.
>
> This doesn't get rid of all of our shell quoting. We've still got some
> in the main Makefile, let's leave most of it to avoid in-flight
> conflicts. I've fully converted "templates/Makefile" and "t/Makefile"
> though.

All of the above may very well explain why we decided not to use
$(call shellquote) in the past, and it may also explain why it is
safe to start using it again today, but it does not explain why we
want to do so in the first place.

Having to write

	$(call shellquote,$(VAR))

in longhand is much more cumbersome to read, write and merge than
defining a prepackaged VAR_SQ just once and refer it as

	'$(VAR_SQ)'

everywhere.

In fact, having to resolve merge conflicts in t/Makefile today,
which wouldn't have been necessary if we didn't have this change,
felt like a makework to me, and my time would have been better spent
elsewhere [*].

Is there a justification other than "this uses a feature supported
by newer GNUMake" we can give to future readers of the log message?
Why do we want to make this change?

It may be that this patch was particularly unlucky to collide with
something else to irritate me, and the above comment may apply to
other patches we saw recently on the list (and they are lucky that
they did not collide with anything not yet in 'master'). =20

In any case, I am wondering if we see too much churn without much
real benefit X-<.

Here is a sample of the damage.  Look how long the lines that use
_SQ twice have become.

 clean-chainlint:
-	$(RM) -r '$(CHAINLINTTMP_SQ)'
+	$(RM) -r $(call shellquote,$(CHAINLINTTMP))
=20
 check-chainlint:
-	@mkdir -p '$(CHAINLINTTMP_SQ)' && \
-	sed -e '/^# LINT: /d' $(patsubst %,chainlint/%.test,$(CHAINLINTTESTS)) =
>'$(CHAINLINTTMP_SQ)'/tests && \
-	sed -e '/^[ 	]*$$/d' $(patsubst %,chainlint/%.expect,$(CHAINLINTTESTS))=
 >'$(CHAINLINTTMP_SQ)'/expect && \
-	$(CHAINLINT) '$(CHAINLINTTMP_SQ)'/tests | grep -v '^[	]*$$' >'$(CHAINLI=
NTTMP_SQ)'/actual && \
-	diff -u '$(CHAINLINTTMP_SQ)'/expect '$(CHAINLINTTMP_SQ)'/actual
+	@mkdir -p $(call shellquote,$(CHAINLINTTMP)) && \
+	sed -e '/^# LINT: /d' $(patsubst %,chainlint/%.test,$(CHAINLINTTESTS)) =
>$(call shellquote,$(CHAINLINTTMP))/tests && \
+	sed -e '/^[ 	]*$$/d' $(patsubst %,chainlint/%.expect,$(CHAINLINTTESTS))=
 >$(call shellquote,$(CHAINLINTTMP))/expect && \
+	$(CHAINLINT) $(call shellquote,$(CHAINLINTTMP))/tests | grep -v '^[	]*$=
$' >$(call shellquote,$(CHAINLINTTMP))/actual && \
+	diff -u $(call shellquote,$(CHAINLINTTMP))/expect $(call shellquote,$(C=
HAINLINTTMP))/actual
