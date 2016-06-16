Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.0 required=5.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B3B51FE4C
	for <e@80x24.org>; Thu, 16 Jun 2016 20:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754227AbcFPU1y (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 16:27:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59503 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753900AbcFPU1x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 16:27:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 33B13239C1;
	Thu, 16 Jun 2016 16:27:52 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/5Or+SjCina2VKXNoTlj8Ad6H28=; b=o+3JRv
	MJGwHhRDNyrpOkoy1pYvdJCnNZbs7/M3rSIuXCJupHq4hsq39lZNTf3EHHhcx//D
	4l7ItMEYf8HYqnclExygtMBAk6LB744dPe+/pNpGe6HE5XB+yRViF+ov97WQr9v3
	NeRKcCGgmEwQhuwlepwPPkTQX4V9oxlP1Ay3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CbYWHAnOZDPbvHzlstj9Iigd/7V9uaXX
	gIN2ns9tac3CW2obIzcazs+PNWQ1ZaijagYmDnTgwhfEN/sCBaV1F6vlt44vV1BW
	f+8T4uNW0T4s1hdPrdpuSFZYlAABi11d3964KAqvo1oHwVUZASi2iEDaaCMqJN2Z
	QWINUx68Jhc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2AD03239C0;
	Thu, 16 Jun 2016 16:27:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A5215239BF;
	Thu, 16 Jun 2016 16:27:51 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	peff@peff.net, git@vger.kernel.org, jacob.keller@gmail.com,
	mhagger@alum.mit.edu
Subject: Re: [PATCH] diff compaction heuristic: favor shortest neighboring blank lines
References: <20160616174620.1011-1-sbeller@google.com>
Date:	Thu, 16 Jun 2016 13:27:49 -0700
In-Reply-To: <20160616174620.1011-1-sbeller@google.com> (Stefan Beller's
	message of "Thu, 16 Jun 2016 10:46:20 -0700")
Message-ID: <xmqqlh24516i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CC7F0A42-3400-11E6-AF28-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> +        def bal
> +                do_bal_stuff()
> +
> +                common_ending()
> +        end
> +
>          def baz
>                  do_baz_stuff()
>
>                  common_ending()
>          end
>
> whereas before we had:
>
>   WIP (TODO: ask peff to provide an example that actually triggers, I seem to be
>        unable to write one, though I thought the above was one)
>
>
> The way we do it, is by inspecting the neighboring lines and see how
> much indent there is and we choose the line that has the shortest amount
> of blanks in the neighboring lines.
> ...
> because there is less space between line start and {end, def bal}
> than for {do_bal_stuff, common_ending}.

I haven't thought this carefully yet, but would this equally work
well for Python, where it does not have the "end" or does the lack
of "end" pose a problem?  You'll still find "def bal" is a good
boundary (but you cannot tell if it is the beginning or the end of a
block, unless you understand the language), though.

> +static unsigned int leading_blank(const char *line)
> +{
> +	unsigned int ret = 0;
> +	while (*line) {
> +		if (*line == '\t')
> +			ret += 8;

This will be broken with a line with space-before-tab whitespace
breakage, I suspect...

> +		else if (*line == ' ')
> +			ret ++;
> +		else
> +			break;
> +		line++;
> +	}
> +	return ret;
> +}
> +
> +static unsigned int surrounding_leading_blank(xrecord_t **recs, long ix,
> +		long flags, long nrec)
> +{
> +	unsigned int i, ret = UINT_MAX;
> +	if (ix > 0)
> +		ret = leading_blank(recs[ix - 1]->ptr);
> +	if (ix < nrec - 1) {
> +		i = leading_blank(recs[ix + 1]->ptr);
> +		if (i < ret)
> +			ret = i;
> +	}
> +	return ret;
> +}
> +
>  static int recs_match(xrecord_t **recs, long ixs, long ix, long flags)
>  {
>  	return (recs[ixs]->ha == recs[ix]->ha &&
> @@ -416,7 +445,7 @@ static int recs_match(xrecord_t **recs, long ixs, long ix, long flags)
>  int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
>  	long ix, ixo, ixs, ixref, grpsiz, nrec = xdf->nrec;
>  	char *rchg = xdf->rchg, *rchgo = xdfo->rchg;
> -	unsigned int blank_lines;
> +	unsigned int blank_lines, min_bl_neigh_indent;
>  	xrecord_t **recs = xdf->recs;
>  
>  	/*
> @@ -451,6 +480,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
>  		do {
>  			grpsiz = ix - ixs;
>  			blank_lines = 0;
> +			min_bl_neigh_indent = UINT_MAX;
>  
>  			/*
>  			 * If the line before the current change group, is equal to
> @@ -485,7 +515,13 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
>  			 * the group.
>  			 */
>  			while (ix < nrec && recs_match(recs, ixs, ix, flags)) {
> -				blank_lines += is_blank_line(recs, ix, flags);
> +				if (is_blank_line(recs, ix, flags)) {
> +					unsigned int bl_neigh_indent =
> +						surrounding_leading_blank(recs, ix, flags, nrec);
> +					if (min_bl_neigh_indent > bl_neigh_indent)
> +						min_bl_neigh_indent = min_bl_neigh_indent;
> +					blank_lines++;
> +				}
>  
>  				rchg[ixs++] = 0;
>  				rchg[ix++] = 1;
> @@ -525,6 +561,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
>  		if ((flags & XDF_COMPACTION_HEURISTIC) && blank_lines) {
>  			while (ixs > 0 &&
>  			       !is_blank_line(recs, ix - 1, flags) &&
> +			       surrounding_leading_blank(recs, ix - 1, flags, nrec) > min_bl_neigh_indent &&
>  			       recs_match(recs, ixs - 1, ix - 1, flags)) {
>  				rchg[--ixs] = 1;
>  				rchg[--ix] = 0;
