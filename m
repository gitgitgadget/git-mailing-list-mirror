Received: from mta1.migadu.com (out-40.mta1.migadu.com [95.215.58.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EFD37DEB6
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 15:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787238020; cv=none; b=FKSLisXlYfH1PUVsseoRRNADkWaKBa+n5OG0cHJhmtit+1IjzW4Sk++kV5XPWf/ffgwiqnBcLAFV9l90hDMhpMkkUt9PATNLCssEgvkSVFSwu2RcFbRmEEnduAzQ37ktk14e2pPK+bRgc5Cum/MF11JYyYIsE2VRj0Ltl1t2HAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787238020; c=relaxed/simple;
	bh=v7ORyy6iDjQTBy7zKHWZbprLVE2r6xljDr3301L7gdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RcmraBIxcPWWmTF8qgk8ikX9xiLYuQafbIXL0cX+5bBeoouMs7h4yiT3ghSpo5M7WDJ6VTHdtIP3onTKuoPO0oR0OKObOahp83BbrhgWUKnkOytH2eMxZJY7ql06B8kQklsk1dSSmLDYKzVHuV+bDlBtCeo0x5WvpUklxgSHpqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mvdan.cc; spf=pass smtp.mailfrom=mvdan.cc; dkim=pass (1024-bit key) header.d=mvdan.cc header.i=@mvdan.cc header.b=aQAiv9Ql; arc=none smtp.client-ip=95.215.58.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mvdan.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvdan.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvdan.cc header.i=@mvdan.cc header.b="aQAiv9Ql"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=v7ORyy6iDjQTBy7zKHWZbprLVE2r6xljDr3301L7gdQ=;
 c=simple/simple; d=mvdan.cc;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787238014; v=1; x=1787842814;
 b=aQAiv9QlhXPeo6jvCNEGcfSc4S7h0tkZ9OybccJx+95qrvg5ttY0RcHtLyZ/Bqr+O334dew8
 UJhWNRcYOOnDy1tz1lztwf6GCHrsIwSgLv/Z7yF5mQPDxVDXNNMD0Mohgnl+L5Ln4Ea9hY9UF9H
 cBsVh7EiAS2lYjzubZSGL7kI=
X-Envelope-To: git@vger.kernel.org
Received: from [IPV6:2a02:6b6f:ea56:2100:e59a:61c0:de61:63be] (2a02:6b6f:ea56:2100:e59a:61c0:de61:63be)
	by smtp.migadu.com with ESMTPS id 868e2e84418efe71;
	Thu, 20 Aug 2026 15:00:13 +0000
X-Mizu-Trace-ID: 868e2e84418efe71
X-Migadu-Flow: FLOW_OUT
Message-ID: <331e94ec-c07a-4d56-938d-d12c9a0cc5c9@mvdan.cc>
Date: Thu, 20 Aug 2026 16:00:12 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] credential/libsecret: load secrets explicitly
Content-Language: en-US
To: =?UTF-8?Q?Daniel_Mart=C3=AD_via_GitGitGadget?= <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: M Hickford <mirth.hickford@gmail.com>,
 =?UTF-8?Q?Mantas_Mikul=C4=97nas?= <grawity@gmail.com>,
 Patrick Steinhardt <ps@pks.im>
References: <pull.2372.git.git.1785883217733.gitgitgadget@gmail.com>
From: =?UTF-8?Q?Daniel_Mart=C3=AD?= <mvdan@mvdan.cc>
In-Reply-To: <pull.2372.git.git.1785883217733.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Gentle nudge on this, anything I can do to assist in getting it reviewed?

I still run into the error a few times per week :)

On 8/4/26 11:40 PM, Daniel Martí via GitGitGadget wrote:
> From: =?UTF-8?q?Daniel=20Mart=C3=AD?= <mvdan@mvdan.cc>
>
> secret_service_search_sync() can return an item whose secret is not
> loaded, despite SECRET_SEARCH_LOAD_SECRETS being set: the search
> silently discards secret-loading failures, and the GNOME keyring
> daemon silently omits from its GetSecrets reply any item that is
> locked or that was deleted after the search matched it, e.g. by a
> concurrent "credential erase" from another git process.
>
> secret_item_get_secret() then returns NULL, which we pass unchecked
> to secret_value_get_text() and secret_value_unref(), producing
>
>      secret_value_get_text: assertion 'value' failed
>      secret_value_unref: assertion 'value != NULL' failed
>
> and losing the password even when the secret is still retrievable.
>
> Drop SECRET_SEARCH_LOAD_SECRETS and instead load the secret of the
> one item we use with secret_item_load_secret_sync(), which does
> report errors. A secret the search would have silently dropped is
> now retrieved normally, and a genuinely inaccessible item produces
> a useful message instead of assertion spew, with git falling back
> to prompting either way. Merely guarding against NULL would avoid
> the assertions, but would forfeit a secret that is still available.
> The cost is unchanged: the search no longer batch-fetches the
> secrets of all matching items, and the explicit load fetches the
> one we use.
>
> Signed-off-by: Daniel Martí <mvdan@mvdan.cc>
> ---
>      credential/libsecret: load secrets explicitly
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2372%2Fmvdan%2Flibsecret-null-secret-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2372/mvdan/libsecret-null-secret-v1
> Pull-Request: https://github.com/git/git/pull/2372
>
>   .../libsecret/git-credential-libsecret.c           | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/credential/libsecret/git-credential-libsecret.c b/contrib/credential/libsecret/git-credential-libsecret.c
> index 941b2afd5e..6bbdf2bd45 100644
> --- a/contrib/credential/libsecret/git-credential-libsecret.c
> +++ b/contrib/credential/libsecret/git-credential-libsecret.c
> @@ -126,7 +126,7 @@ static int keyring_get(struct credential *c)
>   	items = secret_service_search_sync(service,
>   					   &schema,
>   					   attributes,
> -					   SECRET_SEARCH_LOAD_SECRETS | SECRET_SEARCH_UNLOCK,
> +					   SECRET_SEARCH_UNLOCK,
>   					   NULL,
>   					   &error);
>   	g_hash_table_unref(attributes);
> @@ -143,6 +143,18 @@ static int keyring_get(struct credential *c)
>   		gchar **parts;
>   
>   		item = items->data;
> +
> +		/*
> +		 * Load the secret explicitly rather than via
> +		 * SECRET_SEARCH_LOAD_SECRETS, which silently discards load
> +		 * failures and returns items whose secret is NULL.
> +		 */
> +		if (!secret_item_load_secret_sync(item, NULL, &error)) {
> +			g_critical("could not load secret: %s", error->message);
> +			g_error_free(error);
> +			g_list_free_full(items, g_object_unref);
> +			return EXIT_FAILURE;
> +		}
>   		secret = secret_item_get_secret(item);
>   		attributes = secret_item_get_attributes(item);
>   
>
> base-commit: 5b2471720c93ee30e5764a19f3d3b3ae9ec9712a
