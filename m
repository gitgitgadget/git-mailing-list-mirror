Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7001C4332F
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 00:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC224613C8
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 00:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243340AbhI2ALy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 20:11:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55913 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240284AbhI2ALx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 20:11:53 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3AD6EF438B;
        Tue, 28 Sep 2021 20:10:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=YM5iLqG1lOAk
        nb05aeswIFbU8dvRtut/T5IFvAzSRc8=; b=RLTU7eyxLL4sqjBW8H0KLVKGIrqd
        qHs8NuPn7Iuw51ElZHo2AUhdcz8u4RKNdrWxBHj5qug75N2ZHWIJoKQwPeJ7q0l8
        HCRhLxvpfCkmuH1QGd89pxcDv3iR/rd0QJqfciwBe4LCiCAf05x13Xm1WKeIM8UO
        Oh0pA6vlVZFFyjU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 30AFDF4388;
        Tue, 28 Sep 2021 20:10:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 71BE2F4386;
        Tue, 28 Sep 2021 20:10:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 02/10] parse-options.[ch]: consistently use "enum
 parse_opt_flags"
References: <cover-00.10-00000000000-20210928T130905Z-avarab@gmail.com>
        <patch-02.10-289bb437eb5-20210928T130905Z-avarab@gmail.com>
Date:   Tue, 28 Sep 2021 17:10:11 -0700
In-Reply-To: <patch-02.10-289bb437eb5-20210928T130905Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 28 Sep
 2021 15:14:23
        +0200")
Message-ID: <xmqqilykgs2k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9D7CFB7C-20B9-11EC-A87D-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Use the "enum parse_opt_flags" instead of an "int flags" as arguments
> to the various functions in parse-options.c. This will help to catch
> cases where we're not handling cases in switch statements, and

I am not sure about most part this change, and the claim the second
sentence makes is certainly dubious.  Let's look at the first hunk:

> diff --git a/parse-options.c b/parse-options.c
> index 55c5821b08d..9dce8b7f8a8 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -481,7 +481,8 @@ static void parse_options_check(const struct option=
 *opts)

 static void parse_options_start_1(struct parse_opt_ctx_t *ctx,
 				  int argc, const char **argv, const char *prefix,
-				  const struct option *options, int flags)
+				  const struct option *options,
+				  enum parse_opt_flags flags)
 {
 	ctx->argc =3D argc;
 	ctx->argv =3D argv;
 	if (!(flags & PARSE_OPT_ONE_SHOT)) {
 		ctx->argc--;
 		ctx->argv++;
 	}
 	ctx->total =3D ctx->argc;
 	ctx->out   =3D argv;
 	ctx->prefix =3D prefix;
 	ctx->cpidx =3D ((flags & PARSE_OPT_KEEP_ARGV0) !=3D 0);
 	ctx->flags =3D flags;
 	if ((flags & PARSE_OPT_KEEP_UNKNOWN) &&
 	    (flags & PARSE_OPT_STOP_AT_NON_OPTION) &&
 	    !(flags & PARSE_OPT_ONE_SHOT))
 		BUG("STOP_AT_NON_OPTION and KEEP_UNKNOWN don't go together");
 	if ((flags & PARSE_OPT_ONE_SHOT) &&
 	    (flags & PARSE_OPT_KEEP_ARGV0))
 		BUG("Can't keep argv0 if you don't have it");
 	parse_options_check(options);
 }
=20
The "flags" parameter does not take a value that is an "enum" in the
usual "enumeration" sense at all.  Even though parse_opt_flags
defines 7 distinct "enum" values, each enumerated value is a small
unsigned integer with only single bit set, the caller can throw a
value that is not among these 7 by OR'ing them together.  We would
not sensibly do

	switch (flags) {
	case PARSE_OPT_KEEP_UNKNOWN:
		...

In general, I am not all that enthusiastic for such a(n) (ab)use of
"enum" for bit patterns, much less than "enumerate all possible
values to make sure compilers would help us catch missing logic".

The "parse_opt_result" enum is the "right" kind of enumeration that
I can stand behind fully.  The hunk related to that enum in this
patch is quite reasonable and takes advantage of the fact that the
enum is meant to be the enumeration of all possible values.

Compared to it, parse_opt_flags and parse_opt_option_flags, not
really.

If we wanted to really clean up the latter two, perhaps we should
define the bit (which *can* be made to a proper "here are the all
possible values" enumeration), like this:

    enum parse_opt_flags_bit {
	PARSE_OPT_KEEP_DASHDASH_BIT =3D 0,
        PARSE_OPT_STOP_AT_NON_OPTION_BIT,
	PARSE_OPT_KEEP_ARGV0_BIT,
	...
	PARSE_OPT_SHELL_EVAL_BIT,
    };

and then update the users to use (1U << PARSE_OPT_$FLAG$_BIT), or
drop the pretense that it is a good idea to use enum for bit pattern
and use the CPP macro, i.e.

    #define PARSE_OPT_KEEP_DASHDASH (1U<<0)
    #define PARSE_OPT_STOP_AT_NON_OPTION (1U<<1)
    ...
    #define PARSE_OPT_SHELL_EVAL (1U<<6)

to make it clear that we do not mean these are "enumeration of
possible values".

Thanks.
