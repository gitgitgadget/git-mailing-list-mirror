Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740A7C433DB
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 13:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 347F7224B0
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 13:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbgLWNfN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 08:35:13 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51915 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728251AbgLWNfN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 08:35:13 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 014ED96632;
        Wed, 23 Dec 2020 08:34:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=SyENY1+fj6uIYxM4hw0TeJnVq
        Rs=; b=ePHqddwPIh0hWe+NEKZ30lbthoykqE9/CUiZpC3O2reHhS3poDDxmMdUy
        4vKmYfSp/6bczYGR/FZFmN6anBLz+tmRNn69EDK5bn55psjsXFRAeqBI7l0PkbDv
        pivhIY8s7t6gD+z81EdXr8OsPw/nh1tcUU1ODDGi94vrbbE3kw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=U0V0lEElznt3NzCElMX
        4IAjRvbRevXuJ/lu1FXdi+X0VeIvqrec6KPcC5mtmuyltEHAvXkTUK09UJv/ZDmH
        L/F39HKKM2iZ58E9dY1tOr2MJNbRN7BkZRlWmtF8nJfCMmOx8HEiSSGJRWGRiNnw
        y1g+lLYnxg7LolRuHA97N/t8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EBFB696631;
        Wed, 23 Dec 2020 08:34:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 71ADF96630;
        Wed, 23 Dec 2020 08:34:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 14/20] mktag: use fsck instead of custom verify_tag()
References: <20201209200140.29425-1-avarab@gmail.com>
        <20201223013606.7972-15-avarab@gmail.com>
Date:   Wed, 23 Dec 2020 05:34:23 -0800
Message-ID: <xmqqh7ocabog.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 924159E6-4523-11EB-B457-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> +static int verify_object_in_tag(struct object_id *tagged_oid, int *tag=
ged_type)
>  {
> +	int ret;
> +	enum object_type type;
> +	unsigned long size;
> +	void *buffer;
> +	const struct object_id *repl;
> +
> +	buffer =3D read_object_file(tagged_oid, &type, &size);
> +	if (!buffer)
> +		die("could not read tagged object '%s'",
> +		    oid_to_hex(tagged_oid));
> +	if (type !=3D *tagged_type)
> +		die("object '%s' tagged as '%s', but is a '%s' type",
> +		    oid_to_hex(tagged_oid),
> +		    type_name(*tagged_type), type_name(type));
> +
> +	repl =3D lookup_replace_object(the_repository, tagged_oid);
> +	ret =3D check_object_signature(the_repository, repl,
> +				     buffer, size, type_name(*tagged_type));
> +	free(buffer);

This is not new, but I wonder if the object whose name is repl can
be of different type than the object whose name is tagged_oid, and
what happens when such a replacement is defined.

> +	return ret;
>  }
> ...
> +/*
> + * fsck a tag, and pass info about it back to the caller. This is
> + * exposed fsck_object() internals for git-mktag(1).
> + */
> +int fsck_tag_standalone(const struct object_id *oid, const char *buffe=
r,
> +			unsigned long size, struct fsck_options *options,
> +			struct object_id *tagged_oid,
> +			int *tag_type);
> +

OK.

> diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
> index c6826762d9..d20adf0544 100755
> --- a/t/t3800-mktag.sh
> +++ b/t/t3800-mktag.sh
> @@ -47,7 +47,7 @@ too short for a tag
>  EOF

OK.  This seems to show rather nicely what checks got loosened
(and nothing got tightened it seems).

Thanks.  Looking good so far.

> =20
>  check_verify_failure 'Tag object length check' \
> -	'^error: .*size wrong.*$'
> +	'^error:.* missingObject:'
> =20
>  ############################################################
>  #  2. object line label check
> @@ -60,7 +60,7 @@ tagger . <> 0 +0000
> =20
>  EOF
> =20
> -check_verify_failure '"object" line label check' '^error: char0: .*"ob=
ject "$'
> +check_verify_failure '"object" line label check' '^error:.* missingObj=
ect:'
> =20
>  ############################################################
>  #  3. object line hash check
> @@ -73,7 +73,7 @@ tagger . <> 0 +0000
> =20
>  EOF
> =20
> -check_verify_failure '"object" line SHA1 check' '^error: char7: .*SHA1=
 hash$'
