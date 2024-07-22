Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486AB18EB8
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 23:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721689847; cv=none; b=qKqr1xQwhAHvJIsCTq+32vPkD5O6o1H1/pDQObofwRaYkwQtwZwnCQi1kuOJXk7yzWjbei1Y4oer0Vk4BiPZuRofYQKCKcnZhcVGS7+fQN3VYybNxsIA81NNH8OgmSE46IwRpnZ4OAUTEnTvYXLwzOI9AWn9hrhvClUDDboLhmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721689847; c=relaxed/simple;
	bh=3mhSxZQjyJbToKn92VF0lwZIlRnnAc3NFd4QYBLXmiA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=irsc6MzwmmbCQ6O0lnb+//crgfmE6cyOLFfB5k/1EGZAKTmH/3cirImcojAyiNIOJg878eN4aHTohnHkVUcOhIAzcfwSAmuTY+Yw2s7v1Vc00DcieYyypvy/prJ1PM0KhVpb38QEpD7tZJ44Dn3P0WwR5mG5F2CHpAG6b/1q2Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=AyutEa6v; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AyutEa6v"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B873223B95;
	Mon, 22 Jul 2024 19:10:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=3
	mhSxZQjyJbToKn92VF0lwZIlRnnAc3NFd4QYBLXmiA=; b=AyutEa6vkIuYtd+bf
	29K7fp/YKgGVO67jXlcZLDXI2jBNeQwFQSJUWDyNU1R1Ii64CyKiEgLm8odgmPAd
	tJs41vKZK0NA1png6FebP8VgbREHqXKoo014UBbcEKcXOQLjOAXEbsHEYa0lwEVP
	i4VTiz3+LEgPjNRmFlShhMMutI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B15D223B94;
	Mon, 22 Jul 2024 19:10:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2795523B91;
	Mon, 22 Jul 2024 19:10:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2] CodingGuidelines: document a shell that "fails" "VAR=VAL
 shell_func"
Date: Mon, 22 Jul 2024 16:10:41 -0700
Message-ID: <xmqqjzhd81la.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9EA9F072-487F-11EF-922B-34EEED2EC81B-77302942!pb-smtp1.pobox.com

Over the years, we accumulated the community wisdom to avoid the
common "one-short export" construct for shell functions, but seem to
have lost on which exact platform it is known to fail.  Now during
an investigation on a breakage for a recent topic, we found one
example of failing shell.  Let's document that.

This does *not* mean that we can freely start using the construct
once Ubuntu 20.04 is retired.  But it does mean that we cannot use
the construct until Ubuntu 20.04 is fully retired from the machines
that matter.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/CodingGuidelines | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 1d92b2da03..203ef49364 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -204,6 +204,30 @@ For shell scripts specifically (not exhaustive):
 	local variable="$value"
 	local variable="$(command args)"
 
+ - The common construct
+
+	VAR=VAL command args
+
+   to temporarily set and export environment variable VAR only while
+   "command args" is running is handy, but some versions of dash (like
+   0.5.10.2-6 found on Ubuntu 20.04) makes a temporary assignment
+   without exporting the variable, when command is *not* an external
+   command.  Do not use it for shell functions.  A common workaround
+   is to do an explicit export in a subshell, like so:
+
+	(incorrect)
+	VAR=VAL func args
+
+	(correct)
+	(
+		VAR=VAL &&
+		export VAR &&
+		func args
+	)
+
+   but be careful that the effect "func" makes to the variables in the
+   current shell will be lost across the subshell boundary.
+
  - Use octal escape sequences (e.g. "\302\242"), not hexadecimal (e.g.
    "\xc2\xa2") in printf format strings, since hexadecimal escape
    sequences are not portable.

Range-diff:
1:  78a3847e80 ! 1:  75d07c05c7 CodingGuidelines: give an example shell that "fails" "VAR=VAL shell_func"
    @@ Metadata
     Author: Junio C Hamano <gitster@pobox.com>
     
      ## Commit message ##
    -    CodingGuidelines: give an example shell that "fails" "VAR=VAL shell_func"
    +    CodingGuidelines: document a shell that "fails" "VAR=VAL shell_func"
     
         Over the years, we accumulated the community wisdom to avoid the
         common "one-short export" construct for shell functions, but seem to
         have lost on which exact platform it is known to fail.  Now during
    -    an investigation on a breakage for a recent topic, let's document
    -    one example of failing shell.
    +    an investigation on a breakage for a recent topic, we found one
    +    example of failing shell.  Let's document that.
     
         This does *not* mean that we can freely start using the construct
         once Ubuntu 20.04 is retired.  But it does mean that we cannot use
    @@ Documentation/CodingGuidelines: For shell scripts specifically (not exhaustive):
     +
     +	(correct)
     +	(
    -+		VAR=VAL && export VAR &&
    ++		VAR=VAL &&
    ++		export VAR &&
     +		func args
     +	)
     +
-- 
2.46.0-rc1-52-g816ffef0a1

