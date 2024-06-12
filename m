Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0994391
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 22:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718230298; cv=none; b=h4lcYEySJAg82D1tXQWHy1QtmAAErF8goHmWFgr3v330rlJbTUcMfBwu2JCaFylqfGIyNR1Eo/TmifC/xiLlSLYLVQng4R/E/PHLXnE+LmtJ8NljCI8T+9VFxo2gWTGHiEdDHrC9XX0+xDDG2q4otjuUUK/7+hZC0AjcBH232zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718230298; c=relaxed/simple;
	bh=dmC0INgunbwpOZYwIfJhsbsjPI/DRSFics/27AxioI0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Sz5xbKTUBgIZVsv/K4wQWb1lq+XOI+H+S/yDAREX+6KCk18zjadv0qxu7TFRGKTwZfEgp65H6fSvfxIj8s5+uMUtDiSBHX4jIEw/WDfll7dKHYK3yQWeXRb7qLCABj97m/DT/oceP/Gh4wtj6nunnh3bCx9fqBmCOvpKneWHKUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=iOkYgaKx; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iOkYgaKx"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0892B306A2;
	Wed, 12 Jun 2024 18:11:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=dmC0INgunbwpOZYwIfJhsbsjPI/DRSFics/27A
	xioI0=; b=iOkYgaKxWs1AbdpAbeybkgmeYMrb+Z9uglTluXLWgxvegRDAppO/L4
	fgyb9egOwJzlbgbbJwO8xEN0gNQz2MXcvQRixr7upp4aLiZNF8qyROrcgeBupgOS
	h+EBOMWoiBlJosFXlLo2AuZiT3RkOWo20JjRn3lqknJN3p6sSw89A=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 01468306A1;
	Wed, 12 Jun 2024 18:11:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 95F17306A0;
	Wed, 12 Jun 2024 18:11:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 2/2] ci: compile "linux-gcc-default" job with -Og
In-Reply-To: <xmqqed946auc.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	10 Jun 2024 09:06:51 -0700")
References: <cover.1717655210.git.ps@pks.im> <cover.1718001244.git.ps@pks.im>
	<03270d3414117ae7229d87127cff81e349557039.1718001244.git.ps@pks.im>
	<xmqqed946auc.fsf@gitster.g>
Date: Wed, 12 Jun 2024 15:11:30 -0700
Message-ID: <xmqqo785olpp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B9D991F4-2908-11EF-B85B-C38742FD603B-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> We can squelch the warning by initializing the variable to a
> meaningless value, like 0, but I consider that such a change makes
> the resulting code a lot worse than the original, and that is not
> because I do not want an extra and meaningless assignment emitted
> [*2*] in the resulting binary whose performance impact cannot be
> measured by anybody.
>
> It is bad because it defeats efforts by compilers that understand
> the data flow a bit better to diagnose a true "used uninitialized"
> bugs we may introduce in the future.  Adding such a workaround goes
> against the longer-term health of the codebase.
>
> For example, I could add another use of mtimes_size that is not
> guarded by "if (data)" right next to it, i.e.
>
>         @@ -87,6 +87,7 @@ static int load_pack_mtimes_file(char *mtimes_file,
>                 if (ret) {
>                         if (data)
>                                 munmap(data, mtimes_size);
>         +		printf("debug %d\n", (int)mtimes_size);
>                 } else {
>                         *len_p = mtimes_size;
>                         *data_p = data;
>
> gcc-13 does notice that we are now truly using the variable
> uninitialized and flags it for us (gcc-12 also does notice but the
> important difference is that gcc-13 refrained from warning at the
> safe use of the variable that is guarded by "if (data)").

By the way, I do not know if any compiler gives us such a feature,
but if the trick to squelch a false positive were finer grained, I
would have been much more receptive to the idea of building with
different optimization level, allowing a bit more false positives.

The workaround everybody jumps at is to initialize the variable to a
meaningless value (like 0) and I have explained why it is suboptimal
already.  But if we can tell less intelligent compilers "we know our
use of this variable AT THIS POINT is safe", e.g. by annotating the
above snippet of the code, perhaps like this:

                if (ret) {
                        if (data)
				/* -Wno-uninitialized (mtimes_size) */
                                munmap(data, mtimes_size);
			printf("debug %d\n", (int)mtimes_size);

then it would be clear to the compiler that understand the
annotation that inside that "if (data)" block, we know that
the use of mtimes_size is not using an uninitialized variable.

For the use of the same variable on the next "debug" line, because
it is outside of that "if (data)" block, the annotation should have
no effect, and the compiler is free to do its own analysis and we
will accept if it finds mtimes_size can be used uninitialized there.
Any new use added for the same variable will not be masked by a
meaningless initialization if we can use such a "workaround" to
squelch false positives.
