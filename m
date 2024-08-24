Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0998F8460
	for <git@vger.kernel.org>; Sat, 24 Aug 2024 08:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724486784; cv=none; b=VkEdDbTqdmnRNJHaG5tgSW4YYYS+9/plI5Cev8Z2Ae1nrWvidg0UtLZIoxhii+F/3O7wZpkt9qVjU3cCAFkh6HElMdVABcC1dIHVoKmlJpov6vnOe40JYIkxyj9G/Sy6NwiBTLEKyGIP6VqlH8KHsteAFdctkdTuQ76ijXv6qJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724486784; c=relaxed/simple;
	bh=El3zJJyh7jERG8V7NY7xvxOKDH45myGr5V359pvUTdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X+xVz5Xq5a8axatKpfO9susVR9ysM2v49L1esXAOAWz3t0CYssG4pYuEVQWrnSmgy1L1I+BSF168n/z92Vjf3mGYZve5hIK8P7PoeVPd2AfPFltcidLkD1NXYr2jK4ZYbbng4Td7VNPzPyIWkRWO4CXqHvvFUmWJ34v4X5TnY7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=ldF01Nyj; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="ldF01Nyj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1724486770; x=1725091570; i=l.s.r@web.de;
	bh=9qM5G41zjgoY2hXgS7flks53mmQYNYHtsk2rQQ6tUS4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ldF01NyjxT9h8YKhaIxeVsitR6an/WatTgOVwbzxI8DM3/FB+DDLbhVHLg0xQeH8
	 fuFgLTHcqHGiYsskCgGXsBQVNsc4dnYVtWDdAoz+0lRzO5bpCdCB5A7sUi9c1zGFw
	 rwlSSGEoU4j44+5zI2QhmBTllXD5ZOohio5OsFgOzhVkpbi6ZA2160BO5b/aSYB2o
	 jepFTfdQBi4DkWplVzgXmo05b4+UrFA4GXAfq8jg0MIX/5jKa4MeAFVNCfmTwMFdB
	 uQz+7H25m5xVqdZClm1dE7sKO8KtGdQJ8PtUt0Zn5grdp9VQd6S9MmAnHKhZdkn4D
	 Pz7uf423ZnUDmEgwUQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.19.117]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MD5o3-1sqKUV2pl3-002Ra7; Sat, 24
 Aug 2024 10:06:10 +0200
Message-ID: <56522704-3023-44a7-ba01-7b0dea6b9bdf@web.de>
Date: Sat, 24 Aug 2024 10:06:10 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] remote: plug memory leaks at early returns
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>
References: <82cb986c-6830-4d9a-bad1-fe4cab6a76eb@web.de>
 <xmqqseuvndsq.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqseuvndsq.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:81rv+GmDefYC3zNoyWcBMyZZ4MIEnP+1n96q3+3Zz0UWtIuJfjo
 X9TjrNEflW7uZTmOOfkHKnabIDO+6ZL+3SlzMd2e0UHtwvE20Nx8m7cqX+8FZBITKV5XzRq
 ez6DbLsCCs3Ci9ncoMYQtEd6qRgtHD/ItGxWLuXCvVS6X410ss1+oNAYBHwS7uDZb62Ctaa
 DOAtbZI2HeOM3IO1oNoyA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uXz1SmkimPk=;Rs826GN7+H1y1VCT/OZX1y5l6GP
 HghghlMju3dg7U85nU9MOKYkW1+4cR2P8QbJNlTpg1mRrq+9yi42ZyOV2Yj9CcmrMoPprTGcv
 Ga8oQyg3xZKB3WOSYkPKHKM9JLemhXFyrsCIRAAM7e6onm21wyz3cGDqRpEUDWv/419UPBszb
 Q5rgdaALfqXmUFfbJiV2Z/dQquriVHQ5FKAWaiSueWI8AKBpWeZYThpsXw/L0R6HCigVyCzWI
 3ROCUEqBfuZQ0fn5Zk5t/Lfg2tv+94DNQZcR73KHjibLC/CxjJ3vnNwdTwcIqV0eiYUw6Ue1Y
 4JDLV1rSKIJcZjljHU5ch5uZ6qR9a3QS41+j2a6+oZTSraLA00iKy8DZcxsB/EwTn6GqUmmf4
 sur8PiskYAbY5Rzz4RR+qfmAcJT5iUPUCFMdrX6MQKpH0UT3Uf7qkgJvlaqkDN70Uz6bHK5j7
 SvoAMNt6YfhcOqZFAMsT3MACxuEbse4Dpg9NvNSz6TZYOaCI7ER11i73i04AzuPEc0gbQnDCa
 2JkfnIra6DBdEaz7PBngU9KZMflRgouu5DOHcmxv0tYQFbXLQfpP3Hl+cDk5V9Et1vAEfug7n
 BQumflol1gG4eWNf/AeT0eCy3odGI7ToczTtZeQtjfZPtOoJU/U0K2gKyU3JeaPkXgchG5iuw
 Q1ZAlM5aPSVrdxinhuvNmdSyy9AMyQJLNH7LQDLocmnGpve/ZPx0qMQBd0KdIsbGGLo/5SyW2
 LzHh4+TzFXryZOCNS1TnNiXO89vtQph0Woq7YT4CovdUG7Y4wGA1z8kRie5SIvSZsD+KRjFa2
 tCRBesc5LuaLPMxMhBEeqtbw==


Am 23.08.24 um 23:13 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>>  builtin/remote.c | 23 +++++++++++++++--------
>>  1 file changed, 15 insertions(+), 8 deletions(-)
>
> Does this allow us to mark any test script as leak-free?

I don't think so -- at least GIT_TEST_PASSING_SANITIZE_LEAK=3Dcheck still
passes for me.

> Will queue in the meantime but may drop it if Patrick says it
> already is covered or something.

OK.

Ren=C3=A9
