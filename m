Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B30011C8C
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 07:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cqUK4f57"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5456CC
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 23:41:03 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2CBCE35D63;
	Tue, 14 Nov 2023 02:41:03 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=zEq+pMdFBucZ1TjeesCr9QEBZdd4yehBx/01US
	HZkf8=; b=cqUK4f575g1HDp7zmcntaxoUNmbkF7265DhcnNh0ffavxvtp+ypaLN
	F6PLzNCHqdBx9QdqmwK6IBXTwrBw9OVd1Z/yr/al7DScyoDcGE+VtY4EfEhEzgkt
	jMFAqZRHpIAYAEn5eACoRTQSzo8mv8qHaGf0UxpEwgqi6vxNs58Mw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 23FA435D62;
	Tue, 14 Nov 2023 02:41:03 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B257335D5A;
	Tue, 14 Nov 2023 02:40:59 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Taylor Blau
 <me@ttaylorr.com>,  Matthew John Cheetham <mjcheetham@outlook.com>,  M
 Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH v2] credential/wincred: store oauth_refresh_token
In-Reply-To: <pull.1534.v2.git.1699251395093.gitgitgadget@gmail.com>
	(M. Hickford via GitGitGadget's message of "Mon, 06 Nov 2023 06:16:34
	+0000")
References: <pull.1534.git.1684567247339.gitgitgadget@gmail.com>
	<pull.1534.v2.git.1699251395093.gitgitgadget@gmail.com>
Date: Tue, 14 Nov 2023 16:40:58 +0900
Message-ID: <xmqqbkbwzss5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 27765FC4-82C1-11EE-8751-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"M Hickford via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: M Hickford <mirth.hickford@gmail.com>
>
> a5c7656 (credential: new attribute oauth_refresh_token) introduced
> a new confidential credential attribute for helpers to store.
>
> We encode the new attribute in the CredentialBlob, separated by
> newline:
>
>     hunter2
>     oauth_refresh_token=xyzzy
>
> This is extensible and backwards compatible. The credential protocol
> already assumes that attribute values do not contain newlines.
>
> This fixes test "helper (wincred) gets oauth_refresh_token" when
> t0303-credential-external.sh is run with
> GIT_TEST_CREDENTIAL_HELPER=wincred. This test was added in a5c76569e7
> (credential: new attribute oauth_refresh_token, 2023-04-21).
>
> Alternatives considered: store oauth_refresh_token in a wincred
> attribute. This would be insecure because wincred assumes attribute
> values to be non-confidential.

Earlier, a5c76569 (credential: new attribute oauth_refresh_token,
2023-04-21) built the "git" side support for the token, and taught
credential-cache to store the necessary information.  Then 0ce02e2f
(credential/libsecret: store new attributes, 2023-06-16) was written
for libsecret to support the same interface.  

And this one adds corresponding support for wincred.  Do I
understand what is going on around this patch correctly?

I do not do Windows, but some people on this list certainly do and
would be capable of giving the patch a necessary nudge ;-)

Thanks.

