Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484812E405
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 19:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724353268; cv=none; b=i5m6HDMg1emb53ookGaO/Yz5+xDoH1uq3RVvXI/cDXYfajklmAxjJTJnds5hCCHRw3ptpUNADSD4D5owklbQa16+vLKqwio8f1UrYYhNx32havPlOh36bn+0eJyVD9Ae4fsyul95XhwyBJHZqTk4gU7bgHU9xeKH7zQ2oFohxI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724353268; c=relaxed/simple;
	bh=/LMtJBzmDUtArkx4+/a92aHRS2VuWhk86LcA66Rvu0w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kUJiDkC0HaOiLXar1+dcvTnjMja5jGtjzTPwXZ1XLlungm0ppa+prWx/61BrBTV9xH+o6H5BW2UiHva84Fu2b8TNscY56l6+QdLxbTdUfrvvakj6NJhOhJra0kBMaPfjnM34Ufzei8WvPNMlhdO27Wmishm9xWDafulGM2dXvhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Z/Wle0R1; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Z/Wle0R1"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E16EE1AF3A;
	Thu, 22 Aug 2024 15:01:06 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=/LMtJBzmDUtArkx4+/a92aHRS2VuWhk86LcA66
	Rvu0w=; b=Z/Wle0R1vflNjD8SVFmGNlbMgedvtdd5q5tK8M9rUiEzq3terB1iSN
	gca5vmthwz1ito28ugxQdFMLo5HJjbhGQMBzSJs0l1peCjpxmfCCzII7lL4mqLi+
	ie4hXhKWqi1CvKWUMSjdIyyclyjEcfr1Kzdzve0lCpPgcxyfTFxZ4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C45A61AF39;
	Thu, 22 Aug 2024 15:01:06 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 54FC51AF38;
	Thu, 22 Aug 2024 15:01:03 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 00/20] Memory leak fixes (pt.5)
In-Reply-To: <cover.1724315484.git.ps@pks.im> (Patrick Steinhardt's message of
	"Thu, 22 Aug 2024 11:17:08 +0200")
References: <cover.1724159575.git.ps@pks.im> <cover.1724315484.git.ps@pks.im>
Date: Thu, 22 Aug 2024 12:01:01 -0700
Message-ID: <xmqqh6bcqt5e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E0CE17E8-60B8-11EF-AAB7-E92ED1CD468F-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> this is version 2 of this patch series that fixes another set of memory
> leaks.
>
> Changes compared to v1:
>
>   - Remove spaces between cast and variable.
>
>   - Clarify why we move the `ctx.entries_nr` block.
>
>   - Adapt sideband colors to use `git_config_get_string_tmp()` such that
>     we do not have to allocate the strings in the first place.
>
>   - Fix more memory leaks for config values in the remote state.
>
>   - Refactor `unbundle()` to not free extra args passed by the caller
>     anymore. Instead, this is now always done by the caler.

All these changes look sensible to me.

Let me wait for a few days for others' comments, and then mark the
topic for 'next'.

Thanks.
