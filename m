Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FED1549B
	for <git@vger.kernel.org>; Tue,  2 Jan 2024 16:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="V4BA82bJ"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4058E2E7E3;
	Tue,  2 Jan 2024 11:29:18 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ozIUAy/G4BT+
	FM2Um77kJIeQaLObvM+4kYZ4GA2Am+0=; b=V4BA82bJHFUH+fp3AfvGghv4BoKE
	z2dRHq04OLW/cDUYleGuF76gRmsIwhktaj7ODDsR+qjUPpI7dpygOH8T2l2ZnGM0
	or3dD7T2LT6qIcl6R9BoSkLA0pV8TCBMS8CzVORGXiaaxRKHRDhC8CW/PDSj1Fnb
	1rHS4timXDP6iDc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 38A5F2E7E2;
	Tue,  2 Jan 2024 11:29:18 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D85302E7E0;
	Tue,  2 Jan 2024 11:29:14 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc: Chandra Pratap via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Chandra Pratap <chandrapratap376@gmail.com>,
  Chandra Pratap <chandrapratap3519@gmail.com>
Subject: Re: [PATCH] write-or-die: make GIT_FLUSH a Boolean environment
 variable
In-Reply-To: <20240101082446.GA21905@tb-raspi4> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?=
	message of "Mon, 1 Jan 2024 09:24:46 +0100")
References: <pull.1628.git.1703955246308.gitgitgadget@gmail.com>
	<20240101082446.GA21905@tb-raspi4>
Date: Tue, 02 Jan 2024 08:29:13 -0800
Message-ID: <xmqqil4bg0me.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 117D5424-A98C-11EE-8843-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>> -	char *cp;
>> +	int cp;
>>
>>  	if (f =3D=3D stdout) {
>>  		if (skip_stdout_flush < 0) {
>> -			/* NEEDSWORK: make this a normal Boolean */
>> -			cp =3D getenv("GIT_FLUSH");
>> -			if (cp)
>> -				skip_stdout_flush =3D (atoi(cp) =3D=3D 0);
>> +			cp =3D git_env_bool("GIT_FLUSH", -1);
>> +			if (cp >=3D 0)
>> +				skip_stdout_flush =3D (cp =3D=3D 0);
>>  			else if ((fstat(fileno(stdout), &st) =3D=3D 0) &&
>>  				 S_ISREG(st.st_mode))
>>  				skip_stdout_flush =3D 1;
>
> I think that the "cp" variable could be renamed,
> cp is not a "char pointer" any more.

Absolutely.  Very good point.

> However, using the logic from git_env_bool(), it can go away anyway,
> wouldn't it ?

True.

If we are doing clean-ups in this area, we may want to also stop
doing "=3D=3D 0" comparisons on lines the patch touches while at it.

>   diff --git a/write-or-die.c b/write-or-die.c
>   index 42a2dc73cd..01b042bf12 100644
>   --- a/write-or-die.c
>   +++ b/write-or-die.c
>   @@ -13,21 +13,21 @@
>     * more. So we just ignore that case instead (and hope we get
>     * the right error code on the flush).
>     *
>   + * The flushing can be skipped like this:
>   + * GIT_FLUSH=3D0 git-rev-list HEAD
>   + *
>     * If the file handle is stdout, and stdout is a file, then skip the
>   - * flush entirely since it's not needed.
>   + * flush as well since it's not needed.
>     */
>    void maybe_flush_or_die(FILE *f, const char *desc)
>    {
>           static int skip_stdout_flush =3D -1;
>           struct stat st;
>   -       char *cp;
>
>           if (f =3D=3D stdout) {
>                   if (skip_stdout_flush < 0) {
>   -                       /* NEEDSWORK: make this a normal Boolean */
>   -                       cp =3D getenv("GIT_FLUSH");
>   -                       if (cp)
>   -                               skip_stdout_flush =3D (atoi(cp) =3D=3D=
 0);
>   +                       if (git_env_bool("GIT_FLUSH", -1) =3D=3D 0)
>   +                               skip_stdout_flush =3D 1;
>                           else if ((fstat(fileno(stdout), &st) =3D=3D 0=
) &&
>                                    S_ISREG(st.st_mode))
>                                   skip_stdout_flush =3D 1;
