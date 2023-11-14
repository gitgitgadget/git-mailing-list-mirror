Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2849F3FE38
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 16:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nz0eOHEi"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0345711D
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 08:51:46 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6A47F1C3FAE;
	Tue, 14 Nov 2023 11:51:45 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=jBkNwzygNdUJPykD+vPEZxr2UET4cJfPhmT/ln
	K6VM4=; b=nz0eOHEi+VNN9raWIc0kYBbx8z+o6L3Kfp86x/XyT78N+gGqBcOsHO
	ex+Qsw/eWMQ8BdTxZgOCI5QsDgjc/y4t+r66wHqR1ChHQPSL5kq9JgA2UfRMu+fu
	qmS/Mzb7zc337yZlKLwE/HyW68MlWBDTpxTsMQWyPcXVb25BugNUw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 620371C3FAD;
	Tue, 14 Nov 2023 11:51:45 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C698A1C3FAC;
	Tue, 14 Nov 2023 11:51:44 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: [PATCH] commit-graph: disable GIT_COMMIT_GRAPH_PARANOIA by default
In-Reply-To: <xmqq7cmkz3fi.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	15 Nov 2023 01:48:33 +0900")
References: <7e2d300c4af9a7853201121d66f982afa421bbba.1699957350.git.ps@pks.im>
	<ZVNNXNRfrwc_0Sj3@tanuki> <xmqq7cmkz3fi.fsf@gitster.g>
Date: Wed, 15 Nov 2023 01:51:43 +0900
Message-ID: <xmqqzfzgxops.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 17DE9D86-830E-11EE-84F0-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> Gah, I forgot to run this with GIT_TEST_COMMIT_GRAPH=1 before sending
>> this patch. There are two test failures that this change introduces:
>>
>>   - t6022-rev-list-missing.sh, where we test for the `--missing=` option
>>     of git-rev-list(1).
>
> I would have expected you to enable the paranoia mode automatically
> when this option is in effect.
>
>> Both of these are expected failures: we knowingly corrupt the repository
>> and circumvent git-gc(1)/git-maintenance(1), thus no commit-graphs are
>> updated. If we stick with the new stance that repository corruption
>> should not require us to pessimize the common case,...
>
> Yeah, just like we try to be extra careful while running fsck,
> because "--missing" is about finding these "corrupt" cases,
> triggering the paranoia mode upon seeing the option would make
> sense, no?  It would fix the failure in 6022, right?
>
> Thanks for working on this.

Just to make sure we do not miscommunicate, I do not think we want
to trigger the paranoia mode only in our tests.  We want to be
paranoid to help real users who used "--missing" for their real use,
so enabling PARANOIA in the test script is a wrong approach.  We
should enable it inside "rev-list --missing" codepath.


