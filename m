Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E814C433E0
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 11:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C801F223E8
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 11:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbgLWLzQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 06:55:16 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51799 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbgLWLzP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 06:55:15 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 75D46107FD8;
        Wed, 23 Dec 2020 06:54:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=oGBBSsnOEI7c0TmoP+iH5PW4d
        Lo=; b=K5xeqyajsXKAtTjBcY4VMQ1zZ+R8bfW3f9VtsWLZq/Coj8rk7Xzwa5dH2
        vDXohJ6dYCyiUYCZJXtVerzL5wg/H0tDpfj1nsQlYNkL1nudSLKkexGVuuZZcQG9
        xtkQH+80LZQOBUEZLXrmBt/xMAvwT2rJ0gMtHYK/EujUGhsS4o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=KbuZYYwXxtSUg9FUovV
        V2PLIQ/qclSIHk3+jS9J5dvD6ZwDeiKY0Rdm2zUXttn3qd2W21QSjLjj0+ZlzV4u
        RnLPSq2mniBd9NEsjT46jQ1G1Gcaaoji0w+n/OLisDa8rWK1FxBzvHGC1idODTKE
        aSpYaYuXBNHN4Lre16Jz/azI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6D8B3107FD6;
        Wed, 23 Dec 2020 06:54:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 62E1C107FD5;
        Wed, 23 Dec 2020 06:54:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 20/20] mktag: add a --no-strict option
References: <20201209200140.29425-1-avarab@gmail.com>
        <20201223013606.7972-21-avarab@gmail.com>
Date:   Wed, 23 Dec 2020 03:54:23 -0800
Message-ID: <xmqqmty4agb4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9A88E1FE-4515-11EB-9017-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Now that mktag has been migrated to use the fsck machinery to check
> its input, it makes sense to teach it to run in the equivalent of "git
> fsck"'s default mode, instead of hardcoding "git fsck --strict". Let's
> do that and support the "--no-strict" option.
>
> Since this is a new option we don't need to cater to parse-option.c's
> default of automatically supporting --strict. So let's use
> PARSE_OPT_NONEG, using a new trivial helper macro.

Hmph, I would have thought that the internal file-scope static done
like

    static int option_strict =3D 1;

with OPT_BOOL() would be more natural, than a double negation.

What problem does this new OPT_NO_BOOL() thing solve?


> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  Documentation/git-mktag.txt |  7 +++++++
>  builtin/mktag.c             |  9 +++++++++
>  parse-options.h             |  1 +
>  t/t3800-mktag.sh            | 35 ++++++++++++++++++++++++-----------
>  4 files changed, 41 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/git-mktag.txt b/Documentation/git-mktag.txt
> index d04657b219..05e49b6787 100644
> --- a/Documentation/git-mktag.txt
> +++ b/Documentation/git-mktag.txt
> @@ -11,6 +11,13 @@ SYNOPSIS
>  [verse]
>  'git mktag'
> =20
> +OPTIONS
> +-------
> +
> +--no-strict::
> +	By default mktag turns on the equivalent of
> +	linkgit:git-fsck[1] `--strict` mode. This disables it.
> +
>  DESCRIPTION
>  -----------
> =20
> diff --git a/builtin/mktag.c b/builtin/mktag.c
> index 9b04b61c2b..a6a4612247 100644
> --- a/builtin/mktag.c
> +++ b/builtin/mktag.c
> @@ -10,6 +10,7 @@ static char const * const builtin_mktag_usage[] =3D {
>  	N_("git mktag"),
>  	NULL
>  };
> +static int option_no_strict;
> =20
>  static struct fsck_options fsck_options =3D FSCK_OPTIONS_STRICT;
> =20
> @@ -25,6 +26,12 @@ static int mktag_fsck_error_func(struct fsck_options=
 *o,
>  {
>  	switch (msg_type) {
>  	case FSCK_WARN:
> +		if (option_no_strict) {
> +			fprintf_ln(stderr, _("warning: tag input does not pass fsck: %s"), =
message);
> +			return 0;
> +
> +		}
> +		/* fallthrough */
>  	case FSCK_ERROR:
>  		/*
>  		 * We treat both warnings and errors as errors, things
> @@ -67,6 +74,8 @@ static int verify_object_in_tag(struct object_id *tag=
ged_oid, int *tagged_type)
>  int cmd_mktag(int argc, const char **argv, const char *prefix)
>  {
>  	static struct option builtin_mktag_options[] =3D {
> +		OPT_NO_BOOL(0, "no-strict", &option_no_strict,
> +			    N_("don't do strict fsck checks")),
>  		OPT_END(),
>  	};
>  	struct strbuf buf =3D STRBUF_INIT;
> diff --git a/parse-options.h b/parse-options.h
> index 7030d8f3da..90d6a817d7 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -166,6 +166,7 @@ struct option {
>  #define OPT_COUNTUP(s, l, v, h)     OPT_COUNTUP_F(s, l, v, h, 0)
>  #define OPT_SET_INT(s, l, v, h, i)  OPT_SET_INT_F(s, l, v, h, i, 0)
>  #define OPT_BOOL(s, l, v, h)        OPT_BOOL_F(s, l, v, h, 0)
> +#define OPT_NO_BOOL(s, l, v, h)     OPT_BOOL_F(s, l, v, h, PARSE_OPT_N=
ONEG)
>  #define OPT_HIDDEN_BOOL(s, l, v, h) { OPTION_SET_INT, (s), (l), (v), N=
ULL, \
>  				      (h), PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, 1}
>  #define OPT_CMDMODE(s, l, v, h, i)  { OPTION_SET_INT, (s), (l), (v), N=
ULL, \
> diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
> index 2e8b718379..b436ae1e44 100755
> --- a/t/t3800-mktag.sh
> +++ b/t/t3800-mktag.sh
> @@ -12,12 +12,16 @@ test_description=3D'git mktag: tag object verify te=
st'
>  # given in the expect.pat file.
> =20
>  check_verify_failure () {
> -	expect=3D"$2"
> -	test_expect_success "$1" '
> +	test_expect_success "$1" "
>  		test_must_fail env GIT_TEST_GETTEXT_POISON=3Dfalse \
>  			git mktag <tag.sig 2>message &&
> -		grep "$expect" message
> -	'
> +		grep '$2' message &&
> +		if test '$3' !=3D '--no-strict'
> +		then
> +			test_must_fail git mktag --no-strict <tag.sig 2>message.no-strict &=
&
> +			grep '$2' message.no-strict
> +		fi
> +	"
>  }
> =20
>  test_expect_mktag_success() {
> @@ -49,7 +53,8 @@ test_expect_success 'basic usage' '
>  	EOF
>  	git mktag <tag.sig &&
>  	git mktag --end-of-options <tag.sig &&
> -	test_expect_code 129 git mktag --unknown-option
> +	test_expect_code 129 git mktag --unknown-option &&
> +	test_expect_code 129 git mktag --strict
>  '
> =20
>  ############################################################
> @@ -60,7 +65,7 @@ too short for a tag
>  EOF
> =20
>  check_verify_failure 'Tag object length check' \
> -	'^error:.* missingObject:'
> +	'^error:.* missingObject:' 'strict'
> =20
>  ############################################################
>  #  2. object line label check
> @@ -206,7 +211,7 @@ tagger . <> 0 +0000
>  EOF
> =20
>  check_verify_failure 'verify tag-name check' \
> -	'^error:.* badTagName:'
> +	'^error:.* badTagName:' '--no-strict'
> =20
>  ############################################################
>  # 11. tagger line label check #1
> @@ -220,7 +225,7 @@ This is filler
>  EOF
> =20
>  check_verify_failure '"tagger" line label check #1' \
> -	'^error:.* missingTaggerEntry:'
> +	'^error:.* missingTaggerEntry:' '--no-strict'
> =20
>  ############################################################
>  # 12. tagger line label check #2
> @@ -235,7 +240,7 @@ This is filler
>  EOF
> =20
>  check_verify_failure '"tagger" line label check #2' \
> -	'^error:.* missingTaggerEntry:'
> +	'^error:.* missingTaggerEntry:' '--no-strict'
> =20
>  ############################################################
>  # 13. allow missing tag author name like fsck
> @@ -264,7 +269,7 @@ tagger T A Gger <
>  EOF
> =20
>  check_verify_failure 'disallow malformed tagger' \
> -	'^error:.* badEmail:'
> +	'^error:.* badEmail:' '--no-strict'
> =20
>  ############################################################
>  # 15. allow empty tag email
> @@ -388,13 +393,21 @@ this line should not be here
>  EOF
> =20
>  check_verify_failure 'detect invalid header entry' \
> -	'^error:.* extraHeaderEntry:'
> +	'^error:.* extraHeaderEntry:' '--no-strict'
> =20
>  test_expect_success 'invalid header entry config & fsck' '
>  	test_must_fail git mktag <tag.sig &&
> +	git mktag --no-strict <tag.sig &&
> +
>  	test_must_fail git -c fsck.extraHeaderEntry=3Derror mktag <tag.sig &&
> +	test_must_fail git -c fsck.extraHeaderEntry=3Derror mktag --no-strict=
 <tag.sig &&
> +
>  	test_must_fail git -c fsck.extraHeaderEntry=3Dwarn mktag <tag.sig &&
> +	git -c fsck.extraHeaderEntry=3Dwarn mktag --no-strict <tag.sig &&
> +
>  	git -c fsck.extraHeaderEntry=3Dignore mktag <tag.sig &&
> +	git -c fsck.extraHeaderEntry=3Dignore mktag --no-strict <tag.sig &&
> +
>  	git fsck &&
>  	env GIT_TEST_GETTEXT_POISON=3Dfalse \
>  		git -c fsck.extraHeaderEntry=3Dwarn fsck 2>err &&
