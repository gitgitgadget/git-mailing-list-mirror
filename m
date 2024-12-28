Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5AD433A4
	for <git@vger.kernel.org>; Sat, 28 Dec 2024 09:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735379340; cv=none; b=aDogWw1d30LBi+xP4uz86X0nHn5hKMniiQMVRKOtnhdE82q+yvgCRPBCswg3nz1f0t/OOvBZgpHg18FiuWlDlwXtJTbJWnT1JtK3VyhwCe4ZAOnQTdAzHXPbDr5fJOqeCfg/8fvz8cvtclsVGJd1tGKvcC+kc+Sk/TMdAIaha9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735379340; c=relaxed/simple;
	bh=BT3ZlamRjlTQ/Q1prjgXuyg7Xvp7GA+x9fRxobDZtCg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GBkdQOSRyAwWF6APKW+NYwBzHCkxcgzgIkDY7hLuV0QQ/wZyxAJHQq8YrH4ZkmwjfGWu901Opbvhofxe+Hp4tKMQ4TJNB8dn+xItJTz+sF56YjjnURxP2bzshEV8G1Xj5fUl3xLpdE5oZUTzfEylqmxZHzcuxEnE5usWMl+C04s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=MFRNmCQa; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="MFRNmCQa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1735379331; x=1735984131; i=l.s.r@web.de;
	bh=WhvwdGGVHmi193NooQ/nKPF9sG6V7N0tx6bM2/tX8eo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MFRNmCQaHubKcasyaVFRTTcavo5xhnAQLvu9IuC/l+h+lJSR6jDun+Psx6u/UybC
	 YQJyWa8lxoNj/L9doxhHcRALGrt+S+ZB/alPrI4DbeUUUfF3wyfavyzOKnKnfQVAP
	 6MQqPEDPs243HR/m+eNmbMBb+9V1HZVtnr+q1FPynAmSws38+jAAB1BfpLGkGepWP
	 oMfsewQIqR0xlENn+/TfRaVKJ0Dz3iQpCvriOGsHY/VwByGuMuYIlLPQlpgKVDxsp
	 LK9Bwejpemf/0g5guswAZw4HnhWVSyg/n3pmC47PmHc1siNygnzBPVBi2kw81UFcl
	 oUC3xfYMTxa0p3/ZZA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.20.45]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MDvDU-1tHc5G3g6W-00GNOc; Sat, 28
 Dec 2024 10:48:50 +0100
Message-ID: <c2cd277b-ba9d-41cb-b9bd-c519b445d179@web.de>
Date: Sat, 28 Dec 2024 10:48:50 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 3/4] reftable: handle realloc error in parse_names()
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
References: <2b9fba8d-be63-4145-9d25-a2151e422cfa@web.de>
 <f4677194-0a3a-4f07-b003-c0295b51c100@web.de>
Content-Language: en-US
In-Reply-To: <f4677194-0a3a-4f07-b003-c0295b51c100@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VLBu1z+BAJZ40YVt8rFIkBraaZFSMIMUOEwL2PKqdwuGraz1oN5
 AninCvoSvITlIub9Oo0sdbMURLvWBnFeu02ZjGE2dwA0LjLuizXzmN4QuRb5Q0bWpu4B5NN
 jVoyWoyjTWgyi4AT+QqfM+hGFv+dtl6QkMRY86t8VLajQ9s3PhCjw9v2bhku5iaF5eyFqwt
 /Mj9jjmG6qZ81SdELBA1A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yGmUcUL069Q=;AF1zzZDLlw2dF/vIXQ9oEQgmG7J
 qqEvUJ9IgY3HvfEj6SosQgQ5TFX22nZ7p0nEBmyd5S7XcZO4UlgXnKv8xwArbiYtG3pfXE19g
 Z5n+gt6A5WGNnMhzJjiQ6lNzERlYGKOdL/bVLQ7zFVXRudf2ic20hu0Qe5zsM+x9M/Ehi6eDy
 LgAwNojfeawV0HbZK66IIywQwdgfdIThaIpba68amDfDqfqZRlo/4f7wxfuGOJv563p1uRHsZ
 UpXL96n/9We7Xwh6N/udVc3lHpIXEEJyaH2BveAeUiw5YLhWXY6U195RmOz1r0lTANW/A/CQo
 HbIKG4F1fwba10sNm36vkEAUGqPLruLltAIw0wTpUsrCaMI0npFBwFSoxJOcoiU4rX8d90X2q
 OhC3cGED1qTK3WxVR/URzfvJQR2DjMwABy2XvMxjHY9dTWVjOyqkAOPwlhZNH44MqSHi7Ztyl
 tFZXUwdLrAcJbrFuWckxVnvIQo09tr6cM2oEp2qme3Us+otqlIcwKbd9K77sAXv+fqIkzTCgw
 Oauoo3du5dsVBxQ4WbrlRTctrn0BigeRdER1pYO2Vl1vN8AH3D265IB0hyEmtwo4q/HUbY/Fa
 7ogU0nR9enT3vmoY4a1pfxuW+hPZgweaHk0CTjPgJQyuBr8tVXoaOW+a1FoP7AfSUw3+lndCc
 c3NsF3RWgxJ7dZtxRXQ1hYkUb417e1d6Oulote/o6Qj3IeE+vJ6ZX0IeOtITTy4147t/Q4DFe
 9jctYegxOFgHcsxTxyzqy7imBWRHlDyG1hERdY1TvEsRTxSCR5c7fF+Ouu4WJDH23KWVvn5wO
 Th9UXg227GESRIuBbwa+c1LUFDStSIgheORgZpMngmBkXlPusisakce15jkmXRlRdozJ62yaj
 6lTUancEARzNVwIWyRWDvkQnnTr+RSw5+EEhwV91OzTAfHcIMdyw1s9Yvg51pV4+kX1FTSxJj
 i7ghwyE5BuO3yPFAKS8HSqKbjgYmBD9uptya45YPcGz4e9BvsapSaIJkoYBPZlse0WmSMt6CL
 hKQd8reR3PGvfCgZeTHADooYCdlxePWEaDMZa98qqODu9eWYZvxZbnYSoJa+RzSZilK7rCEfs
 2NyS9uAvk=

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