> +check_verify_failure '"object" line check' '^error:.* badObjectSha1:'
> =20
>  ############################################################
>  #  4. type line label check
> @@ -86,7 +86,7 @@ tagger . <> 0 +0000
> =20
>  EOF
> =20
> -check_verify_failure '"type" line label check' '^error: char.*: .*"\\n=
type "$'
> +check_verify_failure '"type" line label check' '^error:.* missingTypeE=
ntry:'
> =20
>  ############################################################
>  #  5. type line eol check
> @@ -94,7 +94,7 @@ check_verify_failure '"type" line label check' '^erro=
r: char.*: .*"\\ntype "$'
>  echo "object $head" >tag.sig
>  printf "type tagsssssssssssssssssssssssssssssss" >>tag.sig
> =20
> -check_verify_failure '"type" line eol check' '^error: char.*: .*"\\n"$=
'
> +check_verify_failure '"type" line eol check' '^error:.* unterminatedHe=
ader:'
> =20
>  ############################################################
>  #  6. tag line label check #1
> @@ -108,7 +108,7 @@ tagger . <> 0 +0000
>  EOF
> =20
>  check_verify_failure '"tag" line label check #1' \
> -	'^error: char.*: no "tag " found$'
> +	'^error:.* missingTagEntry:'
> =20
>  ############################################################
>  #  7. tag line label check #2
> @@ -120,7 +120,7 @@ tag
>  EOF
> =20
>  check_verify_failure '"tag" line label check #2' \
> -	'^error: char.*: no "tag " found$'
> +	'^error:.* badType:'
> =20
>  ############################################################
>  #  8. type line type-name length check
> @@ -132,7 +132,7 @@ tag mytag
>  EOF
> =20
>  check_verify_failure '"type" line type-name length check' \
> -	'^error: char.*: type too long$'
> +	'^error:.* badType:'
> =20
>  ############################################################
>  #  9. verify object (hash/type) check
> @@ -146,7 +146,7 @@ tagger . <> 0 +0000
>  EOF
> =20
>  check_verify_failure 'verify object (hash/type) check -- correct type,=
 nonexisting object' \
> -	'^error: char7: could not verify object.*$'
> +	'^fatal: could not read tagged object'
> =20
>  cat >tag.sig <<EOF
>  object $head
> @@ -157,7 +157,7 @@ tagger . <> 0 +0000
>  EOF
> =20
>  check_verify_failure 'verify object (hash/type) check -- made-up type,=
 nonexisting object' \
> -	'^fatal: invalid object type'
> +	'^error:.* badType:'
> =20
>  cat >tag.sig <<EOF
>  object $(test_oid deadbeef)
> @@ -168,7 +168,7 @@ tagger . <> 0 +0000
>  EOF
> =20
>  check_verify_failure 'verify object (hash/type) check -- incorrect typ=
e, valid object' \
> -	'^error: char7: could not verify object.*$'
> +	'^error:.* badType:'
> =20
>  cat >tag.sig <<EOF
>  object $head
> @@ -179,7 +179,7 @@ tagger . <> 0 +0000
>  EOF
> =20
>  check_verify_failure 'verify object (hash/type) check -- incorrect typ=
e, valid object' \
> -	'^error: char7: could not verify object'
> +	'^fatal: object.*tagged as.*tree.*but is.*commit'
> =20
>  ############################################################
>  # 10. verify tag-name check
> @@ -193,7 +193,7 @@ tagger . <> 0 +0000
>  EOF
> =20
>  check_verify_failure 'verify tag-name check' \
> -	'^error: char.*: could not verify tag name$'
> +	'^error:.* badTagName:'
> =20
>  ############################################################
>  # 11. tagger line label check #1
> @@ -207,7 +207,7 @@ This is filler
>  EOF
> =20
>  check_verify_failure '"tagger" line label check #1' \
> -	'^error: char.*: could not find "tagger "$'
> +	'^error:.* missingTaggerEntry:'
> =20
>  ############################################################
>  # 12. tagger line label check #2
> @@ -222,10 +222,10 @@ This is filler
>  EOF
> =20
>  check_verify_failure '"tagger" line label check #2' \
> -	'^error: char.*: could not find "tagger "$'
> +	'^error:.* missingTaggerEntry:'
> =20
>  ############################################################
> -# 13. disallow missing tag author name
> +# 13. allow missing tag author name like fsck
> =20
>  cat >tag.sig <<EOF
>  object $head
> @@ -236,8 +236,7 @@ tagger  <> 0 +0000
>  This is filler
>  EOF
> =20
> -check_verify_failure 'disallow missing tag author name' \
> -	'^error: char.*: missing tagger name$'
> +test_expect_mktag_success 'allow missing tag author name'
> =20
>  ############################################################
>  # 14. disallow missing tag author name
> @@ -252,7 +251,7 @@ tagger T A Gger <
>  EOF
> =20
>  check_verify_failure 'disallow malformed tagger' \
> -	'^error: char.*: malformed tagger field$'
> +	'^error:.* badEmail:'
> =20
>  ############################################################
>  # 15. allow empty tag email
> @@ -268,7 +267,7 @@ EOF
>  test_expect_mktag_success 'allow empty tag email'
> =20
>  ############################################################
> -# 16. disallow spaces in tag email
> +# 16. allow spaces in tag email like fsck
> =20
>  cat >tag.sig <<EOF
>  object $head
> @@ -278,8 +277,7 @@ tagger T A Gger <tag ger@example.com> 0 +0000
> =20
>  EOF
> =20
> -check_verify_failure 'disallow spaces in tag email' \
> -	'^error: char.*: malformed tagger field$'
> +test_expect_mktag_success 'allow spaces in tag email like fsck'
> =20
>  ############################################################
>  # 17. disallow missing tag timestamp
> @@ -293,7 +291,7 @@ tagger T A Gger <tagger@example.com>__
>  EOF
> =20
>  check_verify_failure 'disallow missing tag timestamp' \
> -	'^error: char.*: missing tag timestamp$'
> +	'^error:.* badDate:'
> =20
>  ############################################################
>  # 18. detect invalid tag timestamp1
> @@ -307,7 +305,7 @@ tagger T A Gger <tagger@example.com> Tue Mar 25 15:=
47:44 2008
>  EOF
> =20
>  check_verify_failure 'detect invalid tag timestamp1' \
> -	'^error: char.*: missing tag timestamp$'
> +	'^error:.* badDate:'
> =20
>  ############################################################
>  # 19. detect invalid tag timestamp2
> @@ -321,7 +319,7 @@ tagger T A Gger <tagger@example.com> 2008-03-31T12:=
20:15-0500
>  EOF
> =20
>  check_verify_failure 'detect invalid tag timestamp2' \
> -	'^error: char.*: malformed tag timestamp$'
> +	'^error:.* badDate:'
> =20
>  ############################################################
>  # 20. detect invalid tag timezone1
> @@ -335,7 +333,7 @@ tagger T A Gger <tagger@example.com> 1206478233 GMT
>  EOF
> =20
>  check_verify_failure 'detect invalid tag timezone1' \
> -	'^error: char.*: malformed tag timezone$'
> +	'^error:.* badTimezone:'
> =20
>  ############################################################
>  # 21. detect invalid tag timezone2
> @@ -349,10 +347,10 @@ tagger T A Gger <tagger@example.com> 1206478233 +=
  30
