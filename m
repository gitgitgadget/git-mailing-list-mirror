Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28A8259C
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 02:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718935443; cv=none; b=UNsd1t5SEwgQD7NTu4aQcnVfGAiNUaDX705WANYvTnwW7A5NuUy6uhTkUY7tKIhh/srECQbsc8P0XLE4MhRgHil0EBDdZiCDnhF3gPcyjlkGnpYh2TNpJCs484W1vrvfgORM3aHHudHl8RX+Ne/tolelcU7WSR0LwTMapGBjoiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718935443; c=relaxed/simple;
	bh=qzXvfNQxIyuGZbNo0hBj2T7/5xVHglBOYXj8UkiYf8I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IOe28HdxTyobuQ0HsnNsmWXJ2I5ko+qJPDFq8Z3QIPoLrxDhgcHebukv6vxDveCnqqdiX41xaYW1uGPHwlpiAwYsZLvOgwAZ+IGrFeg+Rm6dhMhMnXPBnOo7C+4zNvS7Nq1AhLPfnFj7hKUXn3xleiBQkkLCdga8wPsEEN27Lz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=hNLd9fpr; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hNLd9fpr"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7464C1C682;
	Thu, 20 Jun 2024 22:03:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=qzXvfNQxIyuGZbNo0hBj2T7/5xVHglBOYXj8Uk
	iYf8I=; b=hNLd9fprwAqOCzEoDmduvrL5B5nhfClZyDqBrW6IeUHVrzVM8C3sa0
	AU/VAQRHEhYAKMpYsZZOMlRvK9iG6tuTB/CPxCrk4G0y7kBZNqwE8q3dryCLbQDx
	BBGr4WCCae9fh4x0IZuFr5w7Ezjrsh8GnV7jllkPAC/rtlgRcUYj4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6D1871C681;
	Thu, 20 Jun 2024 22:03:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0F6241C67D;
	Thu, 20 Jun 2024 22:03:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Stefan Haller <lists@haller-berlin.de>
Cc: Git <git@vger.kernel.org>
Subject: Re: Thoughts about the -m option of cherry-pick and revert
In-Reply-To: <e60a8b1a-98c8-4ac7-b966-ff9635bb781d@haller-berlin.de> (Stefan
	Haller's message of "Thu, 20 Jun 2024 12:05:45 +0200")
References: <e60a8b1a-98c8-4ac7-b966-ff9635bb781d@haller-berlin.de>
Date: Thu, 20 Jun 2024 19:03:46 -0700
Message-ID: <xmqqa5jfoxvh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7F5463C2-2F72-11EF-9FAD-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

Stefan Haller <lists@haller-berlin.de> writes:

> I have two questions:
>
> - What are real-world scenarios where you would use a mainline number
>   other than 1? I could only come up with a single example myself, which
>   is that you have a topic branch, and right before merging it back to
>   main, you merge main into the topic branch; and then you merge it to
>   main with a fast-forward merge. If you then want to cherry-pick or
>   revert that topic, you'd have to use -m2 on that last merge from main.
>   Any other examples?

I do think your example is a real issue that is helped by using -m2;
I do not think of any other cases offhand myself.

> - Wouldn't it make sense to default to -m1 when no -m option is given?
>   It seems that this would do the expected thing in the vast majority of
>   cases.

I do agree -m2 or higher would be rare when doing "git revert".  

Given that the current behaviour was chosen to make sure that the
user is aware that the commit being reverted/cherry-picked is a
merge and has a chance to choose the right parent (as opposed to
blindly picking the first parent that happened to be the right one
by accident), I am not sure if it is prudent to change the
behaviour.

If I were simplifying this, I would probably

 (1) disallow cherry-picking a merge (and suggest redoing the same
     merge, possibly after rebasing the copy of the merged history
     to an appropriate base as needed), and
 (2) allowing reverting a merge only wrt the first parent,

but that is a different story.
