Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F251718EB0
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 16:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722962935; cv=none; b=ZmGBymBPdqjZiTugFv6dVTCVpzyeu/Hjk8EN8JOqLy1jf89s6LPDoVSDKnf8RtY5FaYM+M6bFXzUwRg9KAW2aSoRcrmnsK8Q/vWVkNJ8yPK769+2VWLkMpbN7NMamSkVFmpb3s57PooZmymotfoO9rZFOMuIAnCyJgY+2uxS7OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722962935; c=relaxed/simple;
	bh=EjM9YOuNMZ4Fgz11CoytO+tJzJugz7GBp4IOT6hWrZo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GkTEVAtXYA5SLOY9ZrucEES7ThigoJkRF0WssRF0yVipD+MUar4aS+ZGLw6ZlalFBeUyp/YYNt1rRriTN9uuA4c9VxnBlSi0r3Sy3FVP8TVdsQZ+cvJTVo1vnjWUuKGzC+JlvHnbeD3+0Kftd92HrD72khCH77WR5VbNGghZQCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wuHBbpiY; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wuHBbpiY"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6EEA8230A3;
	Tue,  6 Aug 2024 12:48:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=EjM9YOuNMZ4Fgz11CoytO+tJzJugz7GBp4IOT6
	hWrZo=; b=wuHBbpiYyiXKq/9j2H4Prb88DHA7quSREzbOPVXZTVbeJbM1AGEMcz
	KtJpO+eRasLO0EVinfuv1QsxUe89uNnfsMLU9e0PpneGMRpZI6sK3vbf8DfbNnEN
	WfFo4kacZoJTWy9J6NdvSvaDPyqfyTgceF4YJaRnOfzp3MsakKBnI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 67E57230A2;
	Tue,  6 Aug 2024 12:48:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3A40E230A1;
	Tue,  6 Aug 2024 12:48:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v1 1/4] refs: avoid "too many arguments"
In-Reply-To: <ZrG_A3UQk56aYJ_m@tanuki> (Patrick Steinhardt's message of "Tue,
	6 Aug 2024 08:13:23 +0200")
References: <20240806003539.3292562-1-gitster@pobox.com>
	<20240806003539.3292562-2-gitster@pobox.com> <ZrG_A3UQk56aYJ_m@tanuki>
Date: Tue, 06 Aug 2024 09:48:47 -0700
Message-ID: <xmqqed71vbps.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C118F8FC-5413-11EF-9BEA-E92ED1CD468F-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> -	cat >expect <<-EOF &&
>> -	usage: too many arguments
>> -	EOF
>> +	{
>> +		printf "fatal: unknown argument: ${SQ}foo${SQ}\n\n" &&
>> +		( git -C repo refs migrate -h || : )
>> +	} >expect &&
>
> I always have to wonder how helpful it really is to print the usage
> information in such a context. I feel that it is too distracting because
> in many cases, we end up printing dozens of lines of options that drown
> out the single line of information that the user actually cares for,
> namely why the command has failed.
>
> In this case here it is somewhat manageable, because only 4/5th of the
> output are unnecessary noise. But the picture changes as commands grow
> more options over time, making the output less and less usable.
>
> So while I think that it is a big improvement to explicitly point out
> the unknown argument, I think it is step backwards to also print the
> usage info.

Yeah, I somehow was fooled by the original that called a usage()
function ;-).

"usage:" should signal that the message given is a command line to
show the usage, i.e.

$ git grep -E -e '[^_]usage\("' builtin/\*.c
builtin/merge-index.c:		usage("git merge-index [-o] [-q] <merge-program> (-a | [--] [<filename>...])");
builtin/unpack-file.c:		usage("git unpack-file <blob>");

and is not a signal that the message explains what it found
problematic in this particular usage of the command.  builtin/refs.c
being relatively young do not honor the tradition, it seems.

$ git grep -E -e 'usage\(' builtin/refs.c
builtin/refs.c:		usage(_("too many arguments"));
builtin/refs.c:		usage(_("missing --ref-format=<format>"));

I think die(_("...")) would be a lot more appropriate in these two
places, including the one I touched.

Thanks.


