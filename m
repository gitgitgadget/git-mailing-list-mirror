Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749DB2DC792
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 17:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785952547; cv=none; b=TWRT/vxkz+ZZf6hPQus+b9+ZsKyfXyhpaWep4RAesKZtRoG3kSde6clE68dt75GSWR2UFvn4pjvIamY6DD5mQ0vWJWyAgXmzZWeKCoA0YOfnMcFY6Nu1iOPaezOuEM8wDPKDdtdg0eZ7fl1v7LHS7YZ9XGpz4Qe1RGthEkEXRfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785952547; c=relaxed/simple;
	bh=5n8LkQLXMzu07ax+eALc6xhN6DUVNAjO+j75UE2S+sM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DTvTTZUcgUUUh34Yfobs7zRMaqqXEn4mgS1OcBXZGLu+yvjNdEmOM3r6Fq+2akENJ+W37P9HZP1vxhsLVfRGGBWjmrrwJ0IIuxiOKJ6RN6ZZE9r73kW3t9EblwUadzFgYhAZmjWGXvN6D/Ea0e+MP/m/CIfrBGAQfexHsJ3jk6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp2.bon.at (unknown [192.168.181.106])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4hFdPC1qP9z7QphT
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 19:55:43 +0200 (CEST)
Received: from [192.168.1.102] (unknown [89.144.223.124])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4hFdNz35FNzRnlK;
	Wed,  5 Aug 2026 19:55:30 +0200 (CEST)
Message-ID: <2952d9a7-c7c0-44c0-a321-7ddad6497a6e@kdbg.org>
Date: Wed, 5 Aug 2026 19:55:30 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Reintroduce writev(3p)
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: Ben Knoble <ben.knoble@gmail.com>, Jeff King <peff@peff.net>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 "Randall S. Becker" <randall.becker@nexbridge.ca>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, git@vger.kernel.org
References: <20260716-pks-reintroduce-writev-v1-0-ea9038c884bc@pks.im>
 <f8050598-392f-44c9-8d66-0454740a7a12@kdbg.org> <xmqqo6fso2s8.fsf@gitster.g>
 <anL0nIk6uzkYR9Oc@pks.im> <xmqqy0ekr0bm.fsf@gitster.g>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <xmqqy0ekr0bm.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 05.08.26 um 18:36 schrieb Junio C Hamano:
>>> I think Patrick's writev(2) follows the pattern our previous compat/
>>> routines have taken.  We use real writev(2) where it is available,
>>> and in the fake implementations in compat/ we have comments that
>>> essentially say "the real function offers X, Y, and Z, but we only
>>> want X and Z and do not need Y, so this implementation does not
>>> support Y".

> A different way to put the same question is "what is Y in the
> context of the intended uses of writev(2) in our codebase"?
The Y that I am thinking of primarily is the atomicity guarantee:

> The  data transfers performed by readv() and writev() are atomic: the
> data written by writev() is written as a single block that is not
> intermingled with output from writes in  other  processes; [...]

(See `man 2 writev`; this isn't spelled out explicitly in the Open Group
Base Specification.)

This is basically unimplementable by any emulation that has to call
write() multiple times.

-- Hannes