>  .../wincred/git-credential-wincred.c          | 46 ++++++++++++++++---
>  1 file changed, 40 insertions(+), 6 deletions(-)
>
> diff --git a/contrib/credential/wincred/git-credential-wincred.c b/contrib/credential/wincred/git-credential-wincred.c
> index 4cd56c42e24..5c6a7d65d4a 100644
> --- a/contrib/credential/wincred/git-credential-wincred.c
> +++ b/contrib/credential/wincred/git-credential-wincred.c
> @@ -35,7 +35,7 @@ static void *xmalloc(size_t size)
>  }
>  
>  static WCHAR *wusername, *password, *protocol, *host, *path, target[1024],
> -	*password_expiry_utc;
> +	*password_expiry_utc, *oauth_refresh_token;
>  
>  static void write_item(const char *what, LPCWSTR wbuf, int wlen)
>  {
> @@ -140,6 +140,11 @@ static void get_credential(void)
>  	DWORD num_creds;
>  	int i;
>  	CREDENTIAL_ATTRIBUTEW *attr;
> +	WCHAR *secret;
> +	WCHAR *line;
> +	WCHAR *remaining_lines;
> +	WCHAR *part;
> +	WCHAR *remaining_parts;
>  
>  	if (!CredEnumerateW(L"git:*", 0, &num_creds, &creds))
>  		return;
> @@ -149,9 +154,23 @@ static void get_credential(void)
>  		if (match_cred(creds[i], 0)) {
>  			write_item("username", creds[i]->UserName,
>  				creds[i]->UserName ? wcslen(creds[i]->UserName) : 0);
> -			write_item("password",
> -				(LPCWSTR)creds[i]->CredentialBlob,
> -				creds[i]->CredentialBlobSize / sizeof(WCHAR));
> +			if (creds[i]->CredentialBlobSize > 0) {
> +				secret = xmalloc(creds[i]->CredentialBlobSize);
> +				wcsncpy_s(secret, creds[i]->CredentialBlobSize, (LPCWSTR)creds[i]->CredentialBlob, creds[i]->CredentialBlobSize / sizeof(WCHAR));
> +				line = wcstok_s(secret, L"\r\n", &remaining_lines);
> +				write_item("password", line, line ? wcslen(line) : 0);
> +				while(line != NULL) {
> +					part = wcstok_s(line, L"=", &remaining_parts);
> +					if (!wcscmp(part, L"oauth_refresh_token")) {
> +						write_item("oauth_refresh_token", remaining_parts, remaining_parts ? wcslen(remaining_parts) : 0);
> +					}
> +					line = wcstok_s(NULL, L"\r\n", &remaining_lines);
> +				}
> +			} else {
> +				write_item("password",
> +						(LPCWSTR)creds[i]->CredentialBlob,
> +						creds[i]->CredentialBlobSize / sizeof(WCHAR));
> +			}
>  			for (int j = 0; j < creds[i]->AttributeCount; j++) {
>  				attr = creds[i]->Attributes + j;
>  				if (!wcscmp(attr->Keyword, L"git_password_expiry_utc")) {
> @@ -160,6 +179,7 @@ static void get_credential(void)
>  					break;
>  				}
>  			}
> +			free(secret);
>  			break;
>  		}
>  
> @@ -170,16 +190,26 @@ static void store_credential(void)
>  {
>  	CREDENTIALW cred;
>  	CREDENTIAL_ATTRIBUTEW expiry_attr;
> +	WCHAR *secret;
> +	int wlen;
>  
>  	if (!wusername || !password)
>  		return;
>  
> +	if (oauth_refresh_token) {
> +		wlen = _scwprintf(L"%s\r\noauth_refresh_token=%s", password, oauth_refresh_token);
> +		secret = xmalloc(sizeof(WCHAR) * wlen);
> +		_snwprintf_s(secret, sizeof(WCHAR) * wlen, wlen, L"%s\r\noauth_refresh_token=%s", password, oauth_refresh_token);
> +	} else {
> +		secret = _wcsdup(password);
> +	}
> +
>  	cred.Flags = 0;
>  	cred.Type = CRED_TYPE_GENERIC;
>  	cred.TargetName = target;
>  	cred.Comment = L"saved by git-credential-wincred";
> -	cred.CredentialBlobSize = (wcslen(password)) * sizeof(WCHAR);
> -	cred.CredentialBlob = (LPVOID)password;
> +	cred.CredentialBlobSize = wcslen(secret) * sizeof(WCHAR);
> +	cred.CredentialBlob = (LPVOID)_wcsdup(secret);
>  	cred.Persist = CRED_PERSIST_LOCAL_MACHINE;
>  	cred.AttributeCount = 0;
>  	cred.Attributes = NULL;
> @@ -194,6 +224,8 @@ static void store_credential(void)
>  	cred.TargetAlias = NULL;
>  	cred.UserName = wusername;
>  
> +	free(secret);
> +
>  	if (!CredWriteW(&cred, 0))
>  		die("CredWrite failed");
>  }
> @@ -265,6 +297,8 @@ static void read_credential(void)
>  			password = utf8_to_utf16_dup(v);
>  		else if (!strcmp(buf, "password_expiry_utc"))
>  			password_expiry_utc = utf8_to_utf16_dup(v);
> +		else if (!strcmp(buf, "oauth_refresh_token"))
> +			oauth_refresh_token = utf8_to_utf16_dup(v);
>  		/*
>  		 * Ignore other lines; we don't know what they mean, but
>  		 * this future-proofs us when later versions of git do
>
> base-commit: bc5204569f7db44d22477485afd52ea410d83743
