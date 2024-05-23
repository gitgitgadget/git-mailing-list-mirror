Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29651CA92
	for <git@vger.kernel.org>; Thu, 23 May 2024 16:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716482754; cv=none; b=KwYGI7xT7mwy5iemPLVQEm3DL8lBUiGDivldutgA8w9Eh0GJy3xkgZA1axWEcGCIqIaU4TAo+5FssuAxbpcQeyiTGtmX7xh77teYMTMHBi9ghV4JlZcoqsf8uCHxkCea+UYbk1wUqkRx134+wT+boBf2rOAjdQW0+erdiDF/MZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716482754; c=relaxed/simple;
	bh=k8izJOroDV0WcvMabdSuXJQIVfodfHuqqt3nrh5vXpE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ULKI0QtBlxtM+alTHD/hlAaQEbQ5N9sR3uCHDvaEutbfeqiHdjR0SsPxcTvTE2jJtIRuf9TvnEnFuewtwizdigR+B6IPX0zHS4JrL7o/OqB7i6rLcDk+a4e8IU1C4mFZi3ZjObUcFQjBPiG7wayWnXGuaDSfUII8G7NtHU6W5a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=nhq81eKU; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nhq81eKU"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1F5A921224;
	Thu, 23 May 2024 12:45:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=k8izJOroDV0WcvMabdSuXJQIVfodfHuqqt3nrh
	5vXpE=; b=nhq81eKU5wTi458MDnK5PDFFX0RWxN91xpLOHOeqnDm38VpshPdVyw
	wF+qM2KXonBRAxvq9qJB1Ly1xX1970lMDeuNZJ9eGgObogt5j/h4edq5x6/SNDfV
	ZaJPKtc3jskywhdUMVJ/UkwUDfuuLeMGqlBQd8B1IIqORzJ0kfEJs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 00BEB21223;
	Thu, 23 May 2024 12:45:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 97D6421222;
	Thu, 23 May 2024 12:45:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/20] Various memory leak fixes
In-Reply-To: <cover.1716465556.git.ps@pks.im> (Patrick Steinhardt's message of
	"Thu, 23 May 2024 14:25:09 +0200")
References: <cover.1716465556.git.ps@pks.im>
Date: Thu, 23 May 2024 09:45:47 -0700
Message-ID: <xmqqle40v5ms.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E8761ED2-1923-11EF-B50B-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> my mind had a couple of minutes where it was roaming, and of course it
> immediately searched for and chased down the next rabbit hole. The
> result is this patch series which fixes a bunch of leaks all over the
> place. There isn't really any structure to the leaks that I did fix --
> it's mostly things that I stumbled over. In the end, this series makes
> another 56 test suites pass with leak checking enabled, 13 of which have
> already been passing without any changes.

... meaning there were coverage gaps?

> While most things are unstructured, there are two topics that stand out:
>
>   - Patches 5 to 12 address a shortcoming of our config API. Both
>     `git_config_string()` and `git_config_pathname()` have a `const char
>     **` out parameter, but they do in fact transfer memory ownership to
>     the caller. This resulted in a bunch of memory leaks all over the
>     place.
>
>     These patches thus refactor a bunch of code and then ultimately
>     switch the out parameter to become a `char *`

I do remember getting hurt by this one relatively recently.
Addressing the issue is very much appreciated.

>   - Patches 16 to 20 have the goal of making git-mv(1) memory leak free.
>     I had a very hard time understanding how it tracks memory. I think
>     this wasn't only me, or otherwise there wouldn't be calls to
>     `UNLEAK()` in there. In any case, I decided to rewrite the arrays to
>     use a `struct strvec`, which makes tracking and releasing of memory
>     a ton easier.
>
>     It does come at the cost of more allocations because we may now
>     duplicate strings that we didn't before. But I think the tradeoff is
>     worth it because the number of strings we may now duplicate is
>     bounded by the number of command line arguments anyway.

Nice.  I have to admit that "git mv" is not one of the best-done
code in this project X-<, and improving it with rewriting was long
overdue.

Thanks.
