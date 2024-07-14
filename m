Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0C0282FA
	for <git@vger.kernel.org>; Sun, 14 Jul 2024 13:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720965538; cv=none; b=E9ki/FTH5s4+z97owzaaXm+eeUXR99I6VBmls5f/wmiTXW+3HlT4PVzuOilN7FkIQJtWdcRf2ycLpxsEMYQnJRAJ+U6JWT7RYH7U/99Mnq01obNNDC45mbgYqWScZait5vqsifYAO0wr8lPP2JapY8STchQCKcVW8JmNeLZa8B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720965538; c=relaxed/simple;
	bh=Rc3v9kvGVTxgLRQgOnLLqvW0WuIt/p6I4SJzNQG2ozQ=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=Veo+eepZPWnFcYLfU7p61IkLf4KQt/U3VtzT5vDhRQVhwmanaOKHY+UtkxCiBijvgaQBfKq4rm/p33XHEN+Mdr8kfcgUSYaWi7L68IvS8OZnQPvdBo5RuBbILL5oGXUHaOceVAsKilFWSiSjiM0k6pt39ebDTrOI4u4+GC/KBUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 46EDwr5m239602
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jul 2024 13:58:54 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>
Cc: <git@vger.kernel.org>
References: <024101dad543$221b4ab0$6651e010$@nexbridge.com> <xmqq8qy4adl4.fsf@gitster.g>
In-Reply-To: <xmqq8qy4adl4.fsf@gitster.g>
Subject: RE: [Test Breakage 2.46.0-rc0] Test t0021.35 fails on NonStop
Date: Sun, 14 Jul 2024 09:58:49 -0400
Organization: Nexbridge Inc.
Message-ID: <002301dad5f5$f6fe3690$e4faa3b0$@nexbridge.com>
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
Thread-Index: AQLxORQfyENxav+zmXZW2AfFrMp2ygG7wSa1r7uYkNA=

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

What is weird is that this worked fine in previous releases. We did not
change operating system versions or shells since...well, this test box was
built a year ago. The only significant change recently was the TZ variable.
Prior to that, back last fall was the introduction of IPv6. Other than that,
things are pretty stable. What I did add to our CI script just prior to
2.46.0-rc0 is GIT_TEST_DEFAULT_REF_FORMAT=reftable GIT_TEST_CLONE_2GB=true
to get the related tests to run. I specifically need to test 2Gb clones
because that is happening a lot on platform.

The semantics of local in ksh is different than in bash, so it looks like I
have to force down the bash path. However, my CI script also runs make test
with TEST_LINT= SHELL=/usr/coreutils/bin/bash. My assumption was that this
would force bash globally. Apparently that is not the case and ksh is being
used inside. I don't like having to run the test manually afterwards.

--Randall