>  EOF
> =20
>  check_verify_failure 'detect invalid tag timezone2' \
> -	'^error: char.*: malformed tag timezone$'
> +	'^error:.* badTimezone:'
> =20
>  ############################################################
> -# 22. detect invalid tag timezone3
> +# 22. allow invalid tag timezone3 (the maximum is -1200/+1400)
> =20
>  cat >tag.sig <<EOF
>  object $head
> @@ -362,8 +360,7 @@ tagger T A Gger <tagger@example.com> 1206478233 -14=
30
> =20
>  EOF
> =20
> -check_verify_failure 'detect invalid tag timezone3' \
> -	'^error: char.*: malformed tag timezone$'
> +test_expect_mktag_success 'allow invalid tag timezone'
> =20
>  ############################################################
>  # 23. detect invalid header entry
> @@ -378,7 +375,7 @@ this line should not be here
>  EOF
> =20
>  check_verify_failure 'detect invalid header entry' \
> -	'^error: char.*: trailing garbage in tag header$'
> +	'^error:.* extraHeaderEntry:'
> =20
>  cat >tag.sig <<EOF
>  object $head
> @@ -412,7 +409,7 @@ tagger T A Gger <tagger@example.com> 1206478233 -05=
00$space
>  EOF
> =20
>  check_verify_failure 'extra whitespace at end of headers' \
> -	'^error: char.*: malformed tag timezone$'
> +	'^error:.* badTimezone:'
> =20
>  cat >tag.sig <<EOF
>  object $head
> @@ -422,7 +419,7 @@ tagger T A Gger <tagger@example.com> 1206478233 -05=
00
>  EOF
> =20
>  check_verify_failure 'disallow no header / body newline separator' \
> -	'^error: char.*: trailing garbage in tag header$'
> +	'^error:.* extraHeaderEntry:'
> =20
>  ############################################################
>  # 24. create valid tag
