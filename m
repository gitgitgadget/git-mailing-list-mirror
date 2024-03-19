Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898E362818
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 15:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710861351; cv=none; b=GGnCD2ImoNcE9Al6ZkdqB7gvnjChs9sHwvq4GiBHVeh3mdyrftg34TN2R5BHRg9tLyrK1zCTdZUTcE6Fx+IBbySw8qwNE1IBTklC1dqINRuy5Jnef4DCFwwyYtMT5gaS7e4MTbg4s8pPYdbIWDfcEXWXRVMbjIACwhbrD05Gv2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710861351; c=relaxed/simple;
	bh=u9+/7OrzD2v4WIgiNjUrcwOiNhOK/U2NbeBysW5B2rc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fq4x7I7N1F33zaJxOMsuA3zUhGp1xaGFgwGNZW66cRe65r1t/IxeI+QjOapFXPvfArSjwTK/T5/Kh6CmQiwn5PVC0Muw31ucGGpaB072Lx4H6H9W2NJCl6ZyAmHf5q1HTSEQ2WHxthN+gBjGg/o5ZNmsg3/hKEDAyzLowexK+TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=NPL8+HzG; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NPL8+HzG"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 734461D9C19;
	Tue, 19 Mar 2024 11:15:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=u9+/7OrzD2v4WIgiNjUrcwOiNhOK/U2NbeBysW
	5B2rc=; b=NPL8+HzGI7mWarqArOC3j4eggRvXQt7nku3wsuowndsTxOu/chgoGa
	sIf3uupjf62Bq33zomj48AmoF6oJTlhBjWojDthn9fRsOX1GNqb6X0YQ+aziZEeT
	O61jHNttth6F+9BnaXzhUl8vMnntOUokpvQMDH5/ta/MSdOrBNcPg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 690231D9C17;
	Tue, 19 Mar 2024 11:15:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C14451D9C16;
	Tue, 19 Mar 2024 11:15:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Han Young <hanyang.tony@bytedance.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/1] quote: quote space
In-Reply-To: <20240319095212.42332-1-hanyang.tony@bytedance.com> (Han Young's
	message of "Tue, 19 Mar 2024 17:52:11 +0800")
References: <20240319095212.42332-1-hanyang.tony@bytedance.com>
Date: Tue, 19 Mar 2024 08:15:46 -0700
Message-ID: <xmqqttl2qml9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9076D9B8-E603-11EE-B6F2-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Han Young <hanyang.tony@bytedance.com> writes:

> We're using 'git format-patch' and 'git am' workflow to sync changes between two repositories. This works great but I've found an edge case in apply.c
>
> If one commit creates a file whose path has a directory segment ending with space will cause the generated patch unappliable. Here is a script to reproduce the edge case:
>
>   mkdir tmp && cd tmp
>   git init
>   git commit --allow-empty -m empty
>   mkdir 'foo '
>   touch 'foo /bar'
>   git add -A
>   git commit -m foo
>   git format-patch HEAD~1
>   git reset --hard HEAD~1
>   git am 0001-foo.patch

That is an interesting corner case.  You should make this into a set
of new tests somewhere in t/; I suspect this only will "break" for
creation and deletion but not modification in-place or renaming (and
that should also be in the tests).

But before going into this too deeply.

I have this feeling that we have seen corner cases like this before
and it always turned out that the right solution was to fix the
parser on the "apply" side, not on the generation side.  The tools
in the wild _will_ show a patch with a header like:

    diff --git a/foo /bar b/foo /bar
    new file mode 100644
    index 0000000..e25f181
    --- /dev/null
    +++ b/foo /bar	

even after we noticed this problem and started working on a fix, so
making sure future "git apply" can grok such output should be a lot
more fruitful direction to go into, and when it happens, we do not
have to touch the generation side at all.  Who knows what external
tools break when we suddenly start quoting a path with a space
anywhere in it, which we never did?

Thanks.
