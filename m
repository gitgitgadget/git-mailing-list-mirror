Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBC28C1E
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 18:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718996020; cv=none; b=RHLFOwjv0BPupmwv9OEJtr9GaUYu9Lj2k9kNO6rnyLVNOcQ6osKEqP9RK6ykwI/IIiSL4fiHGQI5Ei4JUkbvEsik/Lm9RgYS264q3qZY/rp7NFsJIFE4abmSKPE0aVrTk3YRvgOX5uFTGWIPSuyRcYz4IiGpBHUHaIFalhC6j/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718996020; c=relaxed/simple;
	bh=64gYdU6FbGgVGK3HN8VRsECorLdXhY7i7TuyfqUuOLo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LE6/nZ4JT7CafkV00NBpE+HgSOv91aMbG0SMRWDqKEm2KXEt8my5ynPF1wyISK849jEd3norXRGc2fjvYs4Xf9TrL2S1gcA4cSomEoe30sh6nRPHDsU58cmeprStuddbVTfkLeCAp1qu0JBizijV44wGkjTVG5gBM4ycFSB83so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=slq8nWN5; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="slq8nWN5"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 066C6264B9;
	Fri, 21 Jun 2024 14:53:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=64gYdU6FbGgVGK3HN8VRsECorLdXhY7i7Tuyfq
	UuOLo=; b=slq8nWN5qOipul/z27UMZo5xKkIhVcvWy4AH7d4qWDAueMYfOHJ6q4
	y9eOzEczwYq5n6AWFfkogWXQff3c4/xKa5Ir+vu+SN+NoHN19ZUPNeFYCsa/E+4u
	7/EjtayGnXvCcOs3Xw7AUY34uOxiMDabmUzspNHfMheOFTtPeQp2I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F25FE264B8;
	Fri, 21 Jun 2024 14:53:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 60648264B7;
	Fri, 21 Jun 2024 14:53:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Rob Linden <rlinden@redhat.com>
Cc: git@vger.kernel.org
Subject: Re: problem with parsing of patch files for patch-id
In-Reply-To: <xmqqbk3uns4s.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	21 Jun 2024 10:05:23 -0700")
References: <CAP0H_AEd1jFNB_dO=HRjwEUKzFqnjntss_1wskKU6hE1VmBs+A@mail.gmail.com>
	<xmqqbk3uns4s.fsf@gitster.g>
Date: Fri, 21 Jun 2024 11:53:36 -0700
Message-ID: <xmqq7ceiktzj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9162D7BE-2FFF-11EF-A6A1-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Rob Linden <rlinden@redhat.com> writes:
>
>> This patch (also attached) fixes it by only considering commit hashes
>> in a "From xxxxx..." line:
>
> If I am not mistaken, "git patch-id" was designed to read from
>
>     git rev-list ... commit range ... | git diff-tree --stdin -p
>
> where we see
>
>     9005149a4a77e2d3409c6127bf4fd1a0893c3495
>     diff --git a/path b/path
>     index ...
>     ... patch text here ...
>
> so I would suspect that limiting the commit object names only to
> those that follow "From " (i.e. the format-patch output or output
> with the "--format=email" option) would break existing use cases big
> time.

Let's do this to make sure we have a baseline that we will not
break.

------- >8 ------------- >8 ------------- >8 -------
[PATCH] t4204: patch-id supports various input format

"git patch-id" was first developed to read from "git diff-tree
--stdin -p" output.  Later it was enhanced to read from "git
diff-tree --stdin -p -v", which was the downstream of an early
imitation of "git log" ("git rev-list" run in the upstream of a pipe
to feed the "diff-tree").  These days, we also read from "git
format-patch".

Their output begins slightly differently, but the patch-id computed
over them for the same commit should be the same.  Ensure that we
won't accidentally break this expectation.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4204-patch-id.sh | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git c/t/t4204-patch-id.sh w/t/t4204-patch-id.sh
index 605faea0c7..ebce72b2ce 100755
--- c/t/t4204-patch-id.sh
+++ w/t/t4204-patch-id.sh
@@ -114,6 +114,29 @@ test_expect_success 'patch-id supports git-format-patch output' '
 	test "$2" = $(git rev-parse HEAD)
 '
 
+test_expect_success 'patch-id computes the same for various formats' '
+	# This test happens to consider "git log -p -1" output
+	# the canonical input format, so use it as the norm.
+	git log -1 -p same >log-p.output &&
+	git patch-id <log-p.output >expect &&
+
+	# format-patch begins with "From <commit object name>"
+	git format-patch -1 --stdout same >format-patch.output &&
+	git patch-id <format-patch.output >actual &&
+	test_cmp actual expect &&
+
+	# "diff-tree --stdin -p" begins with "<commit object name>"
+	same=$(git rev-parse same) &&
+	echo $same | git diff-tree --stdin -p >diff-tree.output &&
+	git patch-id <diff-tree.output >actual &&
+	test_cmp actual expect &&
+
+	# "diff-tree --stdin -v -p" begins with "commit <commit object name>"
+	echo $same | git diff-tree --stdin -p -v >diff-tree-v.output &&
+	git patch-id <diff-tree-v.output >actual &&
+	test_cmp actual expect
+'
+
 test_expect_success 'whitespace is irrelevant in footer' '
 	get_patch_id main &&
 	git checkout same &&
