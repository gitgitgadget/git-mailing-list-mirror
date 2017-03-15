Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97CF5202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 21:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752785AbdCOVKw (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 17:10:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65484 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752035AbdCOVKu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 17:10:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 45A1679E3D;
        Wed, 15 Mar 2017 17:09:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GYpKaNSc30pF51+rd3uJQ5zoa0Y=; b=E6ErYx
        CBka/TvSKgZ4pBQxHc5p6rBuizk75OZ3xO98q7zdryMqQFIMqMLWn8n65UG9me2J
        fKLiw9n+5rSBnEJgakS+ah0fJreOGImSAJ9og9ey5Eq7jCayHih5x69HsrYUGnbw
        9tq8Q7CiU+jepNJmjcQubW+yTgR2+o+NBxhpE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mpTQe//pkH5wR+yC95kOEw5zSplu87dB
        N1qoZRETXiQLgBNhsrmoZ639LIK2F50HVsyZdBWOUmLlBZixwuz1NIqGoq4pvDE3
        OeaUIMgDaA4xfA38xumWfOTo6tKDM7sIk6lsy5eH4IIOnxmQaRF5cfFRA+/IcPLu
        lg8aHg3ZgRY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3D6CD79E3C;
        Wed, 15 Mar 2017 17:09:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9C83C79E3A;
        Wed, 15 Mar 2017 17:09:34 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] rev-parse: simplify parsing of ref options
References: <20170315200521.qwcm5tqcdzkbwp3x@sigill.intra.peff.net>
        <20170315200802.r4un6p5admfu4h34@sigill.intra.peff.net>
Date:   Wed, 15 Mar 2017 14:09:33 -0700
In-Reply-To: <20170315200802.r4un6p5admfu4h34@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 15 Mar 2017 16:08:02 -0400")
Message-ID: <xmqq8to6dz76.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B0BD156C-09C3-11E7-8A68-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This actually drops the last caller for for_each_branch_ref(). I'm not
> sure if we shoulder consider cleaning up the proliferation of
> for_each_ref() helpers.

That is certainly a good thing to do (but outside this series).

I am wondering if "git diff" could have chosen a better way to
arrange deleted and inserted lines.  The first two if statements
in the preimage corresponds to the new opt-with-value(branches)
thing, the next two are repalced by opt-with-value(tags), an
odd-man-out "--glob=" thing is replaced with handle_ref_opt(NULL),
and then two "--remotes" thing are paired with the final
opt-with-value(remotes) thing.  

That would break the usual expectation of seeing all "-" first and
then "+" when there is no intervening " " context lines, so such an
output might break tools, though (I do not think "git apply" would
choke).

>  builtin/rev-parse.c | 45 ++++++++++++++++-----------------------------
>  1 file changed, 16 insertions(+), 29 deletions(-)
>
> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> index db1417160..76be91350 100644
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -554,6 +554,15 @@ static int opt_with_value(const char *arg, const char *opt, const char **value)
>  	return 0;
>  }
>  
> +static void handle_ref_opt(const char *pattern, const char *prefix)
> +{
> +	if (pattern)
> +		for_each_glob_ref_in(show_reference, pattern, prefix, NULL);
> +	else
> +		for_each_ref_in(prefix, show_reference, NULL);
> +	clear_ref_exclusion(&ref_excludes);
> +}
> +
>  int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>  {
>  	int i, as_is = 0, verify = 0, quiet = 0, revs_count = 0, type = 0;
> @@ -749,42 +758,20 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>  				for_each_ref_in("refs/bisect/good", anti_reference, NULL);
>  				continue;
>  			}
> -			if (skip_prefix(arg, "--branches=", &arg)) {
> -				for_each_glob_ref_in(show_reference, arg,
> -					"refs/heads/", NULL);
> -				clear_ref_exclusion(&ref_excludes);
> -				continue;
> -			}
> -			if (!strcmp(arg, "--branches")) {
> -				for_each_branch_ref(show_reference, NULL);
> -				clear_ref_exclusion(&ref_excludes);
> -				continue;
> -			}
> -			if (skip_prefix(arg, "--tags=", &arg)) {
> -				for_each_glob_ref_in(show_reference, arg,
> -					"refs/tags/", NULL);
> -				clear_ref_exclusion(&ref_excludes);
> +			if (opt_with_value(arg, "--branches", &arg)) {
> +				handle_ref_opt(arg, "refs/heads/");
>  				continue;
>  			}
> -			if (!strcmp(arg, "--tags")) {
> -				for_each_tag_ref(show_reference, NULL);
> -				clear_ref_exclusion(&ref_excludes);
> +			if (opt_with_value(arg, "--tags", &arg)) {
> +				handle_ref_opt(arg, "refs/tags/");
>  				continue;
>  			}
>  			if (skip_prefix(arg, "--glob=", &arg)) {
> -				for_each_glob_ref(show_reference, arg, NULL);
> -				clear_ref_exclusion(&ref_excludes);
> -				continue;
> -			}
> -			if (skip_prefix(arg, "--remotes=", &arg)) {
> -				for_each_glob_ref_in(show_reference, arg,
> -					"refs/remotes/", NULL);
> -				clear_ref_exclusion(&ref_excludes);
> +				handle_ref_opt(arg, NULL);
>  				continue;
>  			}
> -			if (!strcmp(arg, "--remotes")) {
> -				for_each_remote_ref(show_reference, NULL);
> -				clear_ref_exclusion(&ref_excludes);
> +			if (opt_with_value(arg, "--remotes", &arg)) {
> +				handle_ref_opt(arg, "refs/remotes/");
>  				continue;
>  			}
>  			if (skip_prefix(arg, "--exclude=", &arg)) {
