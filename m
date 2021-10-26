Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C01C433EF
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 05:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4631161002
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 05:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbhJZFHt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 01:07:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:46426 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231801AbhJZFHp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 01:07:45 -0400
Received: (qmail 8064 invoked by uid 109); 26 Oct 2021 05:05:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 26 Oct 2021 05:05:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3063 invoked by uid 111); 26 Oct 2021 05:05:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 26 Oct 2021 01:05:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 26 Oct 2021 01:05:20 -0400
From:   Jeff King <peff@peff.net>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] stash: implement '--staged' option for 'push' and
 'save'
Message-ID: <YXeMkC/jPxjzNgWF@coredump.intra.peff.net>
References: <875yugcs3l.fsf@osv.gnss.ru>
 <87lf2zz59w.fsf@osv.gnss.ru>
 <87fst2gwia.fsf_-_@osv.gnss.ru>
 <87pms2mi1p.fsf_-_@osv.gnss.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87pms2mi1p.fsf_-_@osv.gnss.ru>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 18, 2021 at 07:09:06PM +0300, Sergey Organov wrote:

> +static int stash_staged(struct stash_info *info, const struct pathspec *ps,
> +			struct strbuf *out_patch, int quiet)
> +{
> +	int ret = 0;
> +	struct child_process cp_diff_tree = CHILD_PROCESS_INIT;
> +	struct index_state istate = { NULL };
> +
> +	if (write_index_as_tree(&info->w_tree, &istate, the_repository->index_file,
> +				0, NULL)) {
> +		ret = -1;
> +		goto done;
> +	}
> +
> +	cp_diff_tree.git_cmd = 1;
> +	strvec_pushl(&cp_diff_tree.args, "diff-tree", "-p", "-U1", "HEAD",
> +		     oid_to_hex(&info->w_tree), "--", NULL);
> +	if (pipe_command(&cp_diff_tree, NULL, 0, out_patch, 0, NULL, 0)) {
> +		ret = -1;
> +		goto done;
> +	}
> +
> +	if (!out_patch->len) {
> +		if (!quiet)
> +			fprintf_ln(stderr, _("No staged changes"));
> +		ret = 1;
> +	}
> +
> +done:
> +	discard_index(&istate);
> +	return ret;
> +}

This function doesn't look at its "struct pathspec" parameter at all.
I'm not sure if that's a bug (i.e., it should be restricting the diff
here) or if it was just pulled unnecessarily over from stash_patch().

-Peff
