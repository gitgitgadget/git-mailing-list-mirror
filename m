Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19AA16CD03
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719848379; cv=none; b=g56w9rt+Y2ry/wVthjnIg0Bzsw/+pKRLEjSHx7CPXwg2/CW4KBpalcbaR7y1AFymcC2bRWOAm7zMsCT7fibUFXl5PbmEXd/vK6QtFARxwEBAChct6GnFjmyNvoKMlnqhGe6zqvYDpXq3dvu3hY1Jd2Xzy6ldSQDP8ilEYwX5TIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719848379; c=relaxed/simple;
	bh=eiMDjiv1DYFKEte6F3oltFDACj6BNSmxIRN+B+bIHrU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tGvCWfwVnVUgIm9WLGZlSEGwCmG6r3gvbn9qgDMNC4yvTpGy37XCX4KkdKucnoHvUDf4z62YZPMNTU6BkxdVpauy8v2x7EOru0cdGCVlKufAyXKkqEW36ms/83wJqcn/6IzLnpqHFhws2XaM+ifQM9D/4ezTml/i2G+9IQImasU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=TAwRUPtn; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TAwRUPtn"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A638E28F72;
	Mon,  1 Jul 2024 11:39:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=eiMDjiv1DYFKEte6F3oltFDACj6BNSmxIRN+B+
	bIHrU=; b=TAwRUPtn3P6UTtxDcnkwa1mX8ANCTOZLfu+DMnaTFebizDl9mIKgsT
	tFNonpF5KEj9Kr7Tyrr+AHPzUvnX9Vgibow+3flVZOquthnHQna2NYEl20VspAfD
	2kaoaVXlBJJRR/k9Bhst95wZ7zJSRh1G5Mma5cxE3FpySSuZwBUKg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 9F65F28F71;
	Mon,  1 Jul 2024 11:39:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 46F4428F70;
	Mon,  1 Jul 2024 11:39:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Pavel Rappo <pavel.rappo@gmail.com>
Cc: Git mailing list <git@vger.kernel.org>
Subject: Re: Determining if a merge was produced automatically
In-Reply-To: <CAChcVu=Kwqj7JhXqQW6Ni9+3TdSfdmHfSTJQWm1_uO2kczSm8g@mail.gmail.com>
	(Pavel Rappo's message of "Sun, 30 Jun 2024 19:06:24 +0100")
References: <CAChcVu=Kwqj7JhXqQW6Ni9+3TdSfdmHfSTJQWm1_uO2kczSm8g@mail.gmail.com>
Date: Mon, 01 Jul 2024 08:39:26 -0700
Message-ID: <xmqqle2lyvdd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1A1B85E8-37C0-11EF-9025-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

Pavel Rappo <pavel.rappo@gmail.com> writes:

> I'm looking for a robust way to determine if a given merge commit
> could've been produced automatically by `git merge`, without any
> manual intervention or tampering, such as:
>
>   - resolving conflicts,
>   - stopping (`--no-commit`) and modifying,
>   - amending the commit.

This fundamentally cannot be done perfectly and it is by design.

The automated merge algorithms, backends, and strategies will
improve over time, so a merge attempted 7 years ago with the
then-current version of Git may have conflicted and required manual
resolution, but a newer Git you use to "look for manual intervention
or tampering" may have improved enough to resolve the same merge
cleanly and automatically.  Even if the person who created the merge
originally and you are using with the same version of Git, the former
may be using a custom low-level merge driver to resolve conflicts in
certain types of files better than the barebones textual merge driver,
while you do not have access to the same driver.

So you'd need to tighten the definition a bit more, at bit more like
constraints like "using the same version of Git" and "without any
low-level merge driver customization".

Now, with problem narrowed down a bit with tightened constraints.

> My initial idea was to re-enact the merge. If the merge failed, ...
> My second idea was to use `git show --diff-merges=dense-combined` ...
> My third idea was to use a recently added feature, `git show --remerge-diff`...

The first and the third are equivalent (the latter is an automation
of what the former would do).  The --cc output, as you said, is
about showing resolution that is different from any of the parents,
and serves the need quite different from what you are trying to do
(e.g., if the merge was created with "git merge -s ours", there is
nothing _interesting_ in the result from the "--cc"'s point of view),
but it is likely that you are interested in noticing such an unusual
"cauterizing the history" merge.



