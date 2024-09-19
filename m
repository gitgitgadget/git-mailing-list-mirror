Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140F65661
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 19:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726774432; cv=none; b=mq1F9YwtfEkiDpIQbnTF/NCpCtNe3/gIMNTb1ove3XVUSVsxrTqvci1isRC1MATWh1DSBusIanqFHyLXw2Xf+iKIscc2kVbiGkERbya+wku6tStIP9YBta7jLARNVjla0bYGtCRsRn8H3Yn63F/kfESOS6zJQHNsFyZsFteBLv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726774432; c=relaxed/simple;
	bh=GY1g9JoRz3aNvENFLgclDbOx16gXdL81JRRYRUUjuh0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AhgI/7nwOsxqP9hS7hrCW8FxEkIK6w9pYtxDRXEa+Oty0AY1M1kkhRJa49L4qTKW8b1uvTSo/vvStoLLCaVl6nCPhc0HybuIJ7H9JbOzk9KBUTL+rID9oocqQiueyXTWah3jz+ub4W9nANhs7rzBRQI8v0ZeSnEs5kLruFX/uQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=YXlCmpCV; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YXlCmpCV"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BBD872AEE2;
	Thu, 19 Sep 2024 15:33:49 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=G
	Y1g9JoRz3aNvENFLgclDbOx16gXdL81JRRYRUUjuh0=; b=YXlCmpCVmrl7EFuLP
	OBaCIR+/so/yu/LSmYKmCOy0BPeQ9Bv48ZYCehMBShWRNs9VNFAMlNPcp1Fetr0I
	9LhkfimwjdepyyiZu9UN8/f1E0SqKIS6O8B3Qpl5z8O2GgsK3cTgokO0m0rxjJb9
	wxzC5vV37fRF41Jo/tSwFgNsMs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B3C5C2AEE1;
	Thu, 19 Sep 2024 15:33:49 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 080D32AEE0;
	Thu, 19 Sep 2024 15:33:48 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Derrick Stolee <stolee@gmail.com>
Subject: [PATCH] BreakingChanges: early adopter option
Date: Thu, 19 Sep 2024 12:33:47 -0700
Message-ID: <xmqq7cb77810.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1803D232-76BE-11EF-A07F-9B0F950A682E-77302942!pb-smtp2.pobox.com

Discussing the desire to make breaking changes, declaring that
breaking changes are made at a certain version boundary, and
recording these decisions in this document, are necessary but not
sufficient.  We need to make sure that we can implement, test, and
deploy such impactful changes.

Formalize the mechanism based on the `feature.*` configuration
variable to allow early adopters to opt into the breaking change in
a version of Git before the planned version for the breaking change.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Before I forget.  I'll find time to rewrite the "we no longer
   honor core.preferSymlinkRefs" topic to follow this new guideline
   when we see a rough concensus that both the procedure outlined
   here and the idea to remove core.preferSymlinkRefs are good.

 Documentation/BreakingChanges.txt | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git i/Documentation/BreakingChanges.txt w/Documentation/BreakingChanges.txt
index 2b64665694..9f1e9a0fb8 100644
--- i/Documentation/BreakingChanges.txt
+++ w/Documentation/BreakingChanges.txt
@@ -59,10 +59,31 @@ over time. If circumstances change, an earlier decision to deprecate or change
 something may need to be revisited from time to time. So do not take items on
 this list to mean "it is settled, do not waste our time bringing it up again".
 
+== Procedure
+
+Discussing the desire to make breaking changes, declaring that breaking
+changes are made at a certain version boundary, and recording these
+decisions in this document, are necessary but not sufficient.
+Because such changes are expected to be numerous, and the design and
+implementation of them are expected to span over time, they have to
+be deployable trivially at such a version boundary.
+
+The breaking changes MUST be guarded with the configuration
+variable, `feature.git<version>` to help this process.  Each
+individual breaking change must be implemented in such a way that
+for a user who has this configuration variable set to true, it goes
+in effect even before Git <version>.  Note that setting the
+configuration to `false` MUST have no effect, either before or AFTER
+Git <version>.  In other words, this is purely an option to recruit
+early adopters and not a mechanism to keep the old behaviour after
+the announced version boundary for breaking changes.
+
+
 == Git 3.0
 
 The following subsections document upcoming breaking changes for Git 3.0. There
-is no planned release date for this breaking version yet.
+is no planned release date for this breaking version yet.  The early
+adopter configuration used for changes for this release is `feature.git3`.
 
 Proposed changes and removals only include items which are "ready" to be done.
 In other words, this is not supposed to be a wishlist of features that should
