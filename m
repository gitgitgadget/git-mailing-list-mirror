Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811F313D8A8
	for <git@vger.kernel.org>; Fri, 17 May 2024 17:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715965488; cv=none; b=OEy4TorbEMt+Fzs21sODcQWvCmyWlPgXrjBT9VneriW+eVvKPFDbvrGIsYlAJ+UiwLNcnyOfXOd7hjnBxLSKC6hWk8o2j9Rq8+l4KIqc1fb+tHlLrdqgmwBTU21AuFZzZeSt6TGuXVeCogRwkxmqnZ92Mu307zj0LfdYZBUBIUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715965488; c=relaxed/simple;
	bh=qdO5TAyo8I3dDlbZZoK52fUZ3alHg3bMaIV2GMKmPOs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GMHRq+FBQdGTj9N9Kg1OLl7n23QqNuCuF8g4NC40/aoDSnmVSyNOd8qR3HDG6uNFbZM4awAurgdnV8cZ6o/idhHeQBhXPPqE3ybVfTCYjYyvSdPAwuRRfTTW8Dw0Hsc7wB+2X/NjXF7lVT/vAv9vMt2Gd7MqFh/vJxL6aElL/cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=U02fU0H0; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="U02fU0H0"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 16EE72F34A;
	Fri, 17 May 2024 13:04:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=qdO5TAyo8I3dDlbZZoK52fUZ3alHg3bMaIV2GM
	KmPOs=; b=U02fU0H0Tm2YT9SUTXmi73PM7KoU1vq10N8RQIhES8DX+e8EWlkOb6
	0TaYkHRMc2n7uzm9Qu5GQ6lK6f3dmncHyptxAuCFw9Qes02y9+2roEoU07dExtpb
	0c2UojT2gMzUi96NFD6HfQrqIq7+szu/K/2RfSopD/gBB6dijsB8w=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 106772F349;
	Fri, 17 May 2024 13:04:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 918032F346;
	Fri, 17 May 2024 13:04:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Marc Branchaud <marcnarc@xiplink.com>
Cc: git@vger.kernel.org
Subject: Re: [Q] rebase -i: turn "pick" to "edit", make no change, what
 should happen?
In-Reply-To: <6620412e-a8ea-40fb-8823-13c4b33e9808@xiplink.com> (Marc
	Branchaud's message of "Fri, 17 May 2024 08:42:41 -0400")
References: <xmqqy189o94c.fsf@gitster.g>
	<6620412e-a8ea-40fb-8823-13c4b33e9808@xiplink.com>
Date: Fri, 17 May 2024 10:04:41 -0700
Message-ID: <xmqqo794jro6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8DE24904-146F-11EF-B6F7-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Marc Branchaud <marcnarc@xiplink.com> writes:

> On 2024-05-16 15:21, Junio C Hamano wrote:
>> What should happen when I turn "pick" to "edit" in a "rebase -i"
>> session, check what got checked out in the working tree, find it
>> satisfactory and decide not to make any change to the files, and say
>> "rebase --continue"?
>> The current implementation seems to just move to the next step,
>> without offering a chance to edit the log message.  I do not know
>> offhand if this is something we changed recently, or if it has been
>> that way forever.
>
> It's been this way forever (or close enough; I've been using Git since
> ~2010).

Thanks.
