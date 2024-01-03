Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74A01CA9A
	for <git@vger.kernel.org>; Wed,  3 Jan 2024 19:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dTwnnEAl"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id AF45D1802C;
	Wed,  3 Jan 2024 14:18:55 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=J12deXs19kGx
	0hshIEdpsel5udB10/0nJ8PE5QXcm/Y=; b=dTwnnEAl5SOrLRR/uhEWyo6FRrTR
	18RLsPupHj90ADroTVkedE2F60HZ8zAvuBKSlQYtoSCn8AjQjFujn4fAQH4t2wl3
	Fi2fu9ffIdJSe8CHop1ergnQ9q3mrA860DhK2OVe8ojdDkDVGnMWOxUKRig9zRWC
	zZuBLHUDCz3+MoM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A70DF1802B;
	Wed,  3 Jan 2024 14:18:55 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 554B61802A;
	Wed,  3 Jan 2024 14:18:52 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc: Taylor Blau <me@ttaylorr.com>,  Patrick Steinhardt <ps@pks.im>,  Chandra
 Pratap via GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,
  Chandra Pratap <chandrapratap376@gmail.com>,  Chandra Pratap
 <chandrapratap3519@gmail.com>
Subject: Re: [PATCH v2] write-or-die: make GIT_FLUSH a Boolean environment
 variable
In-Reply-To: <20240103184203.GA4334@tb-raspi4> ("Torsten =?utf-8?Q?B=C3=B6?=
 =?utf-8?Q?gershausen=22's?=
	message of "Wed, 3 Jan 2024 19:42:03 +0100")
References: <pull.1628.git.1703955246308.gitgitgadget@gmail.com>
	<pull.1628.v2.git.1704268708720.gitgitgadget@gmail.com>
	<ZZUZNQqDTx3bnveJ@tanuki> <ZZWWLkY+ixg+OMM4@nand.local>
	<20240103184203.GA4334@tb-raspi4>
Date: Wed, 03 Jan 2024 11:18:50 -0800
Message-ID: <xmqq5y0a9qed.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 EE252772-AA6C-11EE-9B19-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>> -			cp =3D getenv("GIT_FLUSH");
>> -			if (cp)
>> -				skip_stdout_flush =3D (atoi(cp) =3D=3D 0);
>> -			else if ((fstat(fileno(stdout), &st) =3D=3D 0) &&
>> -				 S_ISREG(st.st_mode))
>> -				skip_stdout_flush =3D 1;
>> -			else
>> -				skip_stdout_flush =3D 0;
>> +			skip_stdout_flush =3D git_env_bool("GIT_FLUSH", -1);
>> +			if (skip_stdout_flush < 0) {
>> +				struct stat st;
>> +				if (fstat(fileno(f), &st))
>> +					skip_stdout_flush =3D 0;
>> +				else
>> +					skip_stdout_flush =3D S_ISREG(st.st_mode);
>> +			}
>>  		}
>>  		if (skip_stdout_flush && !ferror(f))
>>  			return;
>> --- >8 ---
>
> Thanks for a nice reading - I can not imagine a better version.

Yup, the flow of the logic feels very natural with this version by
making it clear that the case that the default "-1" is returned to
us is where we need to figure out an appropriate value ourselves.
An added bonus is that the scope "struct stat" has is limited to the
absolute minimum.  I like it, too.

Thanks.
