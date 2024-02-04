Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E3DBA26
	for <git@vger.kernel.org>; Sun,  4 Feb 2024 23:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707087737; cv=none; b=hXK39j9yqggeaBwvmmHNiyaFpl2ClWh3RTSgePgWgZHp6Ddr/aW5+5zZbzLt3wKn7BarxJJIzyB+nXISuKjpH7yfVyNpaqSzKdTfAy64LXkMhuiH8XPNvxix4cuMB1g22fEhm8IO63ksOkFer60PZfOukY/0JGzJrDRK6x3AhJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707087737; c=relaxed/simple;
	bh=Yq5v0PIV711pSZaRIKcECJpLAx9IjIgGilfnJ19ASww=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=keXgy7zmG6a1o3+v2yWOHmSVb36X8dq/i6KWE7bhQXurnTe5b3KsP++XZ/+1khxvRRHYKnItq+3DHhsPib2tq2yBXk7O8c0nCWF3num+zVCd2vzs5b0BdKIDr9Xk38OWtwL/AxKByp52hPZETLk7bGySpiEjqx4ca8OtXqIoECs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 414N1wVT2079484
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 4 Feb 2024 23:01:59 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Quentin Bouget'" <ypsah@devyard.org>, <git@vger.kernel.org>
References: <20240204185427.39664-1-ypsah@devyard.org> <20240204185427.39664-3-ypsah@devyard.org>
In-Reply-To: <20240204185427.39664-3-ypsah@devyard.org>
Subject: RE: [PATCH 2/2] http: prevent redirect from dropping credentials during reauth
Date: Sun, 4 Feb 2024 18:01:53 -0500
Organization: Nexbridge Inc.
Message-ID: <017a01da57be$28748aa0$795d9fe0$@nexbridge.com>
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
Thread-Index: AQOLeevKzT3v0wkj8zcvqA/epUr17AK8HKeCrYKmrTA=
Content-Language: en-ca

On Sunday, February 4, 2024 1:54 PM, Quentin Bouget wrote:
>During a re-authentication (second attempt at authenticating with a remote,
e.g.
>after a failed GSSAPI attempt), git allows the remote to provide credential
overrides
>in the redirect URL and unconditionnaly drops the current HTTP credentials
in favors
>of those, even when there aren't any.
>
>This commit makes it so HTTP credentials are only overridden when the
redirect URL
>actually contains credentials itself.
>
>Signed-off-by: Quentin Bouget <ypsah@devyard.org>
>---
> http.c | 18 ++++++++++++++++++
> 1 file changed, 18 insertions(+)
>
>diff --git a/http.c b/http.c
>index ccea19ac47..caba9cac1e 100644
>--- a/http.c
>+++ b/http.c
>@@ -2160,7 +2160,25 @@ static int http_request_reauth(const char *url,
> 	if (options && options->effective_url && options->base_url) {
> 		if (update_url_from_redirect(options->base_url,
> 					     url, options->effective_url)) {
>+			char *username = NULL, *password = NULL;
>+
>+			if (http_auth.username)
>+				username = xstrdup(http_auth.username);
>+			if (http_auth.password)
>+				password = xstrdup(http_auth.password);
>+
> 			credential_from_url(&http_auth,
options->base_url->buf);
>+
>+			if (http_auth.username)
>+				free(username);
>+			else if (username)
>+				http_auth.username = username;
>+
>+			if (http_auth.password)
>+				free(password);
>+			else if (password)
>+				http_auth.password = password;
>+
> 			url = options->effective_url->buf;
> 		}
> 	}

I am wondering whether this is a good idea. Having credentials in a redirect
seems like it might be a vector for going somewhere other than what you want
to do, with credentials you do not necessarily want. Others might no better
than I on this, but would potentially lead to a CVE? I would prefer to see
credentials in a redirect rejected rather than used.
--Randall

