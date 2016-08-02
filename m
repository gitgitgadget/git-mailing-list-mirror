Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E82821F71B
	for <e@80x24.org>; Tue,  2 Aug 2016 17:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbcHBRl6 (ORCPT <rfc822;e@80x24.org>);
	Tue, 2 Aug 2016 13:41:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58053 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932463AbcHBRi2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2016 13:38:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 86E3B32E7D;
	Tue,  2 Aug 2016 13:38:26 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2uvTdMKceYpUwyTWBG3B7doi4As=; b=gc7DOD
	7n+DuLwmVmu5LzFT32AQEuQM5zZVAyjnux5WzPRks+Q3QPuF9ExLyQHUqJ2Sgad8
	nYZ+RqMAEswRXu20/YSR+mWn46+CaFN3mmpsT/mHBWYeiK6hugXKCX4/hKgD6poK
	wPRc52pFwli9q4AkB693AER7LkPu490R7ekSk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LSQ/548whyCgK7QzLEVib8Z45m+VDuLT
	QQkcJRdGccPj61hLimu083SLHBpFnaCK2dG/1lThofk/ZOxJjwyPN7Gn3pxdpdYm
	hiTFdRuYDia4bGDaxcULPjrdOKTLATFezmT3UMowXLNsI9UudKleXw+BBqeB7v9q
	JMkdatCxNTc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E3EC32E7C;
	Tue,  2 Aug 2016 13:38:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 009FF32E7A;
	Tue,  2 Aug 2016 13:38:25 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Pranit Bauva <pranit.bauva@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: [RFC/PATCH v11 03/13] bisect--helper: `write_terms` shell function in C
References: <0102015640423c26-2060fd70-c90d-4de3-ae8c-1801ad160b1c-000000@eu-west-1.amazonses.com>
	<0102015640423cd0-ae286008-08b7-4ca4-9b2b-f4226aa80a97-000000@eu-west-1.amazonses.com>
Date:	Tue, 02 Aug 2016 10:38:23 -0700
In-Reply-To: <0102015640423cd0-ae286008-08b7-4ca4-9b2b-f4226aa80a97-000000@eu-west-1.amazonses.com>
	(Pranit Bauva's message of "Sun, 31 Jul 2016 09:21:38 +0000")
Message-ID: <xmqq37mnf4vk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EAB1E11E-58D7-11E6-8D0F-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Pranit Bauva <pranit.bauva@gmail.com> writes:

> +static int write_terms(const char *bad, const char *good)
> +{
> +	FILE *fp;
> +	int res;
> +
> +	if (!strcmp(bad, good))
> +		return error(_("please use two different terms"));
> +
> +	if (check_term_format(bad, "bad") || check_term_format(good, "good"))
> +		return -1;
> +
> +	fp = fopen(git_path_bisect_terms(), "w");
> +	if (!fp)
> +		return error_errno(_("could not open the file BISECT_TERMS"));
> +
> +	res = fprintf(fp, "%s\n%s\n", bad, good);
> +	res |= fclose(fp);
> +	return (res < 0) ? -1 : 0;
> +}

If fprintf(3) were a function that returns 0 on success and negative
on error (like fclose(3) is), the pattern to cascade the error
return with "res |= another_call()" is appropriate, but the made me
hiccup a bit while reading it.  It is not wrong per-se and it would
certainly be making it worse if we did something silly like

	res = fprintf(...) < 0 ? -1 : 0;
        res |= fclose(fp);

so I guess what you have is the most succinct way to do this.

