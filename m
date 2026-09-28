Received: from mta1.migadu.com (out-251.mta1.migadu.com [95.215.58.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4426378D74
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 07:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790581036; cv=none; b=c6Abm1IV/659fnBZSMGiiS08SOwNgFaX6GHg7JBwe7XhNQ6htYx/JnL+CUzALx7OXyRfn9wPgoovM9zqUHpIRkpHKCfYXSlkvCdEw5Od/dmmLdfzTZxT9cTzx3PdtayVKqyGw0WFaKUYcfFFo7EAW0tC4m0LBmR6EOM6RXY1uLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790581036; c=relaxed/simple;
	bh=QlH5B6FvJbr5dyY1P3YeG064pct4V9Y5nYqXBc7Mf/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jFkdIgzJOE0i7pYCl0AlkPoCgKLL2Cb0mqeByqoFyTQ2WXTyHzWUTgGy4EZhzVYmKKwx7R4oWBKMaA9Xe4cBcj1iZPa6LoAbHCajBPmBThfcf70NOYOPoHZeAiMOIb/WZ/sQKI1ErMe6tBq31gtfk8mRoId+jJcgGIRxOahaE68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mvdan.cc; spf=pass smtp.mailfrom=mvdan.cc; dkim=pass (1024-bit key) header.d=mvdan.cc header.i=@mvdan.cc header.b=XvasuoVD; arc=none smtp.client-ip=95.215.58.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mvdan.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvdan.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvdan.cc header.i=@mvdan.cc header.b="XvasuoVD"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=QlH5B6FvJbr5dyY1P3YeG064pct4V9Y5nYqXBc7Mf/o=;
 c=simple/simple; d=mvdan.cc;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790581030; v=1; x=1791185830;
 b=XvasuoVD7DHMLXWMNJsdnOe6AZ9tM/avKqNfZFBaQSttVTCuYnbs0Jf9JDeVk7yCvDiAu4LE
 6VDTBXxns0l9CtRPjL1inwfcZbUSooXawV2YOBXP/zFoMRR2KZT1dKn0ZU3LGN3WxzERoIupMT+
 ZtYvzKyrUa8hPCIGDCpL4wmA=
X-Envelope-To: git@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 07a3dc8815773c78;
	Mon, 28 Sep 2026 07:37:10 +0000
X-Mizu-Trace-ID: 07a3dc8815773c78
X-Migadu-Flow: FLOW_OUT
Message-ID: <f73a8b6c-37cd-4804-8587-3df4f0999f0a@mvdan.cc>
Date: Mon, 28 Sep 2026 08:37:05 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] credential/libsecret: load secrets explicitly
Content-Language: en-US
To: =?UTF-8?Q?Daniel_Mart=C3=AD_via_GitGitGadget?= <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: M Hickford <mirth.hickford@gmail.com>,
 =?UTF-8?Q?Mantas_Mikul=C4=97nas?= <grawity@gmail.com>,
 Patrick Steinhardt <ps@pks.im>
References: <pull.2372.git.git.1785883217733.gitgitgadget@gmail.com>
 <pull.2372.v2.git.git.1790549181518.gitgitgadget@gmail.com>
From: =?UTF-8?Q?Daniel_Mart=C3=AD?= <mvdan@mvdan.cc>
In-Reply-To: <pull.2372.v2.git.git.1790549181518.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I didn't add the "changes since v1" text to the right section of the PR,
so the bot didn't pick it up correctly. Adding it here now...

Changes since v1:
- Reworded the commit message to answer Junio's questions: why the 
explicit load replaces SECRET_SEARCH_LOAD_SECRETS rather than serving as 
a fallback, what it costs, and why there is no test.
- Dropped the claim that a secret dropped by the search is now 
retrieved; a deleted or still-locked item fails the explicit load too, 
only with a proper error message.
- Updated the code comment to say what libsecret actually does.

On 9/27/26 11:46 PM, Daniel Martí via GitGitGadget wrote:
> From: =?UTF-8?q?Daniel=20Mart=C3=AD?= <mvdan@mvdan.cc>
>
> keyring_get() searches with SECRET_SEARCH_LOAD_SECRETS, then passes
> secret_item_get_secret() of the first match unchecked to
> secret_value_get_text() and secret_value_unref(). As libsecret
> documents, that secret can be NULL: the search does not load secrets
> of locked items, such as when SECRET_SEARCH_UNLOCK fails to unlock
> them, and it ignores errors from loading secrets. The GNOME keyring
> daemon also silently leaves out of its reply any item which is locked
> or which was deleted after the search matched it, e.g. by a concurrent
> "credential erase" from another git process. We then print
>
>      secret_value_get_text: assertion 'value' failed
>      secret_value_unref: assertion 'value != NULL' failed
>
> before git falls back to prompting for the password.
>
> We could keep the flag and load the secret explicitly only when it is
> NULL, but SECRET_SEARCH_LOAD_SECRETS is not part of the search call:
> libsecret implements it as a separate GetSecrets D-Bus call after
> SearchItems. Drop the flag and instead always load the one secret we
> use with secret_item_load_secret_sync(), which reports errors. This
> takes as many D-Bus calls as before, and leaves a single code path
> that runs every time, rather than a fallback that only runs in a rare
> race. libsecret's own secret-tool also loads each secret explicitly
> after searching.
>
> An inaccessible item now produces a useful error message instead of
> the assertion failures, and git still falls back to prompting. The
> race needs a concurrent process or a locked keyring to trigger, so
> there is no test.
>
> Signed-off-by: Daniel Martí <mvdan@mvdan.cc>
> ---
>      credential/libsecret: load secrets explicitly
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2372%2Fmvdan%2Flibsecret-null-secret-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2372/mvdan/libsecret-null-secret-v2
> Pull-Request: https://github.com/git/git/pull/2372
>
> Range-diff vs v1:
>
>   1:  89d3eee91f ! 1:  b9ddf13fa1 credential/libsecret: load secrets explicitly
>       @@ Metadata
>         ## Commit message ##
>            credential/libsecret: load secrets explicitly
>        
>       -    secret_service_search_sync() can return an item whose secret is not
>       -    loaded, despite SECRET_SEARCH_LOAD_SECRETS being set: the search
>       -    silently discards secret-loading failures, and the GNOME keyring
>       -    daemon silently omits from its GetSecrets reply any item that is
>       -    locked or that was deleted after the search matched it, e.g. by a
>       -    concurrent "credential erase" from another git process.
>       -
>       -    secret_item_get_secret() then returns NULL, which we pass unchecked
>       -    to secret_value_get_text() and secret_value_unref(), producing
>       +    keyring_get() searches with SECRET_SEARCH_LOAD_SECRETS, then passes
>       +    secret_item_get_secret() of the first match unchecked to
>       +    secret_value_get_text() and secret_value_unref(). As libsecret
>       +    documents, that secret can be NULL: the search does not load secrets
>       +    of locked items, such as when SECRET_SEARCH_UNLOCK fails to unlock
>       +    them, and it ignores errors from loading secrets. The GNOME keyring
>       +    daemon also silently leaves out of its reply any item which is locked
>       +    or which was deleted after the search matched it, e.g. by a concurrent
>       +    "credential erase" from another git process. We then print
>        
>                secret_value_get_text: assertion 'value' failed
>                secret_value_unref: assertion 'value != NULL' failed
>        
>       -    and losing the password even when the secret is still retrievable.
>       +    before git falls back to prompting for the password.
>       +
>       +    We could keep the flag and load the secret explicitly only when it is
>       +    NULL, but SECRET_SEARCH_LOAD_SECRETS is not part of the search call:
>       +    libsecret implements it as a separate GetSecrets D-Bus call after
>       +    SearchItems. Drop the flag and instead always load the one secret we
>       +    use with secret_item_load_secret_sync(), which reports errors. This
>       +    takes as many D-Bus calls as before, and leaves a single code path
>       +    that runs every time, rather than a fallback that only runs in a rare
>       +    race. libsecret's own secret-tool also loads each secret explicitly
>       +    after searching.
>        
>       -    Drop SECRET_SEARCH_LOAD_SECRETS and instead load the secret of the
>       -    one item we use with secret_item_load_secret_sync(), which does
>       -    report errors. A secret the search would have silently dropped is
>       -    now retrieved normally, and a genuinely inaccessible item produces
>       -    a useful message instead of assertion spew, with git falling back
>       -    to prompting either way. Merely guarding against NULL would avoid
>       -    the assertions, but would forfeit a secret that is still available.
>       -    The cost is unchanged: the search no longer batch-fetches the
>       -    secrets of all matching items, and the explicit load fetches the
>       -    one we use.
>       +    An inaccessible item now produces a useful error message instead of
>       +    the assertion failures, and git still falls back to prompting. The
>       +    race needs a concurrent process or a locked keyring to trigger, so
>       +    there is no test.
>        
>            Signed-off-by: Daniel Martí <mvdan@mvdan.cc>
>        
>       @@ contrib/credential/libsecret/git-credential-libsecret.c: static int keyring_get(
>        +
>        +		/*
>        +		 * Load the secret explicitly rather than via
>       -+		 * SECRET_SEARCH_LOAD_SECRETS, which silently discards load
>       -+		 * failures and returns items whose secret is NULL.
>       ++		 * SECRET_SEARCH_LOAD_SECRETS, which skips locked items and
>       ++		 * ignores load failures, leaving the secret NULL.
>        +		 */
>        +		if (!secret_item_load_secret_sync(item, NULL, &error)) {
>        +			g_critical("could not load secret: %s", error->message);
>
>
>   .../libsecret/git-credential-libsecret.c           | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/credential/libsecret/git-credential-libsecret.c b/contrib/credential/libsecret/git-credential-libsecret.c
> index 941b2afd5e..ad4f60e4d7 100644
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
> +		 * SECRET_SEARCH_LOAD_SECRETS, which skips locked items and
> +		 * ignores load failures, leaving the secret NULL.
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
> base-commit: 34f06850c16c7f7ac822b1adc71354f11b0f2ca3
