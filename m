Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB9C18C08
	for <git@vger.kernel.org>; Fri,  9 Aug 2024 15:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723218372; cv=none; b=miX79F8w18BaYyPtL+ngNRxKNqDercDs/CSsTvt/8CgHQJtBK/dIZW8RTI4VGHYjIrT9xKTuX3XfX6qmN3ef4XNikl8ScLO7jJgZKtEXlp8bMdMxxr/4xv2+g+kru2ATeOrhCS600Zbh1QLSoTMQ0HXgcEKfVQMTfgW1u678crs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723218372; c=relaxed/simple;
	bh=LRwwDCj/mRIT4oHqc/Qbyc4bQ8PpI0VgpL9pLzdD5C8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FL/nkGdedyLF/0934KddjqtJ1I2tIZrQgLnk77X1Er6fFlUzINheTzztDPpDOoy72BB5k+pL1gDhA5m+gF8jilUE3jhkkrS7ChBp+Ff6ShjhcTvManiIv2o2r/EWENm+jtRuPD1wNiRHUe13KB4C12VDLRm+Ke49GcnpJfhxiGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=MrlvKl17; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MrlvKl17"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7A5972C6C0;
	Fri,  9 Aug 2024 11:46:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=LRwwDCj/mRIT4oHqc/Qbyc4bQ8PpI0VgpL9pLz
	dD5C8=; b=MrlvKl17knvDC3TEsuQNSiTZX5I32fV+sERb4LNHeEHHF69N1Iq6uf
	YUZVFjkPUiRUIXx3tzD2MYKdWjH/FPV2A/tnhRYEj9JH3ssfViCPOxBPzL+Y5q3l
	6i80G8MLZ+VfpP+JNlIqQVErj2YbazTAXv6mE0uuGVXIl3P5qt6rk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 73A3C2C6BF;
	Fri,  9 Aug 2024 11:46:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E02122C6BE;
	Fri,  9 Aug 2024 11:46:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "blanet via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  blanet
 <bupt_xingxin@163.com>,  Xing Xin <xingxin.xx@bytedance.com>
Subject: Re: [PATCH v2] diff-tree: fix crash when used with --remerge-diff
In-Reply-To: <xmqq5xs9g19w.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	09 Aug 2024 08:32:27 -0700")
References: <pull.1771.git.1723123250958.gitgitgadget@gmail.com>
	<pull.1771.v2.git.1723188292498.gitgitgadget@gmail.com>
	<xmqq5xs9g19w.fsf@gitster.g>
Date: Fri, 09 Aug 2024 08:46:08 -0700
Message-ID: <xmqqy155em2n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7F9B97D6-5666-11EF-934D-9B0F950A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> but I have to wonder if we do even better in a future follow-up
> patch.

"if we do" -> "if we can do".

> So wouldn't it work well if we
>
>  (1) at the beginning of do_remerge_diff(), only once for a rev_info
>      structure:
>    (1-a) lazily do the "object directory rotation"
>    (1-b) set up an atexit handler to clear the temporary object
>          store

An atexit handler may not be enough, when a program wants to start
creating a real object after we did a remerge-diff but before
exiting. So we'd probably need to allow an explicit "ok, we are
done" clean-up call for such a program, too.

And the atexit handler can call the same clean-up function if the
program hasn't called it explicitly.  For logically read-only
operations like diff-tree, they do not have to worry about rotating
the real object store back to the primary status as soon as
possible.

