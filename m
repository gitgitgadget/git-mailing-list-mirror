Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82C93BB50
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 17:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722964282; cv=none; b=PydB0kdHUvZ2J1Fm1Nc+6gVNpKlOteslyTOrcnVTmipLQArRcHDbC0+KFF+2n7fHjq1qMl6V/FwDmxGSplfcUT/1F42RWjogUP8omuDMmAdx8cwkOpC2nsizvfLHB6clL3vMTcIrKMoLNIqwWBn+12mXXBRU8yuUHLpmSyYcqK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722964282; c=relaxed/simple;
	bh=shP+8VYzUt9qPoRFG4BajYqumdC87DqnIbIVtj1heXM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WjP2n18iGbe/0diwruWBYcdSDb+xFuJHX/iabuaTeL+DeHUO09IMqEEzNkr45ie7erZQy8XlJwUpx969ROh/laTWp7IytusDUvU0hgzy9ybEgtrKt7cx1xPXPW23uMcfJkHEAjq6guU7Mu3/y8elAczuIb/i9pHo6iaEZMmMJ4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=k45r3n/Q; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="k45r3n/Q"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A41DF2F247;
	Tue,  6 Aug 2024 13:11:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=shP+8VYzUt9qPoRFG4BajYqumdC87DqnIbIVtj
	1heXM=; b=k45r3n/QFAzhIdQH0hrhQ9DBXoaPvsa3K/POIc/jeg0e2oEQXVq/Xx
	vHJ8g63N3/QX3CR20iqwsEiSq1j5dFWnRU16aA5Lywne+POflGzeizZVMGUkRohF
	kYy1TN8H5+XGZqkZs7s8IfrsN/eRD1ep05lCxMO0agd6+D2wg/VDE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9A6902F246;
	Tue,  6 Aug 2024 13:11:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 093232F245;
	Tue,  6 Aug 2024 13:11:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: [RFC] usage_msg_opt() and _optf() must die
In-Reply-To: <xmqqed71vbps.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	06 Aug 2024 09:48:47 -0700")
References: <20240806003539.3292562-1-gitster@pobox.com>
	<20240806003539.3292562-2-gitster@pobox.com> <ZrG_A3UQk56aYJ_m@tanuki>
	<xmqqed71vbps.fsf@gitster.g>
Date: Tue, 06 Aug 2024 10:11:17 -0700
Message-ID: <xmqqmslptw3u.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E5A48DD2-5416-11EF-B3D8-9B0F950A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> I always have to wonder how helpful it really is to print the usage
>> information in such a context. I feel that it is too distracting because
>> in many cases, we end up printing dozens of lines of options that drown
>> out the single line of information that the user actually cares for,
>> namely why the command has failed.

Yes.  I do not think I found it useful to give the single-line
message, blank line, followed by the full usage text even a single
time myself.

I am very much tempted to suggest us do this.

 parse-options.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git c/parse-options.c w/parse-options.c
index 30b9e68f8a..f27c425557 100644
--- c/parse-options.c
+++ w/parse-options.c
@@ -1277,11 +1277,10 @@ void NORETURN usage_with_options(const char * const *usagestr,
 }
 
 void NORETURN usage_msg_opt(const char *msg,
-		   const char * const *usagestr,
-		   const struct option *options)
+		   const char * const *usagestr UNUSED,
+		   const struct option *options UNUSED)
 {
-	die_message("%s\n", msg); /* The extra \n is intentional */
-	usage_with_options(usagestr, options);
+	die("%s", msg);
 }
 
 void NORETURN usage_msg_optf(const char * const fmt,
