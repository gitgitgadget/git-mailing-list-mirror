Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A62186E33
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 15:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719415169; cv=none; b=KCT4w40k7PfYtPPGF1t2ddl9o9yN5JRaoS7PId/8t/9gZ+5y9EZH4QrKjm2NxAiX/D3fw8ThQmBtMzOS94Xd0typLU2Dxomrd3fZfL6NPnprwNrr+7+OcJjngk2+Nb8kEOuNEP4mZ9LX7hNpHgnYVTHxyth5bWWeSChOiwBfJXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719415169; c=relaxed/simple;
	bh=2a5uveSszJY8GdGpfZ0LqjZcTrbWcOKt6/rs/3IrdvU=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=orP1WEAuUEsNEXYiYamQLlDJb1cs/HCvyDPwl6CvR8SRsoPON2+HWXHwoRKoBk8srplRl9R6LBTcBNXIfGk5R0Iu0uDkwo7p4W8vKEBVMN1IBRbYVz3P++dmtNjTz5pbH4+hL0yYcqFPEcl7EiosIsucZH/TribndCkrw6kHVAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 45QFJ9xQ895961
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 15:19:10 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: <phillip.wood@dunelm.org.uk>, "'Florian Schmaus'" <flo@geekplace.eu>,
        <git@vger.kernel.org>
Cc: "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
        "'Junio C Hamano'" <gitster@pobox.com>
References: <20240626123358.420292-1-flo@geekplace.eu> <20240626123358.420292-2-flo@geekplace.eu> <9e5b0cc6-e28c-4c51-ab48-663c61c00ee3@gmail.com>
In-Reply-To: <9e5b0cc6-e28c-4c51-ab48-663c61c00ee3@gmail.com>
Subject: RE: [PATCH] setup: support GIT_IGNORE_INSECURE_OWNER environment variable
Date: Wed, 26 Jun 2024 11:19:04 -0400
Organization: Nexbridge Inc.
Message-ID: <046501dac7dc$31d92d60$958b8820$@nexbridge.com>
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
Thread-Index: AQINMK9UPLksDTnp42ww34gnLmqCxQIlmLauAdh5/C6xVWRX0A==
Content-Language: en-ca

On Wednesday, June 26, 2024 9:12 AM, Phillip Wood wrote:
>On 26/06/2024 13:33, Florian Schmaus wrote:
>> Sometimes more flexibility to disable/ignore the ownership check,
>> besides the safe.directory configuration option, is required.
>>
>> For example, git-daemon running as nobody user, which typically has =
no
>> home directory. Therefore, we can not add the path to a user-global
>> configuration and adding the path to the system-wide configuration
>> could have negative security implications.
>>
>> Therefore, make the check configurable via an environment variable.
>
>An alternative would be to allow safe.directory to be specified on the =
command line
>with "git -c safe.directory=3D'*' daemon ..." rather than adding a =
dedicated
>environment variable. Or you could set $HOME to a suitable directory =
when
>running "git daemon" and put the user-global config file there. That =
directory and
>config file only need to be readable by the user that "git daemon" is =
running under it
>can be owned by root or whoever else you want.

I agree with this alternative. Our CI build environment already has so =
many environment variables (not just from git but all dependencies and =
the CI environment itself) that we are pushing the 56Kb platform limit =
(not kidding). Reducing dependence on environment variables is, in my =
opinion, a good and necessary thing.

>> If the environment variable GIT_IGNORE_INSECURE_OWNER is set to true,
>> then ignore potentially insecure ownership of git-related path
>> components.
>>
>> Signed-off-by: Florian Schmaus <flo@geekplace.eu>
>> ---
>>   setup.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/setup.c b/setup.c
>> index 3afa6fb09b28..da3f504fb536 100644
>> --- a/setup.c
>> +++ b/setup.c
>> @@ -1278,6 +1278,14 @@ static int ensure_valid_ownership(const char =
*gitfile,
>>   	 */
>>   	git_protected_config(safe_directory_cb, &data);
>>
>> +	if (data.is_safe)
>> +		return data.is_safe;
>> +
>> +	if (git_env_bool("GIT_IGNORE_INSECURE_OWNER", 0)) {
>> +		warning("ignoring dubious ownership in repository at '%s'
>(GIT_IGNORE_INSECURE_OWNER set)", data.path);
>> +		return 1;
>> +	}
>> +
>>   	return data.is_safe;
>>   }
>>

Sincerely
--Randall

