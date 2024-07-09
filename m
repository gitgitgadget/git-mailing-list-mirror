Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074681A01DB
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 16:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720543055; cv=none; b=mymhObqvl+j9/oyf33+LF5vS+f0QR8NQjPhFQADiGzHu9gN2NL10tuGlsm98GZ1GCQ1ey2tGX3C93sZZ5eUtOV3ZU2SvAC++ykGYo4GvLG6U6KvtsXaYjAZHwH8n7qKn5Mzoz8EkaDSax/c+ABLH4RS7nTSO266TdzKE1sjJJ24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720543055; c=relaxed/simple;
	bh=m8mk0T9tue8UmbvMab5ChiQ6myNHU4CihZQRXksEFfE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D79Qr/b+CzPqhqBblo+aKchbxu+i8U6hyDzoJYayXYXuWfCYP7X8eRou9YRJa4Osxp9pV8uHXzvxMr7Mug42bvZA2aSiFAqZ4pJLZVHzZvFbaRzz6sv9cpRTkpNMFH/1+EqT2i6iZmMcgiAj5q008Q5YFc6HpFAmusMLiMaS0eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=U1enKMwv; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="U1enKMwv"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 81D283AAF8;
	Tue,  9 Jul 2024 12:37:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=m8mk0T9tue8UmbvMab5ChiQ6myNHU4CihZQRXk
	sEFfE=; b=U1enKMwv14o5+sxJrpIANPIKVDR1vb0sz2cYaxhab+8wUYxjaYK2v7
	qMpICOQcxQw7haUh9RjbbJr9o+TPHQmJkb856JENDRTXlNSndAozXYxl9rw4jV7B
	yGM4gFTMV/nfUsg9BryfutbYlezcQm9/YtFScETgINk3lZTFSCIAA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7972B3AAF7;
	Tue,  9 Jul 2024 12:37:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 071E63AAF6;
	Tue,  9 Jul 2024 12:37:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Toon claes <toon@iotcl.com>
Cc: Eric Ju <eric.peijian@gmail.com>,  git@vger.kernel.org,  Christian
 Couder <chriscool@tuxfamily.org>,  Calvin Wan <calvinwan@google.com>,
  Jonathan Tan <jonathantanmy@google.com>,  John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 4/6] transport: add client support for object-info
In-Reply-To: <87ikxfqbm9.fsf@iotcl.com> (Toon claes's message of "Tue, 09 Jul
	2024 09:15:58 +0200")
References: <20240628190503.67389-1-eric.peijian@gmail.com>
	<20240628190503.67389-5-eric.peijian@gmail.com>
	<87ikxfqbm9.fsf@iotcl.com>
Date: Tue, 09 Jul 2024 09:37:28 -0700
Message-ID: <xmqqttgyfrnb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 88B11520-3E11-11EF-9347-C38742FD603B-77302942!pb-smtp20.pobox.com

Toon claes <toon@iotcl.com> writes:

>> +			temp_ref->old_oid = *(transport->smart_options->object_info_oids->oid + i);
>
> Any reason why you're not using the subscript operator (square brackets)
> like this:
>
> +			temp_ref->old_oid = transport->smart_options->object_info_oids->oid[i];

Much nicer, but fold such overly long lines, please,

			temp_ref->old_oid = transport->smart_options->
				object_info_oids->oid[i];

to make them readable.



> ...
> To be honest, I'm not sure it works, because fetch_object_info() always
> seem to return a non-zero value. I'm not sure this is due to missing
> code coverage, or a bug. I guess it's worth looking into.
