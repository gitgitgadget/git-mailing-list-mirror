Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 140A720193
	for <e@80x24.org>; Thu,  4 Aug 2016 18:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965198AbcHDSrl (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 14:47:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51009 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758925AbcHDSrV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 14:47:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D75CF3293F;
	Thu,  4 Aug 2016 14:46:57 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8yYG0xEitD9x9qhDsv+RUCfudgA=; b=hKc0ol
	MqiM8CRt0Dq/71ANWmkoNw7xI0sPK2+I+JiNam2k5LNRwSH2cauRQCq4bdJDKJDx
	c8kMQwe26Bhid5KmSybil1jb193vjcuTHKqJglOK3E3Xb3wmzMFMGs7d8PAChaZN
	hb2yHhlw1hwYtuS1WyCsKziN/QWUh5s7yohRQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SbXkWIGjHydx0Sih2Qj5zzFoBTErBvHl
	LOGJeNbCXa+0wlaJg3JV0l0TKpQQ84z+dStYrlEBdVeD6hcMGcTVo999sAAISkJF
	HlPr89COKckaLdomM4iyO74x5ZPTxLcpnm050LuFzLndzugJZ6auSWwpLht4mlzH
	iNctj610NFw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CE39B3293E;
	Thu,  4 Aug 2016 14:46:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5224F3293B;
	Thu,  4 Aug 2016 14:46:57 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Michael Haggerty <mhagger@alum.mit.edu>
Cc:	git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Jeff King <peff@peff.net>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 6/8] xdl_change_compact(): keep track of the earliest end
References: <cover.1470259583.git.mhagger@alum.mit.edu>
	<b0413b20e3b8de1dedb91460a9f05534166f6afa.1470259583.git.mhagger@alum.mit.edu>
Date:	Thu, 04 Aug 2016 11:46:54 -0700
In-Reply-To: <b0413b20e3b8de1dedb91460a9f05534166f6afa.1470259583.git.mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Thu, 4 Aug 2016 00:00:34 +0200")
Message-ID: <xmqqoa582wyp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D21B046C-5A73-11E6-8E67-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> This makes it easier to detect whether shifting is possible, and will
> also make the next change easier.

I can see the code keeping track of earliest_end but the above does
not make it clear what the new "continue" is about.

... easier to detect whether shifting is possible (in which case we
can skip the shifting), and will also make ...

perhaps.

> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  xdiff/xdiffi.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
> index 66129db..34f021a 100644
> --- a/xdiff/xdiffi.c
> +++ b/xdiff/xdiffi.c
> @@ -414,7 +414,8 @@ static int recs_match(xrecord_t **recs, long ixs, long ix, long flags)
>  }
>  
>  int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
> -	long start, end, io, end_matching_other, groupsize, nrec = xdf->nrec;
> +	long start, end, earliest_end, end_matching_other;
> +	long io, groupsize, nrec = xdf->nrec;
>  	char *rchg = xdf->rchg, *rchgo = xdfo->rchg;
>  	unsigned int blank_lines;
>  	xrecord_t **recs = xdf->recs;
> @@ -516,6 +517,8 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
>  				end_matching_other = -1;
>  			}
>  
> +			earliest_end = end;
> +
>  			/*
>  			 * Now shift the group forward as long as the first line
>  			 * of the current change group is equal to the line after
> @@ -547,6 +550,9 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
>  			}
>  		} while (groupsize != end - start);
>  
> +		if (end == earliest_end)
> +			continue; /* no shifting is possible */
> +
>  		if ((flags & XDF_COMPACTION_HEURISTIC) && blank_lines) {
>  			/*
>  			 * Compaction heuristic: if a group can be moved back and
