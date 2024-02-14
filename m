Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CC824B33
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 23:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707952287; cv=none; b=kpvtUL45Kk8g9/AH+wEHI0Z6e4/F72lzWR5jJhBuoSListGj627kcCy1D2ycctlrSJxv02S3b6ytMUVqauO3jSVpkRQrNgdqnQHGBxZP/k9KFUBVvegE3v1Mi7S7G6IHvvbO7UJludfkIf+sbCE/+7DPdjneLPji4O29VkewMnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707952287; c=relaxed/simple;
	bh=7xpHQpBwcYbsBANcvDc3hrqsfDTsuX7YSjL+884pXNQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dhFN12wxpHx0sSCYedMX/Wlkz4KbKa9YDKiND+BZh1GnVePZb/4Y92JVKMnq/D1XsojmKKT0fzNs1yTv7GB4w0Zy0KRCwTAE4ZvU108mevG8elqtmYsVgljT9lHlLsbscGDXoxx6kW717EoAz2bPrW2WWHf/uqMHNN3j+7VAxcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=h4yHFrm+; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="h4yHFrm+"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 70A7F21657;
	Wed, 14 Feb 2024 18:11:24 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=7xpHQpBwcYbsBANcvDc3hrqsfDTsuX7YSjL+88
	4pXNQ=; b=h4yHFrm+h+dmMLHEGMp5QDBHrDcl/2PHHnIStEHmxx+I+TYiOcMh+5
	vaPtyFD7dW3F2vaXMCU/VjZdZHHr9fPx6vGXTTf5yVsAIUsHC/n8E2TnMYDvU6e+
	7d7Zs0heDt0de6e7qDeW0Lqs0CfE+ndWwnbhe/BJHY2fNMaJpe+f4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 697B221656;
	Wed, 14 Feb 2024 18:11:24 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A360321653;
	Wed, 14 Feb 2024 18:11:20 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/7] t1404: make D/F conflict tests compatible with
 reftable backend
In-Reply-To: <70c6f980126aabb2ade336861e816cf1fe6e9110.1707463221.git.ps@pks.im>
	(Patrick Steinhardt's message of "Fri, 9 Feb 2024 08:23:22 +0100")
References: <cover.1707463221.git.ps@pks.im>
	<70c6f980126aabb2ade336861e816cf1fe6e9110.1707463221.git.ps@pks.im>
Date: Wed, 14 Feb 2024 15:11:19 -0800
Message-ID: <xmqqbk8itze0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5D571E92-CB8E-11EE-9B04-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>  	test_must_fail git update-ref --stdin <commands 2>output.err &&
> -	test_cmp expected-err output.err &&
> +	grep "fatal:\( cannot lock ref $SQ$addname$SQ:\)\? $SQ$delref$SQ exists; cannot create $SQ$addref$SQ" output.err &&

OK, that's more thorough than I would have done (I am lazy and would
just check "cannot create"), but being more specific is better than
being lazy ;-)

> @@ -191,69 +188,69 @@ test_expect_success 'one new ref is a simple prefix of another' '
>  
>  '
>  
> -test_expect_success REFFILES 'D/F conflict prevents add long + delete short' '
> +test_expect_success 'D/F conflict prevents add long + delete short' '
>  	df_test refs/df-al-ds --add-del foo/bar foo
>  '

All the changes make sense here.  Thanks.
