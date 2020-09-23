Return-Path: <SRS0=8LOk=DA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22A7C2D0A8
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 17:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EB5B2068E
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 17:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="P9fZ6rAn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgIWR1Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Sep 2020 13:27:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51064 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgIWR1Q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Sep 2020 13:27:16 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AD08288EB5;
        Wed, 23 Sep 2020 13:27:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=D9OAlq0ypFkZiNDkS0zve+pZVbM=; b=P9fZ6r
        AnlEc6TWkK5E0C13NoIHQBQ4qOl+4slAo8KN5CWHzdq/DPdQxWa6nP6J80+kw6nM
        +oBSXbEoXaDRtXA5rbaiTQrO+p2KShYMz+52sHFhr6hlfp2SfwuOp5FmDOKyVv81
        +Vz+y1uxIIOkFvJuuDLkEAApKoWAbqnwaKEoM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EnxFAqzEGW7SzIdrDmRpJhk6JYETRXxq
        5AOMzBIrbw4mrsKdxFF6EkuNegaw/9haNyv4Iqi0ALXtL59jd7/2kRzXsBkOREr9
        nzAG16imh1LDEbjxFYx3svM6PZZj0/eFhjmKNMFuam6893Zoz4q+JYR1XAsJCSQA
        OSI9IDR1G0I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A518F88EB4;
        Wed, 23 Sep 2020 13:27:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3682C88EB3;
        Wed, 23 Sep 2020 13:27:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Miriam Rubio <mirucam@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] bisect: don't use invalid oid as rev when starting
References: <20200923170915.21748-1-chriscool@tuxfamily.org>
Date:   Wed, 23 Sep 2020 10:27:14 -0700
In-Reply-To: <20200923170915.21748-1-chriscool@tuxfamily.org> (Christian
        Couder's message of "Wed, 23 Sep 2020 19:09:15 +0200")
Message-ID: <xmqqwo0kietp.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 05E1D1FE-FDC2-11EA-A9CA-01D9BED8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> In 06f5608c14 (bisect--helper: `bisect_start` shell function
> partially in C, 2019-01-02), we changed the following shell
> code:

Wow, that's an ancient breakage (goes back to 2.21 or something).

Thanks; will queue.

>
> -                       rev=$(git rev-parse -q --verify "$arg^{commit}") || {
> -                               test $has_double_dash -eq 1 &&
> -                               die "$(eval_gettext "'\$arg' does not appear to be a valid revision")"
> -                               break
> -                       }
> -                       revs="$revs $rev"
>
> into:
>
> +                       char *commit_id = xstrfmt("%s^{commit}", arg);
> +                       if (get_oid(commit_id, &oid) && has_double_dash)
> +                               die(_("'%s' does not appear to be a valid "
> +                                     "revision"), arg);
> +
> +                       string_list_append(&revs, oid_to_hex(&oid));
> +                       free(commit_id);
>
> In case of an invalid "arg" when "has_double_dash" is false, the old
> code would "break" out of the argument loop.
>
> In the new C code though, `oid_to_hex(&oid)` is unconditonally
> appended to "revs". This is wrong first because "oid" is junk as
> `get_oid(commit_id, &oid)` failed and second because it doesn't break
> out of the argument loop.
>
> Not breaking out of the argument loop means that "arg" is then not
> treated as a path restriction (which is wrong).
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> This is a bug fix for the bug Miriam talks about in:
>
> https://lore.kernel.org/git/20200923072740.20772-1-mirucam@gmail.com/
>
> and:
>
> https://lore.kernel.org/git/CAN7CjDDVp_i7dhpbAq5zrGW69nE6+SfivJQ-dembmu+WyqKiQQ@mail.gmail.com/
>
>  builtin/bisect--helper.c    | 14 +++++++++-----
>  t/t6030-bisect-porcelain.sh |  7 +++++++
>  2 files changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 7dcc1b5188..538fa6f16b 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -486,12 +486,16 @@ static int bisect_start(struct bisect_terms *terms, const char **argv, int argc)
>  			return error(_("unrecognized option: '%s'"), arg);
>  		} else {
>  			char *commit_id = xstrfmt("%s^{commit}", arg);
> -			if (get_oid(commit_id, &oid) && has_double_dash)
> -				die(_("'%s' does not appear to be a valid "
> -				      "revision"), arg);
> -
> -			string_list_append(&revs, oid_to_hex(&oid));
> +			int res = get_oid(commit_id, &oid);
>  			free(commit_id);
> +			if (res) {
> +				if (has_double_dash)
> +					die(_("'%s' does not appear to be a valid "
> +					      "revision"), arg);
> +				break;
> +			} else {
> +				string_list_append(&revs, oid_to_hex(&oid));
> +			}
>  		}
>  	}
>  	pathspec_pos = i;
> diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
> index b886529e59..cb645cf8c8 100755
> --- a/t/t6030-bisect-porcelain.sh
> +++ b/t/t6030-bisect-porcelain.sh
> @@ -82,6 +82,13 @@ test_expect_success 'bisect fails if given any junk instead of revs' '
>  	git bisect bad $HASH4
>  '
>  
> +test_expect_success 'bisect start without -- uses unknown stuff as path restriction' '
> +	git bisect reset &&
> +	git bisect start foo bar &&
> +	grep foo ".git/BISECT_NAMES" &&
> +	grep bar ".git/BISECT_NAMES"
> +'
> +
>  test_expect_success 'bisect reset: back in the master branch' '
>  	git bisect reset &&
>  	echo "* master" > branch.expect &&
