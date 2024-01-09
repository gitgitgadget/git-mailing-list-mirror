Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9A43A1AF
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 19:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp1.bon.at (unknown [192.168.181.103])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4T8gtm0WvHz5tnD
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 20:27:44 +0100 (CET)
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4T8gtb52T5z5tlB;
	Tue,  9 Jan 2024 20:27:35 +0100 (CET)
Message-ID: <d1e1a543-ab9c-4b1b-9f1d-3728e791df2e@kdbg.org>
Date: Tue, 9 Jan 2024 20:27:35 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/1] mingw: give more details about unsafe directory's
 ownership
To: =?UTF-8?Q?S=C3=B6ren_Krecker?= <soekkle@freenet.de>
Cc: sunshine@sunshineco.com, git@vger.kernel.org
References: <de9cf40a-1ad6-45fb-8b70-8b0c71a3bfbb@kdbg.org>
 <20240108173837.20480-1-soekkle@freenet.de>
 <20240108173837.20480-2-soekkle@freenet.de>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20240108173837.20480-2-soekkle@freenet.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 08.01.24 um 18:38 schrieb Sören Krecker:
> +static BOOL user_sid_to_user_name(PSID sid, LPSTR *str)
> +{
> +	SID_NAME_USE pe_use;
> +	DWORD len_user = 0, len_domain = 0;
> +	BOOL translate_sid_to_user;
> +
> +	/*
> +	 * returns only FALSE, because the string pointers are NULL
> +	 */
> +	LookupAccountSidA(NULL, sid, NULL, &len_user, NULL, &len_domain,
> +			  &pe_use); 

At this point, the function fails, so len_user and len_domain contain
the required buffer size (including the trailing NUL).

> +	/*
> +	 * Alloc needed space of the strings
> +	 */
> +	ALLOC_ARRAY((*str), (size_t)len_domain + (size_t)len_user); 
> +	translate_sid_to_user = LookupAccountSidA(NULL, sid,
> +	    (*str) + len_domain, &len_user, *str, &len_domain, &pe_use);

At this point, if the function is successful, len_user and len_domain
contain the lengths of the names (without the trailing NUL).

> +	if (!translate_sid_to_user)
> +		FREE_AND_NULL(*str);
> +	else
> +		(*str)[len_domain] = '/';

Therefore, this overwrites the NUL after the domain name and so
concatenates the two names. Good.

I found this by dumping the values of the variables, because the
documentation of LookupAccountSid is not clear about the values that the
variables receive in the success case.

> +	return translate_sid_to_user;
> +}
> +

This patch looks good and works for me.

Acked-by: Johannes Sixt <j6t@kdbg.org>

Thank you!

-- Hannes

