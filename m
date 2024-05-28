Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2855F175AB
	for <git@vger.kernel.org>; Tue, 28 May 2024 18:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716920187; cv=none; b=C25Rhs4co6i/ZGrQcxH5GzoOB2MiXLbGD8mT5oQRRytcgnPHKHsICSPn5QW/lgE9wz0NmXQX/SMtBF4D+1Q3l358e7BJrzerkFIaPWyuXfaW9JEftZoQLo77RyFBw+oNSdqzgBkYxJzqb3xdlFdOTBPn6lZ56vQAlMdmIoqMS5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716920187; c=relaxed/simple;
	bh=euzKW4aKgFlzeYDqElFB33TnMKr2cHpAtJnhJ+PV21w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f/HH9hOH6mNnYET3pN3M1R/XQaaltM6Ts0J6GXi1bdOt0GvXGOY4xTZnAsa8QoeK0U67tRIlrMLu8GC3zU3yDDjF0mzqpvBbsz13pgAXFec4BuavzTqAT7JE1My83uEw/Vk7I5jonb3wQcXH7hC5zSToxHBPGEEB6LL8I4rAEzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=mboJa1/K; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mboJa1/K"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E04C2AD3A;
	Tue, 28 May 2024 14:16:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=euzKW4aKgFlzeYDqElFB33TnMKr2cHpAtJnhJ+
	PV21w=; b=mboJa1/KiAOhmmCk2jiGMoXaX4bf8RZKPyqU2TyM31gpra5ysA17T5
	qNtM1LqUsP0RLe/pSmVnQ0gbXDJZ23NpVgWAljsRaRYZbZM5u19Uvg0mH6egyume
	uYIf+gAfFDsAQ/XcOAL7mZNyl1gSdhwnjFkpYnlKXbP5a5r5ApZss=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 76F902AD39;
	Tue, 28 May 2024 14:16:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E14072AD38;
	Tue, 28 May 2024 14:16:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  Ramsay
 Jones <ramsay@ramsayjones.plus.com>,  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v3 00/12] refs: ref storage format migrations
In-Reply-To: <cover.1716877224.git.ps@pks.im> (Patrick Steinhardt's message of
	"Tue, 28 May 2024 08:31:10 +0200")
References: <cover.1716451672.git.ps@pks.im> <cover.1716877224.git.ps@pks.im>
Date: Tue, 28 May 2024 11:16:17 -0700
Message-ID: <xmqqo78p4xam.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 613CF8C4-1D1E-11EF-8D88-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>   - Swapped out calls to `remove_path()` to `unlink()`. We do not want
>     to walk up and remove empty parent directories, even though this is
>     harmless in practice.

Hmph.

It is customary to remove a directory when the last file in it gets
removed in the working tree, because Git tracks contents and does
not track directories, and it seems that the files backend does the
equivalent in the files_transaction_finish() method with
unlink_or_warn() followed by try_remove_empty_parents().  If we are
transitioning from the files backend to the reftable backend, don't
we want to end with no loose ref files under $GIT_DIR/refs/ and no
empty directories to house those loose ref files that would be
created in the future?

Let's find out why this is needed in [10/12].  It may just be a
simple matter of "let's not bother removing directories as we remove
loose ref files one by one---we know the whole hierarchy can be
removed after we are done", in which case I do think it is nicer.

>   - Release the reftable refdb before removing it. This closes the
>     cached "tables.list" file descriptor, which would otherwise break
>     removal of this file on Windows.
>
>   - Fix a bug with worktrees where we store the current worktree refdb
>     twice. This caused us to keep file descriptors open, which breaks
>     removal of the refdb on Windows.

Wow.  Windows' limitation sometimes helps us catch real bugs ;-).

Thanks, will replace to take a look.
