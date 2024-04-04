Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35721BDCD
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 16:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712249158; cv=none; b=ljAJYxoEY6LP1g9noiweiAHXAvUfdqCo4Ov4jQyBCRoAqhlMeKB9vIeyiWXXGxEPo6/pXHWsSLCESCWqw4uhGYqYhhQ4O0AOHgLGvEX5uDc/WHt6xfVbtFnJgDUHE7wqLRcLFJzR0uKTGkjsCr59V42fBrvUYXdTwXxaS7Mlokc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712249158; c=relaxed/simple;
	bh=cGFvrXR8bkZ2h4G/Umipptjp6qrjT+1qcyFGAay74lk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sHTrCbK86A48joQEZuA04ZVbLSa54BroKLCYjpR3a4ooqHGumgrbvj+nyY6MwSzHh0ySKTP+AuvwxGzOZeDseEP2b7Y51ZkK9Zy2RNqU5BwV2CGE7qymYniVC1Wk8BUZbTj9y4f45/Wujm8MQcRMgsUAbVZ8EVW2eSErYdrknDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=vrTLQfGx; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vrTLQfGx"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 12B021BF79;
	Thu,  4 Apr 2024 12:45:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=cGFvrXR8bkZ2h4G/Umipptjp6qrjT+1qcyFGAa
	y74lk=; b=vrTLQfGxmRYNBBsSPau9cKaMQG93J566OdUpsmkZ1OK5GlNr/+1OvG
	3fg6kmALj01Jy3LM+dilgTA44DBfPSSsxmZO8W2JSt/AMP82wSuC/0npVHbYpQ7y
	04inFovc+CfniHUgzfynh7+G6PJxByeUpb7C07LKGITr5JmeVD3OY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0A73D1BF78;
	Thu,  4 Apr 2024 12:45:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6C16E1BF77;
	Thu,  4 Apr 2024 12:45:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "David Bimmler via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  David Bimmler <david.bimmler@isovalent.com>
Subject: Re: [PATCH] sequencer: honor signoff opt in run_git_commit
In-Reply-To: <xmqqzfu914jc.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	04 Apr 2024 09:22:31 -0700")
References: <pull.1707.git.1712223572933.gitgitgadget@gmail.com>
	<xmqqzfu914jc.fsf@gitster.g>
Date: Thu, 04 Apr 2024 09:45:50 -0700
Message-ID: <xmqqr0fl13gh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CC7F5574-F2A2-11EE-8F2F-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

>> +	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
>> +	test_cmp expected-signed-after-conflict actual
>
> Running any git command on the left hand side of a pipe is frowned
> upon, as it will hide exit status from it when it fails.
>
> In this case, the primary thing we care about is that we have added
> the sign off that did not exist in the original, so I wonder
>
> 	git cat-file commit HEAD >actual &&
> 	test_grep "Signed-off-by: " actual
>
> would be sufficient?

The answer is No.  It is plausible that somebody else in a future
may think that a better fix is to always prepare the final commit
message inside sequencer.c and call append_signoff(), and use it in
both the "in-process commit" codepath in try_to_commit() and in the
code that was fixed in the patch we are discussing.  If such a
future update is done carelessly, we might end up adding duplicate
sign off.  A "at least one instance must be there" test_grep would
not be a good tool to catch such a breakage.

	git show -s --format=%B HEAD >actual &&
	test_cmp expect actual

may be a good replacement.

But having said that, and then after having looked at the existing
tests in the file, I see that it is littered with the same "do not
run git on the upstream of the pipe" violation.  So let's not worry
about this one.  The whole t3428 script needs to be cleaned up after
the dust settles.

Thanks.
