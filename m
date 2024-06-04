Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BA714658E
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 20:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717534292; cv=none; b=E3STPFL6glwO6DaQIIfexzuV9QohZ2xaFYgLeQ6GRheJXVuhsDJN5HTk4qGgxI2Q/Id2FsNM+UI0GRSwlbqLc5FnrwNm8ODc4LVTNC6/n2hl0i9tzzVuWb9vA0U/jhqkhGGaZrJU+wZmvPMJhp3phyw1nOpEUsSb1YI3BWwe5rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717534292; c=relaxed/simple;
	bh=JDbVSlVL9ZUWobqOgRLqAPWY/RLoM6bBhoOTwfNZ6B0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VHc+WW/opv08eRZ0Qdo0euvU/rHxiYwCf80QtbYnJTaxivJqyETrr+GIpRfcUNVVCSnJrCqyJU+5TMjPbiAGR3rFYZXOhY+rWeIRWglMmLlxs/0558+el447/zdLP4ZMH6929dC4gc5qkZFi4veAPmc4/skbjynlRcYcF5Eb7Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=RNe2xrCw; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RNe2xrCw"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A23F51E115;
	Tue,  4 Jun 2024 16:51:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=JDbVSlVL9ZUWobqOgRLqAPWY/RLoM6bBhoOTwf
	NZ6B0=; b=RNe2xrCwaQy6131TssDhM1CrBN5MzCIFBvWbYI5BpfTztMZm1CVOQ8
	dgrKAV6VGgwIEmqaQXbkFOFe0wWMS9lkuHzHFN3NlSAzyvvPqfWFXUKHy3q9ECVZ
	tPBgDZjm14VfKUSgCbhhLzrDFKjOQLToGGwzFuhSTBka6QDAdQtlQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 9AC5C1E114;
	Tue,  4 Jun 2024 16:51:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9DCEB1E113;
	Tue,  4 Jun 2024 16:51:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Rahul Rameshbabu <rrameshbabu@nvidia.com>, Aaron
 Plattner <aplattner@nvidia.com>
Subject: Re: [PATCH v2] credential: clear expired c->credential, unify
 secret clearing
In-Reply-To: <20240604192929.3252626-1-aplattner@nvidia.com> (Aaron Plattner's
	message of "Tue, 4 Jun 2024 12:29:28 -0700")
References: <20240604192929.3252626-1-aplattner@nvidia.com>
Date: Tue, 04 Jun 2024 13:51:25 -0700
Message-ID: <xmqqtti8tos2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 35F71276-22B4-11EF-9FAB-8F8B087618E4-77302942!pb-smtp21.pobox.com

Brian, on top of your topic that was merged last month c5c9acf7
(Merge branch 'bc/credential-scheme-enhancement', 2024-05-08), do
these changes make sense to you as a fix/clean-up?

Thanks.

Aaron Plattner <aplattner@nvidia.com> writes:

> When a struct credential expires, credential_fill() clears c->password
> so that clients don't try to use it later. However, a struct cred that
> uses an alternate authtype won't have a password, but might have a
> credential stored in c->credential.
>
> This is a problem, for example, when an OAuth2 bearer token is used. In
> the system I'm using, the OAuth2 configuration generates and caches a
> bearer token that is valid for an hour. After the token expires, git
> needs to call back into the credential helper to use a stored refresh
> token to get a new bearer token. But if c->credential is still non-NULL,
> git will instead try to use the expired token and fail with an error:
>
>  fatal: Authentication failed for 'https://<oauth2-enabled-server>/repository'
>
> And on the server:
>
>  [auth_openidc:error] [client <ip>:34012] oidc_proto_validate_exp: "exp" validation failure (1717522989): JWT expired 224 seconds ago
>
> Fix this by clearing both c->password and c->credential for an expired
> struct credential. While we're at it, use credential_clear_secrets()
> wherever both c->password and c->credential are being cleared, and use
> the full credential_clear() in credential_reject() after the credential
> has been erased from all of the helpers.
>
> v2: Unify secret clearing into credential_clear_secrets(), use
> credential_clear() in credential_reject(), add a comment about why we
> can't use credential_clear() in credential_fill().
>
> Signed-off-by: Aaron Plattner <aplattner@nvidia.com>
> ---
>  credential.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/credential.c b/credential.c
> index 758528b291..72c6f46b02 100644
> --- a/credential.c
> +++ b/credential.c
> @@ -20,12 +20,11 @@ void credential_init(struct credential *c)
>  
>  void credential_clear(struct credential *c)
>  {
> +	credential_clear_secrets(c);
>  	free(c->protocol);
>  	free(c->host);
>  	free(c->path);
>  	free(c->username);
> -	free(c->password);
> -	free(c->credential);
>  	free(c->oauth_refresh_token);
>  	free(c->authtype);
>  	string_list_clear(&c->helpers, 0);
> @@ -479,9 +478,14 @@ void credential_fill(struct credential *c, int all_capabilities)
>  
>  	for (i = 0; i < c->helpers.nr; i++) {
>  		credential_do(c, c->helpers.items[i].string, "get");
> +
>  		if (c->password_expiry_utc < time(NULL)) {
> -			/* Discard expired password */
> -			FREE_AND_NULL(c->password);
> +			/*
> +			 * Don't use credential_clear() here: callers such as
> +			 * cmd_credential() expect to still be able to call
> +			 * credential_write() on a struct credential whose secrets have expired.
> +			 */
> +			credential_clear_secrets(c);
>  			/* Reset expiry to maintain consistency */
>  			c->password_expiry_utc = TIME_MAX;
>  		}
> @@ -528,12 +532,7 @@ void credential_reject(struct credential *c)
>  	for (i = 0; i < c->helpers.nr; i++)
>  		credential_do(c, c->helpers.items[i].string, "erase");
>  
> -	FREE_AND_NULL(c->username);
> -	FREE_AND_NULL(c->password);
> -	FREE_AND_NULL(c->credential);
> -	FREE_AND_NULL(c->oauth_refresh_token);
> -	c->password_expiry_utc = TIME_MAX;
> -	c->approved = 0;
> +	credential_clear(c);
>  }
>  
>  static int check_url_component(const char *url, int quiet,
