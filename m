Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710167BB16
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 18:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707501890; cv=none; b=UDpy8nKY2nNzzGOPkuc1llJFe271feKS8447mZfQL6Y0ZALGCPHSyTDp2w1T59kKfNd7R83eU9QPp5TaEDidJO9PJw1DKR5Ta8lEHLAHbp3je88cvOwTKbNF1kvbC138o9AXuh8gzsFZtaLP9s6BIlgwXEcXBri6V66Yth0sr9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707501890; c=relaxed/simple;
	bh=glcgCtCPdyC6A7Y/6WooNoBibylBc+g4mfNhNoemx6s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A2XJVUBudbal7jsMW1U9BX6er8llhlTtEZ4PvW/tYbC+Vfza0Aku0RplBDk9Si+uaA3xsJ+85eu+HyeBksDgunbcuVXm0isSs7R9bnhoO/DIZA7ZpNL4musa1DsRBazU8JPgsTJxhFbbcAjBJ32wbSvFh75E2yoJap2K6BrxfII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=vAVRhGsc; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vAVRhGsc"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 17EDE1DA5FC;
	Fri,  9 Feb 2024 13:04:48 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=glcgCtCPdyC6A7Y/6WooNoBibylBc+g4mfNhNo
	emx6s=; b=vAVRhGsc39zG6jbN1m5I46joRISsCTTmr51nKmr/JtN3kkpm93CjzU
	duVzSmW8/TGNAIxg3P+4RLvteYQ+S9QRePE7i/z+UA0jXDCuFvS0aG4eXrH7hlAM
	yDBkqCvtf35I0Z69sq/RBMb8Bxh9vV+e++DeNonStE8lCaqnWp3Ec=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0EB311DA5FB;
	Fri,  9 Feb 2024 13:04:48 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 609ED1DA5FA;
	Fri,  9 Feb 2024 13:04:47 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Orgad Shaneh <orgads@gmail.com>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2] prune: mark rebase autostash and orig-head as reachable
In-Reply-To: <pull.1656.v2.git.1707495579886.gitgitgadget@gmail.com> (Phillip
	Wood via GitGitGadget's message of "Fri, 09 Feb 2024 16:19:39 +0000")
References: <pull.1656.git.1707411636382.gitgitgadget@gmail.com>
	<pull.1656.v2.git.1707495579886.gitgitgadget@gmail.com>
Date: Fri, 09 Feb 2024 10:04:46 -0800
Message-ID: <xmqqjzndfr9d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B607D710-C775-11EE-9EAC-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +static void add_rebase_files(struct rev_info *revs)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +	size_t len;
> +	const char *path[] = {
> +		"rebase-apply/autostash",
> +		"rebase-apply/orig-head",
> +		"rebase-merge/autostash",
> +		"rebase-merge/orig-head",
> +	};

Yuck.

Having this table here makes the sequencer subsystem even less
maintainable than it already is.  I wonder if we can at least
somehow share some of these?  #leftoverbits.

Thanks.

