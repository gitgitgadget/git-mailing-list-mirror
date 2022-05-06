Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3A2C433EF
	for <git@archiver.kernel.org>; Fri,  6 May 2022 18:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389026AbiEFSQf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 14:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234158AbiEFSQc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 14:16:32 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9166E8C4
        for <git@vger.kernel.org>; Fri,  6 May 2022 11:12:48 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C95C6185C67;
        Fri,  6 May 2022 14:12:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cXw4DOMZyAHljytvcPxE2M37i4TZsrTYxQr+Rt
        sZJts=; b=oLRaFXZW7TTDPFUYWCN21tE8ugxWF/hDAbb63zGTjYF+4V3p0HRy54
        uBs4m4AL+vxyc4xLmDMzi8IyAqwFE1Mtp+VnQDzddMnO+ZQmRQwa1U0YOzFXrvfF
        1Tde9xBYOe1qiJnBmX0pNQ51CU43VLn21U8OooPW0M5CvthcxRRu4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B4091185C66;
        Fri,  6 May 2022 14:12:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 33BC1185C60;
        Fri,  6 May 2022 14:12:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Christian Couder <chriscool@tuxfamily.org>, kernel-team@fb.com
Subject: Re: [PATCH v2 1/2] bisect: output state before we are ready to
 compute bisection
References: <cover.1651796862.git.chris@chrisdown.name>
        <11edd3e4dbaac7fada8a3bcd43f4bbd353087637.1651796862.git.chris@chrisdown.name>
Date:   Fri, 06 May 2022 11:12:42 -0700
In-Reply-To: <11edd3e4dbaac7fada8a3bcd43f4bbd353087637.1651796862.git.chris@chrisdown.name>
        (Chris Down's message of "Fri, 6 May 2022 01:52:46 +0100")
Message-ID: <xmqqtua2lecl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1F9C5250-CD68-11EC-93FB-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Chris Down <chris@chrisdown.name> writes:

> diff --git a/bisect.h b/bisect.h
> index 1015aeb8ea..ccd9ad31f6 100644
> --- a/bisect.h
> +++ b/bisect.h
> @@ -62,6 +62,12 @@ enum bisect_error {
>  	BISECT_INTERNAL_SUCCESS_MERGE_BASE = -11
>  };
>  
> +struct bisect_state {
> +	int nr_good;  /* How many good commits do we have? */
> +	int nr_bad;   /* How many bad commits do we have? (Well, you can only
> +			  have 0 or 1, but...) */
> +};

;-)  Multi-line comment style (cf. Documentation/CodingGuidelines)?

> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 8b2b259ff0..9d583f651c 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -329,12 +329,12 @@ static int check_and_set_terms(struct bisect_terms *terms, const char *cmd)
>  	return 0;
>  }
>  
> -static int mark_good(const char *refname, const struct object_id *oid,
> -		     int flag, void *cb_data)
> +static int inc_nr(const char *refname, const struct object_id *oid,
> +		  int flag, void *cb_data)
>  {
> -	int *m_good = (int *)cb_data;
> -	*m_good = 0;
> -	return 1;
> +	int *nr = (int *)cb_data;
> +	(*nr)++;
> +	return 0;
>  }

"mark_good" used to be a way to see if there is _any_ ref that match
the glob "refs/bisect/good-*"---the missing_good variable in the caller
is initialized to "true" (pessimism) and this callback is called for
each such ref.  Because the first such call is enough to say "yes,
we do have such a ref" without finding the second or subsequent "good"
ones, the function used to return 1 to stop for_each_glob_ref_in()
early.

All of that is now different here.  The helper is to "count" the
refs that match the glob.  So the caller will instead initialize the
counter to 0, and each time this callback is called, we increment it,
and because we do not want to stop the iteration early, we return 0.

All makes sense.

>  static const char need_bad_and_good_revision_warning[] =
> @@ -384,23 +384,49 @@ static int decide_next(const struct bisect_terms *terms,
>  			     vocab_good, vocab_bad, vocab_good, vocab_bad);
>  }
>  
> -static int bisect_next_check(const struct bisect_terms *terms,
> -			     const char *current_term)
> +static struct bisect_state bisect_status(const struct bisect_terms *terms)
>  {
> -	int missing_good = 1, missing_bad = 1;
>  	char *bad_ref = xstrfmt("refs/bisect/%s", terms->term_bad);
>  	char *good_glob = xstrfmt("%s-*", terms->term_good);
> +	struct bisect_state bs;
> +
> +	memset(&bs, 0, sizeof(bs));

We should just zero-initialize the struct by

	struct bisect_state bs = { 0 };

without memset().  But see below

>  	if (ref_exists(bad_ref))
> -		missing_bad = 0;
> +		bs.nr_bad = 1;
>  
> -	for_each_glob_ref_in(mark_good, good_glob, "refs/bisect/",
> -			     (void *) &missing_good);
> +	for_each_glob_ref_in(inc_nr, good_glob, "refs/bisect/",
> +			     (void *) &bs.nr_good);
>  	free(good_glob);
>  	free(bad_ref);
>  
> -	return decide_next(terms, current_term, missing_good, missing_bad);
> +	return bs;
> +}

Passing struct by value?

It is more usual in this codebase for the caller to prepare a struct
and give a pointer to it to a helper function like this one, i.e.

    static void bisect_status(struct bisect_state *state,
			      const struct bisect_terms *terms)
    {
	...
	for_each_glob_ref_in(count_matches, good_glob, "refs/bisect",
			     (void *) &state->nr_good);
    }

    static void bisect_print_status(const struct bisect_terms *terms)
    {
	struct bisect_state state = { 0 };

	bisect_status(&state, terms);
	...

would be more common.

> diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
> index 5382e5d216..a02587d1a7 100755
> --- a/t/t6030-bisect-porcelain.sh
> +++ b/t/t6030-bisect-porcelain.sh
> @@ -1025,4 +1025,22 @@ test_expect_success 'bisect visualize with a filename with dash and space' '
>  	git bisect visualize -p -- "-hello 2"
>  '
>  
> +test_expect_success 'bisect state output with multiple good commits' '
> +       git bisect reset &&
> +       git bisect start >output &&
> +       grep "waiting for both good and bad commits" output &&
> +       git bisect good "$HASH1" >output &&
> +       grep "waiting for bad commit, 1 good commit known" output &&
> +       git bisect good "$HASH2" >output &&
> +       grep "waiting for bad commit, 2 good commits known" output
> +'
> +
> +test_expect_success 'bisect state output with bad commit' '
> +       git bisect reset &&
> +       git bisect start >output &&
> +       grep "waiting for both good and bad commits" output &&
> +       git bisect bad "$HASH4" >output &&
> +       grep -F "waiting for good commit(s), bad commit known" output
> +'
> +
>  test_done

Looking good.

Thanks.
