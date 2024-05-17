Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2FA27471
	for <git@vger.kernel.org>; Fri, 17 May 2024 16:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715962497; cv=none; b=HXK/W6Y5XVQIHJ2jfZvYOZKGuqkZ4e5D3Q/Zi10Q4X+Gcll+k31D3jseE10kwJkp9+afB+uyOocKZ91z2NGNmt0Rkda5WNMtTRua8ZO7VvXkwD6XKKB+5yuyIhJwoMxq92u2Ckm4fsYO6P3n7eGxgfKR0TnCqUNIVOSQK6thKLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715962497; c=relaxed/simple;
	bh=7FEgyVDKilCjcylkn9d0T0r3yi9MeI24fpOadnGEsaY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u49R6W1cqvoI+6FFw6YbB2zBjivKYeBM6HGgHo1kY/W5j5zENbRjGrxM3rlvGJkt5XKxiM1DDiMJilEvkTMQ/f8rtuv2UGkLg3uVjSqw7ps8zzpK4n3bWGSE8g1X8+pZ+2unT354wIGe04Rf955LImWNqd3gPquU2rt4JNgKtyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=KpCEVSdi; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KpCEVSdi"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 16F872ED38;
	Fri, 17 May 2024 12:14:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=7FEgyVDKilCjcylkn9d0T0r3yi9MeI24fpOadn
	GEsaY=; b=KpCEVSdiavmjnA5iRM5KGh8C/fpOoGXVu+DXdZ2OnBCOl1diJvoWXd
	MVMrW+2ttJaDR+Eg225UniUMUDuK1EPgzyi3GUTy6o36dBGa5pG5gC63ARpORXzX
	6BrHHgwvuRrxq3roOaukJmtNhtOET+aAwz+8+SfQBvwA0kCfj3YrE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0DDE22ED37;
	Fri, 17 May 2024 12:14:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 711F62ED36;
	Fri, 17 May 2024 12:14:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: blanet via GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,
  blanet <bupt_xingxin@163.com>,  Xing Xin <xingxin.xx@bytedance.com>
Subject: Re: [PATCH] bundle-uri: refresh packed_git if unbundle succeed
In-Reply-To: <ZkbkgT46mdNEhcf0@tanuki> (Patrick Steinhardt's message of "Fri,
	17 May 2024 07:00:49 +0200")
References: <pull.1730.git.1715742069966.gitgitgadget@gmail.com>
	<ZkbkgT46mdNEhcf0@tanuki>
Date: Fri, 17 May 2024 09:14:47 -0700
Message-ID: <xmqqikzcl8js.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 953EA42E-1468-11EF-AF58-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Now there are two conflicting thoughts here:
>
>   - Either we can now drop `REF_SKIP_OID_VERIFICATION` as the object IDs
>     should now be accessible.
>
>   - Or we can avoid calling `reprepare_packed_git()` inside the loop and
>     instead call it once after we have fetched all bundles.
>
> The second one feels a bit like premature optimization to me. But the
> first item does feel like it could help us to catch broken bundles
> because we wouldn't end up creating refs for objects that neither we nor
> the bundle have.

I like the way your thoughts are structured around here.

I do agree that the latter is a wrong approach---we shouldn't be
trusting what came from elsewhere over the network without first
checking.  We should probably be running the "index-pack --fix-thin"
the unbundling process runs with also the "--fsck-objects" option if
we are not doing so already, and even then, we should make sure that
the object we are making our ref point at have everything behind it.

