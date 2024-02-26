Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E22130AEE
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 23:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708988543; cv=none; b=MnsQLenDMKb82kwkzjp7Zka6w3T1YyL1BFT6d45o1HLYV1m0tBXVtF/3z2FtLsa5IK0GeeEjyz7ok2fmIKDk+MO3xY+GmqMjPorSZ7KhIKxErknDpKhYIIKAxCkfrwRFeApVsAxD9Fmb9oDzf4y6lLlURH0MHDJgemEc/yjrhO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708988543; c=relaxed/simple;
	bh=YaOmEUCsSsTWZwYulcHg4I6Q+rkHsWeVrJuL+lJaWjE=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=VMFWQjnm1Uy/cFr9AnWHv1jix+W09fMQmRjQwN+0KqkyAIhAdGklnMwEyWn1yRyMlapv1zDJtJbiJ7S6TtuCsfkgI27c5oKc30c7gdGNTFEfA5revDzj0A2IMooGylEsj2FD1cQsMEeEI6wmLsMIzsOL6F4DUcrslFISaGGjaa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 41QN2IXI2233494
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 23:02:18 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Randall S. Becker'" <the.n.e.key@gmail.com>, <git@vger.kernel.org>
References: <20240226220539.3494-1-randall.becker@nexbridge.ca> <20240226220539.3494-3-randall.becker@nexbridge.ca>
In-Reply-To: <20240226220539.3494-3-randall.becker@nexbridge.ca>
Subject: RE: [PATCH v1 2/4] builtin/receive-pack.c: change xwrite to write_in_full to allow large sizes.
Date: Mon, 26 Feb 2024 18:02:13 -0500
Organization: Nexbridge Inc.
Message-ID: <026c01da6907$d93297b0$8b97c710$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQFCEXZVVjijNd8r2UxZXOALnJerBgFnNa3tskKy2ZA=

On Monday, February 26, 2024 5:06 PM, I wrote:
>From: "Randall S. Becker" <rsbecker@nexbridge.com>
>
>This change is required because some platforms do not support file writes
of arbitrary sizes (e.g, NonStop). xwrite ends up truncating
>the output to the maximum single I/O size possible for the destination
device.
>
>Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
>---
> builtin/receive-pack.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>
>diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c index
db65607485..5064f3d300 100644
>--- a/builtin/receive-pack.c
>+++ b/builtin/receive-pack.c
>@@ -455,8 +455,9 @@ static void report_message(const char *prefix, const
char *err, va_list params)
>
> 	if (use_sideband)
> 		send_sideband(1, 2, msg, sz, use_sideband);
>-	else
>-		xwrite(2, msg, sz);
>+	else {
>+		write_in_full(2, msg, sz);
>+	}
> }
>
> __attribute__((format (printf, 1, 2)))
>--
>2.42.1

This needs to be fixed, so the {} after the else is removed. Will be in v2.

