Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8949B13D521
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 17:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718989527; cv=none; b=fnP2icC4xbY0zbYdt/72+mKS+8JT4LLv2J434QG/5PD9FGyj/TCSj45yqwlx1SxxEzsn9PQt/PgW6vcRw/OGhc+hZvOdRdmGEz7B/zVfFKMFAnJiWKeH+bQ2E5ncQipUq2c1DALBPFD0lS0Cb2ZYX+K61QcsSiBalUN8dTkTAKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718989527; c=relaxed/simple;
	bh=WYrwSD5dTsZv8jb/GgW5EybXPadV0BYc2DuEcmu0/rI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B0fsFik8+GsonWF2UCr5gJwrcaaW86Yzs7K+Jwt9xG5xb3PwBbaPiG21+MELqC+VRdPOxL8iUQKTyWRXFlLE2kpvnK1vHR6zPTouCeK1J2Uri2LZV852b5B34CXp8oXaApHmKIu448b573ByZTShBSpH9euEEa0ei2MQWbE3IeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=uSvGKGXK; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uSvGKGXK"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 801762155E;
	Fri, 21 Jun 2024 13:05:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=WYrwSD5dTsZv8jb/GgW5EybXPadV0BYc2DuEcm
	u0/rI=; b=uSvGKGXKCxs56qLOGQSZiDsQfxo9HA72e5AtbdUNA0eOzgH9MsDvcj
	lAPY/Utm/BBkzgAWOLGfLwo878pgK/OMXOydVoK/504ZgPMHeXHLPz0MaIxrKM2h
	fxUeG6vmiaHQ8cVLCe1zPoMA/vhBDEplgoQqTUwm5MK3sVak//dhg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 790B02155D;
	Fri, 21 Jun 2024 13:05:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D5B712155C;
	Fri, 21 Jun 2024 13:05:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Rob Linden <rlinden@redhat.com>
Cc: git@vger.kernel.org
Subject: Re: problem with parsing of patch files for patch-id
In-Reply-To: <CAP0H_AEd1jFNB_dO=HRjwEUKzFqnjntss_1wskKU6hE1VmBs+A@mail.gmail.com>
	(Rob Linden's message of "Fri, 21 Jun 2024 12:33:10 +0200")
References: <CAP0H_AEd1jFNB_dO=HRjwEUKzFqnjntss_1wskKU6hE1VmBs+A@mail.gmail.com>
Date: Fri, 21 Jun 2024 10:05:23 -0700
Message-ID: <xmqqbk3uns4s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 738AFE60-2FF0-11EF-B2A6-965B910A682E-77302942!pb-smtp2.pobox.com

Rob Linden <rlinden@redhat.com> writes:

> This patch (also attached) fixes it by only considering commit hashes
> in a "From xxxxx..." line:

If I am not mistaken, "git patch-id" was designed to read from

    git rev-list ... commit range ... | git diff-tree --stdin -p

where we see

    9005149a4a77e2d3409c6127bf4fd1a0893c3495
    diff --git a/path b/path
    index ...
    ... patch text here ...

so I would suspect that limiting the commit object names only to
those that follow "From " (i.e. the format-patch output or output
with the "--format=email" option) would break existing use cases big
time.
