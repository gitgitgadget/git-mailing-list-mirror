Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6DBA1F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 22:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756620AbcHXWpt (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 18:45:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64259 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756583AbcHXWps (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 18:45:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 23FC239528;
        Wed, 24 Aug 2016 18:30:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GnwKpHt9U1eSIs1inE8/YlNWyrA=; b=lnG0gZ
        B1+3qYzSYbrH70CIZgVZatksAnxoLmWGwlVgVmOXxW+TYeeQ5PfjmCab8Gd4aq6L
        2B0x29bylOcuQU/786+Fq+gS4BWF0yQBVsQvqp1mydn5E+AIiqSTX1vLn2fMTEyj
        Ag5SY8KZ/670HAk7QOKkrfcKzPwVdixU+s6Ps=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=u68YWV6p02vUSrKgb17HHZBUC6Ddn9lC
        Y1XUVoLJiyOnnafpdwwH4ZJYHP+NGM8iIs86XDPSOYpHLMtO6dDHb18eZV14ASZS
        Sok0N7LciWHKv39GCSq6f5xiGySy1EBmCSAGLtISy+ojSL/v5OPtRZ55ZA8fBppK
        qqyiTiawcQ0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1D90C39527;
        Wed, 24 Aug 2016 18:30:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6DC0739526;
        Wed, 24 Aug 2016 18:30:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pranit Bauva <pranit.bauva@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v14 09/27] bisect--helper: `bisect_write` shell function in C
References: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
        <01020156b73fe6a7-2e9df745-e3f4-4830-a1af-4acae7964c11-000000@eu-west-1.amazonses.com>
Date:   Wed, 24 Aug 2016 15:30:38 -0700
In-Reply-To: <01020156b73fe6a7-2e9df745-e3f4-4830-a1af-4acae7964c11-000000@eu-west-1.amazonses.com>
        (Pranit Bauva's message of "Tue, 23 Aug 2016 11:53:53 +0000")
Message-ID: <xmqqfuptol4h.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 63218248-6A4A-11E6-929A-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pranit Bauva <pranit.bauva@gmail.com> writes:

> +struct bisect_terms {
> +	struct strbuf term_good;
> +	struct strbuf term_bad;
> +};

I think "struct strbuf" is overrated.  For things like this, where
these fields will never change once it is set (and setting it is
done atomically, not incrementally), there is no good reason to use
define the fields as strbuf.

Only because you chose to use strbuf for these two fields, you have
to make unnecessarily copies of argv[] in the command parser, and
you have to remember to discard these copies later.

I think you can just say "const char *" in this case.  

> +static int bisect_write(const char *state, const char *rev,
> +			const struct bisect_terms *terms, int nolog)
> +{
> +	struct strbuf tag = STRBUF_INIT;
> +	struct strbuf commit_name = STRBUF_INIT;
> +	struct object_id oid;
> +	struct commit *commit;
> +	struct pretty_print_context pp = {0};
> +	FILE *fp;
> +
> +	if (!strcmp(state, terms->term_bad.buf))
> +		strbuf_addf(&tag, "refs/bisect/%s", state);
> +	else if (one_of(state, terms->term_good.buf, "skip", NULL))
> +		strbuf_addf(&tag, "refs/bisect/%s-%s", state, rev);
> +	else
> +		return error(_("Bad bisect_write argument: %s"), state);

OK.

> +	if (get_oid(rev, &oid)) {
> +		strbuf_release(&tag);
> +		return error(_("couldn't get the oid of the rev '%s'"), rev);
> +	}
> +
> +	if (update_ref(NULL, tag.buf, oid.hash, NULL, 0,
> +		       UPDATE_REFS_MSG_ON_ERR)) {
> +		strbuf_release(&tag);
> +		return -1;
> +	}
> +	strbuf_release(&tag);
> +
> +	fp = fopen(git_path_bisect_log(), "a");
> +	if (!fp)
> +		return error_errno(_("couldn't open the file '%s'"), git_path_bisect_log());
> +
> +	commit = lookup_commit_reference(oid.hash);
> +	format_commit_message(commit, "%s", &commit_name, &pp);
> +	fprintf(fp, "# %s: [%s] %s\n", state, sha1_to_hex(oid.hash),
> +		commit_name.buf);
> +	strbuf_release(&commit_name);
> +
> +	if (!nolog)
> +		fprintf(fp, "git bisect %s %s\n", state, rev);
> +
> +	fclose(fp);
> +	return 0;

You seem to be _release()ing tag all over the place.

Would it make sense to have a single clean-up label at the end of
function, introduce a "int retval" variable and set it to -1 (or
whatever) when an error is detected and "goto" to the label?  It may
make it harder to make such a leak.  That is, to end the function
more like:

	finish:
        	if (fp)
                	fclose(fp);
		strbuf_release(&tag);
                strbuf_release(&commit_name);
		return retval;
	}

and have sites with potential errors do something like this:

	if (update_ref(...)) {
        	retval = -1;
                goto finish;
	}

> +	struct bisect_terms terms;
> +	bisect_terms_init(&terms);

With the type of "struct bisect_terms" members corrected, you do not
even need the _init() function.

> @@ -182,24 +251,38 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  		usage_with_options(git_bisect_helper_usage, options);
>  
>  	switch (cmdmode) {
> +	int nolog;
>  	case NEXT_ALL:
>  		return bisect_next_all(prefix, no_checkout);
>  	case WRITE_TERMS:
>  		if (argc != 2)
>  			die(_("--write-terms requires two arguments"));
> -		return write_terms(argv[0], argv[1]);
> +		res = write_terms(argv[0], argv[1]);
> +		break;
>  	case BISECT_CLEAN_STATE:
>  		if (argc != 0)
>  			die(_("--bisect-clean-state requires no arguments"));
> -		return bisect_clean_state();
> +		res = bisect_clean_state();
> +		break;
>  	case BISECT_RESET:
>  		if (argc > 1)
>  			die(_("--bisect-reset requires either zero or one arguments"));
> -		return bisect_reset(argc ? argv[0] : NULL);
> +		res = bisect_reset(argc ? argv[0] : NULL);
> +		break;
>  	case CHECK_EXPECTED_REVS:
> -		return check_expected_revs(argv, argc);
> +		res = check_expected_revs(argv, argc);
> +		break;
> +	case BISECT_WRITE:
> +		if (argc != 4 && argc != 5)
> +			die(_("--bisect-write requires either 4 or 5 arguments"));
> +		nolog = (argc == 5) && !strcmp(argv[4], "nolog");
> +		strbuf_addstr(&terms.term_good, argv[2]);
> +		strbuf_addstr(&terms.term_bad, argv[3]);

Here,

	terms.term_good = argv[2];
	terms.term_bad = argv[3];

and then you do not need bisect_terms_release() at all.

> +		res = bisect_write(argv[0], argv[1], &terms, nolog);
> +		break;
>  	default:
>  		die("BUG: unknown subcommand '%d'", cmdmode);
>  	}
> -	return 0;
> +	bisect_terms_release(&terms);
> +	return res;
>  }
