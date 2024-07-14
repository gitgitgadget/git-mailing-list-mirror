Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30A726AE6
	for <git@vger.kernel.org>; Sun, 14 Jul 2024 13:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720963524; cv=none; b=o0vbhANFQRZVcQByFgU2/jvPs8H5bvdw1P5qpAJ15nx8jOBpOaaiaj0ZHVm1HBsCKuR/xgIs+eftg2WoneMyESrV78ktIVv5TI+71ta6++N1BZ60kF6ZAtDayr6xipc0Tj2B/+2cayjo2bCi9GH4n9MhwD2ZJO0VABEv/U38qqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720963524; c=relaxed/simple;
	bh=YfR8BYtVnKYWJn+wchG5mFaqx5HMGOUUyBaXN7T3WDI=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=b7OI0Ax2BiiRHUav7jPsUmvyj3cVlmiFaTNr3uN+3KUW1JZylj5O4GOrB4pODq94LSQCOFSgvsX/6qjbVrzswyAdNPGolXH1tbL6eMIBsDTsZGf8ZPHFV8tF+KcRbe0Pxf2Mlcaf/BxQtV5AOTbYXOs3yPaB2eYZr6yi9fWDKZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 46EDPFVj236794
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jul 2024 13:25:15 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>
Cc: <git@vger.kernel.org>, "'Jeff King'" <peff@peff.net>
References: <024201dad543$877221e0$965665a0$@nexbridge.com> <xmqqv818aezm.fsf@gitster.g>
In-Reply-To: <xmqqv818aezm.fsf@gitster.g>
Subject: RE: [Test Breakage 2.46.0-rc0] Test t4135.06 fails on NonStop
Date: Sun, 14 Jul 2024 09:25:10 -0400
Organization: Nexbridge Inc.
Message-ID: <001e01dad5f1$43c66100$cb532300$@nexbridge.com>
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
Thread-Index: AQJckAmmCZK41Ze1gwmoqh/WdA7U+QGrrguYsOVj/bA=

On Saturday, July 13, 2024 10:23 PM, Junio C Hamano wrote:
><rsbecker@nexbridge.com> writes:
>
>> Here is the breakage. This looks like a non-portable dependency on
>> /dev/zero was introduced.
>>
>> expecting success of 4153.6 '--reject overrides --no-reject':
>>         rm -fr .git/rebase-apply &&
>>         git reset --hard &&
>>         git checkout first &&
>>         rm -f file.rej &&
>>
>>         test_must_fail git am --no-reject side1.eml &&
>>         test_path_is_dir .git/rebase-apply &&
>>         test_path_is_missing file.rej &&
>>
>>         test_must_fail git am --retry --reject </dev/zero &&
>>         test_path_is_dir .git/rebase-apply &&
>>         test_path_is_file file.rej
>
>I think you are blaming 53ce2e3f (am: add explicit "--retry" option,
2024-06-06),
>but /dev/zero was in use before that commit.
>
>        diff --git a/t/t4153-am-resume-override-opts.sh
b/t/t4153-am-resume-
>override-opts.sh
>        ...
>        @@ -40,7 +44,7 @@ test_expect_success TTY '--3way overrides
--no-3way' '
>
>                # Applying side1 with am --3way will succeed due to the
threeway-merge.
>                # Applying side2 will fail as --3way does not apply to it.
>        -	test_must_fail test_terminal git am --3way </dev/zero &&
>        +	test_must_fail git am --retry --3way &&
>                test_path_is_dir .git/rebase-apply &&
>                test side1 = "$(cat file2)"
>         '
>
>In this hunk, use of /dev/zero goes away; if /dev/zero were a problem, you
would
>have been failing this test already.
>
>        @@ -94,7 +98,7 @@ test_expect_success TTY '--reject overrides
--no-reject' '
>                test_path_is_dir .git/rebase-apply &&
>                test_path_is_missing file.rej &&
>
>        -	test_must_fail test_terminal git am --reject </dev/zero &&
>        +	test_must_fail git am --retry --reject </dev/zero &&
>                test_path_is_dir .git/rebase-apply &&
>                test_path_is_file file.rej
>         '
>
>And this hunk uses /dev/zero the same way before and after.  The older use
of
>/dev/zero in these tests were from 852a1710 (am: let command-line options
>override saved options, 2015-08-04), which was part of v2.6.0 that was
tagged in
>late Sep 2015.
>
>In short this is nothing new in this release.
>
>Preparing a garbage file that is sufficiently large (like 1kB) and feeding
from that file
>to the commands instead of from /dev/null may be sufficient to reduce the
>dependence of /dev/zero but given that this is ancient, there are many
other uses
>of /dev/zero in the test directory, it does not seem ultra-urgent to
address this, at
>least to me.  Certainly not during the pre-release freeze.
>
>Thanks for a report.

I think the /dev/zero usage was being hidden. We definitely do not have
/dev/zero, but I think the prior hung failed anyway, so the test diff not
differentiate between the test fail and using /dev/zero. So it looks like
--retry. This worked at 2.44.2 and for years before that.

