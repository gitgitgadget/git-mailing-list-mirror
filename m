Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,URI_HEX shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08415205C9
	for <e@80x24.org>; Mon,  9 Jan 2017 02:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759520AbdAICjV (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jan 2017 21:39:21 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56684 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1757384AbdAICjU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2017 21:39:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 908CF6032B;
        Sun,  8 Jan 2017 21:39:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=CpAgE5o6rhQ0
        VG465z3nfdfaUrg=; b=pV+NzvMegEVWK52np1Q++vLHyjFs277YIpj4Uw0sHoQW
        niTyhsuxB0CGvgyzt0AuH3CI3zuZy3vGTTkfA8qXen7/COKAZmzZK3t3AgjOlniM
        huTDcPn5mxln0cEIs613zAMJ8hL/saOCmExLXGNH97oa5jiSVrsBa2hnj69YFmE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=W5gvcc
        7AybT+ph4dMi2hUGOVwjkdur60QBsb8n1tmG+QMgOgmP3rYCqhkAtjd2JrMgFYSl
        0L7JJntdZNwQ1cRBsD3QUccBlvWuWYJFz6rie45Svkyip0RUI+KEBJmC5dTNJLv8
        nLg4Cww9I/9fM0TVOCmbVYncLwIAbbYnhZgrc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 87F8A6032A;
        Sun,  8 Jan 2017 21:39:19 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DBA9E60329;
        Sun,  8 Jan 2017 21:39:18 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     bmwill@google.com, peff@peff.net, git@vger.kernel.org
Subject: Re: [PATCHv6 2/2] pathspec: give better message for submodule related pathspec error
References: <20170105192904.1107-1-sbeller@google.com>
        <20170105192904.1107-3-sbeller@google.com>
Date:   Sun, 08 Jan 2017 18:39:17 -0800
In-Reply-To: <20170105192904.1107-3-sbeller@google.com> (Stefan Beller's
        message of "Thu, 5 Jan 2017 11:29:04 -0800")
Message-ID: <xmqqbmvhyn1m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D1D082B2-D614-11E6-A98B-FE3F13518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Every once in a while someone complains to the mailing list to have
> run into this weird assertion[1]. The usual response from the mailing
> list is link to old discussions[2], and acknowledging the problem
> stating it is known.
>
> This patch accomplishes two things:
>
>   1. Switch assert() to die("BUG") to give a more readable message.
>
>   2. Take one of the cases where we hit a BUG and turn it into a normal
>      "there was something wrong with the input" message.
>
>    =C2=A0 This assertion triggered for cases where there wasn't a progr=
amming
>  =C2=A0   bug, but just bogus input. In particular, if the user asks fo=
r a
>    =C2=A0 pathspec that is inside a submodule, we shouldn't assert() or
>  =C2=A0   die("BUG"); we should tell the user their request is bogus.
>
>      The only reason we did not check for it, is the expensive nature
>      of such a check, so callers avoid setting the flag
>      PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE. However when we die due
>      to bogus input, the expense of CPU cycles spent outweighs the user
>      wondering what went wrong, so run that check unconditionally befor=
e
>      dying with a more generic error message.
>
> Note: There is a case (e.g. "git -C submodule add .") in which we call
> strip_submodule_slash_expensive, as git-add requests it via the flag
> PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE, but the assert used to
> trigger nevertheless, because the flag PATHSPEC_LITERAL was not set,
> such that we executed
>
> 	if (item->nowildcard_len < prefixlen)
> 		item->nowildcard_len =3D prefixlen;
>
> and prefixlen was not adapted (e.g. it was computed from "submodule/")
> So in the die_inside_submodule_path function we also need handle paths,
> that were stripped before, i.e. are the exact submodule path. This
> is why the conditions in die_inside_submodule_path are slightly
> different than in strip_submodule_slash_expensive.
>
> [1] https://www.google.com/search?q=3Ditem-%3Enowildcard_len
> [2] http://git.661346.n2.nabble.com/assert-failed-in-submodule-edge-cas=
e-td7628687.html
>     https://www.spinics.net/lists/git/msg249473.html
>
> Helped-by: Jeff King <peff@peff.net>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

For future reference, do not bury a useful fix behind unproven new
things.  The main purpose of this two-patch series is this change,
and it does not have to wait for the change to allow test_commit to
notice "-C" you have in another series.

Just write it in longhand, and when both topics graduate, send in
another patch to update "(cd <dir> && test_commit <others>)" to use
the new "test_commit -C <dir> <others>".

Thanks.

>  pathspec.c                       | 35 ++++++++++++++++++++++++++++++++=
+--
>  t/t6134-pathspec-in-submodule.sh | 33 ++++++++++++++++++++++++++++++++=
+
>  2 files changed, 66 insertions(+), 2 deletions(-)
>  create mode 100755 t/t6134-pathspec-in-submodule.sh
>
> diff --git a/pathspec.c b/pathspec.c
> index d4efcf6662..42cd83c235 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -296,6 +296,27 @@ static void strip_submodule_slash_expensive(struct=
 pathspec_item *item)
>  	}
>  }
> =20
> +static void die_inside_submodule_path(struct pathspec_item *item)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < active_nr; i++) {
> +		struct cache_entry *ce =3D active_cache[i];
> +		int ce_len =3D ce_namelen(ce);
> +
> +		if (!S_ISGITLINK(ce->ce_mode))
> +			continue;
> +
> +		if (item->len < ce_len ||
> +		    !(item->match[ce_len] =3D=3D '/' || item->match[ce_len] =3D=3D '=
\0') ||
> +		    memcmp(ce->name, item->match, ce_len))
> +			continue;
> +
> +		die(_("Pathspec '%s' is in submodule '%.*s'"),
> +		    item->original, ce_len, ce->name);
> +	}
> +}
> +
>  /*
>   * Perform the initialization of a pathspec_item based on a pathspec e=
lement.
>   */
> @@ -391,8 +412,18 @@ static void init_pathspec_item(struct pathspec_ite=
m *item, unsigned flags,
>  	}
> =20
>  	/* sanity checks, pathspec matchers assume these are sane */
> -	assert(item->nowildcard_len <=3D item->len &&
> -	       item->prefix         <=3D item->len);
> +	if (item->nowildcard_len > item->len ||
> +	    item->prefix         > item->len) {
> +		/*
> +		 * This case can be triggered by the user pointing us to a
> +		 * pathspec inside a submodule, which is an input error.
> +		 * Detect that here and complain, but fallback in the
> +		 * non-submodule case to a BUG, as we have no idea what
> +		 * would trigger that.
> +		 */
> +		die_inside_submodule_path(item);
> +		die ("BUG: item->nowildcard_len > item->len || item->prefix > item->=
len)");
> +	}
>  }
> =20
>  static int pathspec_item_cmp(const void *a_, const void *b_)
> diff --git a/t/t6134-pathspec-in-submodule.sh b/t/t6134-pathspec-in-sub=
module.sh
> new file mode 100755
> index 0000000000..2900d8d06e
> --- /dev/null
> +++ b/t/t6134-pathspec-in-submodule.sh
> @@ -0,0 +1,33 @@
> +#!/bin/sh
> +
> +test_description=3D'test case exclude pathspec'
> +
> +TEST_CREATE_SUBMODULE=3Dyes
> +. ./test-lib.sh
> +
> +test_expect_success 'setup a submodule' '
> +	git submodule add ./pretzel.bare sub &&
> +	git commit -a -m "add submodule" &&
> +	git submodule deinit --all
> +'
> +
> +cat <<EOF >expect
> +fatal: Pathspec 'sub/a' is in submodule 'sub'
> +EOF
> +
> +test_expect_success 'error message for path inside submodule' '
> +	echo a >sub/a &&
> +	test_must_fail git add sub/a 2>actual &&
> +	test_cmp expect actual
> +'
> +
> +cat <<EOF >expect
> +fatal: Pathspec '.' is in submodule 'sub'
> +EOF
> +
> +test_expect_success 'error message for path inside submodule from with=
in submodule' '
> +	test_must_fail git -C sub add . 2>actual &&
> +	test_cmp expect actual
> +'
> +
> +test_done
