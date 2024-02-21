Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFEE84FDD
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 17:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708537453; cv=none; b=Ietqsa+3m2d70YMDWTeTApdumLQc/nLBKBd31RM5zJe4yUg6bDRJfx993nHJmj/vtTCsZOpEKGspV3JAyeY4ktVEepwaYCobBwAj2oRZq01JFIo9rk+hpMll9Srin5o9YmOmTIQuDIavD21yGfbMg5VaT6gyuze/xldFv+yLZKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708537453; c=relaxed/simple;
	bh=P+It86gl9avUeHN1F+Zq1acpOuJg7G1htR6VYgXtVG0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YsuZr0duy2mcg5IXLs1asI/0bb1EMxdAO3PFMMPs9tt7S/6TFan5pdhQtKX9kZOeo9pWb2R4zNjumZrgm6xwTFfavJ4ziFO+qoNpR6V+tcCEAFMxhHIpcUVTxg3sGIl/H1tN/UrLWIxKre891Ef4lsaQBwzPbhxmDC1qaORSoq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=h3dcN84C; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="h3dcN84C"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 026D31E52E2;
	Wed, 21 Feb 2024 12:44:11 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=P+It86gl9avUeHN1F+Zq1acpOuJg7G1htR6VYg
	XtVG0=; b=h3dcN84CLMvBzxCeKuK4jIhbfWvTOscKO/+7QAsMAmy5LwGHNVGp3I
	ReNEWvZXNwKTzNbeAxf1rs4cc/9ag2EQjkt0qPZxzWwVSihQliWBThdUy96fDLVf
	sw38SZiaqOWPqer2vPPLBt+k7WTp52PdXtj5aX1JiSGbiEI8AiQRE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id ED0991E52E1;
	Wed, 21 Feb 2024 12:44:10 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4A6891E52E0;
	Wed, 21 Feb 2024 12:44:10 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Yasushi SHOJI <yasushi.shoji@gmail.com>,  Denton Liu
 <liu.denton@gmail.com>,  Git Mailing List <git@vger.kernel.org>
Subject: Re: Segfault: git show-branch --reflog refs/pullreqs/1
In-Reply-To: <20240221084250.GA25385@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 21 Feb 2024 03:42:50 -0500")
References: <CAELBRWK-bZTV0qx6_34HAgpmYwy+5Zo2E0M+4B6yZJJ3CqweTw@mail.gmail.com>
	<20240221084250.GA25385@coredump.intra.peff.net>
Date: Wed, 21 Feb 2024 09:44:09 -0800
Message-ID: <xmqqv86hogpi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D19FB4D8-D0E0-11EE-94A9-25B3960A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> with an empty reflog file (added by that same commit). The code in
> get_oid_basic() to parse reflogs doesn't suffer from the same bugs: it
> checks up front that the reflog file exists, it preloads the output oid
> with the current ref value, and it doesn't look at other fields (like
> the reflog message).

It is a usability hack to allow foo@{0} to resolve successfully,
instead of causing a failure, when there is no reflog entries for
foo, I would think.  As to the "show-branch -g", the intent is to
see the recent evolution of the branch, so I am fine if we do not
give any output when no reflog entries exist (i.e. "no evolution
behind the current state---it just is"), or just one entry output
for "foo@{0}" to say "there is only one recent state".

Even though it may feel wrong to successfully resolve foo@{0} when
reflog for foo does not exist at the mechanical level (read: the
implementors of reflog mechanism may find the usability hack a bad
idea), I suspect at the end-user level it may be closer to what
people expect out of foo@{0} (i.e. "give me the latest").

Thanks.

