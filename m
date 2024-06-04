Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E016320C
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 22:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717538684; cv=none; b=sEe8RyryskKL5ky2SYVKF9rrRhmLiwM/cY1TjABpbo2TFMRxDP+PKORRA0Sdmfz08eqNgr/VP7rb3q1MqyyDqG2dyIGY735bwMVE24gjNTkXHt1xgbnlSqPtT0P8aiRI0B5RM9oQG3tAHSJjHdPKqJ8IImInPGnge02gS2ndkn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717538684; c=relaxed/simple;
	bh=+n1BoXHaVtxKH5MxMkA9c+gRgP7LYRy8z6acxM0orMQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z71yEg5/SMgxAMxBalS/9P9jLSL7CZHzpPKvobEVI0bjF1QmBZSVqRYsfiKpsMUiNDXmn/ttwUhZDzXK+XZN57MQnZFzgi/XpJQ7UHXIwmxE3opsLBaHy0f4R8mGUEiccBCXWA6nDBBKuziIGrjUlCyT2uKcph0VgaVqOnxnI/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=itHGDnxx; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="itHGDnxx"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 33B501EE45;
	Tue,  4 Jun 2024 18:04:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=+n1BoXHaVtxKH5MxMkA9c+gRgP7LYRy8z6acxM
	0orMQ=; b=itHGDnxxtjoPdoGoA6rfT5qFEs5edeKZu+S+WpaWSQAoU97rF316M6
	4r7ao8Ag/0k/GmF34AFJ8bqRzZawWA5Q3FPrTMO1FwQM2loUibbDtC8bm0vdFMw7
	GSCOHZCADx3I11pCAvxBzKMIGxpVU1mNuxTDEI8T0h2HSJ2niE0ZE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C7AE1EE44;
	Tue,  4 Jun 2024 18:04:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 970E41EE43;
	Tue,  4 Jun 2024 18:04:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Aaron Plattner <aplattner@nvidia.com>
Cc: <git@vger.kernel.org>,  Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH v2] credential: clear expired c->credential, unify
 secret clearing
In-Reply-To: <20240604192929.3252626-1-aplattner@nvidia.com> (Aaron Plattner's
	message of "Tue, 4 Jun 2024 12:29:28 -0700")
References: <20240604192929.3252626-1-aplattner@nvidia.com>
Date: Tue, 04 Jun 2024 15:04:40 -0700
Message-ID: <xmqqo78gtldz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7192BE34-22BE-11EF-87B4-B84BEB2EC81B-77302942!pb-smtp1.pobox.com

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

OK.

>
> v2: Unify secret clearing into credential_clear_secrets(), use
> credential_clear() in credential_reject(), add a comment about why we
> can't use credential_clear() in credential_fill().

This does not belong to the commit log message proper.  Those who
are reading "git log" would not know (and care about) an earlier
attempt.  Writing the changes since the previous round(s) like the
above paragraph is very much appreciated as it helps reviewers who
saw them, but please do so after the three-dash "---" line below (I
can remove the paragraph while queueing, so no need to resend).

Will queue.  Thanks.


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
