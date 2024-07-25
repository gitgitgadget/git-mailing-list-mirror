Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EFF78676
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 16:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721924058; cv=none; b=Jcj/GUcZD88HcPl7wSZ96G/vyI9ywy9+9iCqNlLcE6rQosiM9rhY79SHUidd2KbqjnhH8fOHBsclq63GJCTs87i8r8EJDoYv982yDVhU+8B7MZmm4ZSVfzfSpoYejDtrFVSrM5XOmNB8jANK7e+JS9iZlTYyOTN+jXeabSXlkf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721924058; c=relaxed/simple;
	bh=nlnu8nd6Q2dQgMOIrOXtkn7XbzYOiArU0IGs2LwRZDw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GgDiXf+s17PLtzgN1W3CrMLlxrlq+53dKiCjHPaLcLnVy578yUzn5UYtklWJniAtmd2Kj6hnn2M0DIYbo332GqE2LsB1g7ug3GhZ1/9VNA+0ZGkQ7iazSb3PgvkWNUBc2O2kiDKkKwxaq66WH1hu8lPtMe7oWOOD9ABrKn2TMyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=EU2yMQLU; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EU2yMQLU"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 3BBF529176;
	Thu, 25 Jul 2024 12:14:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=nlnu8nd6Q2dQgMOIrOXtkn7XbzYOiArU0IGs2L
	wRZDw=; b=EU2yMQLUPzpXbwUPPSIcv9TBgcimUrFAcKOtPY7uByI/fxaepC0e8h
	eCppkIcRBKAA4W1VbNl+gU/CXTW5XUkZLWCAQTXQGA24oeopvDl4NOh9ihzSi4jG
	HgFwowQFh4dV09ZNT5cpXAaXWNcYIkpdw7rwLBMJaiMcADPZKVTCQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 34F5929175;
	Thu, 25 Jul 2024 12:14:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BDE5629170;
	Thu, 25 Jul 2024 12:14:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 0/3] safe.directory clean-up
In-Reply-To: <d9d1115a-d530-479a-acf8-189713632adf@gmail.com> (Phillip Wood's
	message of "Thu, 25 Jul 2024 10:45:46 +0100")
References: <20240720220915.2933266-1-gitster@pobox.com>
	<20240723021900.388020-1-gitster@pobox.com>
	<d9d1115a-d530-479a-acf8-189713632adf@gmail.com>
Date: Thu, 25 Jul 2024 09:14:11 -0700
Message-ID: <xmqq34nxjvos.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EE797168-4AA0-11EF-BB46-9625FCCAB05B-77302942!pb-smtp21.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> Thanks for picking this up, I think this looks like a good approach
> apart from resolving relative entries in safe.directory which is
> intrinsically unsafe as we don't know which directory the user wants
> to consider safe. With these changes it should not be necessary to add
> "." to safe.directory to get "git daemon" to work and all the other
> code paths use an absolute path from getcwd() so I don't think there
> is any need to support relative directories.

I agree that we could limit to absolute, but that would mean we
would be breaking a configuration that used to work.  I do not want
to mix that into this topic.

> I'll be off the list for the next couple of weeks

I'd imagine it would be for a block of fun time?  Enjoy.

In any case, this topic won't be moving in the coming few weeks
anyway ;-)

