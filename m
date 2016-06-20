Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 774B81FF40
	for <e@80x24.org>; Mon, 20 Jun 2016 17:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756112AbcFTRJK (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 13:09:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59368 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756106AbcFTRJH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 13:09:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 95640238AC;
	Mon, 20 Jun 2016 13:01:43 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=f4DgMRH01Ju5hvBhm67P8UyjKoI=; b=jwX4Oi
	+zCGwbWTHbUIgrBCZ43Pr6kG3ro2DNhmuSnw+e1kxxPEgAjPuLonlA+AiWn8/L/e
	UxosuI4fGNHQEfFWZW6W5FmCE0piGyYgiPnVqpYbh6irRb9/yjn6zfC5vfclYh+V
	UUQKhDHcRrNgtGMRLJjQnpQx+3QWjaXNgnkqE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=spQy3+8phe5MfyGz7I7Y6IKX5I3o/aMu
	NO55MJ3yOhdociyjmuyC4HsacpfMhLq1/euuUzj3yV6i7ZltCh2M0yA0D1IaVJiT
	11d/gxbNmHUijQdEToCYDR1PsJI13JeLzh1/9ca39609Lm5yYjwqYlfvPbEN0ks2
	5zHZl6P7F3w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8E9DF238AB;
	Mon, 20 Jun 2016 13:01:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 13A24238AA;
	Mon, 20 Jun 2016 13:01:43 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/7] log-tree: respect diffopt's configured output file stream
References: <cover.1466244194.git.johannes.schindelin@gmx.de>
	<cover.1466420060.git.johannes.schindelin@gmx.de>
	<babf95df5f610feb6c2ae7f2ed3cff98bab47fe2.1466420060.git.johannes.schindelin@gmx.de>
Date:	Mon, 20 Jun 2016 10:01:41 -0700
In-Reply-To: <babf95df5f610feb6c2ae7f2ed3cff98bab47fe2.1466420060.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Mon, 20 Jun 2016 12:55:13 +0200
	(CEST)")
Message-ID: <xmqqwplju74a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A9E3A924-3708-11E6-B4FA-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> The diff options already know how to print the output anywhere else
> than stdout. The same is needed for log output in general, e.g.
> when writing patches to files in `git format-patch`. Let's allow
> users to use log_tree_commit() *without* changing global state via
> freopen().

I wonder if this change is actually fixing existing bugs.  Are there
cases where diffopt.file is set, i.e. the user expects the output to
be sent elsewhere, but the code here unconditionally emits to the
standard output?  I suspect that such a bug can be demonstratable in
a test or two, if that were the case.

I am sort-of surprised that we didn't do this already even though we
had diffopt.file for a long time since c0c77734 (Write diff output
to a file in struct diff_options, 2008-03-09).

Use of freopen() to always write patches through stdout may have
been done as a lazy workaround of the issue this patch fixes, but
what is surprising to me is that doing it the right way like this
patch does is not that much of work.  Perhaps that was done long
before c0c77734 was done, which would mean doing it the right way
back then when we started using freopen() it would have been a lot
more work and we thought taking a short-cut was warranted.

In any case, this is a change in the good direction.  Thanks for
cleaning things up.

>  		if (opt->children.name)
>  			show_children(opt, commit, abbrev_commit);
>  		show_decorations(opt, commit);
>  		if (opt->graph && !graph_is_commit_finished(opt->graph)) {
> -			putchar('\n');
> +			fputc('\n', opt->diffopt.file);

Hmph.  putc() is the "to the given stream" equivalent of putchar()
in the "send to stdout" world, not fputc().  I do not see a reason
to force the call to go to a function avoiding a possible macro here.

Likewise for all the new fputc() calls in this series that were
originally putchar().

> @@ -880,8 +880,9 @@ int log_tree_commit(struct rev_info *opt, struct commit *commit)
>  		shown = 1;
>  	}
>  	if (opt->track_linear && !opt->linear && opt->reverse_output_stage)
> -		printf("\n%s\n", opt->break_bar);
> +		fprintf(opt->diffopt.file, "\n%s\n", opt->break_bar);
>  	opt->loginfo = NULL;
> -	maybe_flush_or_die(stdout, "stdout");
> +	if (opt->diffopt.file == stdout)
> +		maybe_flush_or_die(stdout, "stdout");
>  	return shown;
>  }

This one looks fishy.

Back when we freopen()'ed to write patches only through stdout, we
always called maybe_flush_or_die() to make sure that the output is
flushed correctly after processing each commit.  This change makes
it not to care, which I doubt was what you intended.  Instead, my
suspicion is that you didn't want to say "stdout" when writing into
a file.

But even when writing to on-disk files, the code before your series
would have said "stdout" when it had trouble flushing, so I do not
think this new "if()" condition is making things better.  If "it
said stdout when having trouble flushing to a file" were a problem
to be fixed, "let's not say stdout by not even attempting to flush
and catch errors when writing to a file" would not be the right
solution, no?

Personally, I do not think it hurts if we kept saying 'stdout' here,
even when we flush opt->diffopt.file and found a problem.

Thanks.


