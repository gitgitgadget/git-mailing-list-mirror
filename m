Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C4813A3E7
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 19:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711741249; cv=none; b=OQXQlLu6I0wBUJIUUp7jgIRRC3/59mSIf3/yowDRd1YJoNRRy0dcXonNCwlxf6YxdBz/Ot+Bco3ZBx4hYRD5squVEakbWe/ynfe1e3z7LnXvbfi5Ui57WQehluJmq3BQhf8jP3CoEa41ZGZ7lW5hKUgrskUR/IZDbtWJLCz5nXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711741249; c=relaxed/simple;
	bh=dZrFIhbwjhS83TWIqcOXxcSBoyC7yLaropozpoD7v7w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JtRHANq5j/s+w0IlL7n59yo7kpPsnHE7RLlQO13+TIB6981pYSaBN0AqiPBXOifDslmZKg3gF06xv9cEqbbnwpPupbrt/YHgBpFBEeAB98kCXJFiTduzcef6V0AK6sviZ3Xqpboy6/lIMvD0WIfwNyCWNVNElgQgktbUaFOv9TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=STtaoKe7; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="STtaoKe7"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4E01F1E6D42;
	Fri, 29 Mar 2024 15:40:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=dZrFIhbwjhS83TWIqcOXxcSBoyC7yLaropozpo
	D7v7w=; b=STtaoKe7VJTyT3jzeKDvV05pFtDM03p6PMowyjdr6JCqUzzJekb5YK
	NuSkcypDS7V6JIffu3DVa/Bj3pN0nsoql60GK7Fm1OTGiQ+UWMk3hMEf3nKFotlt
	y1PhlPonyjCpae8Sw4edOO8UnDl6HmtHdZYuz9NYiiMKfZWztTTIc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 444401E6D41;
	Fri, 29 Mar 2024 15:40:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A5EA71E6D40;
	Fri, 29 Mar 2024 15:40:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Michael Ernst <mernst@cs.washington.edu>
Cc: git@vger.kernel.org
Subject: Re: Feature request: a merge strategy that makes any file
 difference a merge conflict
In-Reply-To: <CAAJCdQQB3_DWOTCTbb-TAkLUX_XVd5TBd3z0M2_KrHxKxr69Kw@mail.gmail.com>
	(Michael Ernst's message of "Fri, 29 Mar 2024 12:20:59 -0700")
References: <CAAJCdQQB3_DWOTCTbb-TAkLUX_XVd5TBd3z0M2_KrHxKxr69Kw@mail.gmail.com>
Date: Fri, 29 Mar 2024 12:40:45 -0700
Message-ID: <xmqqfrw8ygg2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3D128A16-EE04-11EE-BF0D-25B3960A682E-77302942!pb-smtp2.pobox.com

Michael Ernst <mernst@cs.washington.edu> writes:

> Git's built-in merge strategies, such as ort, sometimes create a
> clean-but-incorrect merge.  A merge driver or a mergetool cannot be
> used to correct such problems, because a merge driver or mergetool is
> only called when the strategy resulted in a conflict (so far as I
> understand).

A custom low-level merge driver is always called when selected via
the attribute mechansism (see how merge-ll.c:ll_merge() calls
find_ll_merge_driver()) and participates in a content-level 3-way
merge.

If you are trying to interfere with cases that a content-level 3-way
merge does not kick in (e.g., your side did not change anything in
the file since their history forked, and they modified the file; the
tree level 3-way merge will resolve it to take their version), then
it is true that the low-level merge driver is not invoked, but I
somehow get an impression from the above description that it is not
what you are trying to do.

> It is challenging to write a merge strategy, but it is
> much easier to write a merge driver or a mergetool.

A merge strategy is about performing three-way merge at the tree
level, figuring out which three variants of contents to hand to a
merge driver that handles the content-level three-way merge.  They
serve totally different purposes and comparing them is like
comparing apples and oranges.
