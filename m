Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B11A44494
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 18:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HDVHkEuV"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED49D9F
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 11:34:57 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4A9891A5F08;
	Tue, 17 Oct 2023 14:34:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=AXgreTEC9ZnFNOc36vpce6H6uR+DTLqkHD98s4
	Qx8Jo=; b=HDVHkEuVHchAUb5Me5DRuQz69jn4Kz2GUxGW7wcENpm6hh1vhuX89l
	9BPsfFjw8ZQR7uaJ62omI3eNzt3N4F3oFidFCxXnQhBao/m23jrdXIGmntCILI6O
	rNrRbVbHOnGqyDgpjUMdSuzn/5NEaZtruoSx6Z8P8zErKiQnrA0Jc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3F23C1A5F07;
	Tue, 17 Oct 2023 14:34:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 95FAC1A5F06;
	Tue, 17 Oct 2023 14:34:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Taylor
 Blau <me@ttaylorr.com>
Subject: Re: [PATCH] commit: detect commits that exist in commit-graph but
 not in the ODB
In-Reply-To: <ZS4rmtBTYnp2RMiY@tanuki> (Patrick Steinhardt's message of "Tue,
	17 Oct 2023 08:37:14 +0200")
References: <ZSkCGS3JPEQ71dOF@tanuki>
	<b0bf576c51a706367a758b8e30eca37edb9c2734.1697200576.git.ps@pks.im>
	<xmqq1qdy1iyr.fsf@gitster.g> <ZS4rmtBTYnp2RMiY@tanuki>
Date: Tue, 17 Oct 2023 11:34:53 -0700
Message-ID: <xmqqjzrlhzci.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DDB6C0D2-6D1B-11EE-9037-25B3960A682E-77302942!pb-smtp2.pobox.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Patrick Steinhardt <ps@pks.im> writes:

> Fair point indeed. The following is a worst-case scenario benchmark of
> of the change where we do a full topological walk of all reachable
> commits in the graph, executed in linux.git. We parse commit parents via
> `repo_parse_commit_gently()`, so the new code path now basically has to
> check for object existence of every reachable commit:
> ...
> The added check does lead to a performance regression indeed, which is
> not all that unexpected. That being said, the commit-graph still results
> in a significant speedup compared to the case where we don't have it.

Yeah, I agree that both points are expected.  An extra check that is
much cheaper than the full parsing is paying a small price to be a
bit more careful than before.  The question is if the price is small
enough.  I am still not sure if the extra carefulness is warranted
for all normal cases to spend 30% extra cycles


Yeah, I agree that both points are expected.  An extra check that is
much cheaper than the full parsing is paying a small price to be a
bit more careful than before.  The question is if the price is small
enough.  I am still not sure if the extra carefulness is warranted
for all normal cases to spend 30% extra cycles.

Thanks.
