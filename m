Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9FC175AB
	for <git@vger.kernel.org>; Tue, 28 May 2024 18:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716920792; cv=none; b=pMlHRepXETFCFYG11NpDSn+Bh6h9FXJ3rOXsFXS61gLmOOf5/S6vKAXydtfAQggU6c+mdCuO8u1/ajxmOBPehM/pIkC9doqAJoMm+8imFenRCvzZLxWLU20DD0LIzN9iz22XtOjFC0RteKmqnvqFe8JOcIzmVK3i/NftARClvKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716920792; c=relaxed/simple;
	bh=qnqlbWL93lrzYFIjOD+k9XQD23Oh8JayPoNhWR2yyyU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Zz0+MxqfYV3FKkY08t0V5MXFognFv4dEE6SZUPrM3lqE7rMpDXFAYcmVxLPjloi8Jm7+8PkuMzAMVlkXnkF1kBhjSBxn9eAOjxAN39xEf0Ug1XOVeEN4wzY8qnQwwLVlM1JsU488AFyUpAbzO2RecDDfOHENTgGAgWzA8olEyAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=QVvWh6qo; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QVvWh6qo"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8E90229C54;
	Tue, 28 May 2024 14:26:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=qnqlbWL93lrzYFIjOD+k9XQD23Oh8JayPoNhWR
	2yyyU=; b=QVvWh6qobqyXrnDicSHOqygyonQ4Ak0pdfbEUsgDZH4wpF8Ejmi7vc
	RIBsBPTc8ItmGEAUkVGoD5AUphR0gtqvWRDlcXYs4SRSslp0F/KvtoNrXtArzJ96
	C+fBgOo56NfiHQdQ8NDPXHe+pJiNtT40Nh3mBI8eR0LjIKg6fS0GQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 87E5B29C53;
	Tue, 28 May 2024 14:26:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A548529C52;
	Tue, 28 May 2024 14:26:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  Ramsay
 Jones <ramsay@ramsayjones.plus.com>,  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v3 00/12] refs: ref storage format migrations
In-Reply-To: <xmqqo78p4xam.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	28 May 2024 11:16:17 -0700")
References: <cover.1716451672.git.ps@pks.im> <cover.1716877224.git.ps@pks.im>
	<xmqqo78p4xam.fsf@gitster.g>
Date: Tue, 28 May 2024 11:26:26 -0700
Message-ID: <xmqqfru14wtp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CC157EAE-1D1F-11EF-94CF-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>>   - Swapped out calls to `remove_path()` to `unlink()`. We do not want
>>     to walk up and remove empty parent directories, even though this is
>>     harmless in practice.
> ...
> Let's find out why this is needed in [10/12].  It may just be a
> simple matter of "let's not bother removing directories as we remove
> loose ref files one by one---we know the whole hierarchy can be
> removed after we are done", in which case I do think it is nicer.

Ah, it is not something as sophisticated like that.  It simply is
wrong to use remove_path() to remove files used by files_backend, as
the helper is designed to work on working tree files.

The reason it is wrong is because "now I removed this path, if the
containing directory has become empty, I need to remove that
directory, and I need to go up recursively doing that" has to stop
somewhere, and for remove_path() that is on the working tree side
the natural place to stop is at the root of the working tree,
i.e. above ".git/" directory.  Of course, when removing extra
directories above a loose ref file, the recursion must stop much
earlier than going up to ".git/", and try_remove_empty_parents()
in files-backend.c is the helper that was designed for the task.

Looking at the difference between the result of applying v2 and v3,
I think this "unlink" thing is only about removing root refs?  So I
agree that a simple unlink() is not just adequate but is absolutely
the right thing to do.  There is no reason for us to go up and remove
empty directories when we remove ORIG_HEAD or other stuff.

Thanks.
