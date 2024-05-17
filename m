Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B8B12C492
	for <git@vger.kernel.org>; Fri, 17 May 2024 17:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715968537; cv=none; b=bwJWgJIm5LtUQ4xVYPIurzvMG+7yIBcSWaV/V8b6K9YnEgn3xWx5bLS/PWl+S49bKExkZUNYl1Ul1IyXTHp3NPlgA/GYal4T39SkPFTQg3WVnRM2fvxEIt0o8erI0PZSaU5WJ7deeZhbUAMZ7cbsayssTBZI6+TW6jBOQ0URasQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715968537; c=relaxed/simple;
	bh=j49EfVcDZB7W8feKFYbgVUgXNcR0HyrRsvvNyPaqjdk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QznEAdkJmujcHmNudUlqn+x5oBYx2TGohkYdNCvGjy9GeCsLanGIKao+f6rOLCKtCGJW9HAMSttNZgn1E676aVWAzxSbztzYlL5W1wrL3kW8hmaaU2G/09QezzKIXYg14SLvDAo1v86OEB5Kgrj5tG1mfMFRmU33EhOBN98rWuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=IbJneVbO; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IbJneVbO"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 835FF29654;
	Fri, 17 May 2024 13:55:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=j49EfVcDZB7W8feKFYbgVUgXNcR0HyrRsvvNyP
	aqjdk=; b=IbJneVbOlKU2sq1eeoyIKK81uq/64cb5pH5F18VIdg3I4DrdysSRUf
	SkcXbJtzPBbtgMVBZDdJVzqXO1CKj4Rd8IQP+51AKFsErxsvq/9I4RK4+Raa/SUS
	3jRT46mTtvpaBryixFwZsDw5LbbPOPFJRXXiRAdx3cUNGtKGfsCP4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7A6B529653;
	Fri, 17 May 2024 13:55:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D010529652;
	Fri, 17 May 2024 13:55:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Marcel Telka <marcel@telka.sk>
Cc: git@vger.kernel.org
Subject: Re: Three t4150 tests does not work as expected
In-Reply-To: <ZkeJx97qdLoaC2H-@telcontar> (Marcel Telka's message of "Fri, 17
	May 2024 18:45:59 +0200")
References: <ZkeJx97qdLoaC2H-@telcontar>
Date: Fri, 17 May 2024 10:55:33 -0700
Message-ID: <xmqqcypkiaqy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A92BCBA2-1476-11EF-8239-25B3960A682E-77302942!pb-smtp2.pobox.com

Marcel Telka <marcel@telka.sk> writes:

> All of them does something like:
>
> 	git show HEAD --format="%B" >actual
> 	grep -f actual expected

Wow, these commands look nonsensical in as many counts as there are
lines in there X-< [*].

It seems that they came from two patches, namely

 7c096b8d (am: support --empty=<option> to handle empty patches, 2021-12-09)
 9e7e41bf (am: support --allow-empty to record specific empty patches, 2021-12-09)

Most likely the author of these lines were confused and meant to use
test_cmp (which by the way should always compare actual against
expect, i.e. "test_cmp expect actual", because when the actual
output differs, that is the order of the diff we want to see in the
output to diagnose the breakage).  I especially suspect that the
author did not mean "read patterns from this file", but was confused
to think that 'f' implies "match literally" somehow (the correct
spelling of that fixed-strings option is -F but still it does the
wrong thing reading from the file---it does not even ensure that
all patterns listed in the file matches).

I am not saying (as I did not check) that doing just "grep -f A B"
-> "test_cmp B A" woudl make things work.  I do not think I trust
that these tests added by the same patch have a sane expectations
X-<.  The outcome these tests try to verify may also need to be
corrected.


[Footnote] 

 * To start with, any dashed option like --format=%B should come
   before a revision argument HEAD.  There are many other
   antipatterns in this test script, which should be cleaned up.
