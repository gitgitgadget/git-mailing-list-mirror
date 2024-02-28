Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0516D1361B0
	for <git@vger.kernel.org>; Wed, 28 Feb 2024 22:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709160468; cv=none; b=OMQYFZim3QewmkRxzF2sBZ9poF2EkmMYPP8N7rR3lS8+GKzPXDZCkrlBYSqyE9FrGv3Td4FJHd29QXm4VJznQ4gUql+3JSXvVbOjUwwMRTP3AI3JzSdQvd6HDVhPz9O9gUvqg1uZJ5ArGd6Zmy+K7QF6flm03CiJNea06BV/pg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709160468; c=relaxed/simple;
	bh=YXi1vHZyJYQ9bqMaKVRmcMdBO/EFBNBddVQdo0cnvDU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rdUMaKAmw2Bgt3jCBm+dDAnF74jytxi9/XszvQFOl+HTg/b+Tgnq1mb4+RYUEjBMDG4OmDscvNIGrAygSJHZBiibjxx9f9vtoEeVSjybM4KR3QbndoWREO2biRC8Ge9zXLCNRTub2BH1ZNrIxUUtHBcmkUlDaJQntviGbtjbdbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=kL8Gcxyh; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kL8Gcxyh"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A16E61C05DE;
	Wed, 28 Feb 2024 17:47:45 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=YXi1vHZyJYQ9bqMaKVRmcMdBO/EFBNBddVQdo0
	cnvDU=; b=kL8Gcxyhdl/UksZ/lWsID8PsJLMBcx96De9TxlfEB662DwaJeIWOFN
	8qHWrhDs5Z/V5nc1yBgpJldZWl+fjJmK00WCkbRfe44r3rhvopXe+p5/NzaAgEow
	fPEA0qC+iZ139I+zp5Ju9jxfO/CrF3vHnaxdk7mUrk6F3rYSJftb4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 99E051C05DD;
	Wed, 28 Feb 2024 17:47:45 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0E67A1C05DC;
	Wed, 28 Feb 2024 17:47:44 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Benjamin Flesch <benjaminflesch@icloud.com>
Subject: Re: [PATCH 0/9] bound upload-pack memory allocations
In-Reply-To: <20240228223700.GA1157826@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 28 Feb 2024 17:37:00 -0500")
References: <20240228223700.GA1157826@coredump.intra.peff.net>
Date: Wed, 28 Feb 2024 14:47:43 -0800
Message-ID: <xmqqa5nkjje8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 635A9CA8-D68B-11EE-88E9-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Jeff King <peff@peff.net> writes:

> We're not doing a coordinated disclosure or special release for this.
> Even after these patches, it's possible to get upload-pack to allocate
> quite a bit of memory, especially for a large repository. Not to mention
> that pack-objects may also allocate quite a bit to serve the pack
> itself. So while this is low-hanging fruit, a public-facing Git site
> probably still needs to have some kind of external tooling to kill
> hungry processes (even if it's just OOM-killing them so they don't hurt
> other clients).
>
>   [1/9]: upload-pack: drop separate v2 "haves" array
>   [2/9]: upload-pack: switch deepen-not list to an oid_array
>   [3/9]: upload-pack: use oidset for deepen_not list
>   [4/9]: upload-pack: use a strmap for want-ref lines
>   [5/9]: upload-pack: accept only a single packfile-uri line
>   [6/9]: upload-pack: disallow object-info capability by default
>   [7/9]: upload-pack: always turn off save_commit_buffer
>   [8/9]: upload-pack: use PARSE_OBJECT_SKIP_HASH_CHECK in more places
>   [9/9]: upload-pack: free tree buffers after parsing

I saw them when they were posted to the security list and they
looked good already.  Will queue.  Thanks.
