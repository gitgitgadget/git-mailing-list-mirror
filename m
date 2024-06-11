Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D03D3D388
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 17:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718128468; cv=none; b=g7RoDc39r+8s2MUP9sCU7SoByWmOMzYs/ShEjXBrXpjaFR12eXlXrXMsNMv7Uk76lzR+GOBY0IAMpFNB0gNLO62mRwx+cn7bIq1KWU1WjqlCyjHLlYaxf2MVNxtjsTU6Mpn3DY75+nzYHQ2pk/IvCXbkCxmdDM32vRV2Lb/DdSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718128468; c=relaxed/simple;
	bh=CjbyDgPIh+Fy0H3HkaM6MLmja7tEZf06CZajKPSILoE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t5m9gHWHWCPMQtI/u7W761Qfv2kwrP5+3HdAhEyaK9WRBUCYaITP4Xr7boMyF09Z2GajSAcB2BPmENm1dmZ0DWoVb34bYNu+eevqFlMYhStZLuflvy4QDq7slMkQv0j+UXaE/BpZO7zQWQOYzTdgCDVba2qjg/qED203SSUGoVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=FIejWLYO; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FIejWLYO"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4D4D919258;
	Tue, 11 Jun 2024 13:54:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=CjbyDgPIh+Fy0H3HkaM6MLmja7tEZf06CZajKP
	SILoE=; b=FIejWLYOSbK3CdmgfPcSuojK7oPeeq8ms8DtaoDGwkSZKU8XlrwkUq
	AjK93UzLaoc4yJJMHiLarleLeWSYuJo86+d5TDhiXWS1rOfqjFSNQ9K7pX6IxK7M
	n72uHoSTfX0hZe4xr59VutLjFwkNBh0Dmtg7GdwkG0RyLGTFZLLqQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 45EB119257;
	Tue, 11 Jun 2024 13:54:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A587819256;
	Tue, 11 Jun 2024 13:54:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Kyle Lippincott <spectral@google.com>
Subject: Re: [PATCH 1/2] config: fix segfault when parsing "core.abbrev"
 without repo
In-Reply-To: <7ded51bbce1b23cf4110e3bf0abb7579efd4d344.1718095090.git.ps@pks.im>
	(Patrick Steinhardt's message of "Tue, 11 Jun 2024 10:42:02 +0200")
References: <CAO_smVimsHAPbMxy09mcYZY8apFgCbpnS9eSF7UOL6_BLqntNw@mail.gmail.com>
	<7ded51bbce1b23cf4110e3bf0abb7579efd4d344.1718095090.git.ps@pks.im>
Date: Tue, 11 Jun 2024 10:54:23 -0700
Message-ID: <xmqqh6dzwek0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A3AC265A-281B-11EF-86F3-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Fix both of these issues by not making it an error anymore when the
> given length exceeds the hash length. Instead, if we have a repository,
> then we truncate the length to the maximum length of `the_hash_algo`.
> Otherwise, we simply leave the abbreviated length intact and store it
> as-is. This is equivalent to the logic in `parse_opt_abbrev_cb()` and is
> handled just fine by `repo_find_unique_abbrev_r()`. In practice, we
> should never even end up using `default_abbrev` without a repository
> anyway given that abbreviating object IDs to unique prefixes requires us
> to have access to an object database.

Makes sense.

> diff --git a/config.c b/config.c
> index abce05b774..ab2844d9e1 100644
> --- a/config.c
> +++ b/config.c
> @@ -1460,11 +1460,14 @@ static int git_default_core_config(const char *var, const char *value,
>  		if (!strcasecmp(value, "auto"))
>  			default_abbrev = -1;
>  		else if (!git_parse_maybe_bool_text(value))
> -			default_abbrev = the_hash_algo->hexsz;
> +			default_abbrev = startup_info->have_repository ?
> +				the_hash_algo->hexsz : GIT_MAX_HEXSZ;

We will need to have some code that further adjusts overly long
default_abbrev when we really have to abbreviate (at which time,
hopefully we are already aware of the real hash algorithm used in
the repository, and that may be SHA-1) anyway.

So do we even need the conditional here?  Can't we just set it to
GIT_MAX_HEXSZ here unconditionally?

> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index 86c695eb0a..99c063e4cd 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -1237,6 +1237,12 @@ test_expect_success 'log.abbrevCommit configuration' '
>  	test_cmp expect.whatchanged.full actual
>  '
>  
> +test_expect_success 'log.abbrevCommit with --abbrev=9000' '
> +	git log --no-abbrev >expect &&
> +	git log --abbrev-commit --abbrev=9000 >actual &&
> +	test_cmp expect actual
> +'

Interesting.  We didn't have coverage for "we want to see full
object names" case.

> +test_expect_success 'output from clone with core.abbrev does not crash' '
> +	rm -fr dst &&
> +	echo "Cloning into ${SQ}dst${SQ}..." >expect &&
> +	git -c core.abbrev=12 clone -n "file://$(pwd)/src" dst >actual 2>&1 &&
> +	test_cmp expect actual
> +'

OK.
