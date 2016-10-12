Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A979215F6
	for <e@80x24.org>; Wed, 12 Oct 2016 23:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933429AbcJLXkS (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 19:40:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55482 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932370AbcJLXkR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 19:40:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D5B93467DC;
        Wed, 12 Oct 2016 19:33:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=h1DGkJJ0ORcstuzPW3eOLLDdbXE=; b=UA9ieD
        UMUXmDCOYHzAQE0sMTcpRjmMIm2vClAY3GxFAIybyleC0PoAxksKpjUOc9NI9QbV
        OR0yMzp1RPPnNU3t4EjytcJ3kPQGUYiqdvxu6C7KM3/g+pJwO5USFH8deUfcRsMP
        0FsQKjfXgASM5VO8VbyWia2DZS22m9Uti8AOA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ge8XU7BYBfjO53EiGioQWRIWGtrK8nJW
        9DaQ6rSkQHi2VMH0T+nEhEA3be1KkyJespGH8gePh1Ew1eb4OW9XsZ9hzOCmByT7
        lkKhKwT42365arBOHctPnHoptfs/ACTprumIl8/LdqD0IVC5NMRlFRxPm71p8mBp
        Qg6Sbsdvw5I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CDD2F467DB;
        Wed, 12 Oct 2016 19:33:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 20A99467DA;
        Wed, 12 Oct 2016 19:33:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     bmwill@google.com, git@vger.kernel.org, j6t@kdbg.org,
        jacob.keller@gmail.com
Subject: Re: [PATCHv3] attr: convert to new threadsafe API
References: <20161012224109.23410-1-sbeller@google.com>
Date:   Wed, 12 Oct 2016 16:33:31 -0700
In-Reply-To: <20161012224109.23410-1-sbeller@google.com> (Stefan Beller's
        message of "Wed, 12 Oct 2016 15:41:09 -0700")
Message-ID: <xmqqfuo116t0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4A11CD02-90D4-11E6-8DB7-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> @@ -89,15 +114,20 @@ static void setup_check(void)
>  
>  ------------
>  	const char *path;
> +	struct git_attr_result *result;
>  
>  	setup_check();
> -	git_check_attr(path, check);
> +	result = git_check_attr(path, check);

This looks stale by a few revisions of the other parts of the patch?

> diff --git a/archive.c b/archive.c
> index 11e3951..15849a8 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -107,10 +107,12 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
>  		void *context)
>  {
>  	static struct strbuf path = STRBUF_INIT;
> +	static struct git_attr_check *check;
> +
>  	struct archiver_context *c = context;
>  	struct archiver_args *args = c->args;
>  	write_archive_entry_fn_t write_entry = c->write_entry;
> -	static struct git_attr_check *check;
> +	struct git_attr_result result = GIT_ATTR_RESULT_INIT;
>  	const char *path_without_prefix;
>  	int err;
>  
> @@ -124,12 +126,16 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
>  		strbuf_addch(&path, '/');
>  	path_without_prefix = path.buf + args->baselen;
>  
> -	if (!check)
> -		check = git_attr_check_initl("export-ignore", "export-subst", NULL);
> -	if (!git_check_attr(path_without_prefix, check)) {
> -		if (ATTR_TRUE(check->check[0].value))
> +	git_attr_check_initl(&check, "export-ignore", "export-subst", NULL);
> +	git_attr_result_init(&result, check);
> +
> +	if (!git_check_attr(path_without_prefix, check, &result)) {
> +		if (ATTR_TRUE(result.value[0])) {
> +			git_attr_result_clear(&result);
>  			return 0;
> -		args->convert = ATTR_TRUE(check->check[1].value);
> +		}
> +		args->convert = ATTR_TRUE(result.value[1]);
> +		git_attr_result_clear(&result);
>  	}

This is exactly what I meant by "can we avoid alloc/free of result
in leaf function when we _know_ how many attributes we are
interested in already, which is the majority of the case?".

Starting with a simple but unoptimized internal implementation of
the attr subsystem is one thing (which is good).  Exposing an API that
cannot be optimally implemented later without changing the callers
is another (which is bad).

By encapsulating each element into "struct git_attr_result", we can
extend the API without changing the API user [*1*].  

But I do not think of a way to allow an efficient implementation
later unless the source of the API user somehow says "this user is
only interested in this many attributes", like having this

	struct git_attr_result result[2];

(because this caller only wants "ignore" and "subst") on the API
user's side [*2*].  Without such a clue (like the patch above, that
only says "there is a structure called 'result'"), I do not think of
a way to avoid dynamic allocation on the API implementation side.

All the other callers in the patch (pack-objects, convert, ll-merge,
etc.) seem to share the exact same pattern.  Each of the leaf
functions knows a fixed set of attributes it is interested in, the
caller iterates over many paths and makes calls to these leaf
functions, and it is a waste to pay alloc/free overhead for each and
every iteration when we know how many elements result needs to
store.


[Footnote]

*1* Would we need a wrapping struct around the array of results?  If
    that is the case, we may need something ugly like this on the
    API user side:

	GIT_ATTR_RESULT_TYPE(2) result = {2,};

    with something like the following on the API implementation
    side:

        #define GIT_ATTR_RESULT_TYPE(n) \
            struct { \
                    int num_slots; \
                    const char *value[n]; \
            }

        struct git_attr_result {
                int num_slots;
                const char *value[FLEX_ARRAY];
        };
        git_attr_result_init(void *result_, struct git_attr_check *check)
        {
                struct git_attr_result *result = result_;

                assert(result->num_slots, check->num_attrs);
                ...
        }                
        git_check_attr(const char *path,
                       struct git_attr_check *check,
                       void *result_)
        {                       
                struct git_attr_result *result = result_;

                assert(result->num_slots, check->num_attrs);
                for (i = 0; i < check_num_attrs; i++)
                        result->value[i] = ... found value ...;
        }


*2* Or the uglier

	GIT_ATTR_RESULT_TYPE(2) result = {2,};

    I can see why the "check" side would benefit from a structure
    that contains an array, but I do not see why "result" side would
    want to, so I am hoping that we won't have to do this uglier
    variant and just go with the simple "array of resulting values".
