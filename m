Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCB3748D
	for <git@vger.kernel.org>; Sun, 25 Feb 2024 17:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708881898; cv=none; b=U2WqHenmEr7TjLKDJc6m+iJOzMB+YgdKzE/N4GDdkPIyhO9rotKDoaMHXQomhDspLLT1jcZJ4SQURQVLIeb6bYyl0cdIac0QtP4Y/lKzFfLlwBAiJJcu1XWGyOVgI54qf6ahJzaEKFc6BYzvs7qosF7WDT78S17s8bkpBj10/lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708881898; c=relaxed/simple;
	bh=iqbfW+BkbXezsLR0OkQJ5N0bL7iwVazOykvrRH8QtcI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mQsQGI8GjnRLnCdYW1f6Z/OC2mclMjshIXHiZlcD8GUhgagYh/6tubo2pEfoc/pe9BNVeUwZ1OIMKcBTijghj++lFSktgLB4bXc1L8GTWSN9vEwkhv8Rqbd0V3nsgB/zp9OXCdIcWVI01SM5FL8wxhILg6/hZiPdLb2uB88I3ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=cmyI3g5P; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cmyI3g5P"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C53F91EF33F;
	Sun, 25 Feb 2024 12:24:55 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=iqbfW+BkbXez
	sLR0OkQJ5N0bL7iwVazOykvrRH8QtcI=; b=cmyI3g5PbT3r/4VF+p3viEJej4Yu
	4hH+iWbqLqVBlP8IAQNfva+hJFAnQ6eOotBQdWwMbhQQzGjhpRPkYH1tGaIclbAv
	lp8afaOCyzYQD45K3zd7nHFz1cygtMZa14Ai1FPBwfoihmQ3R0HBkP69eeH2HkAl
	KfmiyBwO4EMheaI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BCDF71EF33E;
	Sun, 25 Feb 2024 12:24:55 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 30CA11EF33D;
	Sun, 25 Feb 2024 12:24:55 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc: Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Jeff Hostetler
 <git@jeffhostetler.com>,  Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH v2 06/16] fsmonitor: refactor refresh callback for
 non-directory events
In-Reply-To: <20240225123050.GA1952@tb-raspi4> ("Torsten =?utf-8?Q?B=C3=B6?=
 =?utf-8?Q?gershausen=22's?=
	message of "Sun, 25 Feb 2024 13:30:51 +0100")
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
	<pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
	<7ee6ca1aefd34a37d749300e317df10d80ef2b29.1708658300.git.gitgitgadget@gmail.com>
	<20240225123050.GA1952@tb-raspi4>
Date: Sun, 25 Feb 2024 09:24:54 -0800
Message-ID: <xmqq4jdwjw2h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 CAC847AE-D402-11EE-A3BA-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>> +		pos =3D -pos - 1;
>> +
>> +		for (i =3D pos; i < istate->cache_nr; i++) {
>> +			if (!starts_with(istate->cache[i]->name, name))
>> +				break;
>> +			if ((unsigned char)istate->cache[i]->name[len] > '/')
>> +				break;
>
> Hm, this covers all digits, letters, :;<=3D>?
> but not e.g. !+-. (and others). What do i miss ?

This is scanning an in-core array of cache entries, which is sorted
by name in lexicographic order, and the loop knows that files under
the directory "foo", whose pathnames all share prefix "foo/", would
sort between "foo.h" and "foo00", because "." sorts before "/" and
"0" sorts after "/".

It is trying to find where in the array a hypothetical directory
would appear, if any of the files in it existed in the array, and
exiting early, taking advantage of the fact that after seeing
something that sorts after a '/', it will never see an entry that
shares cache[i]->name[] as a prefix.

It is not a new code in the patch, of course; merely got moved from
elsewhere below.

>> -		/*
>> -		 * The path is not a tracked file -or- it is a
>> -		 * directory event on a platform that cannot
>> -		 * distinguish between file and directory events in
>> -		 * the event handler, such as Windows.
>> -		 *
>> -		 * Scan as if it is a directory and invalidate the
>> -		 * cone under it.  (But remember to ignore items
>> -		 * between "name" and "name/", such as "name-" and
>> -		 * "name.".
>> -		 */
>> -		pos =3D -pos - 1;
>> -
>> -		for (i =3D pos; i < istate->cache_nr; i++) {
>> -			if (!starts_with(istate->cache[i]->name, name))
>> -				break;
>> -			if ((unsigned char)istate->cache[i]->name[len] > '/')
>> -				break;
>> -			if (istate->cache[i]->name[len] =3D=3D '/')
>> -				istate->cache[i]->ce_flags &=3D ~CE_FSMONITOR_VALID;
>> -		}
>> +		handle_path_without_trailing_slash(istate, name, pos);
>>  	}
>>
>>  	/*
>> --
>> gitgitgadget
>>
>>
