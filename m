Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6275FC433EA
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 20:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AC9F2075D
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 20:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cYu0Pwql"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgGJUiZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 16:38:25 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54157 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728040AbgGJUiY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 16:38:24 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B176DD3A1C;
        Fri, 10 Jul 2020 16:38:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UvINzQfFHnZ7hR1wdqA25yEDeeg=; b=cYu0Pw
        qlxWnPciF+meb6ZkGNaU4tDbqbw/I7z0MI80EATHsuQwEztn/RZenBijb28Pw4uR
        xWJ5Onndj/3dwbfOGrtdbP9bHALU/x3q0+LJlePlLhqFWSfUMTmgbupUaJvgvudF
        gXZGzb/Niu4+cMicXCddQc8tOdBlWi9HEZXU8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=apu1pjj0lCDWtvLoZyl7vMbqbIMEuab/
        +zeBcqfaf3HYX9wNv3cDPsHCw6ljh5AxvWhF6defaAoUr3SC5c6uIg6+dc8/LeIY
        gI64DXhoOWDKYyFQ131ub+4fLkrlNe3Qm5mQZ5V0+BXYgRgo+Yk1wauHQMlfxb3c
        l6c26j2H9xA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A9EE5D3A1B;
        Fri, 10 Jul 2020 16:38:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 00F17D3A17;
        Fri, 10 Jul 2020 16:38:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 3/3] ref-filter: add support for %(contents:size)
References: <20200707174049.21714-1-chriscool@tuxfamily.org>
        <20200710164739.6616-1-chriscool@tuxfamily.org>
        <20200710164739.6616-4-chriscool@tuxfamily.org>
Date:   Fri, 10 Jul 2020 13:38:18 -0700
In-Reply-To: <20200710164739.6616-4-chriscool@tuxfamily.org> (Christian
        Couder's message of "Fri, 10 Jul 2020 18:47:39 +0200")
Message-ID: <xmqq365zt8at.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4A7126AE-C2ED-11EA-A242-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> It's useful and efficient to be able to get the size of the
> contents directly without having to pipe through `wc -c`.
>
> Also the result of the following:
>
> `git for-each-ref --format='%(contents)' refs/heads/my-branch | wc -c`
>
> is off by one as `git for-each-ref` appends a newline character
> after the contents, which can be seen by comparing its output
> with the output from `git cat-file`.
>
> As with %(contents), %(contents:size) is silently ignored, if a
> ref points to something other than a commit or a tag:
>
> ```
> $ git update-ref refs/mytrees/first HEAD^{tree}
> $ git for-each-ref --format='%(contents)' refs/mytrees/first
>
> $ git for-each-ref --format='%(contents:size)' refs/mytrees/first
>
> ```
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  Documentation/git-for-each-ref.txt |  3 +++
>  ref-filter.c                       |  7 ++++++-
>  t/t6300-for-each-ref.sh            | 19 +++++++++++++++++++
>  3 files changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index b739412c30..2ea71c5f6c 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -235,6 +235,9 @@ and `date` to extract the named component.
>  The message in a commit or a tag object is `contents`, from which
>  `contents:<part>` can be used to extract various parts out of:
>  
> +contents:size::
> +	The size in bytes of the commit or tag message.
> +
>  contents:subject::
>  	The first paragraph of the message, which typically is a
>  	single line, is taken as the "subject" of the commit or the

OK.

> diff --git a/ref-filter.c b/ref-filter.c
> index 8447cb09be..73d8bfa86d 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -127,7 +127,8 @@ static struct used_atom {
>  			unsigned int nobracket : 1, push : 1, push_remote : 1;
>  		} remote_ref;
>  		struct {
> -			enum { C_BARE, C_BODY, C_BODY_DEP, C_LINES, C_SIG, C_SUB, C_TRAILERS } option;
> +			enum { C_BARE, C_BODY, C_BODY_DEP, C_LENGTH,
> +			       C_LINES, C_SIG, C_SUB, C_TRAILERS } option;
>  			struct process_trailer_options trailer_opts;
>  			unsigned int nlines;
>  		} contents;
> @@ -338,6 +339,8 @@ static int contents_atom_parser(const struct ref_format *format, struct used_ato
>  		atom->u.contents.option = C_BARE;
>  	else if (!strcmp(arg, "body"))
>  		atom->u.contents.option = C_BODY;
> +	else if (!strcmp(arg, "size"))
> +		atom->u.contents.option = C_LENGTH;
>  	else if (!strcmp(arg, "signature"))
>  		atom->u.contents.option = C_SIG;
>  	else if (!strcmp(arg, "subject"))
> @@ -1253,6 +1256,8 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
>  			v->s = copy_subject(subpos, sublen);
>  		else if (atom->u.contents.option == C_BODY_DEP)
>  			v->s = xmemdupz(bodypos, bodylen);
> +		else if (atom->u.contents.option == C_LENGTH)
> +			v->s = xstrfmt("%"PRIuMAX, (uintmax_t)strlen(subpos));
>  		else if (atom->u.contents.option == C_BODY)
>  			v->s = xmemdupz(bodypos, nonsiglen);
>  		else if (atom->u.contents.option == C_SIG)

OK.

> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index e9f468d360..467871ac10 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -52,6 +52,25 @@ test_atom() {

You need to stare at the precontext to see if the added lines are
correct.  We have these before the precontext of the patch:

	case "$1" in
		head) ref=refs/heads/master ;;
		 tag) ref=refs/tags/testtag ;;
		 sym) ref=refs/heads/sym ;;
		   *) ref=$1 ;;
	esac
	printf '%s\n' "$3" >expected
	test_expect_${4:-success} $PREREQ "basic atom: $1 $2" "
		git for-each-ref --format='%($2)' $ref >actual &&

