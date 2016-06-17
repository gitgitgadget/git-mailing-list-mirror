Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E2821FEAA
	for <e@80x24.org>; Fri, 17 Jun 2016 21:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755571AbcFQVyc (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 17:54:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51798 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752644AbcFQVyb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Jun 2016 17:54:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D05A425EE6;
	Fri, 17 Jun 2016 17:54:29 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=X88ryFQTYVa2
	/WJUhGiuxT1/Fac=; b=ClB/qV+Ju8pvZmRZiKA8z9H7ph2qzFP2zLP7JM9wc9A2
	umxmEuAkFzZLLkpYiIDM/VbxcbY/6PPtMetLiuL9WBtdOYeR9Ss23gbrWKcQ/PRR
	5IvlBiTdb5XtQ5K073+KdYiO3R/37RSYbLSdU/ShluUNza66BLyltGQUVRLB3Bs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=NnYxGA
	3ptVvZ9dyYqBU1RRq8KN68f77u/gsIUsny8CgY9s4vyVgXlSu/D/X4G14idWsgOY
	aZGovIK4GNvMToPFuhgVFDx4UrCfko9AQE4lEYgo3rSGndXAvn7WDifgouIaMxjB
	IYykZhmABqTdxT5kx2mf0G1dKGriWcYBsC5n8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C5AFD25EE5;
	Fri, 17 Jun 2016 17:54:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4A7DF25EE3;
	Fri, 17 Jun 2016 17:54:29 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH v6 01/11] grep: allow -F -i combination
References: <1453982183-24124-1-git-send-email-pclouds@gmail.com>
	<1454724190-14063-1-git-send-email-pclouds@gmail.com>
	<1454724190-14063-2-git-send-email-pclouds@gmail.com>
Date:	Fri, 17 Jun 2016 14:54:27 -0700
In-Reply-To: <1454724190-14063-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 6 Feb
 2016 09:03:00 +0700")
Message-ID: <xmqqk2hnzdkc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 10F96D9A-34D6-11E6-BCB9-89D312518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> -F means "no regex", not "case sensitive" so it should not override -i

That logic is flawed, isn't it?

"-F" means "no regex", so it should not touch opt.regflags at all.

> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  builtin/grep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 5526fd7..4be0df5 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -809,7 +809,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>  
>  	if (!opt.pattern_list)
>  		die(_("no pattern given."));
> -	if (!opt.fixed && opt.ignore_case)
> +	if (opt.ignore_case)
>  		opt.regflags |= REG_ICASE;
>  
>  	compile_grep_patterns(&opt);

In grep.c, we do this:

static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
{
	int err;

	p->word_regexp = opt->word_regexp;
	p->ignore_case = opt->ignore_case;

	if (opt->fixed || is_fixed(p->pattern, p->patternlen))
		p->fixed = 1;
	else
		p->fixed = 0;

	if (p->fixed) {
		if (opt->regflags & REG_ICASE || p->ignore_case)
			p->kws = kwsalloc(tolower_trans_tbl);
		else

It is possible that your later changes _depend_ on having REG_ICASE
set in opt->regflags, but if that is why this commit is needed, then
you are going in a wrong direction.

I liked the overall objective of making "-i" work better on
non-ASCII, and I wanted to like this whole series, but at least this
change needs to be dropped (and the remainder of the series fixed if
they depend on this change).

Thanks.
