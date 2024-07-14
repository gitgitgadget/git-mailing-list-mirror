Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A057130486
	for <git@vger.kernel.org>; Sun, 14 Jul 2024 13:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720963791; cv=none; b=H5207nfUHP61shxb+0Xw+gdEgbRq8PEQPdYjSWca5bq2U9TE1GIr9AJX5SyIQ3DxANW4p9YTkbs1i5OOX8U1KUZI64CUoCbmJ/+e9RM76sk0JdBStuFm5OzJbn73oohC79ukB6fivRjhBNclMTFwcysQfYW1XVTWi4kxVxbfssA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720963791; c=relaxed/simple;
	bh=Z7IZzfeHfh82eSBpGo8ohV+kpQJIY4hD63Lp0WK/dgU=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ss3Kz8AcKYWyfSIcfCpH3cTKVAC6dHoBSSvi7M+K/JDD9O7w2UAsElNah7nYEPrTXBrerJ/ryHGcIe/a3Vr0qH34NnG1RR6d23SKQE8GNxE/uavJVihN9DmFgHFA3LqHkCVAPadUnaVDXkO1yUQ2gTwsaqmXozAEX0v9SCho8Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 46EDTjJY237140
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jul 2024 13:29:46 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>
Cc: <git@vger.kernel.org>
References: <024101dad543$221b4ab0$6651e010$@nexbridge.com> <xmqq8qy4adl4.fsf@gitster.g>
In-Reply-To: <xmqq8qy4adl4.fsf@gitster.g>
Subject: RE: [Test Breakage 2.46.0-rc0] Test t0021.35 fails on NonStop
Date: Sun, 14 Jul 2024 09:29:41 -0400
Organization: Nexbridge Inc.
Message-ID: <001f01dad5f1$e518e6e0$af4ab4a0$@nexbridge.com>
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
Thread-Index: AQLxORQfyENxav+zmXZW2AfFrMp2ygG7wSa1r7uS6hA=

On Saturday, July 13, 2024 10:54 PM, Junio C Hamano wrote:
><rsbecker@nexbridge.com> writes:
>
>> ok 34 # skip delayed checkout shows progress by default on tty
>> (pathspec
>> checkout) (missing TTY of PERL,TTY)
>>
>> expecting success of 0021.35 'delayed checkout ommits progress on
>> non-tty (pathspec checkout)':
>>                 test_delayed_checkout_progress ! git checkout $opt
>>
>> + test_delayed_checkout_progress ! git checkout .
>> test_delayed_checkout_progress: test: argument expected
>
>This "test: argument expected" is curious.
>
>The shell function reads like so and it hasn't changed since
>7a132c62 (checkout: make delayed checkout respect --quiet and
--no-progress,
>2021-08-26) introduced it, and there are 3 uses of "test" builtin function.
>
>        test_delayed_checkout_progress () {
>                if test "$1" = "!"
>                then
>                        local expect_progress=N &&
>                        shift
>                else
>                        local expect_progress=
>                fi &&
>
>                if test $# -lt 1
>                then
>                        BUG "no command given to
test_delayed_checkout_progress"
>                fi &&
>
>                (
>                        cd progress &&
>                        GIT_PROGRESS_DELAY=0 &&
>                        export GIT_PROGRESS_DELAY &&
>                        rm -f *.a delay-progress.log &&
>
>                        "$@" 2>err &&
>                        grep "IN: smudge test-delay10.a .* \\[DELAYED\\]"
delay-progress.log
>&&
>                        if test "$expect_progress" = N
>                        then
>                                ! grep "Filtering content" err
>                        else
>                                grep "Filtering content" err
>                        fi
>                )
>        }
>
>I do not see how any of these tests can be fed a list of zero or more
argument that
>causes it to barf with "argument expected", when
>
>	test_delayed_checkout_progress ! git checkout .
>
>is run.  The first "are we negated?" test gets
>
>	test "!" = "!"
>
>and shifts that "!" away, the second test that checks the number of
arguments do
>not need any extra quoting (in other words, $# can never be an empty
string, so
>
>	test $# -lt 1
>
>cannot become "test -lt 1" that would barf, like so:
>
>	$ ksh -c 'test -lt 1'
>	ksh: test: argument expected
>
>And whether expect_progress gets an empty string or N (we should have got N
in
>there, if the shell is so broken that the first comparison between "!" and
"!" were
>botched and the variable got assigned an empty string, or "local" were
botched and
>the variable were somehow left uninitialized, expect_progress could be a
value we
>do not expect), the last test to switch between !grep and grep can never
break like
>so:
>
>	$ ksh -c 'test = N'
>	ksh: test: argument expected
>
>because $expect_progress is inside a pair of double quotes.
>
>In the above "thinking out aloud", I invoked ksh because bash and dash
gives
>different error messages.
>
>Another remotely curious thing is that I am not sure how "local" in the
outer shell
>influences the use of the variable in the subshell
>(read: now I am speculating if the above code uses some constructs that are
so
>tricky to implement correctly and an unfortunate bug gets triggered in your
shell),
>but even if such a bug caused a nonsense value to be assigned to
$expect_progress,
>I do not see how it can cause "test" to barf with "argument expected".
>
>So, I am not sure what is going on at all.
>
>In any case, this does not sound anything recent.  Do you know that this
used to
>work in previous releases?  Could this be caused by changes in your
environment
>(like which shell is used)?

This looks like a different between ksh and bash. Under bash, the test
works. I can live with that but will have to force bash to be used as the
shebang #!/bin/sh defaults to ksh on this box.

Thanks for looking.

--Randall

