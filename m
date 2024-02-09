Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC0A107AA
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 22:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707516700; cv=none; b=bpycJa8xWNsLetd4IT76L111kkQ+jA/gF54aVp2bcsg7k+1k/UTh+8n30PLvbvrZJ6YKl5fpiDUqm39J9GfA6mKq5N33erQIvIONsr6Po2hLi9po5TZaShUrF9tCpJAPBRC6yq0ZTtPbsGiLcCoKJm60ZbILEfM7li7vx9q4bRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707516700; c=relaxed/simple;
	bh=AmTh4PJuAaPAEkb/USFiNJZ/fcJYmfgmnv5epT/tuc8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wqfy4790I3Uca2mNaDuvMre1WyY3XQregSgi9DAvoc8VW0t/EwAHVDcrvTUu+LDgWmCMQjK9Yn1WD+hWDis4EOP8wxwpVhvMdWL2euTfZS4mjhydFG0wP87z5FzrDKPN7gclD/yt/OUlHG52TGx9nW+g97oDXE1WF8rTHXxxzu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=dDuF0n9+; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dDuF0n9+"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 583761C50C9;
	Fri,  9 Feb 2024 17:11:37 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=AmTh4PJuAaPA
	Ekb/USFiNJZ/fcJYmfgmnv5epT/tuc8=; b=dDuF0n9+0ozax8WRpNm2B/VA3cu4
	rm4OKZ7PyMyU/pQsmG3XeMXjl5e7Ia/qveXmfqGCb3oYmBNq9yNjwzUQ/nhH2o2q
	vxFdVqEY9smusKMDoVPs23rcKBLxfKfeJliUzWAlqzUFb8aOPp1l7mqNPvHFzQVM
	kYNS2oAU4Hl/5co=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4E65C1C50C6;
	Fri,  9 Feb 2024 17:11:37 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6AB2D1C50C5;
	Fri,  9 Feb 2024 17:11:36 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>,  Chandra Pratap
 <chandrapratap376@gmail.com>,  Chandra Pratap
 <chandrapratap3519@gmail.com>,  Jeff King <peff@peff.net>,  Kyle
 Lippincott <spectral@google.com>,  John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 1/2] receive-pack: use find_commit_header() in
 check_cert_push_options()
In-Reply-To: <ff0db7e3-abce-44ea-a1e3-16e1fdaf4c75@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Fri, 9 Feb 2024 21:36:40 +0100")
References: <ff0db7e3-abce-44ea-a1e3-16e1fdaf4c75@web.de>
Date: Fri, 09 Feb 2024 14:11:35 -0800
Message-ID: <xmqqsf21cmp4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 30E85FF0-C798-11EE-A0EF-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> The string comparison becomes more complicated because we need to check
> for NUL explicitly after comparing the length-limited option, but on th=
e
> flip side we don't need to clean up allocations or track the remaining
> buffer length.

Yeah, the strncmp() followed by the termination check indeed is
trickier but not having to worry about allocation is nice.

>  		if (options_seen > push_options->nr
> -		    || strcmp(option,
> -			      push_options->items[options_seen - 1].string)) {

We used to allocate option[] with NUL termination, but ...

> -			retval =3D 0;
> -			goto leave;
> -		}
> -		free(option);
> +		    || strncmp(push_options->items[options_seen - 1].string,
> +			       option, optionlen)
> +		    || push_options->items[options_seen - 1].string[optionlen])

... now option[] is a borrowed memory, option[optionlen] would have
been NUL if we were allocating.  So to see if the last-seen string[]
is different from option[], we have to see that they match up to
optionlen and the last-seen string[] ends there.  Trickier than
before, but is correct.

> +			return 0;
>  	}
>
>  	if (options_seen !=3D push_options->nr)
>  		retval =3D 0;
>
> -leave:
> -	free(option);
>  	return retval;
>  }
>
> --
> 2.43.0
