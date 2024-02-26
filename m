Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1A712F36D
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 17:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708967523; cv=none; b=ln6OA2mczYUWtUsqWMax20XQT7Q9wIQSTraO3iQn9GIZNYoLSWEGnLv1BjSwK49PqsidIKVftMQ6iKqE69PhqRg4eyn7DLTHzOiCiUZ26NcDnPnmsiVkEPFuJZA39dXbp7Zluw5E54d7cNGfrktZvaXLsaMUfNW7qQhDn8/TWGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708967523; c=relaxed/simple;
	bh=foX77zXLSwS8CXRSC4c0yLa+WUqpcS0kntDf7m2Fwi8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d0EWbWulfeCVkJpTxMgQ0mSr7cRboKfsdxYUZdHIT7f+nFb8OtBCz7hh0EU0vrw5dQV8i3ohqP6cbV0WTOF4kK3Ii2ZSNYuASepYW/1Q2Cm6ipBhwOup1GCLu7AAtSLccS/YeJZRwMB3zv2xXytRVxSqo9DsIooXeGPGqdqQ5vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=f2dpITd/; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="f2dpITd/"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B7F691DC32;
	Mon, 26 Feb 2024 12:12:00 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=foX77zXLSwS8CXRSC4c0yLa+WUqpcS0kntDf7m
	2Fwi8=; b=f2dpITd/PNX0G7URmX4HwoHFzNuGWhil/vZdNQjZpbJ1hxmXC91zMZ
	cfBlZ8bG12+uWrXW1g5Oe4XUfAJUF8WISZdhCC3F9UWBxNwx4SX+8uUnNBwW8wOx
	PauYLyluLT+S6561xZ2oq3Vnz/Z88EKWc37e0tW5IhV7nYvP/S0Jk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id AFA1D1DC31;
	Mon, 26 Feb 2024 12:12:00 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C54601DC30;
	Mon, 26 Feb 2024 12:11:56 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] fetch: convert strncmp() with strlen() to starts_with()
In-Reply-To: <xmqqfrxhjujr.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
	24 Feb 2024 15:45:28 -0800")
References: <cb94b938-03f9-4dd3-84c1-f5244ca81be3@web.de>
	<xmqqfrxhjujr.fsf@gitster.g>
Date: Mon, 26 Feb 2024 09:11:55 -0800
Message-ID: <xmqq1q8zduas.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 253BFA7E-D4CA-11EE-95AA-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

>> -		     !strncmp(rs->items[i].src,
>> -			      ref_namespace[NAMESPACE_TAGS].ref,
>> -			      strlen(ref_namespace[NAMESPACE_TAGS].ref)))) {
>> +		     starts_with(rs->items[i].src,
>> +				 ref_namespace[NAMESPACE_TAGS].ref))) {
>
> The original tries to check that "namespace" fully matches the
> initial part of .src string, which is exactly what starts_with()
> does.  Makes sense.

There are two more such instances in the codebase, easily found with

        $ cat >contrib/coccinelle/starts_with.cocci <<\-EOF
        @@
        expression string, prefix;
        @@
        - !strncmp(string, prefix, strlen(prefix))
        + starts_with(string, prefix)

        @@
        expression string, prefix;
        @@
        - strncmp(string, prefix, strlen(prefix))
        + !starts_with(string, prefix)
        EOF
        $ make contrib/coccinelle/starts_with.cocci.patch

which finds the one you just fixed (naturally, since the Cocci patch
was written by taking inspiration from your fix).

Here is one in the reftable code.  The other one is in xdiff/ I'd
rather not touch (as starts_with() is probably not available there).

diff -u -p a/reftable/refname.c b/reftable/refname.c
--- a/reftable/refname.c
+++ b/reftable/refname.c
@@ -103,7 +103,7 @@ static int modification_has_ref_with_pre
 			}
 		}
 
-		if (strncmp(ref.refname, prefix, strlen(prefix))) {
+		if (!starts_with(ref.refname, prefix)) {
 			err = 1;
 			goto done;
 		}
