Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB5F19D07C
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 16:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721923929; cv=none; b=j/u25RXBnqOlyOrxcONhmuM1DoD2UUAkzE0pYctK3fyjlrJhgFECO89yDMz41p3R1XxeWdx0wxi6s95cvkOwJW8AAz+FP3VSExId5ysy6b3iBggSvd8kJreM22Yyz+UWMxUhuOQBW+yH8737ieI2U2M1XOyYWP0EizjxYz4BSio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721923929; c=relaxed/simple;
	bh=2r2j9XSGCU4cWrjX+WJ63vUHZKS94kVt8olyVI+wJ5g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qx3cWSQHKNJV1SwLEiN0P25km/9qWH1fjRKEe0+frHw7JIjJ7K4XvSW+k/KQ81rd/dTmOOBAvUQIP6fPRoNOmBY7nW0BRB60KSmfVSfZjy378HVSVdzfNXErKWex0v1dS3tvfaA54uNvYaVC6bk3jMbb2KgetOlZCGJsMc4kBkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=uDW0Gi8P; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uDW0Gi8P"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 593E119F88;
	Thu, 25 Jul 2024 12:12:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=2r2j9XSGCU4cWrjX+WJ63vUHZKS94kVt8olyVI
	+wJ5g=; b=uDW0Gi8P6TOeWLcpNg5x/0V6XUd6CkuAJfhGQdb6tWsv4OA+7KTlJC
	upRylW4guHYanerftsnzdStG6Vvq4+hQIxBKZrPsKuTcDco52+7HalEwOfPzbAgr
	yv23gc7F4z+dgSVcdKDid5qMhPe5OD9U5VA/VJaawsoQrZod3kXaw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5027319F87;
	Thu, 25 Jul 2024 12:12:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D01F119F85;
	Thu, 25 Jul 2024 12:12:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] safe.directory: setting safe.directory="."
 allows the "current" directory
In-Reply-To: <ecfd53a7-645b-4e8b-a1e7-17ee5c782ad4@gmail.com> (Phillip Wood's
	message of "Thu, 25 Jul 2024 10:45:41 +0100")
References: <20240720220915.2933266-1-gitster@pobox.com>
	<20240723021900.388020-1-gitster@pobox.com>
	<20240723021900.388020-4-gitster@pobox.com>
	<ecfd53a7-645b-4e8b-a1e7-17ee5c782ad4@gmail.com>
Date: Thu, 25 Jul 2024 09:12:02 -0700
Message-ID: <xmqq7cd9jvsd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A1A10BDA-4AA0-11EF-822C-92D9AF168FA5-77302942!pb-smtp20.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Junio
>
> On 23/07/2024 03:19, Junio C Hamano wrote:
>> When "git daemon" enters a repository, it chdir's to the requested
>> repository and then uses "." (the curent directory) to consult the
>> "is this repository considered safe?" when it is not owned by the
>> same owner as the process.
>> Make sure this access will be allowed by setting safe.directory to
>> ".".
>
> Setting safe.directory to "." should be unnecessary after the previous
> two patches. It might be better to test that "git daemon" works
> without safe.directory containing "." instead.

Hmph.  Even without the two previous steps, it was a working
workaround, wasn't it?
