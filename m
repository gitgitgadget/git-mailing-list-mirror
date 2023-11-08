Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971336AB6
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 08:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WbR9QnL3"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00257192
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 00:01:07 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 866D6212E5;
	Wed,  8 Nov 2023 03:01:07 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=HdNofpsg7clcsoqSfEbO3Yjyr2QGfe3nmKNr3c
	nMLZ0=; b=WbR9QnL3vhftsgWYnvEGNjRbytiPp+2HKbTcMNVOcVFpPRfXEo2d2k
	S8wZ7JP8zcOgxV9/AWv30MQFSTSHX9Wl5s/7bScgyRpcLmru+nxAPd7yVMxPl1VO
	0kofH55pTCyl/QCndeklY+OJbr/eKF9a10IzBQTuBt7FyNn+SUy2M=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7EEE4212E4;
	Wed,  8 Nov 2023 03:01:07 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 160D7212DF;
	Wed,  8 Nov 2023 03:01:04 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/3] t/lib-httpd: stop using legacy crypt(3) for
 authentication
In-Reply-To: <23835763002c5f5cd68db7bdc9e4c083dda3558f.1699428122.git.ps@pks.im>
	(Patrick Steinhardt's message of "Wed, 8 Nov 2023 08:30:01 +0100")
References: <cover.1699428122.git.ps@pks.im>
	<23835763002c5f5cd68db7bdc9e4c083dda3558f.1699428122.git.ps@pks.im>
Date: Wed, 08 Nov 2023 17:01:02 +0900
Message-ID: <xmqq8r787jy9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F6D72992-7E0C-11EE-A0EC-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> When setting up httpd for our tests, we also install a passwd and
> proxy-passwd file that contain the test user's credentials. These
> credentials currently use crypt(3) as the password encryption schema.
>
> This schema can be considered deprecated nowadays as it is not safe
> anymore. Quoting Apache httpd's documentation [1]:
>
>> Unix only. Uses the traditional Unix crypt(3) function with a
>> randomly-generated 32-bit salt (only 12 bits used) and the first 8
>> characters of the password. Insecure.
>
> This is starting to cause issues in modern Linux distributions. glibc
> has deprecated its libcrypt library that used to provide crypt(3) in
> favor of the libxcrypt library. This newer replacement provides a
> compile time switch to disable insecure password encryption schemata,
> which causes crypt(3) to always return `EINVAL`. The end result is that
> httpd tests that exercise authentication will fail on distros that use
> libxcrypt without these insecure encryption schematas.
>
> Regenerate the passwd files to instead use the default password
> encryption schema, which is md5. While it feels kind of funny that an
> MD5-based encryption schema should be more secure than anything else, it
> is the current default and supported by all platforms. Furthermore, it
> really doesn't matter all that much given that these files are only used
> for testing purposes anyway.

This step makes quite a lot of sense, as we are changing this not at
all for security but for portability ;-)

>
> [1]: https://httpd.apache.org/docs/2.4/misc/password_encryptions.html
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/lib-httpd/passwd       | 2 +-
>  t/lib-httpd/proxy-passwd | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/lib-httpd/passwd b/t/lib-httpd/passwd
> index 99a34d64874..d9c122f3482 100644
> --- a/t/lib-httpd/passwd
> +++ b/t/lib-httpd/passwd
> @@ -1 +1 @@
> -user@host:xb4E8pqD81KQs
> +user@host:$apr1$LGPmCZWj$9vxEwj5Z5GzQLBMxp3mCx1
> diff --git a/t/lib-httpd/proxy-passwd b/t/lib-httpd/proxy-passwd
> index 77c25138e07..2ad7705d9a3 100644
> --- a/t/lib-httpd/proxy-passwd
> +++ b/t/lib-httpd/proxy-passwd
> @@ -1 +1 @@
> -proxuser:2x7tAukjAED5M
> +proxuser:$apr1$RxS6MLkD$DYsqQdflheq4GPNxzJpx5.
