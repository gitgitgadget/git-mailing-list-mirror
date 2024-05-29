Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80C915B0E6
	for <git@vger.kernel.org>; Wed, 29 May 2024 22:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717021336; cv=none; b=LiO+e03EQBbnk0rP/mMEBDEKVCGC05k+c1Z1335HR8Y4EDUpbL11g2BuObqVKj80jAdhycinKyAi1KeRP04UUikic0XN/X5gyaOJkfSLplXvbD2eiLqcxAuOmu3fTAVVd2JuXdxdj/ZImql5Za2su7E0NxvC6J4weqKF42HRpoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717021336; c=relaxed/simple;
	bh=ooq0RUYHwYVWCBP2+JqEL71WXFk6h0+Rz49MSd5xSxU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iL7W9ibzWT2cx85pMTRfE6Fc4J9P0E7E7klqPcwZqwpvftuorcMM3q66U5cjbVLVAnhCl3qnkWa2NRaduu57FV2UX7u+kJBVJen2greNMWxef45j+HUgv4HHKChor/eGjpclOFnlJkUdGHq1lAcJHPYS+0pWFPDTll+SiRgzQs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xYWJdYGu; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xYWJdYGu"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 2517033F0C;
	Wed, 29 May 2024 18:22:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ooq0RUYHwYVWCBP2+JqEL71WXFk6h0+Rz49MSd
	5xSxU=; b=xYWJdYGu+0krH4Yi0tfDuCY81MLz8efNXLXy7SLHifrfNpzUanDn/9
	HYVEkdjLAZfrUtx8S90EqsJoJ32HtyZvzpMj3lGc2O1E3XqpWuaiJN1tb124JpcR
	DThUQsnAvAJhLfweW9b74pVtzpLB7PZm/UEl32mVLbGUbmOa8hvoQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1DBF633F0B;
	Wed, 29 May 2024 18:22:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2587B33F0A;
	Wed, 29 May 2024 18:22:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Kevin Day <toasty@dragondata.com>
Cc: git@vger.kernel.org
Subject: Re: Commands using -h as an option don't work consistently
In-Reply-To: <52819526-4C6F-418C-8B8B-A4D5C7E371EA@dragondata.com> (Kevin
	Day's message of "Wed, 29 May 2024 17:03:04 -0500")
References: <52819526-4C6F-418C-8B8B-A4D5C7E371EA@dragondata.com>
Date: Wed, 29 May 2024 15:22:09 -0700
Message-ID: <xmqqfru0tg1a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E4AA5594-1E09-11EF-BBDA-8F8B087618E4-77302942!pb-smtp21.pobox.com

Kevin Day <toasty@dragondata.com> writes:

> Because of a bug in parse-options.c, any command that has a '-h' option will sometimes display the usage page instead of executing. For example, ls-remote has two options:
>
>     -t, --[no-]tags       limit to tags
>     -h, --[no-]heads      limit to heads
>
> git ls-remote --heads  #works
> git ls-remote --tags  #works
> git ls-remote -t  #works
> git ls-remote -t -h  #works
> git ls-remote -h  #shows the help page
>
> This is because of these lines in parse-options.c:
>
> /* lone -h asks for help */
> if (internal_help && ctx->total == 1 && !strcmp(arg + 1, "h"))
> goto show_usage;
>
> This is being executed before it looks to see if there actually is a -h option.

This is very much deliberate design.  I think in these cases we make
an unambiguous longhand (e.g. "--heads" we see above) available, or
you can explicitly say the remote, i.e. "git ls-remote -h origin",
and that has been the officially accepted "solution".

Let's see what improvements you bring to the table.

> The options I see:
>
> 1) Fix -h handling and add ignores and fixes where possible to the
> failing tests and try to not use -h as an option for anything new.

I do not quite understand the former half, but "try not to use -h
for new things" is a very good idea and it is pretty much what we
have been doing.

    Note: There however is a scenario where we cannot avoid it---if
    we were trying to match/mimick some established external
    command, we may have to use the same "-h" as they use (e.g.,
    "git grep -h -e ..." tries to mimick "grep -h -e ...").  Even in
    that case, because "git grep -h" alone would not make any sense
    without any pattern, the command behaves very sensibly, by the
    way.

> 2) Change -h to -H or something, but this breaks backwards compatibility

As you said it yourself, this is a non starter.

> 3) Fix it so that -h works if a command uses it, and additionally
> make a new global option -? or --usage or something that always
> shows the usage page and change tests to use that, while leaving
> -h sometimes showing usage and sometimes executing the option to
> preserve as much backward compatibility as possible.

Reading this and then going back to the ls-remote examples you gave
earlier, I do not think the current behaviour is all that bad,
relative to what is being proposed, except for an explicit support
for "-?".

We can certainly add support for "-?", but the behaviour when "-?"
is not used (and when "-h" is used) would not have to change from
the current behaviour, and that would still be serviceable, I
presume?

We actually do not have to *add* support for "-?", as it comes with
parse-options for free ;-)

    $ git ls-remote -\?
    error: unknown switch '?'
    usage: git ls-remote ...
	... the same "ls-remote -h" output given here ...

So, I dunno.
