Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7044F17B02B
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 18:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720551422; cv=none; b=fnv8IgIInf+4G8/tc1+AqWBLvx0xt8pJ0BDdCjcrVfXY72O8l8jbTsGu+3EcJb3CrCnzAg/truLMiy1gJ1BbXW0KjWwsa+1vD+G2stSkxm9d3QLdGvgoi6g+aCttQcHfqo0i3jerHOVCHEHsk703tNEMVY5rOW5sQ1q81TP9BL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720551422; c=relaxed/simple;
	bh=SZIj59eIox8k4BjaHApFIR1f68+sp9FEM1ECSLdaV94=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qH7UyU+zcUfmGSy/eeAJsE4TDfdXYlfOqkN+x5mrl5S30uS8WiN5Vft/7zvMas8iOd8XcAfPEW8ZoJBey24lLLCpBqghDyCmGpjmIYVmYeMYiUprgDp6R2fdYK1JcTv+1nbn7AODLGTFJA7HLulfHvuy9yzOTNLViMwxR0TOClQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=QvTgc3zR; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QvTgc3zR"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 52247253B5;
	Tue,  9 Jul 2024 14:56:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=SZIj59eIox8k4BjaHApFIR1f68+sp9FEM1ECSL
	daV94=; b=QvTgc3zRzXS4+ffxVBbbDVOKeswOb6FgmbYVxgjZkXlQcorun07Wnx
	2WukqKijjlHrZopSqdz7ipXuTB6qBRJFRu+0KHfZDv7TCeYH1Wcwv3gDO258GHo2
	PmtvMdOk6kLIASWpXVjWhAfuCLYmY10cuyvK8c4Y00tPjNTBaZDKk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4AAB7253B4;
	Tue,  9 Jul 2024 14:56:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D00EE253B3;
	Tue,  9 Jul 2024 14:56:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  peff@peff.net
Subject: Re: [PATCH v2] builtin/push: call set_refspecs after validating remote
In-Reply-To: <xmqq4j8yflrq.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	09 Jul 2024 11:44:25 -0700")
References: <20240708140350.622986-1-karthik.188@gmail.com>
	<20240709144931.1146528-1-karthik.188@gmail.com>
	<xmqq4j8yflrq.fsf@gitster.g>
Date: Tue, 09 Jul 2024 11:56:49 -0700
Message-ID: <xmqqsewie6mm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 00218712-3E25-11EF-BA44-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Is it merely "this is a nonsense request and must fail, but we do
> not want to hit BUG in general"?  I think it is the latter, but
> leaving it unsaid is confusing.  How about starting it more like...

A bit of clarification.  "it is the latter" -> "that is what you
meant".  In any earlier draft I had another possibility but I
removed it before sending the message.

>     When an end-user runs "git push" with an empty string for the
>     remote repository name, e.g.
>
>         $ git push '' main
>
>     "git push" fails with a BUG().  This is because ...
>
> or something.

Another clarificaiton.  

    ... with a BUG().

 ->

    ... with a BUG().  Even though this is a nonsense request that
    we want to fail, we shouldn't hit a BUG().  Instead we want to
    give a sensible error message, e.g., 'bad repository'".

Let's make a habit of not stopping at saying what is bad, and also
saying what we want instead explicitly. 

Thanks.
