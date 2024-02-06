Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E297213FEA
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 18:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707244941; cv=none; b=W13LJ59pxTNqPo3kSJ2rJJorm8K3sbMCdy1EV6/uf0196otQpzVrNBzeK8tzmAaRW6nYWgX97uTPpLhjhHsUp2IvCM1k8P7O+rb8/SXpU3IGFo4sqN990jNeEk9z7hEh7D5cu9dCpTRCg7hTFUDh4hXjTELxQuJr+jD9x9r9qU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707244941; c=relaxed/simple;
	bh=ajtvP4tJWcQrijkKSB2k/L4qCDTR6LdRfitswcrl2sk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LK5BRCbafS+5d7aP2+DXpZlunaveFHB2N+EGgMQZ1iJs0w2noFrRDzZNfPE0M2FsfplTOi3n6+wRLuQt2Z52a9dLgPqCuKpfZYwVMolvLhL9Y1j/xmd8WIuE4KaItKP+ZczIQ0IAk9U2bXXCRpDznBjxxbPmsxEOScToLs+WxVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=uVQaBzE4; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uVQaBzE4"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3058624587;
	Tue,  6 Feb 2024 13:42:19 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ajtvP4tJWcQrijkKSB2k/L4qCDTR6LdRfitswc
	rl2sk=; b=uVQaBzE4agFGK4jKbQAVuphoDHt96NTosEtK4wDe0KGHrfvbFpGqtP
	vmMYGHBxVk7M6J+BixqnjTuPe7WqmfJtgHzhyt6kxK/w/+Ie5uuix+RLXeGivPYF
	6Sjz2QYm+KUIgJCBLRRqA1VF2WXzK31IbnyRzhcTHlPRXaVYqYC88=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 29A3624586;
	Tue,  6 Feb 2024 13:42:19 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CA58524585;
	Tue,  6 Feb 2024 13:42:15 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] Always check the return value of `repo_read_object_file()`
In-Reply-To: <ZcHW_bc6N5umk2G4@tanuki> (Patrick Steinhardt's message of "Tue,
	6 Feb 2024 07:51:41 +0100")
References: <pull.1650.git.1707143753726.gitgitgadget@gmail.com>
	<ZcHW_bc6N5umk2G4@tanuki>
Date: Tue, 06 Feb 2024 10:42:14 -0800
Message-ID: <xmqq1q9pige1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 72F5DA1A-C51F-11EE-A27B-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>>  			mmfile[i].ptr = repo_read_object_file(the_repository,
>>  							      &ce->oid, &type,
>>  							      &size);
>> +			if (!mmfile[i].ptr)
>> +				die(_("unable to read %s"),
>> +				    oid_to_hex(&ce->oid));
>>  			mmfile[i].size = size;
>>  		}
>>  	}
>
> A few lines below this we check whether `mmfile[i].ptr` is `NULL` and
> replace it with the empty string if so. So this patch here is basically
> a change in behaviour where we now die instead of falling back to the
> empty value.

I think that one is trying to cope with cases where we genuinely do
not have all three variants, not "we thought we had this variant so
we tried to read it into mmfile[i].{ptr,size}, but it turns out that
the object name we had was bad".  So the fallback code for an entirely
different case was masking the breakage the above hunk fixes, and
this being "rerere", it is better to be cautious than sorry.

Thanks for reading the original code carefully.

