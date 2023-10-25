Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A72629
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 00:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LRbGguYx"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493ECD7F
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 17:35:12 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D0C7C1B3585;
	Tue, 24 Oct 2023 20:35:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=KJWRk9Tf57Q8nBWw42qvLa1nLP+nPokB4dFNYZ
	3ed0Y=; b=LRbGguYx6gMOCY2PIrgFzCaieBjafC2LPZYsvMy1yX0LRlmWPyO72M
	uVdJerY4aIBL4YVMKnFYrAbhfzV8oMbqPhyeUFrNcPi7AW9aDB2mSWJ4RTD7Nura
	JWS9n7B+MGLvEFOKHSjUhUHMwWrJfzXDLwltD6U9jkCfZoo02n2EI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BDAC81B3583;
	Tue, 24 Oct 2023 20:35:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E57F21B3581;
	Tue, 24 Oct 2023 20:35:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v4 3/3] rev-list: add commit object support in
 `--missing` option
In-Reply-To: <xmqqbkcn52z4.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	24 Oct 2023 10:45:19 -0700")
References: <20231019121024.194317-1-karthik.188@gmail.com>
	<20231024122631.158415-1-karthik.188@gmail.com>
	<20231024122631.158415-4-karthik.188@gmail.com>
	<xmqqbkcn52z4.fsf@gitster.g>
Date: Tue, 24 Oct 2023 17:35:06 -0700
Message-ID: <xmqqfs1zh745.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5926A0AE-72CE-11EE-8277-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> I noticed that nobody releases the resource held by this new oidset.
> Shouldn't we do so in revision.c:release_revisions()?

It seems that linux-leaks CI job noticed the same.

https://github.com/git/git/actions/runs/6633599458/job/18021612518#step:5:2949

I wonder if the following is sufficient?

 revision.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git c/revision.c w/revision.c
index 724a116401..7a67ff74dc 100644
--- c/revision.c
+++ w/revision.c
@@ -3136,6 +3136,8 @@ void release_revisions(struct rev_info *revs)
 	clear_decoration(&revs->merge_simplification, free);
 	clear_decoration(&revs->treesame, free);
 	line_log_free(revs);
+	if (revs->do_not_die_on_missing_objects)
+		oidset_clear(&revs->missing_objects);
 }
 
 static void add_child(struct rev_info *revs, struct commit *parent, struct commit *child)

