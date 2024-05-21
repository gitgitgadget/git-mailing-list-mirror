Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51351FBB
	for <git@vger.kernel.org>; Tue, 21 May 2024 15:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716307189; cv=none; b=ADrOFTckGNWKFNH3Xhx18CjEXgo8oRfL4hJ+1Ej8zrzVQTBTpn26ww2DBP5I41cKM+lbsGYBl43vYzDa0xdAvv0zh8FPUZhov6sXnHS1H0wQ0NW9VKB+M4OWNbo1BJJ5F4sFYESWGRo4ZK0O7lN+XYaeef3p7qipCLFrv82JYJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716307189; c=relaxed/simple;
	bh=3i9W1htGR9zutCQTIxHMq0JhuC20QGnftnAXNilxROU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VFrPv6F9lw1zbNn6M5l944oG63eckQxvxW2J9o/caFpE6NDU9/qjTASiWHF3rndiuNwAMjZkiD8J6gGiLIDRz8hCiMT1H0spn7yM+T4Hyr93e+WOndClIgJSow3p75hpm1jObPu/jlDv2OmmlejfeXVTslSY97DFrFJVCBxl1Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=diUnep0q; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="diUnep0q"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D43B12F990;
	Tue, 21 May 2024 11:59:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=3i9W1htGR9zutCQTIxHMq0JhuC20QGnftnAXNi
	lxROU=; b=diUnep0qaPA0/Q2Jci/q7uxwCT7TYCuZaVMihN2QXhwKY86DqMU5EU
	8z+tlpDbmQldlzUf/AWsvjDBl4HV2CfOQY2sznOQ4bb1XyTHKhvJAccDin4Z8nTY
	mAJkYA2DJy/kjdqf4qixdgXfadeEY/NJjGBRgOD+1FKlL3UqWRNPE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CBEA82F98F;
	Tue, 21 May 2024 11:59:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 255B22F98E;
	Tue, 21 May 2024 11:59:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v5 1/5] setup: add an escape hatch for "no more default
 hash algorithm" change
In-Reply-To: <ZkxUBebjx8WvyJnm@tanuki> (Patrick Steinhardt's message of "Tue,
	21 May 2024 09:57:57 +0200")
References: <cover.1715582857.git.ps@pks.im>
	<20240520231434.1816979-1-gitster@pobox.com>
	<20240520231434.1816979-2-gitster@pobox.com> <ZkxUBebjx8WvyJnm@tanuki>
Date: Tue, 21 May 2024 08:59:45 -0700
Message-ID: <xmqqle43b1fy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 25135AA2-178B-11EF-BC99-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, May 20, 2024 at 04:14:30PM -0700, Junio C Hamano wrote:
>> Partially revert c8aed5e8 (repository: stop setting SHA1 as the
>> default object hash, 2024-05-07), to keep end-user systems still
>> broken when we have gap in our test coverage but yet give them an
>> escape hatch to set the GIT_TEST_DEFAULT_HASH_ALGO environment
>> variable to "sha1" in order to revert to the previous behaviour.
>> 
>> Due to the way the end-user facing GIT_DEFAULT_HASH environment
>> variable is used in our test suite, we unfortunately cannot reuse it
>> for this purpose.
>
> Okay, so this now really only is an escape hatch for users as we do not
> specify it in our tests anymore. It does make me wonder whether we want
> to name the envvar accordingly, but don't mind it much either way. It is
> only intended to be a stop gap solution anyway that we can eventually
> drop once we are sufficiently sure that there is no further breakage.

Yes, I think the name of that escape hatch variable should be
irrelevant by the time we are reasonably confident that we could
remove it ;-)

But the proposed log message should make that intention more clear.
How does this read?

    ... give them an escape hatch ... in order to revert to the
    previous behaviour, just in case we haven't done a thorough job
    in fixing the fallout from c8aed5e8.  After we build confidence,
    we should remove the escape hatch support, but we are not there
    yet after only fixing three commands (hash-object, apply, and
    patch-id) in this series.

Thanks.
