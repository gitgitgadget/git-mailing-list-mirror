Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_50,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BA9A1FEAA
	for <e@80x24.org>; Fri, 24 Jun 2016 20:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbcFXU4p (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 16:56:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53789 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751308AbcFXU4p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 16:56:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8341127450;
	Fri, 24 Jun 2016 16:56:43 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z2/5H0JnfuRElKoAz+dMHBZCr6k=; b=pZ0FTl
	vR8uAlGhMMQ5BS+vKZpSjmaGLBFJ1YKpcZ+DaXSrzXGB2GRRVJ9IeInrPrpTc9s0
	qniA/UgfKXRIGxDmJHNM2LUjlK8TxWf6RfXb2eb6Vcjm9rCNifqvJs96IU/4reJw
	BP/b1v/kVt3Eo6e+NDeKHP93RifPYd9ErtSD8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uWVhvOrpziHIAEryUAMUpsl3k6woI8vl
	4bPtRGx+B5QF7IViyr9dm4DbvO7pEWaZ2KzfzLNBZYR1JOmI5LfHJE6FhjzUA7e/
	9D85jv0W6zudguXhEvCe/TEu45bzODL+nBm9VZ8SYLOxjQXt37bFre3Ij9afbO9I
	JxU+e1eDeB8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7AB472744F;
	Fri, 24 Jun 2016 16:56:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F232D2744E;
	Fri, 24 Jun 2016 16:56:42 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 01/10] Prepare log/log-tree to reuse the diffopt.close_file attribute
References: <cover.1466505222.git.johannes.schindelin@gmx.de>
	<cover.1466607667.git.johannes.schindelin@gmx.de>
	<044f3c6359b63eaa18229cd73e6815e8e15c9778.1466607667.git.johannes.schindelin@gmx.de>
Date:	Fri, 24 Jun 2016 13:56:40 -0700
In-Reply-To: <044f3c6359b63eaa18229cd73e6815e8e15c9778.1466607667.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Wed, 22 Jun 2016 17:01:28 +0200
	(CEST)")
Message-ID: <xmqq60syfgqf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 27BE9320-3A4E-11E6-8BD1-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> We are about to teach the log-tree machinery to reuse the diffopt.file
> field to output to a file stream other than stdout, in line with the
> diff machinery already writing to diffopt.file.
>
> However, we might want to write something after the diff in
> log_tree_commit() (e.g. with the --show-linear-break option), therefore
> we must not let the diff machinery close the file (as per
> diffopt.close_file.
>
> This means that log_tree_commit() itself must override the
> diffopt.close_file flag and close the file, and if log_tree_commit() is
> called in a loop, the caller is responsible to do the same.

Makes sense.

> Note: format-patch has an `--output-directory` option. Due to the fact
> that format-patch's options are parsed first, and that the parse-options
> machinery accepts uniquely abbreviated options, the diff options
> `--output` (and `-o`) are shadowed. Therefore close_file is not set to 1
> so that cmd_format_patch() does *not* need to handle the close_file flag
> differently, even if it calls log_tree_commit() in a loop.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/log.c | 15 ++++++++++++---
>  log-tree.c    |  5 ++++-
>  2 files changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index 099f4f7..27bc88d 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -243,9 +243,10 @@ static struct itimerval early_output_timer;
>  
>  static void log_show_early(struct rev_info *revs, struct commit_list *list)
>  {
> -	int i = revs->early_output;
> +	int i = revs->early_output, close_file = revs->diffopt.close_file;

Probably not worth a reroll, but I find this kind of thing easier to
read as two separate definitions.

>  	int show_header = 1;

And this was separate from "int i = ...;" for the same reason.  It
is OK to write "int i, j, k;" but "show_header" is something that
keeps track of the more important state during the control flow and
it is easier to read if we make it stand out.  close_file falls into
the same category, I would think.

>  		case commit_error:
> +			if (close_file)
> +				fclose(revs->diffopt.file);

I wondered if we want to also clear, i.e. revs->diffopt.file = NULL, 
but I do not think .close_file does that either, so this is good.

Thanks.
