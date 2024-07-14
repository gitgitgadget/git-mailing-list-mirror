Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865F72BD18
	for <git@vger.kernel.org>; Sun, 14 Jul 2024 13:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720964212; cv=none; b=Pbu+FWn3E4v6zQDV3c8YH4cZKLkJyxTsuwloU0m3fsb39iIC3ZqE9aFaOda3NNU1GWmDex/3PrCXT4pSkN1WveIZ8pz3Pa1wUNu1ndPjat48ZEkZvvbjzrOxEQxvvkl6sCJbecC9igLsXI2xTuMjsOuYaScw4wWP3tIYIOWJ5TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720964212; c=relaxed/simple;
	bh=jmacS5BWk+Ww4Q3iOdARMsXBiUQhA5WD2RzcITeV/7U=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=lMqbRzKp264iHdtb/fXbAkHCPXnS9PzC9iddZLThHPPx5ivbvxxLT5lN7QrUNXj9PPx/49y7K1YgPjGoX07qGPmszYaW/XSI9twUnPGRjGijBnFIC1BqtHe0+cVzcETy4XGc5MkLUwiLHJMbdHb7H9FYTPV3ksNfZu1l1AJTdYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 46EDajik237768
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jul 2024 13:36:46 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Jeff King'" <peff@peff.net>, "'Junio C Hamano'" <gitster@pobox.com>
Cc: <git@vger.kernel.org>
References: <024201dad543$877221e0$965665a0$@nexbridge.com> <xmqqv818aezm.fsf@gitster.g> <20240714070558.GA575927@coredump.intra.peff.net>
In-Reply-To: <20240714070558.GA575927@coredump.intra.peff.net>
Subject: RE: [Test Breakage 2.46.0-rc0] Test t4135.06 fails on NonStop
Date: Sun, 14 Jul 2024 09:36:41 -0400
Organization: Nexbridge Inc.
Message-ID: <002001dad5f2$df7b69a0$9e723ce0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQJckAmmCZK41Ze1gwmoqh/WdA7U+QGrrguYATpsQYyw25NWMA==

On Sunday, July 14, 2024 3:06 Am, Peff wrote:
>To: Junio C Hamano <gitster@pobox.com>
>Cc: rsbecker@nexbridge.com; git@vger.kernel.org
>Subject: Re: [Test Breakage 2.46.0-rc0] Test t4135.06 fails on NonStop
>
>On Sat, Jul 13, 2024 at 07:23:25PM -0700, Junio C Hamano wrote:
>
>> And this hunk uses /dev/zero the same way before and after.  The =
older
>> use of /dev/zero in these tests were from 852a1710 (am: let
>> command-line options override saved options, 2015-08-04), which was
>> part of v2.6.0 that was tagged in late Sep 2015.
>>
>> In short this is nothing new in this release.
>
>One thing my recent patch did was remove the TTY prereq from those =
tests. So it's
>possible that they're now being run on his platform for the first time.

Good catch. That was it. From the prior CI build:
*** t4153-am-resume-override-opts.sh ***
ok 1 - setup
ok 2 # skip --3way overrides --no-3way (missing TTY)
ok 3 - --no-quiet overrides --quiet
ok 4 - --signoff overrides --no-signoff
ok 5 # skip --reject overrides --no-reject (missing TTY)

>> Preparing a garbage file that is sufficiently large (like 1kB) and
>> feeding from that file to the commands instead of from /dev/null may
>> be sufficient to reduce the dependence of /dev/zero but given that
>> this is ancient, there are many other uses of /dev/zero in the test
>> directory, it does not seem ultra-urgent to address this, at least to
>> me.  Certainly not during the pre-release freeze.
>
>The other mentions of /dev/zero that I see are all in tests marked as =
EXPENSIVE,
>which likewise aren't run normally.
>
>So I think it is plausibly a new issue for some platforms, though I =
agree it is not super
>urgent.
>
>With --retry I think we would not actually read stdin at all, so we =
could just remove
>the mention of /dev/zero entirely. But if we wanted to be sure it did =
not read and
>choke on any input provided, I think just:
>
>diff --git a/t/t4153-am-resume-override-opts.sh =
b/t/t4153-am-resume-override-
>opts.sh
>index a4d0c03ca6..76783bdd67 100755
>--- a/t/t4153-am-resume-override-opts.sh
>+++ b/t/t4153-am-resume-override-opts.sh
>@@ -45,6 +45,7 @@ test_expect_success '--3way overrides --no-3way' '
>
> 	# Applying side1 with am --3way will succeed due to the =
threeway-merge.
> 	# Applying side2 will fail as --3way does not apply to it.
>+	echo garbage |
> 	test_must_fail git am --retry --3way &&
> 	test_path_is_dir .git/rebase-apply &&
> 	test side1 =3D "$(cat file2)"
>@@ -99,7 +100,8 @@ test_expect_success '--reject overrides --no-reject' =
'
> 	test_path_is_dir .git/rebase-apply &&
> 	test_path_is_missing file.rej &&
>
>-	test_must_fail git am --retry --reject </dev/zero &&
>+	echo garbage |
>+	test_must_fail git am --retry --reject &&
> 	test_path_is_dir .git/rebase-apply &&
> 	test_path_is_file file.rej
> '
>
>would be sufficient.

And it does work properly on the box. Thanks.
ok 1 - setup
ok 2 - --retry fails without in-progress operation
ok 3 - --3way overrides --no-3way
ok 4 - --no-quiet overrides --quiet
ok 5 - --signoff overrides --no-signoff
ok 6 - --reject overrides --no-reject
# passed all 6 test(s)
1..6

Thanks,
Randall

