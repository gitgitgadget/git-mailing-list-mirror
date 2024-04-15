Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F1A811E7
	for <git@vger.kernel.org>; Mon, 15 Apr 2024 20:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713212145; cv=none; b=ojEm2x4UytLX4FV3lM59y52IjK8XBc2ZYLmsxxTD8Bgwv+XYW+PxrlQXtEJV5yDNj2hBL613Q3TeR6tQacsxTYs20AyNp8Cr2g3bbg6n79dbzn0xyQ9uTljBjms1C1/O82A9TjwyWyf2O0yvzy5IY4tJK9l3F9IpwHVvR9Ii1BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713212145; c=relaxed/simple;
	bh=1lINNkGIjgfzfsQMjrhj2H/0k3GNoQQFmMMHSmjrUEk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eWEBHTHXnHUPuP1BRJaa0nN/5J59LUVMkDxcDIIeudqycdwWwEjfxUAnXO1VZJk6OfT+QT7w0HShkV0eYm6rBhS/WLNxn/xFh2rd5PANdYieWrpdhRbzLTiVlwnYh1f8JsF6h2XsItidFuexhavX7rOuxuJFeuBooNVDq0YQeTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=aP4KGaD8; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aP4KGaD8"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2208A1F0CF8;
	Mon, 15 Apr 2024 16:15:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=1lINNkGIjgfz
	fsQMjrhj2H/0k3GNoQQFmMMHSmjrUEk=; b=aP4KGaD8t8GcTfOpt3MIHRbMYSj3
	1sEACfcyyE4nxl3P4QXGcmD5/ejsxdstH3F9QvJHZfwhLF5ptV5gV8VrowAA+1Yy
	mqlI877V83YrbTX+ddJ+oSUJcimJ3UoOl82Sa2IzTBKQ9tKksMDvknQRefBGeqzO
	R7m+JHR3Mx2qAPw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1AD571F0CF6;
	Mon, 15 Apr 2024 16:15:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 812621F0CF5;
	Mon, 15 Apr 2024 16:15:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Marcel =?utf-8?Q?R=C3=B6thke?= <marcel@roethke.info>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3] rerere: fix crashes due to unmatched opening
 conflict markers
In-Reply-To: <20240409121708.131542-2-marcel@roethke.info> ("Marcel
 =?utf-8?Q?R=C3=B6thke=22's?=
	message of "Tue, 9 Apr 2024 14:13:51 +0200")
References: <20240218194603.1210895-1-marcel@roethke.info>
	<20240409121708.131542-2-marcel@roethke.info>
Date: Mon, 15 Apr 2024 13:15:35 -0700
Message-ID: <xmqq7cgymlg8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 EBBE0334-FB64-11EE-BD10-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Marcel R=C3=B6thke <marcel@roethke.info> writes:

> +test_expect_success 'rerere does not crash with unmatched conflict mar=
ker' '
> +	git config rerere.enabled true &&
> ...
> +	git rebase --continue
> +'
> +

This one fails, either standalone or when merged to 'seen'.

A sample CI run that failed can be seen here (you probably need to
be logged in to view it):

https://github.com/git/git/actions/runs/8694652245/job/23844028985#step:5=
:1894

