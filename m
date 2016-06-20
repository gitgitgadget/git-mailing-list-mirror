Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C3DB2018B
	for <e@80x24.org>; Mon, 20 Jun 2016 19:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbcFTTfs (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 15:35:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52115 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753156AbcFTTfd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 15:35:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 91EA526F83;
	Mon, 20 Jun 2016 15:35:11 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aMWai0Bu66kN8wZ1UJRrSc8A2Og=; b=JITIvK
	YBXhwM7KaiQS1l8QBoMaCkoPVfsRnlWgABZAeXrJWMYx3z1JcNKV3AdLFW/e5SL7
	lRqyqxkjXI0ERj+vFF8FafunGGSDE9o5yEDSCAWjGqDmX2MOtWQHbw9CANGnj5wm
	FJDjX5IZppczeGD9pm2xEihkk/Rbyz0MxiZ3w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UFH1mYrXtbhXvewgdIFPLeNGrbApeAkd
	SYa0z+0to0jdJwmPLJyfVf3xNrrBkVye0L3A6b76/8sI1izlCbL7zuL8+mwmQI1V
	35NoIK5om0RZA5/baWmufm0zEBuF3ykFNwF47a/a0iaOdLnz+8qozg16LTySILIb
	YNH5f9mQ6PA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A67526F82;
	Mon, 20 Jun 2016 15:35:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0D9D426F7F;
	Mon, 20 Jun 2016 15:35:10 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH] Make find_commit_subject() more robust
References: <34ef85eb4e2aef0b342ef5d3bce9e468c8339486.1466255489.git.johannes.schindelin@gmx.de>
Date:	Mon, 20 Jun 2016 12:35:09 -0700
In-Reply-To: <34ef85eb4e2aef0b342ef5d3bce9e468c8339486.1466255489.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Sat, 18 Jun 2016 15:12:17 +0200
	(CEST)")
Message-ID: <xmqqeg7ru00i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1A452F0C-371E-11E6-9E81-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Just like the pretty printing machinery, we should simply ignore empty
> lines at the beginning of the commit messages.
>
> This discrepancy was noticed when an early version of the rebase--helper
> produced commit objects with more than one empty line between the header
> and the commit message.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> Published-As: https://github.com/dscho/git/releases/tag/leading-empty-lines-v1
>
> 	Aaaaand another patch from the rebase--helper front. I guess I'll
> 	call it a day with this one.

Makes sense.  This has a trivial textual conflict with cleanup
patches in flight, I think, but that is not a big problem.  It does
hint that we might want to find a library function that can replace
a hand-rolled while loop we are adding here, though ;-)

Perhaps cast this new behaviour in stone by adding a test?

Thanks.

>  commit.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/commit.c b/commit.c
> index 3f4f371..7b00989 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -415,6 +415,8 @@ int find_commit_subject(const char *commit_buffer, const char **subject)
>  		p++;
>  	if (*p) {
>  		p += 2;
> +		while (*p == '\n')
> +			p++;
>  		for (eol = p; *eol && *eol != '\n'; eol++)
>  			; /* do nothing */
>  	} else
