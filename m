Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD88F1FF40
	for <e@80x24.org>; Tue, 21 Jun 2016 18:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752759AbcFUSoK (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 14:44:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55922 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751748AbcFUSoI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 14:44:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EBF7625D98;
	Tue, 21 Jun 2016 14:43:36 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WiD1E5/bhipLkbPG273lTCudBVY=; b=ToU0ds
	+oi0Q0ibhNJkSo5u7h6HwS+eHLLz5hvuwW/a9thf3L/kXoiINtzHlKapTnBSsxxL
	e81MYVIQHByhAnd9p/8XDEWfG/q8w7TyROJ9NWnyx3zpy4kMVPi+Bs2o1msqr45P
	KNjPi4xcSIYpYj87AliDETrsUlqjfKhYcPvXE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t8sLBIYb1FETIr8aot0ANoN29uJs063d
	OM3Yn4f87Sliw06EP3mQH50kj1EhwI/zMnmcd1kB6sl+WELZbjWHHJeaNWv38RCC
	xKKUtBzsGbse8vJ5jSDT51TPYibUkZV0SZllKYgki4ZwAkOlTVfZ+i7DmakJar1P
	J8er7HRWDl4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DF7FB25D96;
	Tue, 21 Jun 2016 14:43:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 60E2825D95;
	Tue, 21 Jun 2016 14:43:36 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 0/2] friendlier handling of overflows in archive-tar
References: <20160616043523.GA13615@sigill.intra.peff.net>
	<20160621161604.GA17638@sigill.intra.peff.net>
Date:	Tue, 21 Jun 2016 11:43:34 -0700
In-Reply-To: <20160621161604.GA17638@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 21 Jun 2016 12:16:04 -0400")
Message-ID: <xmqqtwgmpell.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 101F9702-37E0-11E6-A4DD-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Junio, this is the jk/big-and-old-archive-tar topic.
>
> The interdiff is:
> ...
> diff --git a/archive-tar.c b/archive-tar.c
> index c7b85fd..ed562d4 100644
> --- a/archive-tar.c
> +++ b/archive-tar.c
> @@ -179,7 +179,7 @@ static size_t get_path_prefix(const char *path, size_t pathlen, size_t maxlen)
>  
>  static inline unsigned long ustar_size(uintmax_t size)
>  {
> -	if (size < 077777777777UL)
> +	if (size <= 077777777777UL)
>  		return size;
>  	else
>  		return 0;
> @@ -187,7 +187,7 @@ static inline unsigned long ustar_size(uintmax_t size)
>  
>  static inline unsigned long ustar_mtime(time_t mtime)
>  {
> -	if (mtime < 077777777777UL)
> +	if (mtime <= 077777777777UL)
>  		return mtime;
>  	else
>  		return 0;
> @@ -299,7 +299,7 @@ static int write_tar_entry(struct archiver_args *args,
>  			memcpy(header.linkname, buffer, size);
>  	}
>  
> -	if (ustar_size(size) != size)
> +	if (S_ISREG(mode) && ustar_size(size) != size)
>  		strbuf_append_ext_header_uint(&ext_header, "size", size);
>  	if (ustar_mtime(args->time) != args->time)
>  		strbuf_append_ext_header_uint(&ext_header, "mtime", args->time);

Thanks.

By the way, I realized the naming mistake and the topic branch is
now named s/old/future/.  Size being big is one condition that needs
this fix, so is timestamp being from far future, not "old".
