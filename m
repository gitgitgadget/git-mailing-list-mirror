Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D737B662
	for <git@vger.kernel.org>; Thu, 23 May 2024 23:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716507150; cv=none; b=m3hJJeGoy3rAGcSTFJUCbszvgrPgw8qoqDoAkuuvTXzKavHDORJuGt2+YOojOBSJAsrUPQwF13D/a0mNeKHVmZWSEG1hM9gtXBJQbQrRF+XuZUnF/cyQkngYdHd6+IefQLxsDOl8PHyS18j+J+BwaqeHZ5I/VTDNGt9QAKlaRJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716507150; c=relaxed/simple;
	bh=FF68F5RPyanauffYm17RuBNv6fmKygunQL2BR+RSoEE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AuNv+hVoOFUakQPy91h76n2aUmmU7iy2GHSibOGqa9Wzmak521mcYQSOsDP1xyPRLcLI94A+WaOzsWXsGy/RMQDjLa4vozvbTVbaFgZk49M1pCK5LLOszUspvLw6JDlSBRqbUWXNpFIYMfqcyHIY7e1CuuDqVIwsSGwXyzyB/Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=pY2Z+23Q; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pY2Z+23Q"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1BB2C347CF;
	Thu, 23 May 2024 19:32:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=FF68F5RPyanauffYm17RuBNv6fmKygunQL2BR+
	RSoEE=; b=pY2Z+23QJOi3Zzl7J+s9Xsdl0cJ+rZNEm0EawEmz8+tjjifL/hux8A
	17oWo1WtrhXGJaFJ1NtEIcI6oPpYMnkV85Sw/uQrW0qKE/yAXU6cA5WJOz1+8rZL
	XITAd0zkYhbrvtv9LYK/Eci1/ci4aVaorxX224vGimMQMT+kcK9eA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 13587347CE;
	Thu, 23 May 2024 19:32:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7330A347CD;
	Thu, 23 May 2024 19:32:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org,  Joey Hess <id@joeyh.name>
Subject: Re: [PATCH 00/12] Fix various overly aggressive protections in
 2.45.1 and friends
In-Reply-To: <xmqqv835xekc.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	22 May 2024 22:49:55 -0700")
References: <20240521195659.870714-1-gitster@pobox.com>
	<Zk3ChIHr5amGh8Mt@kitenet.net> <xmqqv835xekc.fsf@gitster.g>
Date: Thu, 23 May 2024 16:32:25 -0700
Message-ID: <xmqqy180p0ja.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B6B65F90-195C-11EF-A977-25B3960A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Joey Hess <id@joeyh.name> writes:
>
>> Please also revert it, or at least the portions for 
>> and symlinkPointsToGitDir and symlinkTargetLength. The
>> checks for symlinkTargetBlob and symlinkTargetMissing seem worth
>> keeping.
>
> Looking at the change in question, in a33fea08 (fsck: warn about
> symlink pointing inside a gitdir, 2024-04-10), you said:
> ...
> So, I am ambivalent.  I have prepared a revert queued on maint-2.39
> and cascaded it up to the maintenance track, which I tentatively
> queued on top of 'seen', to see how much damage such a reversion
> involves (and it did not look too bad), but
>
>  (1) I am not sure if this is such a huge deal that requires a
>      revert;
>
>  (2) I am not sure which one is more practical between ripping
>      everything out and demoting these new fsck error types with
>      FSCK_WARN to FSCK_IGNORE.  If the structure of the code to
>      perform these checks is more or less good and the actual check
>      the code implements is bad, the latter might give us a better
>      foundation to build on than rebuilding everything from scratch.
>      On the other hand, if we are redoing things in the open, it may
>      be better to forget about the code in 2.45.1/2.39.4 and to build
>      from scratch for those reviewers and developers who will offer
>      help.
>
>  (3) As I look at the change by a33fea08 again, it actually adds a
>      few new fsck error types with FSCK_ERROR.  Perhaps that is a
>      good enough reason to do a straight revert for now?
>
> Thanks.  It is past my bedtime so I won't be pushing out the 'seen'
> with the revert I prepared as a practice, at least tonight.

So at least for now, I've queued a full revert of the change in
question in the "revert over-eager layering-on-top changes" pile,
but as we haven't really seen anybody give good input to help me
decide what to do with this step, the pile is still kept outside of
the 'next' branch.  At least it is visible on 'seen' as of tonight.

Thanks.
