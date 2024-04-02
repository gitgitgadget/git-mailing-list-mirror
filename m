Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD3615AAA7
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 17:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712079951; cv=none; b=rKf4YxgFKdOat0qR3mQipnKpmy+l9EFKRXJr2zlVWijeW6T+Gfoirs2CNsxiEx0e5S2R0aqM9MT0MDUqD4J7ZjzGZkKo5+Sfn2ewDHpAowpPxypWJcBnFnVaqSCR9uIbTDFUKVDS6zGs7j38iOjc+vzqxoPzyuK7V39j8nUENlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712079951; c=relaxed/simple;
	bh=J3+PsWd9+uP1fvU+MC3y0KnYd1zOyoQMB+hDZmvt9W0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=epR/R6K1nVF19jj1NHRuau6JdFBG3XoLmaPH46TEoAohjVzZJuwf8kC2xMjLn6BjG7BsAFOyd2i6Ok+X7+ndNBez1B8RrtdF4U/m+We+kVQ1xT4Ghp+bRjG1MMhpFNqe5GGD+EvPVBGS9fYuMJVvUxFr4FzQ8k614y5+2lQKArw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=KH6hO8Bx; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KH6hO8Bx"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 733E21F1B30;
	Tue,  2 Apr 2024 13:45:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=J
	3+PsWd9+uP1fvU+MC3y0KnYd1zOyoQMB+hDZmvt9W0=; b=KH6hO8BxfxBNgjl8h
	V36pxKAZsZOMhaT5xblUS4YAtWcGuwpWvI7x3zTmS54b1EoZYFC/lvWIgebiFrI+
	FhHNEqLXpA3WMLqawWhmoXQEoQuzjM2ZkSSvipip0mlau/qgeNc3Dz3wHq0VQlQq
	3q3ykiYzJVLQA701O7AJbFG9VQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6C9961F1B2F;
	Tue,  2 Apr 2024 13:45:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DB5341F1B2E;
	Tue,  2 Apr 2024 13:45:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [BUG] "git range-diff" does not know X^! is a valid range
Date: Tue, 02 Apr 2024 10:45:46 -0700
Message-ID: <xmqq7chf64l1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D6BA7EC8-F118-11EE-87EE-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

When cherry-picking an existing commit X to a different base, which
may have resulted in conflicts that needed a fix-up, you would want
to be able to compare X~1..X and HEAD~1..HEAD and naturally, we
would expect "range-diff" to have a handy way to allow giving the
command without having to type the overly long branch name X twice.

Individual "diff" for these two ranges are easy to obtain without
repeating X:

    $ git diff X^!
    $ git diff HEAD^!

The "git range-diff" however does not understand that X^! is a valid
range X~1..X.  This command throws an error and ...

    $ git range-diff refs/merge-fix/ew/khash-to-khashl^! HEAD^!
    fatal: need two commit ranges

... to add insult to injury, it shows the huge "git range-diff -h"
output after that.

Any takers?
