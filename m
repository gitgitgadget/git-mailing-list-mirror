Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B031B168486
	for <git@vger.kernel.org>; Wed, 28 Aug 2024 16:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724863539; cv=none; b=psnIIewLKiiI+fpShYKykNtPGNr8Ub8MLmap0Tq/113A1kk7o0D8ZTT7LWya0C6nRtTlFAuJ5ZUox2+dM8KTUIxwV6mcPNMRPg00Eq2hXVkD86K8IsnwZeUehdSIABWuaxEFSXeZvy8iDrulIBUT1N6AwN0gdS1wXK4S3SVqTVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724863539; c=relaxed/simple;
	bh=aOBTqtcvu5bcCeWNN5ZK91AuB1oAmwtl/whhUWeAaaQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J8WJ4vo4KfVgs0PXcmOyxIN/Q3Hgyr0bWLMGzdERll7Z4dVuQyfNUp5qXcy7/mf2V2GW8f3cZViOjuBLWAn/nieczG/bL/n//35etFVG0x3vyso2pEmLVbf0eBVYEVoEC+iatQ+4z8AB27Q9cM7In8bz7HrJ3KOm6QlZu63zhi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Oil4XQAD; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Oil4XQAD"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7DC6C26F25;
	Wed, 28 Aug 2024 12:45:36 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=aOBTqtcvu5bcCeWNN5ZK91AuB1oAmwtl/whhUW
	eAaaQ=; b=Oil4XQAD7IrxyZQhBSS9273LEzaIU/EYF0cGiHCWcuq02InU5n45R+
	TFcwh6rUAT+Hweu46ULfac6cM+3+gRBfYywu9Rn422JFhynSn22KpNPDf3LLnyXk
	eyGSBHcWFeJkb4o0gwFrtiSDzaVq2zzJpCyvumVHLfoIqBPUiMTKg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7667E26F24;
	Wed, 28 Aug 2024 12:45:36 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DBB7A26F23;
	Wed, 28 Aug 2024 12:45:35 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: [PATCH v2 2/4] ref: add regular ref content check for files
 backend
In-Reply-To: <Zs801HqHg45v_q6X@ArchLinux> (shejialuo@gmail.com's message of
	"Wed, 28 Aug 2024 22:31:48 +0800")
References: <Zs348uXMBdCuwF-2@ArchLinux> <Zs353oLDaw2SbNQs@ArchLinux>
	<xmqqjzg1aksx.fsf@gitster.g> <Zs801HqHg45v_q6X@ArchLinux>
Date: Wed, 28 Aug 2024 09:45:34 -0700
Message-ID: <xmqqr0a81tqp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F2F2DF8C-655C-11EF-96B8-9B0F950A682E-77302942!pb-smtp2.pobox.com

shejialuo <shejialuo@gmail.com> writes:

>> > @@ -170,6 +173,12 @@
>> >  `nullSha1`::
>> >  	(WARN) Tree contains entries pointing to a null sha1.
>> >  
>> > +`refMissingNewline`::
>> > +	(INFO) A valid ref does not end with newline.
>> > +
>> > +`trailingRefContent`::
>> > +	(INFO) A ref has trailing contents.
>> > +
>> >  `treeNotSorted`::
>> >  	(ERROR) A tree is not properly sorted.
>> 
>> There is no mention of "you shouldn't promote these to error" here,
>> which is good.  But wouldn't we want to tell users to report such
>> curiously formatted loose refs, after figuring out who created them,
>> to help us to eventually make the check stricter in the future?
>
> From the review from the Patrick, I will add another patch in the
> "Documentation/BreakingChanges.txt" later.

As that documentation is not end-user facing, it is orthogonal and
unrelated.

What I meant was that we need to tell the user that the refs they
have (and the third-party tools they used to create them) may be
declared invalid in a future version of Git and they would want to
report it, in order to influence our possible future direction.  And
we need to do so in an end-user facing documentation (i.e. the part
of the patch quoted above) and/or in the info messages themselves.

