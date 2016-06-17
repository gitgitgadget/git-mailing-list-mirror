Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.0 required=5.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6E9D20179
	for <e@80x24.org>; Fri, 17 Jun 2016 00:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753971AbcFQAD5 (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 20:03:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52939 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752163AbcFQAD5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 20:03:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6716C2363E;
	Thu, 16 Jun 2016 20:03:55 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Sgw6qvLkoEy7lN2TMdaxet67Rs8=; b=yQsdfx
	86VjjHeXR4uUGRk17tTHIVFjwV+vDqg7CW2ODNUYLfyQJWIsQFSrhhlEw3FCqBWq
	RWOGXITg29PdmaCBDbWG29JVXfJBzdBq7DtcBSHNum7gdLQHsQMLH39XiR/gTcGn
	jObWWUqaAOzWD4y/X6OP/2IlS1CuQVwpbDMcg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lO0rwJP3Baro1rcRfProcEGcuxTF3cE6
	qRRVvIzA263GtLoNAIKNvKl2h2wT5tHl7QUys80+eUG0jbEikNrI0Aogde00J+t+
	gboBE4Ftr7OLXiCwmQWeYK3iDnYkg58o/npwATW5Yoq5WtBMWj0UgsOQn7ot5rx2
	rlVig97VpzA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5E5692363D;
	Thu, 16 Jun 2016 20:03:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DD48C2363C;
	Thu, 16 Jun 2016 20:03:54 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Christian Couder <christian.couder@gmail.com>,
	Markus Trippelsdorf <markus@trippelsdorf.de>,
	git@vger.kernel.org
Subject: Re: [PATCH] bisect: always call setup_revisions after init_revisions
References: <20160616125326.GA314@x4> <20160616132952.GC314@x4>
	<20160616134742.GA25920@sigill.intra.peff.net>
	<xmqqporh3rqu.fsf@gitster.mtv.corp.google.com>
	<20160616233719.GB15013@sigill.intra.peff.net>
Date:	Thu, 16 Jun 2016 17:03:53 -0700
In-Reply-To: <20160616233719.GB15013@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 16 Jun 2016 19:37:20 -0400")
Message-ID: <xmqqoa703cly.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FB2EE812-341E-11E6-B408-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The former initializes the rev_info struct to default
> values, and the latter parsers any command-line arguments
> and finalizes the struct.

The former refers to init and the latter setup?

> In e22278c (bisect: display first bad commit without forking
> a new process, 2009-05-28), a show_diff_tree() was added
> that calls the former but not the latter. It doesn't have
> any arguments to parse, but it still should do the
> finalizing step.
>
> This may have caused other minor bugs over the years, but it
> became much more prominent after fe37a9c (pretty: allow
> tweaking tabwidth in --expand-tabs, 2016-03-29). That leaves
> the expected tab width as "-1", rather than the true default
> of "8". When we see a commit with tabs to be expanded, we
> end up trying to add (size_t)-1 spaces to a strbuf, which
> complains about the integer overflow.
>
> The fix is easy: just call setup_revisions() with no
> arguments.

Thanks.

I wonder if we can make it even harder to make the same mistake
again somehow.  I notice that run_diff_files() and run_diff_index()
in diff-lib.c share the ideal name for such an easy-to-use helper
and run_diff_tree(), which does not exist yet, could sit alongside
with them, but the actual implementation of the former two do not
address this issue either.  I guess that the diversity of the set of
pre-packaged options that various callers want to use are so graet
that we need a rather unpleasntly large API refactoring before we
could even contemplate doing so?

In any case, this is a strict improvement.  Let's queue it for the
first maintenance release.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Same patch as earlier, now with 100% more commit message.
>
> I didn't add a test, as it seemed weirdly specific to be checking "can
> bisect show a commit with tabs in it". I.e., it's not likely to actually
> regress in this specific way again.
>
>  bisect.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/bisect.c b/bisect.c
> index 6d93edb..dc13319 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -890,6 +890,7 @@ static void show_diff_tree(const char *prefix, struct commit *commit)
>  	if (!opt.diffopt.output_format)
>  		opt.diffopt.output_format = DIFF_FORMAT_RAW;
>  
> +	setup_revisions(0, NULL, &opt, NULL);
>  	log_tree_commit(&opt, commit);
>  }
