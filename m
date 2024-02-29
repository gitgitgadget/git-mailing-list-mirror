Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5637937149
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 05:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709185363; cv=none; b=S2zRFKlyB34eIjHqcu277AeH3WyU6llJnRtkK3I/JkFoAG32p6nNSBrBI+7UQfnyBc+qK9te5h+vAh5H/vmKCmgDHtBz2q6L174EkW2WL8Vs7OFTjTq7KSx08x1MfaO1TzdnGW5bEcHaHeW4RCRyVD4IcqqnZrQ0tHSOp2Bo32M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709185363; c=relaxed/simple;
	bh=TMrhczHaIZHyA5teLWFds3+RdFMNWBge0aA0IJD8By4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gnJhwtpUSzZ8tAGtYopQrA3hIsz1YNAaZnszMzs3p7MlBx8s4M8iAChxldr2+M8qxZJqrFtfiOXZtPSWUYuUGWhx4KsCDUTmuXkP/mkXSJmbVDUx5g4d8iROSxxjDXmUoFhkiLFi1ooUVs4NsMoUMAJhrkDYUKWAv4N/PmwPUW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 25876 invoked by uid 109); 29 Feb 2024 05:42:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 29 Feb 2024 05:42:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30503 invoked by uid 111); 29 Feb 2024 05:42:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 29 Feb 2024 00:42:43 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 29 Feb 2024 00:42:39 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] upload-pack: only accept packfile-uris if we
 advertised it
Message-ID: <20240229054239.GA1669526@coredump.intra.peff.net>
References: <20240228224625.GA1158651@coredump.intra.peff.net>
 <20240228225050.GA1159078@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240228225050.GA1159078@coredump.intra.peff.net>

On Wed, Feb 28, 2024 at 05:50:50PM -0500, Jeff King wrote:

> diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
> index 6ef4971845..902e42c1c0 100755
> --- a/t/t5702-protocol-v2.sh
> +++ b/t/t5702-protocol-v2.sh
> @@ -778,6 +778,24 @@ test_expect_success 'archive with custom path does not request v2' '
>  	! grep ^GIT_PROTOCOL env.trace
>  '
>  
> +test_expect_success 'reject client packfile-uris if not advertised' '
> +	{
> +		packetize command=fetch &&
> +		printf 0001 &&
> +		packetize packfile-uris https &&
> +		packetize done &&
> +		printf 0000
> +	} >input &&
> +	test_must_fail env GIT_PROTOCOL=version=2 \
> +		git upload-pack client <input &&
> +	test_must_fail env GIT_PROTOCOL=version=2 \
> +		git -c uploadpack.blobpackfileuri \
> +		upload-pack client <input &&
> +	GIT_PROTOCOL=version=2 \
> +		git -c uploadpack.blobpackfileuri=anything \
> +		upload-pack client <input
> +'

Sorry, this needs one tweak to pass under the sha256 CI job:

diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 902e42c1c0..1ef540f73d 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -781,6 +781,7 @@ test_expect_success 'archive with custom path does not request v2' '
 test_expect_success 'reject client packfile-uris if not advertised' '
 	{
 		packetize command=fetch &&
+		packetize object-format=$(test_oid algo) &&
 		printf 0001 &&
 		packetize packfile-uris https &&
 		packetize done &&

Otherwise the server complains that the other side did not respect its
advertised object-format (I sure am glad to have included the final
"hey, this input works, right?" test there, as that is what caught it).

-Peff
