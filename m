Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11C329CF7
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 17:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CfGqI/FQ"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F634CA
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 10:17:02 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id BD8ED1E642;
	Thu, 19 Oct 2023 13:17:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=sWMn6AxoamBioy6+JgrXQ1tJuqESGMMKtD59id
	il+Pw=; b=CfGqI/FQqfFUpCh8gHz4hyIHgQBriPXkfoiHPpDcUifGpmLvybUSOG
	TxIgaoGLEpOFNlTdtS/X7L0SApJvY2go/j1bZwgChZifJqX7OjDDn91UnYfkT7Og
	4RqegG8PvgobgtJZ+SkECnyqUhVLnyKLnTszYGrsQAlmDdt7mwLTA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B56E61E641;
	Thu, 19 Oct 2023 13:17:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4230F1E63F;
	Thu, 19 Oct 2023 13:16:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Taylor
 Blau <me@ttaylorr.com>
Subject: Re: [PATCH] commit: detect commits that exist in commit-graph but
 not in the ODB
In-Reply-To: <ZTDn-Wd5xsFrBmqI@tanuki> (Patrick Steinhardt's message of "Thu,
	19 Oct 2023 10:25:29 +0200")
References: <ZSkCGS3JPEQ71dOF@tanuki>
	<b0bf576c51a706367a758b8e30eca37edb9c2734.1697200576.git.ps@pks.im>
	<xmqq1qdy1iyr.fsf@gitster.g> <ZS4rmtBTYnp2RMiY@tanuki>
	<xmqqjzrlhzci.fsf@gitster.g> <ZTDQjangLsQ1cSJl@tanuki>
	<ZTDn-Wd5xsFrBmqI@tanuki>
Date: Thu, 19 Oct 2023 10:16:56 -0700
Message-ID: <xmqqzg0ey1kn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4F385CCE-6EA3-11EE-99BD-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> There's another way to handle this, which is to conditionally enable the
> object existence check. This would be less of a performance hit compared
> to disabling commit graphs altogether with `--missing`, but still ensure
> that repository corruption was detected. Second, it would not regress
> performance for all preexisting users of `repo_parse_commit_gently()`.

The above was what I meant to suggest when you demonstrated that the
code with additional check is still much more performant than
running without the commit-graph optimization, yet has observable
impact on performance for normal codepaths that do not need the
extra carefulness.

But I wasn't sure if it is easy to plumb the "do we want to double
check?  in other words, are we running something like --missing that
care the correctness a bit more than usual cases?" bit down from the
caller, because this check is so deep in the callchain.

Thanks.

