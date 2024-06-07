Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04F514F9D8
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 21:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717796948; cv=none; b=EYJqSqs26BYZ13cyPS1S9/Exbu0ufyzEMi8q86kiqvH0h9YHA1s84khZviyC9ir3hA9osR7CwzsN93FV330OofGUP6fMWkEfh+2XOajDcdlaLi7agYzI2AKYyydltFVXDAIukHEm47QGJkzEiUjmNJAhkbMwWITZkrSpB8u8vdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717796948; c=relaxed/simple;
	bh=YfL+/qaGYzjaVVVKn1B4nXMtUw4viSgdqAFe+WDwWPA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EMIWqleGk4NyEwTN1+21QlDMxGglr2GARYZeSMEM9TDXPheCINpR6/gFCuSwxsOCP5PIafHQApfEaEZqEmtXikZFh6Pq6PD8rVO0y6MnW0U+Abh9UK2CVfj43gh96I3XYRZCJC7AX/0+fRiBubazFiTTGU72n4COCZRiICchTto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Kzs0P9RB; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Kzs0P9RB"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5716018F0F;
	Fri,  7 Jun 2024 17:49:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=YfL+/qaGYzjaVVVKn1B4nXMtUw4viSgdqAFe+W
	DwWPA=; b=Kzs0P9RBxBmoQK9xcNw5zLYYjqjojF/w7UTew4dnWz7cpOX+7tMFxD
	VsN3kES39a/C2AkRR/qRXVaq0OmStGehe0N4tnSlTXDdSzGIVDbVjCt2nd7gRc6I
	Kl3/QqaGVQJRf3lrhzKxjTvyT5s/4EKfDjlKWTn/yB8OTFW6KcGd4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 3C93718F0D;
	Fri,  7 Jun 2024 17:49:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 563D218F0C;
	Fri,  7 Jun 2024 17:49:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH 2/2] server-info.c: remove temporary info files on exit
In-Reply-To: <ZmN/NZlriT3gsw7p@nand.local> (Taylor Blau's message of "Fri, 7
	Jun 2024 17:44:21 -0400")
References: <cover.1717712358.git.me@ttaylorr.com>
	<2d5a0536af1a6d45835622e2c020266079fa0873.1717712358.git.me@ttaylorr.com>
	<xmqqfrtog2rd.fsf@gitster.g> <ZmN/NZlriT3gsw7p@nand.local>
Date: Fri, 07 Jun 2024 14:49:02 -0700
Message-ID: <xmqqjzj0e84x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C18F6E86-2517-11EF-9E7B-8F8B087618E4-77302942!pb-smtp21.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

>> We no longer do so.  We later call rename_tempfile() to close the
>> underlying file descriptor and move the temporary file to its final
>> place, but I do not see what guarantee we have that we do not lose
>> what we had buffered in the stdio with the updated code.
>
> rename_tempfile() first calls close_tempfile_gently() before calling
> rename(). close_tempfile_gently() calls fclose() on temp->fp before
> returns, so we get our fflush() call implicitly there.

OK.  I didn't see that fclose().  Then we are safe.

Thanks.
