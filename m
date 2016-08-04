Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB49F20193
	for <e@80x24.org>; Thu,  4 Aug 2016 18:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758858AbcHDSS3 (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 14:18:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55125 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758843AbcHDSS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 14:18:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AAFFD32535;
	Thu,  4 Aug 2016 14:18:26 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cKa/qxpjdfZe7LHlOaMcaNeVdZ4=; b=IwD2AU
	02KiChFJlvS9rHyO5I7P/FkzlsC2Ka1aC7jDRTD5coRCq2GJgB/EUfM8tb7QAkU1
	fCv/d+3+KdkyHo8WiygiRVHpvOQsg+3FE3MA8ZQEY4+C75hgiL9ifDc7Hu4jHiDi
	5SBPkQicFA/7HlQOeVOVGWdHPLPm3GkvKhC+s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iUehxFixMRGSQub9QLuBRG38ofrD+YyA
	FcHMx/cz2xvCd8CL/OoZI13RmIrSis6KD0ERVP6A59TGx3RZ/UrUoIagrF9IBTCm
	hmdBd1iMsRSQY1Q+6EN9QLAB7T8TIqRe7ZLqW4UqLBd/lEayB6EA8UalUjCOuYpG
	qEh7EXhcqcw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A252E32534;
	Thu,  4 Aug 2016 14:18:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0B8C632533;
	Thu,  4 Aug 2016 14:18:26 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v6 15/16] Ensure that the output buffer is released after calling merge_trees()
References: <cover.1469547160.git.johannes.schindelin@gmx.de>
	<cover.1470051326.git.johannes.schindelin@gmx.de>
	<0fa117f8ae42e2f7c9b1cc803261b236d5cd6b17.1470051326.git.johannes.schindelin@gmx.de>
Date:	Thu, 04 Aug 2016 11:18:23 -0700
In-Reply-To: <0fa117f8ae42e2f7c9b1cc803261b236d5cd6b17.1470051326.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Mon, 1 Aug 2016 13:44:53 +0200
	(CEST)")
Message-ID: <xmqqbn184cuo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D61937A4-5A6F-11E6-9A14-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> The recursive merge machinery accumulates its output in an output
> buffer, to be flushed at the end of merge_recursive(). At this point,
> we forgot to release the output buffer.
> ...
> diff --git a/merge-recursive.c b/merge-recursive.c
> index ec50932..9e527de 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -2078,6 +2078,8 @@ int merge_recursive(struct merge_options *o,
>  		commit_list_insert(h2, &(*result)->parents->next);
>  	}
>  	flush_output(o);
> +	if (!o->call_depth && o->buffer_output < 2)
> +		strbuf_release(&o->obuf);

OK, with !o->call_depth the change makes sense to me.
