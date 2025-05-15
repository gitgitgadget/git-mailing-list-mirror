Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB9528B414
	for <git@vger.kernel.org>; Thu, 15 May 2025 18:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747335346; cv=none; b=t/tDhYN/K/D20Wf0DVu2S8s6q7q5C20lKpuP1Dw0lFpx5AOiR6jdyCiYrS3DrhPEg7I/xbORuVIh11x6Wu4f8wFJXQTksqJrxXX6FItd+N6iL5Wfo5pzaTGSnhTYO2hS4Oufr4imttKm6iXGqxWWhNUiSWJoZmKdo7UP0ovooGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747335346; c=relaxed/simple;
	bh=fuMPmQtvOng0t2UU0XZXSu5+osRDtFQIpj8l7whqN1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tnpVb5hB6BnXX4nnswhsXtwNHcHqbkSHOORx9tpcPKYQhTjttvMliSMuWyj13BwE+8Cg7eao1BbMVGsGDUKjBbuSb16yHmLhp2Np4WXejCbqmLx6BbTW3fw3nbfVptTDl4TjzIOSypZ3jYDxtnVyX6ESVBXSLF+cafBDi9hAtcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=dc/U1eiP; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="dc/U1eiP"
Received: (qmail 32586 invoked by uid 109); 15 May 2025 18:55:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=fuMPmQtvOng0t2UU0XZXSu5+osRDtFQIpj8l7whqN1Y=; b=dc/U1eiPx8JNczSqXQDMyvri3UytNQRkpQSQhYjPozXhRCMfQLuZu2atoxrqfilTEbUfHmQP4Y/NgukESy9ZdkufcoSKxmczSdgpG6q6keT0t2dYv4NHGXP5Wz7NES1F63cgZcuiZHfVd/WkLMmPgfLZNkITBVNXAeHaRVIYeAriDvii+XQHkKZuV2ZybVBrkglI53yi1t4Jk/Z2o5hd5F6ruX+I8n4Co4NmeA4D9LkHWqkJxxUWXvfCdDXwX89orQUudaX5BBg/FG1bDE9Kt8I7cxn9SN59249DXPIlcC22vwqp5Bk64+yfjlR61erPEfmbCFF/ja1S5XNefdXA5w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 May 2025 18:55:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29716 invoked by uid 111); 15 May 2025 18:55:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 May 2025 14:55:37 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 15 May 2025 14:55:35 -0400
From: Jeff King <peff@peff.net>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, toon@iotcl.com, ps@pks.im, gitster@pobox.com
Subject: Re: [PATCH v2 4/4] receive-pack: use batched reference updates
Message-ID: <20250515185535.GA3309052@coredump.intra.peff.net>
References: <20250515-501-update-git-fetch-1-to-use-partial-transactions-v2-0-80cbaaa55d2e@gmail.com>
 <20250515-501-update-git-fetch-1-to-use-partial-transactions-v2-4-80cbaaa55d2e@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250515-501-update-git-fetch-1-to-use-partial-transactions-v2-4-80cbaaa55d2e@gmail.com>

On Thu, May 15, 2025 at 04:07:28PM +0200, Karthik Nayak wrote:

> +failure:
> +	for (cmd = commands; cmd; cmd = cmd->next) {
> +		if (reported_error)
> +			cmd->error_string = reported_error;
> +		else if (strmap_contains(&failed_refs, cmd->ref_name))
> +			cmd->error_string = xstrdup(strmap_get(&failed_refs, cmd->ref_name));
>  	}

Coverity complains about this code, claiming that strmap_get() could
return NULL. At first glance, I thought it was being totally stupid,
since we just called strmap_contains() above. But it's only being a
little bit stupid: even if the entry exists, it is still possible for it
to contain NULL.

However, that won't ever be the case, since it is always fed from the
set of ref transaction reasons.

Still, I wondered if:

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index bd0fb729ff..fe001bbfe8 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1897,10 +1897,11 @@ static void execute_commands_non_atomic(struct command *commands,
 
 failure:
 	for (cmd = commands; cmd; cmd = cmd->next) {
+		const char *reason;
 		if (reported_error)
 			cmd->error_string = reported_error;
-		else if (strmap_contains(&failed_refs, cmd->ref_name))
-			cmd->error_string = xstrdup(strmap_get(&failed_refs, cmd->ref_name));
+		else if ((reason = strmap_get(&failed_refs, cmd->ref_name)))
+			cmd->error_string = xstrdup(reason);
 	}
 
 cleanup:

might be simpler, and skip the extra lookup? I dunno, it is probably
getting into bikeshedding, and it is not like this is the only Coverity
false positive we have seen. So feel free to ignore. ;)

-Peff
