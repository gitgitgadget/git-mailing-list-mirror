Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B831DA53
	for <git@vger.kernel.org>; Sat, 27 Apr 2024 22:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714255793; cv=none; b=LT7SXY5HPod3fINGF8x/YtkzixHEyctuc6F4l4HMOHmuiKUl96rDulf6g1Oul1KOzqtmFaJkF+yWELBJz/fNvw/dnLl23M/vN+s/5E/db+nAtcaUjdBb7a82NO1mD1EkqvcEHjutBX8mYwi7MzkHcsqTRVLNdmPszFDFyYjqDlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714255793; c=relaxed/simple;
	bh=ShVBfdm/GqZLjsBVyCZGlPIe1TpTZm0hesIObLupIlE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p3PKFWieaIdKJQhizQSw5jTIcKkAengp0cz9uL5Swfza3UAR0zL6hF8OtvDMtNBOwoYBuKfZEkCjp+TcwZ5rxubl66B5jm+eIY/zZ4ruULe+WPbdPVreNFgDU2xWAOQ3SIchD54xe7p9pOqa2oEyoEzfotGIyRPhLXJyjGV0S/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=WFQEoLgU; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WFQEoLgU"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2B1FF352C7;
	Sat, 27 Apr 2024 18:09:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ShVBfdm/GqZLjsBVyCZGlPIe1TpTZm0hesIObL
	upIlE=; b=WFQEoLgUb/T2UWexUtq+4pKHUghC5HBJzCtrBzxjKWOyl5T54sQHK/
	agVbhfhpoi0gtWCv9YMbuzJ+Bl4fn6kzQW6E0dLstoKQ6XnkoJZX7Vq/zNFG/BZE
	HLIlGf5LawYf8kBtK+hHbZgTY1IrHI+VQHuS1sWffiIBsNOUsKRsM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2254B352C6;
	Sat, 27 Apr 2024 18:09:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7F4F9352C5;
	Sat, 27 Apr 2024 18:09:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Justin Tobler <jltobler@gmail.com>, Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v2 00/12] Stop relying on SHA1 fallback for `the_hash_algo`
In-Reply-To: <cover.1713848619.git.ps@pks.im> (Patrick Steinhardt's message of
	"Tue, 23 Apr 2024 07:07:20 +0200")
References: <cover.1713519789.git.ps@pks.im> <cover.1713848619.git.ps@pks.im>
Date: Sat, 27 Apr 2024 15:09:43 -0700
Message-ID: <xmqqwmoi31aw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DA6B9A92-04E2-11EF-A9A1-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

[cc: added Josh as the commit-graph fuzzer was his creation].

> this is the second version of my patch series that causes us to stop
> relying on the SHA1 default hash.

With this topic merged, 'seen' fails "fuzz smoke test"; I think this

    https://github.com/git/git/actions/runs/8807729398/job/24175445340

is the first merge of this topic into 'seen' where "fuzz smoke test"
started failing.

With the merge of the topic from 'seen' reverted tentatively,

    https://github.com/git/git/actions/runs/8862811497/job/24336185541

the same test seems happy.
