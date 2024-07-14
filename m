Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C9A273F9
	for <git@vger.kernel.org>; Sun, 14 Jul 2024 17:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720978183; cv=none; b=Q7zYG0nTFGgqthx1Ydkm6NKE+NIxAlf1/hzHT0y0IfGJvHvYLWeM6noslAi4LLoUenfwEfL/H2pAwOIC4ClC5uuz5nyKfgWpz2IdBVvaw1se7FW4bVq690BiLWY0q3+p05F6Sflkj08NDu5+fSfOiUsTT4mVImTMENrheeggV1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720978183; c=relaxed/simple;
	bh=D4Eemz0MYuSAtRvub+ynx845ZLjZkNmKfWSa1l2ULgs=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=SEcGrTRkmcSterZiWK70kGweO+uYXYPMXbub9KRCUlgMWqtMAsjWoLIQRJfIE11moAd0fITFAu1580h4JmYu4GDbchAODUhO11+1cJ/sx0D7HEJd8cIO4wynruR8Zly1UFeXZBh8pqNZnlAvCoQ+5hDuXdH6D7ZBsNROIavz3tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 46EHTUp5261621
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jul 2024 17:29:30 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>
Cc: <git@vger.kernel.org>
References: <024101dad543$221b4ab0$6651e010$@nexbridge.com>	<xmqq8qy4adl4.fsf@gitster.g>	<001f01dad5f1$e518e6e0$af4ab4a0$@nexbridge.com> <xmqqttgr9aeb.fsf@gitster.g>
In-Reply-To: <xmqqttgr9aeb.fsf@gitster.g>
Subject: RE: [Test Breakage 2.46.0-rc0] Test t0021.35 fails on NonStop
Date: Sun, 14 Jul 2024 13:29:25 -0400
Organization: Nexbridge Inc.
Message-ID: <003301dad613$62b40aa0$281c1fe0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQLxORQfyENxav+zmXZW2AfFrMp2ygG7wSa1AglWfbcCCOoxC6+bQ9rA

On Sunday, July 14, 2024 1:00 PM, Junio C Hamano wrote:
><rsbecker@nexbridge.com> writes:
>
>> This looks like a different between ksh and bash. Under bash, the test
>> works. I can live with that but will have to force bash to be used as
>> the shebang #!/bin/sh defaults to ksh on this box.
>
>It turns out that the version of ksh I used in my description does not seem
to grok
>"local" at all. I vaguely recall that we've written off various hobbist
>reimplementation of ksh as unusable enough, but this one is ksh93 direct
from
>AT&T Research.
>
>I guess when we said "as long as we limit our use to a simple 'this
variable has
>visibility limited to the function and its children'
>and nothing else, it is portable enough across practically everybody we
care about",
>we have written off the real ksh, too.
>
>In the meantime, we may want to document this in a more prominent way.
>Perhaps like so:
>
>-------- >8 --------------- >8 --------------- >8 --------
>Subject: doc: guide to use of "local" shell language construct
>
>The scripted Porcelain commands do not allow use of "local" because it is
not
>universally supported, but we use it liberally in our test scripts, which
means some
>POSIX compliant shells (like "ksh93") can not be used to run our tests.
>
>Document the status quo, and hint that we might want to change the
situation in
>the fiture.
>
>Signed-off-by: Junio C Hamano <gitster@pobox.com>
>---
> Documentation/CodingGuidelines | 4 +++-
> t/README                       | 8 ++++++++
> 2 files changed, 11 insertions(+), 1 deletion(-)
>
>diff --git c/Documentation/CodingGuidelines
w/Documentation/CodingGuidelines
>index 1d92b2da03..68b7210f48 100644
>--- c/Documentation/CodingGuidelines
>+++ w/Documentation/CodingGuidelines
>@@ -186,7 +186,9 @@ For shell scripts specifically (not exhaustive):
>  - Even though "local" is not part of POSIX, we make heavy use of it
>    in our test suite.  We do not use it in scripted Porcelains, and
>    hopefully nobody starts using "local" before they are reimplemented
>-   in C ;-)
>+   in C ;-) Notably, ksh (not just reimplementations but the real one
>+   from AT&T Research) does not support "local" and cannot be used,
>+   which we might want to reconsider.
>
>  - Some versions of shell do not understand "export variable=value",
>    so we write "variable=value" and then "export variable" on two diff
--git
>c/t/README w/t/README index d9e0e07506..1d39d8cfd5 100644
>--- c/t/README
>+++ w/t/README
>@@ -850,6 +850,14 @@ And here are the "don'ts:"
>    but the best indication is to just run the tests with prove(1),
>    it'll complain if anything is amiss.
>
>+ - Don't overuse "local"
>+
>+   Because strictly POSIX-compliant shells do not have to support
>+   "local", we avoid using it in our scripted Porcelain scripts, but
>+   we have allowed use of "local" in test scripts.  We may want to
>+   reconsider this and rewrite our tests to also run on shells like
>+   ksh93.  Do not add new use of "local" unnecessarily.
>+
>
> Skipping tests
> --------------

Thanks. I approve. I'm currently working on trying to get the test suite to
run under bash. It looks like TEST_SHELL_PATH is not propagated to the inner
make -C test. My current approach is to run the inner make without the outer
make. Otherwise I am forced to use ksh, which is known not to work. Will
advice when this runs - I have to rebuild, and that takes about an hour.

