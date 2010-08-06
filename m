From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 05/18] Parse the -L options
Date: Fri, 06 Aug 2010 12:42:13 -0700
Message-ID: <7v39ur8r56.fsf@alter.siamese.dyndns.org>
References: <1281024717-7855-1-git-send-email-struggleyb.nku@gmail.com>
 <1281024717-7855-6-git-send-email-struggleyb.nku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, Jens.Lehmann@web.de
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 06 21:42:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhSoI-0006nc-VQ
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 21:42:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935133Ab0HFTm1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Aug 2010 15:42:27 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65281 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935084Ab0HFTmY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Aug 2010 15:42:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 69986CBC1B;
	Fri,  6 Aug 2010 15:42:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=dgGnti8stNS8qJAL1mNc1lMgGgg=; b=DVOm5cCSLOYvNBg1Ca8Eqrr
	TiKaPjbuARnymJYZXYWh1kTEnFEiSd97cXwqG5M2WELu2DHfo/FoSO0gLZo0QzRE
	2k4PZG3PtJr3nW9jrq03C01J9hx0rGadhWQ5h0wa64sW0mq0AfXxWHgiOD0fOSTT
	NwCclsujNs4B3ScINcCY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=avtbqxhg7htr6bIk1qzeUPZOjBoHivGpngXNxVZeyiavs0m/O
	7nhyFh154TygKyjMPksD5aPUku0mCqZo5KOX6pqXozZQ/15vA89ewHiqn7dU9/Hj
	Qf9VCwcaxHJSaUzbR9x1nYYG0q9GSwyamO7TCBCnv78wxHuiOOy8FK1slI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2695ACBC18;
	Fri,  6 Aug 2010 15:42:20 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8EB35CBC15; Fri,  6 Aug
 2010 15:42:14 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B9F15E36-A192-11DF-9CC6-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152804>

Bo Yang <struggleyb.nku@gmail.com> writes:

>  static void cmd_log_init(int argc, const char **argv, const char *prefix,
>  			 struct rev_info *rev, struct setup_revision_opt *opt)
>  {
>  	int i;
>  	int decoration_given = 0;
>  	struct userformat_want w;
> +	const char *path = NULL, *pathspec = NULL;
> +	static struct diff_line_range *range = NULL, *r = NULL;
> +	static struct parse_opt_ctx_t ctx;
> +	static struct line_opt_callback_data line_cb = {&range, &ctx, NULL};

Do these have to be static?  cmd_log_init() may be near the top of the
call chain and has less reason to be reentrant, but it feels somewhat
wrong if we are placing something that should live on stack in BSS.

> +	static const struct option options[] = {
> +		OPT_CALLBACK('L', NULL, &line_cb, "n,m", "Process only line range n,m, counting from 1", log_line_range_callback),
> +		OPT_END()
> +	};
> + ...
> +	parse_options_start(&ctx, argc, argv, prefix, PARSE_OPT_KEEP_DASHDASH |
> +			PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_STOP_AT_NON_OPTION);
> +	for (;;) {
> +		switch (parse_options_step(&ctx, options, log_opt_usage)) {
> +		case PARSE_OPT_HELP:
> +			exit(129);
> +		case PARSE_OPT_DONE:
> +			goto parse_done;
> +		case PARSE_OPT_NON_OPTION:
> + ... do the extra path thing ...
> +			pathspec = prefix_path(prefix, prefix ? strlen(prefix) : 0, path);

Please do not call it "pathspec", as this is a specific path in a commit.
"pathspec" is a pattern to be matched to zero or more paths.

> ...
> +			parse_options_next(&ctx, 1);
> +			continue;
> +		case PARSE_OPT_UNKNOWN:
> +			parse_options_next(&ctx, 1);
> +			continue;
> +		}
> +		parse_revision_opt(rev, &ctx, options, log_opt_usage);
> +	}

Hmm, so the strategy is that you first run the command line through a pass
of parse-options that is aware only of "-L" syntax, eat whatever it
recognizes, and give remainder to the setup_revisions().

While I agree with that strategy in general, I think this implementation
is ugly.  It may be even wrong.  For example, can a user specify a path
that begins with a dash with this parser?

My gut feeling is that the capturing of the (optional) second argument
given to -L is better done inside your callback.

Now, the current callback interface does not give you access to ctx so you
may need to invent a new type of "more powerful callback API" that gives
you access to the ctx as well, but if you did so, you should be able to do
something like:

    static int log_line_range_callback(...)
    {
	arg = parse_options_current(ctx);
        ... make sure it is a line range, e.g. "10,20"
        parse_options_next(ctx); /* consume it */
        path = parse_options_current(ctx); /* peek the second position */
        if (does it look like a path?) {
		... associate path with the range in arg
		parse_options_next(ctx); /* consume it */
	} else if (have we already got another range earlier?) {
        	... use the previous path with the range in arg
        } else {
        	die("-L range not followed by path");
	}
    }

no?  In the above illustration, I am assuming that the "more powerful" one
allows the callback to control even parsing of the first argument,
i.e. parse-options does not call get_arg() before calling you back.

And "does it look like a path?" logic could say something like "If it is
in the index, it is a path, even if it begins with a dash", or "If it is
prefixed with ./, then it is always a path but we strip that dot-slash
out", and somesuch, to make the heuristic of "do we have the optional
second parameter?" better than "we do not allow a path that begins with a
dash".  After all, the callback for -L knows better than the generic
"parse-options" infrastructure what to expect for the optional argument at
the second position.

And if you do that, I suspect that you also can lose the "clear up the
last range" hack after the loop is done, no?