Here it uses "$1" for mere reporting on the test title, while using
"$ref" as the reliable way to uniquely identify it as a full ref.

>  		sanitize_pgp <actual >actual.clean &&
>  		test_cmp expected actual.clean
>  	"
> +	# Automatically test "contents:size" atom after testing "contents"
> +	if test "$2" = "contents"
> +	then
> +		case "$1" in
> +		refs/tags/signed-*)

Shouldn't this be $ref to be compared with full refnames like we see
below?

I know the callers won't pass 'head', 'tag' and 'sym' with
'contents' to this helper so the distinction may not currently
matter in practice, but still this use of "$1" does not sound quite
right, no?  

I actually was expecting you to switch on

	case $(git cat-file -t "$ref") in
	tag)
		...;;
	tree | blob)
		...;;
	commit)
		...;;
	easc

instead of the namespace, as %(contents:size) silently becomes empty
due to the underlying object type, not where the object that does
not support the "method" sits in the refs/ namespace.

> +			# We cannot use $3 as it expects sanitize_pgp to run
> +			expect=$(git cat-file tag $ref | tail -n +6 | wc -c) ;;
> +		refs/mytrees/* | refs/myblobs/*)
> +			expect='' ;;

Thanks for catching my thinko; I think I wrote 0 here in my
illustration.

> +		*)
> +			expect=$(printf '%s' "$3" | wc -c) ;;
> +		esac
> +		# Leave $expect unquoted to lose possible leading whitespaces
> +		echo $expect >expected

OK.

> +		test_expect_${4:-success} $PREREQ "basic atom: $1 $2:size" "
> +			git for-each-ref --format='%($2:size)' $ref >actual &&
> +			test_cmp expected actual
> +		"

This is harder to read than necessary; let's not say "$2" when we
know it is 'contents' and nothing else.  Also avoid double-quoted
test body when you can.  The body is evaled and $ref we assigned is
visible inside the test just fine, so make it a habit to quote the
body with single quote pair, i.e.

	test_expect_${4:-sucess} $PREREQ "basic atom: $1 contents:size" '
		git for-each-ref --format="%(contents:size)" "$ref" >actual &&
		test_cmp expect actual
	'

Thanks.

> +	fi
>  }
>  
>  hexlen=$(test_oid hexsz)
