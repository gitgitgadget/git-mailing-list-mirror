Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFD8188583
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 21:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725571009; cv=none; b=Kl4WsSGOnAIdQTFrPfcEdbPv6nKhCgI7FpifcWOui+q0W8YP9RMYkhiULr0cWsQ1wcnfoByb+O/T5KqH+AW4WaQC05p3a6Q1MYtyLewsRGBx4HhPaCliUlVGI0hCfKQkDhXIUNgibtyqGFMmdfrRhHX40sOtzDpAFICTpTCpKOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725571009; c=relaxed/simple;
	bh=amADqu+wueRW/L2achd1J1pMZcgKP9QelT7Ql0uwKPs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LU+nD1nmt8Zf0rxc97XSKohuiXVAlrEgmbC/1lnKWFwrXASUcLS6liY0xyHihj4XAScVV0Aw3+R7MQU/JRbnqT7aCjlJCp3l7t6goaG9m6lbN8LHH01qMPehfXdFxf/azFiWQ7exzaE6wjJN/rfW2na14B36rOv1H4pnkkKCzwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ht2S7OX7; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ht2S7OX7"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1EEB92FBDD;
	Thu,  5 Sep 2024 17:16:47 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=amADqu+wueRW/L2achd1J1pMZcgKP9QelT7Ql0
	uwKPs=; b=Ht2S7OX7si2UY7OPzLK9xoI3eOZp7ZEWPZvTtpAS7LCplcYhk0UC+Q
	PoUsvw/tCziSPt0jVjsvq1Lyk9WxkHDVSrMvq2i9dpQpjgo+s9+QpaggQZzeM6xh
	aqffSNhj+IMTU+MFJOhmj+61k9NblltIfx2NNctVwO7OlZBpy5LDk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 151B72FBDC;
	Thu,  5 Sep 2024 17:16:47 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7627D2FBDB;
	Thu,  5 Sep 2024 17:16:46 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: [PATCH] sparse-checkout: use fdopen_lock_file() instead of
 xfdopen()
In-Reply-To: <ZtmN6sZCvDy1BGfn@pks.im> (Patrick Steinhardt's message of "Thu,
	5 Sep 2024 12:54:42 +0200")
References: <20240905082749.GA88220@coredump.intra.peff.net>
	<ZtmN6sZCvDy1BGfn@pks.im>
Date: Thu, 05 Sep 2024 14:16:45 -0700
Message-ID: <xmqqr09xztqa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 28467C50-6BCC-11EF-9E2E-9B0F950A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> +	if (commit_lock_file(&lk))
>> +		die_errno(_("unable to write %s"), get_locked_file_path(&lk));
>>  
>>  	clear_pattern_list(pl);
>
> I think the error handling is broken. `commit_lock_file()` calls
> `rename_tempfile()`, which deletes the temporary file even in the error
> case. The consequence is that `lk->tempfile` will be set to the `NULL`
> pointer. When we call `get_locked_file_path()` we then dereference it
> unconditionally and would thus segfault.

Hmph.  Would this be sufficient as a band-aid, then?

 builtin/sparse-checkout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git c/builtin/sparse-checkout.c w/builtin/sparse-checkout.c
index f1bd31b2f7..60363fd056 100644
--- c/builtin/sparse-checkout.c
+++ w/builtin/sparse-checkout.c
@@ -356,7 +356,7 @@ static int write_patterns_and_update(struct pattern_list *pl)
 		write_patterns_to_file(fp, pl);
 
 	if (commit_lock_file(&lk))
-		die_errno(_("unable to write %s"), get_locked_file_path(&lk));
+		die_errno(_("unable to write %s"), sparse_filename);
 
 	clear_pattern_list(pl);
 
