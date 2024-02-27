Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B0B4CB4B
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 17:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709055244; cv=none; b=lJPERxg5NOC7SV7hDjmbUiUuhPJrK9XVIWuHdEIbVwX+Y4NH4In57ISzo3uWg9q6Edrlv71SKwat8JJwfz/RiQ70uFy6I9iVoQPh7A8U5arbqSCbM9B57rQOq5SS4nqhwnBk/eafzEapg8k0CTrqjnnHW2NacS7Oo0paRyrpN7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709055244; c=relaxed/simple;
	bh=8naWeSgmverc13mGVXzbLNaNLGpbZdYVKswb+fjrevQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t9L64LaW31Y5G63e7mj06/lCbxm+uGh8N/xOQEUw9rIOHgLyJyDsIt6qRKe7Nkg+pnAN2Oaeg0J+Zh6piK7pps/R3u0xypTfUdaWyR1+UXfhRoP2x22NelwaE/oC10eXk05kc1mzWe6Nzoipb5GimAj27fyn/JLZLr+S0xHDxcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=WtSh6DyH; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WtSh6DyH"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 753B71DCB7C;
	Tue, 27 Feb 2024 12:34:01 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=8naWeSgmverc13mGVXzbLNaNLGpbZdYVKswb+f
	jrevQ=; b=WtSh6DyHA3hm7EK4Qq0DlLUp7uWOXEaKBbTLhkG/DhDsGO8otwuab/
	9HobbFRlEHtxtdCD2+j08i73hAV9/9KTj9h82hdFfFCrppovjCpPxm8eIRJsjb7c
	0bkWD7IiYfTuqxGadzoz/+Oazg+573IoHWJ3COnjWdQzCNPFgLlVk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F4531DCB7B;
	Tue, 27 Feb 2024 12:34:01 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 648241DCB7A;
	Tue, 27 Feb 2024 12:34:00 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: phillip.wood123@gmail.com
Cc: Brian Lyles <brianmlyles@gmail.com>,  phillip.wood@dunelm.org.uk,
  git@vger.kernel.org,  newren@gmail.com,  me@ttaylorr.com
Subject: Re: [PATCH v2 8/8] cherry-pick: add `--empty` for more robust
 redundant commit handling
In-Reply-To: <1004c565-ee6c-4aa4-8226-47d0ef7c8631@gmail.com> (phillip's
	message of "Tue, 27 Feb 2024 10:39:33 +0000")
References: <17b74c2ffa1884ed.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
	<1004c565-ee6c-4aa4-8226-47d0ef7c8631@gmail.com>
Date: Tue, 27 Feb 2024 09:33:59 -0800
Message-ID: <xmqqttltu7zs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 64947EFE-D596-11EE-9EA1-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

phillip.wood123@gmail.com writes:

>>>> I do not quite see a good reason to do the opposite, dropping
>>>> commits that started out as empty but keeping the ones that have
>>>> become empty.  Such a behaviour has additional downside that after
>>>> such a cherry-pick, when you cherry-pick the resulting history onto
>>>> yet another base, your precious "were not empty but have become so
>>>> during the initial cherry-pick" commits will appear as commits that
>>>> were empty from the start.  So I do not see much reason to allow the
>>>> decoupling, even with the new "empty=keep" thing that does not imply
>>>> "allow-empty".
>>>
>>> Junio -- can you clarify this part?
>>>
>>>> So I do not see much reason to allow the decoupling, even with the new
>>>> "empty=keep" thing that does not imply "allow-empty"
>>>
>>> I'm not 100% sure if you are saying that you want `--empty=keep` to
>>> *also* imply `--allow-empty`, or that you simply want
>>> `--keep-redundant-commits` to continue implying `--allow-empty`
>>> *despite* the new `--empty=keep` no implying the same.
>
> FWIW I read it as the latter, but I can't claim to know what was in
> Junio's mind when he wrote it.

Given that "drop what was empty originally while keeping what became
empty" would "lose" what it wanted to keep (i.e. the one that has
become empty") when used to cherry-pick the result of doing such a
cherry-pick, I do not think allowing such combination makes as much
sense as the opposite "keep what was empty originally while dropping
what became empty", which does not have such a property.

And it does not matter if that is expressed via the combination of
existing --allow-empty and --keep-redundant-commits options, or the
newly proposed --empty=keep option.  If we start allowing the "drop
what was originally empty and keep what has become empty"
combination if we make empty=keep not to imply --allow-empty, I do
not think it is a good idea.

That was what was on my mind when I wrote it.  It may be that I was
not following the discussion correctly, and making "empty=keep" not
to imply "allow-empty" does *not* allow a request to "drop what was
originally empty, keep what has become empty".  If that is the case,
then I have no objection to making "empty=keep" not to imply
"allow-empty".

Thanks.
