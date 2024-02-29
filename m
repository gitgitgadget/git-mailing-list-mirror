Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4918337141
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 16:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709224496; cv=none; b=Itx984HcO4v/QD4vDTVRsAFegwPLnrmy8H/GJWBx/Am24gQroPPTVMInJSkQuMT6h+b0AqyBBfQ+khXiXYz0cBXTaOrOPijsBM+oJ9GVeFvqCA82s7kmFkHQLG9e1eU+Fkz3wgV2vJJR6P+URdZW4yYTCrDB1GpJUMcS6rA6LzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709224496; c=relaxed/simple;
	bh=Jjqei1FojrHokeSGyBg7QzzKKcVXwjx36GyRpo1K31w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lf/JiHCga1V7NvJcLtrUs33dJ6ogz1wmwL638nejQIGedrAtcz0gEFXwwqtQQrGgMkuif/y+MZaZ3h8wPIk4Y8tn2teacawZ9oIUoWRwRcbjbDuUNV+UZpPlavDKOWbGPSr3lzZ5W9PyWullM8CX9wbVMHo5I1L1eejdppraJJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Psi/XHB9; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Psi/XHB9"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A302A34DB1;
	Thu, 29 Feb 2024 11:34:54 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Jjqei1FojrHokeSGyBg7QzzKKcVXwjx36GyRpo
	1K31w=; b=Psi/XHB9zTgDTp35jkSdGFU1i0Vcucdsk3sr9oXY+6E8Ld+PLg+Y/r
	ShBGf/eOWHYiE0uh2du34gB7lURr4CvuSvwKbUPii0DnkiStNpBHx+ruiwtDl1mY
	RJFvyTEqgjQdJ2OoO6vN/0Lo0aJd1sSIEEfqWny9jKmFgEkmx1U58=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 9C67234DB0;
	Thu, 29 Feb 2024 11:34:54 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D6F2834D5C;
	Thu, 29 Feb 2024 11:34:49 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/4] upload-pack: only accept packfile-uris if we
 advertised it
In-Reply-To: <20240229054239.GA1669526@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 29 Feb 2024 00:42:39 -0500")
References: <20240228224625.GA1158651@coredump.intra.peff.net>
	<20240228225050.GA1159078@coredump.intra.peff.net>
	<20240229054239.GA1669526@coredump.intra.peff.net>
Date: Thu, 29 Feb 2024 08:34:48 -0800
Message-ID: <xmqqmsrji5zr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 751ED72A-D720-11EE-84BA-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Jeff King <peff@peff.net> writes:

> Sorry, this needs one tweak to pass under the sha256 CI job:
>
> diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
> index 902e42c1c0..1ef540f73d 100755
> --- a/t/t5702-protocol-v2.sh
> +++ b/t/t5702-protocol-v2.sh
> @@ -781,6 +781,7 @@ test_expect_success 'archive with custom path does not request v2' '
>  test_expect_success 'reject client packfile-uris if not advertised' '
>  	{
>  		packetize command=fetch &&
> +		packetize object-format=$(test_oid algo) &&
>  		printf 0001 &&
>  		packetize packfile-uris https &&
>  		packetize done &&
>
> Otherwise the server complains that the other side did not respect its
> advertised object-format (I sure am glad to have included the final
> "hey, this input works, right?" test there, as that is what caught it).

Ah, good finding.  Will use it to amend.

I wonder if it is still worth testing if the command is happy with
an input that lacks object-format capability under SHA-1 mode.  This
test piece is primarily about packfile-uris, so in that sense, we
are not all that interested in that unspecified client object-format
defaults to the initial value of serve.c:client_hash_algo (which is
SHA-1), and not testing that here is perfectly fine, I guess.

Thanks.
