Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BA55466C
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 19:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705690818; cv=none; b=NvZsZzdrTOztCHO9aQGU2Kl6iZ6ZtnoC0getuhsp43xgreF2ttphN1ypfIqBuO2xju4JyR2eD9GJXotMu8cA0+SipgwYsCVwQ/4WcEblZKYbLhD00iz/O2Jd7WKHDfHBq79YJzRIS0PUGz0/DwPDIOTEGIXwHuE8WCDHqlC/bCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705690818; c=relaxed/simple;
	bh=o7Pe4c+Ixna+pCzKtJHH4RqvVy8Lvvf/hOfesK6Y7ek=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=FhN5/dJZTIA0b8QH8S8Nc93wPk0bCitaIUVaZTIZTC6lFjykH/vRX4ABBzmFrutFcyGgjx5fg1TE2ulupIHQMCYwCwIhst2Dl3f/s3DJPXnufb57klVwcX8zhOIDamVRJvGqFGCIUTltyRMFK3CiL4LGt2R22RTM/Z4LjogZMe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 40JIu5BL3319714
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 18:56:06 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>,
        "'Kristoffer Haugsbakk'" <code@khaugsbakk.name>
Cc: "'Patrick Steinhardt'" <ps@pks.im>, <git@vger.kernel.org>,
        <stolee@gmail.com>, "'Eric Sunshine'" <sunshine@sunshineco.com>,
        "'Taylor Blau'" <me@ttaylorr.com>
References: <cover.1697660181.git.code@khaugsbakk.name>	<cover.1705267839.git.code@khaugsbakk.name>	<32e5ec7d866ff8fd26554b325812c6e19cb65126.1705267839.git.code@khaugsbakk.name>	<ZaoUOPsze7rhtT2M@tanuki>	<7f0864ad-c846-42a6-8ddc-85d6be58a4ee@app.fastmail.com> <xmqq34utkw6i.fsf@gitster.g>
In-Reply-To: <xmqq34utkw6i.fsf@gitster.g>
Subject: RE: [PATCH v2 3/4] config: factor out global config file retrieval
Date: Fri, 19 Jan 2024 13:59:55 -0500
Organization: Nexbridge Inc.
Message-ID: <01e901da4b09$b4548dc0$1cfda940$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHnwspgQ8j827465kX8CqClTwQUGAIvIw6sAkDgsE8BWEu88wKC5xHJAd/RsLSwdTVUEA==
Content-Language: en-ca

On Friday, January 19, 2024 1:36 PM, Junio C Hamano wrote:
>"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:
>
>> On Fri, Jan 19, 2024, at 07:18, Patrick Steinhardt wrote:
>>> But second, I think that the new function you introduce here has the
>>> same issue as the old function that you refactored in the preceding
>>> patch: `git_config_global()` isn't very descriptive, and it is also
>>> inconsistent the new `git_config_global_paths()`. I'd propose to =
name
>>> the new function something like `git_config_global_preferred_path()`
>>> or `git_config_global_path()`.
>>
>> The choice of `git_config_global` is mostly motivated by it working
>> the same way as `git_config_system`:
>>
>> ```
>> given_config_source.file =3D git_system_config(); [=E2=80=A6]
>> given_config_source.file =3D git_global_config(); ```
>
>I shared the above understanding with you, so I didn't find the name =
"not very
>descriptive" during my review.  If only we had two more functions that =
can replace
>our uses of repo_git_path(r, "config") and repo_git_path(r, =
"config.worktree") [*] in
>the code, to obtain the path to the repository local and worktree local =
configuration
>files, the convention may have been more obvious.
>
>    Side note: the worktree specific one is messier; there are code
>    paths that use "%s/config.worktree" on gitdir as well---if we
>    were to introduce helpers, we should catch and convert them, too.
>
>> Your suggestion makes sense. But should `git_system_config` be =
renamed
>> as well?
>
>I do not mind including "path" in the names of these functions, but I =
do agree that
>such renaming should be done consistently across the family of =
functions (which
>we currently have only two members, but still).

Is this going to impact the libification effort? I am just curious what =
other on the team think.
--Randall

