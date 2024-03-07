Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC15E13A256
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 21:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709846654; cv=none; b=nBwXEl98UoBM+ENwI8Gb+NnHQjvPPpD+tyRaHdQNfL+ROQ5hPRdKjaohSudorzXcSxYHurktqXGkx+08dNXlffSBKTGRM+CvgyKPhSDLzJRtDoR+vta2ltoRVkZB7n6eUK6hAAj4TJcBzBXUytq4z9uHSXo5hTSHK8LzXjzFy90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709846654; c=relaxed/simple;
	bh=VdcdE9Rwx09EvNN05AqIXvxzoG5mSshTqkB4Njg51ns=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SeV8cPAUbuX/wXmLy3gTD7qjzgkG40CfKRWsqKjqST0OxSQ++y8i/q4Kf3FEDxFsccobtcbeDQ5qwYuuCbkg9ibhyFRDnnvbnVQOelZzIdewWlHjqrWv2duEmJovZ5JuJgovV+XDlk557ukO+r1K1MmuieLPDlHnF4sJ6uLhQcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=v2i1xGmZ; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="v2i1xGmZ"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6FEFB1EFAD4;
	Thu,  7 Mar 2024 16:24:11 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=VdcdE9Rwx09EvNN05AqIXvxzoG5mSshTqkB4Nj
	g51ns=; b=v2i1xGmZeCWuAt+44NBJDBfZKO2pl7r/VN2vJrsZ84ZVfEfPbLUcqp
	WDZJexID4qSNwhMxpMXCB8eXUvmhURXTwGgOo4l5W1Sh9DnUqzd2nq1ms94Ad/7r
	yk4liGQhY7js0/jNDaI2cBHsl0kGRWLbxHd+cziXMYSSc5BTtm8EA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 667461EFAD3;
	Thu,  7 Mar 2024 16:24:11 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D15CD1EFAD2;
	Thu,  7 Mar 2024 16:24:10 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc: git@vger.kernel.org,  "Jonathan Davies" <jonathan.davies@nutanix.com>,
  "Phillip Wood" <phillip.wood@dunelm.org.uk>,  "Denton Liu"
 <liu.denton@gmail.com>,  "Linus Arver" <linusa@google.com>,  "Florian
 Schmidt" <flosch@nutanix.com>
Subject: Re: [PATCH] wt-status: Don't find scissors line beyond buf len
In-Reply-To: <f8de2b3a-9e12-49fe-a7d9-481317f10c4d@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Thu, 07 Mar 2024 22:15:12 +0100")
References: <20240307183743.219951-1-flosch@nutanix.com>
	<xmqq34t1n91w.fsf@gitster.g> <xmqq7cidlqg5.fsf@gitster.g>
	<f8de2b3a-9e12-49fe-a7d9-481317f10c4d@app.fastmail.com>
Date: Thu, 07 Mar 2024 13:24:09 -0800
Message-ID: <xmqqo7bpka6e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 09F66D06-DCC9-11EE-B606-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

> On Thu, Mar 7, 2024, at 21:47, Junio C Hamano wrote:
>> Signed-off-by: Florian Schmidt <flosch@nutanix.com>
>> Reviewed-by: Jonathan Davies <jonathan.davies@nutanix.com>
>> [jc: tweaked the commit log message and the implementation a bit]
>
> Just a question. Given the imperative mood principle/rule, why are these
> bracket changelog lines always written in the past tense?

These are not giving orders to the code to become like so.  The
trailer block records what happend to the patch in chronological
order---think of those written there at one level higher level,
"meta" comments.
