Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91A8E208CD
	for <e@80x24.org>; Tue, 15 Aug 2017 21:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751841AbdHOVdL (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 17:33:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57271 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751460AbdHOVdK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 17:33:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 29982A1CBF;
        Tue, 15 Aug 2017 17:33:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wSfrVUwEghkLbuk46spG8wjWcdE=; b=oLfTTg
        0TzJ4MsGps1E2q197/mqHFKDnGH21eUvFWv7pbAvcXmrw2Aqra4RbQ+dnrHCfDDD
        spcwy+yIo238JgMF74xiKo+EbGxbCrl6c4EjQe6OYA6W/siwDsoW7xOSBa0Zakhl
        wvtLAYTXKiv5A/IxdJ0Q9YXS59fsXrPdCGNmc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HCocHnCg45uM/tWPcaw4xgK4F5kNzCwd
        jWDSnXX2h35j+aaF2y7Lt+Qd28xwirf+vuZR2gUdk6QNb+hjMkIVZTebGyzYnEVU
        5vSch8+MEL0jFELOxOPzsH0BFnyFBZP5Z6lsEP4y5HPK26nj+SaHPtR52kb8vCOp
        utfg9W1HL/0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1ACFEA1CBE;
        Tue, 15 Aug 2017 17:33:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 702B3A1CB8;
        Tue, 15 Aug 2017 17:33:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Anthony Sottile <asottile@umich.edu>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH/RFC] git-grep: correct exit code with --quiet and -L
References: <20170815203503.12299-1-asottile@umich.edu>
Date:   Tue, 15 Aug 2017 14:33:01 -0700
In-Reply-To: <20170815203503.12299-1-asottile@umich.edu> (Anthony Sottile's
        message of "Tue, 15 Aug 2017 13:35:03 -0700")
Message-ID: <xmqqpobwplde.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 51116526-8201-11E7-84C2-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Anthony Sottile <asottile@umich.edu> writes:

> The handling of `status_only` no longer interferes with the handling of
> `unmatch_name_only`.  `--quiet` no longer affects the exit code when using
> `-L`/`--files-without-match`.

I agree with the above statement of yours that --quiet should not
affect what the exit status is.

But I am not sure what the exit code from these commands _should_
be:

    $ git grep -L qfwfq \*.h    ;# no file matches
    $ git grep -L \# \*.h       ;# some but not all files match
    $ git grep -L . \*.h        ;# all files match

with or without --quiet.  I seem to get 0, 0, 1, which I am not sure
is correct.  I do recall writing "git grep" _without_ thinking what
the exit code should be when we added --files-without-match, so the
exit status the current code gives out may be just a random garbage.

Asking GNU grep (because --files-without-match is not a POSIX thing):

    $ grep -L qfwfq *.h          ;# no file matches
    $ grep -L \# *.h             ;# some but not all files match
    $ grep -L . *.h              ;# all files match

I seem to get 1, 0, 0.  So the exit status should reflect if there
was _any_ hit from any file that were inspected.

> @@ -1755,7 +1755,7 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
>  		}
>  		if (hit) {
>  			count++;
> -			if (opt->status_only)
> +			if (!opt->unmatch_name_only && opt->status_only)
>  				return 1;
>  			if (opt->name_only) {
>  				show_name(opt, gs->name);

Does the change in this hunk have any effect?

Just before this hunk there is this code:

		/* "grep -v -e foo -e bla" should list lines
		 * that do not have either, so inversion should
		 * be done outside.
		 */
		if (opt->invert)
			hit = !hit;
		if (opt->unmatch_name_only) {
			if (hit)
				return 0;
			goto next_line;

If (opt->unmatch_name_only && hit) then the function would have
already returned and the control wouldn't have reached here.

Which would mean that when the control reaches the line this hunk
touches, either one of these must be false, and because we are
inside "if (hit)", opt->unmatch_name_only must be false.

> @@ -1820,13 +1820,14 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
>  	if (collect_hits)
>  		return 0;
>  
> -	if (opt->status_only)
> -		return 0;
>  	if (opt->unmatch_name_only) {
>  		/* We did not see any hit, so we want to show this */
> -		show_name(opt, gs->name);
> +		if (!opt->status_only)
> +			show_name(opt, gs->name);
>  		return 1;
>  	}
> +	if (opt->status_only)
> +		return 0;

This hunk makes sense to me (provided if the semantics we want out
of --files-without-match is sensible, which is dubious), even though
I would have limited the change to just a single line, i.e.

	if (opt->status_only)
-		return 0;
+		return opt->unmatch_name_only;
	if (opt->unmatch_name_only) {
		/* We did not see any hit, ... */

But I suspect we want to fix the exit code not to be affected by
the "--files-without-match" option in the first place, so all the
code changes we see in this patch might be moot X-<.


