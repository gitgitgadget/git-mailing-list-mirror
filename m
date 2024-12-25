Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52441B393B
	for <git@vger.kernel.org>; Wed, 25 Dec 2024 18:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735151928; cv=none; b=tv7ynijHbrSZaulR284oQGO+EDc/wJ8+QAWIuXH+TSdtAPzIHEs3Mv10I9zE5QDS4PYuieGVv/smB+raUVbGlXtwM5DBO0WpXWdeRffZRmPP8UXJ779l5l/zu+7FtDeBjXOFJg8c33WboGQDEVPu6HaYitzSzmoYL2Mj5hDILJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735151928; c=relaxed/simple;
	bh=BT3ZlamRjlTQ/Q1prjgXuyg7Xvp7GA+x9fRxobDZtCg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hD4V/K7I+CrkrReb3Sq2QSvbbV5HGeH8IXy9tN4hUpnQwBgR7UJZLz7B0fbNi47ZwuHUbGqkeyQfjtfsZHudC/Yu+Ua/XufSJxD8lP7IwuiuAXXBIk2BN9+V8gSNK2UlmIRGoNSXR+rd+toVDzeYhrOUrkCDqq1Xd7bfEXD6pgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=unZFWshl; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="unZFWshl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1735151921; x=1735756721; i=l.s.r@web.de;
	bh=WhvwdGGVHmi193NooQ/nKPF9sG6V7N0tx6bM2/tX8eo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=unZFWshlGbMjiXRtB0UdHdzvyVHb02wMDqOftiZK9CriDZe0fGAjanK7Bg4q4N/T
	 EjGWZ5xSOR8tJH0/OnO4UrEFL03w2d9GYQsRO/MaQdYmbM9Uz++nH+9fBjJNHjKjm
	 AAWxzVcBYK3jNEa5XdYWsZuI5O3xSC/MIUU/2wF0gggeC9sIPBTJI/JNnJECFDHwK
	 74c2/7OcCj4Fwuzs1x1iixMWnnoAC+k/+aTR+AWzX4KXEDucKMAEQ0idsbESag37b
	 1uZ4y4UV3IJd+LUH/Nl4QCm1Bc2XtE7Sr9WNH1zvdHax03EucLSNZ8wK3KD0bVSf0
	 UPpbV8bcYPMOC0mXqg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.20.45]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MDv9a-1tGeuL0CSi-009x56; Wed, 25
 Dec 2024 19:38:41 +0100
Message-ID: <3ca514b7-63f8-49cb-9816-627d706c6145@web.de>
Date: Wed, 25 Dec 2024 19:38:40 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 3/4] reftable: handle realloc error in parse_names()
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>
References: <2b9fba8d-be63-4145-9d25-a2151e422cfa@web.de>
Content-Language: en-US
In-Reply-To: <2b9fba8d-be63-4145-9d25-a2151e422cfa@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UKfeXkiqWp1TfpRxbfbodlnI3EkOcVKqdqdSVm0tV/ReUBZ5oWx
 hgVpgxgaYKuij3DHKFbpk+IyzxvN4oZdEFDPiVRNYKV2BAh4CWKcjIa1ofl1u4/twJTKzbX
 ZE2jyJar7CV0T1QXSAOnL42Raw7GstDb/OEyk8XWCjeNiDW7EyTBRDpenA9Et17FLXj4rjV
 jvt/1YSD0d7sQRo3g6Yuw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OT/lZ/65q9Y=;cymI3Bzn6C0YTyYX9vwyPCr2beW
 Ag/AAbeDQBqpov551gvKEna5ebtmM0nv5QzQe7WqxhrzduZ0TyJqSLyR9Rix1HJ64m7Y9AcSC
 YXv5MmQLENzmdTIS70KSBs9q+T5N+GgF1VliLzbtyCiqfcZy2b98vXjONuIUitYxzT7aZ7/ms
 V9sLrcNy6ZeeDEN4kDrtTErmyBzmXfmidPD0YOJa1914XGB9kvqTR0nPo6efrD71+kgx8+ljC
 Xcwcdn/jc4I6YVm2zuO3931LGrHHgMlisFYDoLEjFCOMaGCIyUOSPKvU4oBw4GMxh/mnMrrWN
 ZuNHm/pbsjpoVVxdAs23moDoS5Pi8d+3p0Olq+WLF80uVoihqp8qAFG5/aFlc2Au469pJLaHl
 6OMC8SlqnkslqiZQNqnIQDUEw1MXhj4mMqMBWEBdeLsDobdwSmrmmZa7lFtELsUGBHBQisRZz
 zWV7FQ1Ac3UET6pS4PyoHGkEDWZ8gXFsJxteQNxose5EDgweb+uYOu8R7/CRAxs3qWYteCkOR
 kKY5CIi6WHdEDouTAlYhBjU1LvFnjwv80hAcnrsutoi5WwD3OijCyHytZCG1/VsxujKNfDJTc
 CZOjbIYamdqDqbUtHEEh9MLQRciIoYkVCzhHt/Gq4CIs0RmWD4H0ggv7CaUeJQvHkXtCbGSAD
 0xipBn86avDy8gVweJen3cb0zVBotWJlwXxoyPrdt46tIFGzDJkQeomkEWnDgAwpPN+7ofn0b
 AO/NYwnL5ZedTxlSQNayKRrdagc7vxDwlfmPcVq//Z3sKztIuTQt1Q+UXt7dhsDQyFQ1hqaQn
 ZxvPiRZ1/A0NWbz72Bf3smaybKBKKgsRscwAZcTJnpReIfH1CxOHGTM+oazAd1ocZL+TlLa3f
 CLarVxV0r+axmYnh0CbdwDnL36/C0Steu9WCHFJfSP//V3OyC99ep6r804Exk4QfGe58rx4aR
 OFpfDsjVtR0UZfEos0UYLpKKOHA6HI/xjOa6KzU7UXGRFHZdOoL835KMdvArAPKQeDBTFyWuS
 8H7YsTVGUoVgxVuwo1GPGtRcq+cOxFqAlYzGK9YoKgFRi7dyDv+11JlECwr0MMdit4lIfy0mx
 d/OktxbHM=

Check the final reallocation for adding the terminating NULL and handle
it just like those in the loop.  Simply use REFTABLE_ALLOC_GROW instead
of keeping the REFTABLE_REALLOC_ARRAY call and adding code to preserve
the original pointer value around it.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 reftable/basics.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/reftable/basics.c b/reftable/basics.c
index cd6b39dbe9..fe2b83ff83 100644
=2D-- a/reftable/basics.c
+++ b/reftable/basics.c
@@ -241,7 +241,8 @@ char **parse_names(char *buf, int size)
 		p =3D next + 1;
 	}

-	REFTABLE_REALLOC_ARRAY(names, names_len + 1);
+	if (REFTABLE_ALLOC_GROW(names, names_len + 1, names_cap))
+		goto err;
 	names[names_len] =3D NULL;

 	return names;
=2D-
2.47.1
