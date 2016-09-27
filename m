Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DE2120986
	for <e@80x24.org>; Tue, 27 Sep 2016 17:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754611AbcI0RvA (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 13:51:00 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57477 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751495AbcI0Ru6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 13:50:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 816243FE07;
        Tue, 27 Sep 2016 13:50:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MV0QWO/enavopH/AxPQ1SEMNqdk=; b=CgbMxs
        mj1mcKhIzPIxw9HBpXeOajKM8FSufF8kbLiUGvVLQXB/INPWPDbG6xHZWAJFGJO+
        Ykmt2f15G5l8UzC4leAgpeljx29gQ4PPNepSn+Dg3Ij4fFTWpOANJv8axriJLuEv
        3VlEhQFiHwdb6IMAEunZZBBsCncNrgRhIsA0Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=C3iJBRyFLXu6+9ipY1k8cQLI3ZXSp3EA
        yRHo6mcGo/QNBIAvIsSE4SJDHNstUryWZ5l5OS5owh2QyPyQiLlXHR/2/7S+keee
        xql21M/g/qFi+DM/g3Uz359ackVxd0rb0j2ENzMaMMGvnnkbu/r4L7sgyr/ETiKt
        AC+PVTpGV3M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 73C583FE04;
        Tue, 27 Sep 2016 13:50:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 94F523FE03;
        Tue, 27 Sep 2016 13:50:56 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     santiago@nyu.edu
Cc:     git@vger.kernel.org, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Lukas P <luk.puehringer@gmail.com>
Subject: Re: [PATCH v2 5/5] builtin/tag: add --format argument for tag -v
References: <20160926224233.32702-1-santiago@nyu.edu>
        <20160926224233.32702-6-santiago@nyu.edu>
Date:   Tue, 27 Sep 2016 10:50:54 -0700
In-Reply-To: <20160926224233.32702-6-santiago@nyu.edu> (santiago@nyu.edu's
        message of "Mon, 26 Sep 2016 18:42:33 -0400")
Message-ID: <xmqq37klp6yp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F143B334-84DA-11E6-A141-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

santiago@nyu.edu writes:

> From: Lukas P <luk.puehringer@gmail.com>
>
> Adding --format to git tag -v mutes the default output of the GPG
> verification and instead prints the formatted tag object.
> This allows callers to cross-check the tagname from refs/tags with
> the tagname from the tag object header upon GPG verification.
>
> Caveat: The change adds a format specifier argument to the
> (*each_tag_name_fn) function pointer, i.e. delete_tag now receives this
> too, although it does not need it.

That's an interesting "caveat".

Generally it is a good idea to give an additional opaque pointer to
callback functions of iteration API so that code that uses the
iteration can pass custom data to its callback.

Looking at the way you enhanced each_tag_name_fn, however, you added
a specific argument instead; that is the only reason why you need a
"caveat".  If it were "void *", it would have been in line with the
usual practice, not worth mentioning as a "caveat", but could even
be advertised as a feature, replacing the last "Caveat" paragraph
with something like this:

	The callback function for for_each_tag_name() didn't allow
	callers to pass custom data to their callback functions.
	Add a new opaque pointer to each_tag_name_fn's parameter to
	allow this.

> Signed-off-by: Lukas P <luk.puehringer@gmail.com>
> ---
>  builtin/tag.c | 30 ++++++++++++++++++++----------
>  1 file changed, 20 insertions(+), 10 deletions(-)
>
> diff --git a/builtin/tag.c b/builtin/tag.c
> index 14f3b48..f53227e 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -24,7 +24,7 @@ static const char * const git_tag_usage[] = {
>  	N_("git tag -d <tagname>..."),
>  	N_("git tag -l [-n[<num>]] [--contains <commit>] [--points-at <object>]"
>  		"\n\t\t[--format=<format>] [--[no-]merged [<commit>]] [<pattern>...]"),
> -	N_("git tag -v <tagname>..."),
> +	N_("git tag -v [--format=<format>] <tagname>..."),
>  	NULL
>  };
>  
> @@ -66,9 +66,10 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting, con
>  }
>  
>  typedef int (*each_tag_name_fn)(const char *name, const char *ref,
> -				const unsigned char *sha1);
> +				const unsigned char *sha1, const char *fmt_pretty);

You'd replace "const char *fmt_pretty" with "void *cb_data" here, and...
>  
> -static int for_each_tag_name(const char **argv, each_tag_name_fn fn)
> +static int for_each_tag_name(const char **argv, each_tag_name_fn fn,
> +		const char *fmt_pretty)

... also here.  Then introduce fmt_pretty as an auto variable in the
function ...

>  {
>  	const char **p;

... by adding this line here:

	const char *fmt_pretty = cb_data;

>  	char ref[PATH_MAX];
> @@ -87,14 +88,14 @@ static int for_each_tag_name(const char **argv, each_tag_name_fn fn)
>  			had_error = 1;
>  			continue;
>  		}
> -		if (fn(*p, ref, sha1))
> +		if (fn(*p, ref, sha1, fmt_pretty))
>  			had_error = 1;
>  	}
>  	return had_error;
>  }
>  
>  static int delete_tag(const char *name, const char *ref,
> -				const unsigned char *sha1)
> +				const unsigned char *sha1, const char *fmt_pretty)

And this "const char *fmt_pretty" also becomes "void *cb_data"...

>  {
>  	if (delete_ref(ref, sha1, 0))
>  		return 1;
> @@ -103,9 +104,15 @@ static int delete_tag(const char *name, const char *ref,
>  }
>  
>  static int verify_tag(const char *name, const char *ref,
> -				const unsigned char *sha1)
> +				const unsigned char *sha1, const char *fmt_pretty)

... and here.  Reintroduce fmt_pretty as a name local to the
function by doing the same thing as for_each_tag_name() above.

>  {
> -	return verify_and_format_tag(sha1, name, NULL, GPG_VERIFY_VERBOSE);
> +	int flags;
> +	flags = GPG_VERIFY_VERBOSE;
> +
> +	if (fmt_pretty)
> +		flags = GPG_VERIFY_QUIET;
> +
> +	return verify_and_format_tag(sha1, name, fmt_pretty, flags);
>  }
>  
>  static int do_sign(struct strbuf *buffer)
> @@ -424,9 +431,12 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>  	if (filter.merge_commit)
>  		die(_("--merged and --no-merged option are only allowed with -l"));
>  	if (cmdmode == 'd')
> -		return for_each_tag_name(argv, delete_tag);
> -	if (cmdmode == 'v')
> -		return for_each_tag_name(argv, verify_tag);
> +		return for_each_tag_name(argv, delete_tag, NULL);
> +	if (cmdmode == 'v') {
> +		if (format)
> +			verify_ref_format(format);
> +		return for_each_tag_name(argv, verify_tag, format);
> +	}

Thanks.
