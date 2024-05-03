Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B561157E7D
	for <git@vger.kernel.org>; Fri,  3 May 2024 17:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714757044; cv=none; b=gnM3UXGflbti93up3MmdExYilh8ulEJrweoLr52hKVJg46a/J/jDGZmdAGHBpPjxabSW1sIz3x9ECihXfzrbtTbDl447TV6NxJQ0xLLB02tIoYjv0FN43mNqXVMGqgl578mDBzQ2fih0dCMzAqlzg2QhKMNc8HT7VJlq6IRuHE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714757044; c=relaxed/simple;
	bh=Ob/ZxM6xXRxly9tfBN0KWi3QyDiyfZ3ySeYhxflYNWE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fg2g3vcGCE/dNy0ugcubBBP7346WYWEe6CYm5cGPFrTtf5RkfFCoDK2l3Txxyd61L3O6NcdLY3JugptOSWgITVjNlHikxpcI7vs74vrqfrtquq0onmL+Z5F/ZDWqOKLNeYN8UGXhcZ4FxQT7sDgc965W1v2Myy5MoJAx8cNXlys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=PJ1yl/8a; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PJ1yl/8a"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 48E462A873;
	Fri,  3 May 2024 13:24:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Ob/ZxM6xXRxly9tfBN0KWi3QyDiyfZ3ySeYhxf
	lYNWE=; b=PJ1yl/8aQ+1zo5n0tNq/z+JyAPfhQD9/SS835yl02SgZTFXmR3vtVC
	cX4hIM8pWMjmUI2S4EHKma6Eh7yPdomfQC57nl2kx+Kx0efCMdUx9nNSRgsrVUSU
	0UafE20iEZyvwuBBCyrwmHPFglTND43UQWbcJlGh9UCpz75m8J2I0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D9312A872;
	Fri,  3 May 2024 13:24:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6DF1F2A871;
	Fri,  3 May 2024 13:24:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/5] refs: remove functions without ref store
In-Reply-To: <cover.1714717057.git.ps@pks.im> (Patrick Steinhardt's message of
	"Fri, 3 May 2024 08:27:55 +0200")
References: <cover.1714717057.git.ps@pks.im>
Date: Fri, 03 May 2024 10:24:00 -0700
Message-ID: <xmqqikzu95cf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EED55C3C-0971-11EF-B5E6-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> It is quite likely that this patch series will impact in-flight patch
> series. I'd be quite happy to drop the last patch that removes the old
> interfaces to make this a bit less painful.

The last step could replace these deprecated-to-be-removed functions
with a stub that BUG()s out [*], with a comment to instruct how a
caller can be rewritten to use the corresponding refs_ variant with
a call to get_main_ref_store(the_repository) as the first parameter,
which would help out of tree and in-flight series to migrate.

[Footnote]

 * The exact mechanism to cause an attempted use of an old function
   fail is immaterial.  We can remove the definition of these
   functions while retaining the old implementation as comments, or
   wrap them in an #ifdef USE_REF_STORE_LESS_FUNCTIONS .. #endif
   pair _without_ defining USE_REF_STORE_LESS_FUNCTIONS, purely for
   the documentation value to help us migration.
