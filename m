Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DFEC433F5
	for <git@archiver.kernel.org>; Thu, 28 Apr 2022 19:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236943AbiD1T4n convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 28 Apr 2022 15:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236900AbiD1T4l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Apr 2022 15:56:41 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C66BF311
        for <git@vger.kernel.org>; Thu, 28 Apr 2022 12:53:25 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.96.21] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 23SJrHW1025921
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 28 Apr 2022 15:53:21 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "=?utf-8?Q?'Carlo_Marcelo_Arenas_Bel=C3=B3n'?=" <carenas@gmail.com>
Cc:     <git@vger.kernel.org>
References: <20220428033544.68188-1-carenas@gmail.com>        <20220428105852.94449-1-carenas@gmail.com>        <20220428105852.94449-4-carenas@gmail.com> <xmqq7d79du6c.fsf@gitster.g>
In-Reply-To: <xmqq7d79du6c.fsf@gitster.g>
Subject: RE: [PATCH v2 3/3] t: add tests for safe.directory when running with sudo
Date:   Thu, 28 Apr 2022 15:53:12 -0400
Organization: Nexbridge Inc.
Message-ID: <000001d85b39$9d5cfc90$d816f5b0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEhoH1klsquz/XrUeoh6UIeie+nGgNSFEhJAdygO20BcR/rTa4+BG4Q
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On April 28, 2022 12:55 PM, Junio C Hamano wrote:
>Carlo Marcelo Arenas Belón  <carenas@gmail.com> writes:
>
>> +test_description='verify safe.directory checks while running as root'
>> +
>> +. ./test-lib.sh
>> +
>> +if [ "$IKNOWWHATIAMDOING" != "YES" ]; then
>
>Style.
>
>	if test "$IKNOWWHATIAMDOING" != "YES"
>	then
>
>> +is_root() {
>> +	test -n "$1" && CMD="sudo -n"
>> +	test $($CMD id -u) = $(id -u root)
>> +}
>
>Style.
>
>	is_root () {
>		... body ..
>
>But more importantly, why do we need this in the first place?
>SANITY prerequisite checks if the user is running as root or non-root---can't we
>use it here?
>
>Or perhaps my reading is wrong?  I assumed from its name that it was just "see if
>we are running as user 'root' and return 0 or non-zero to answer", but if it does
>more than that, like priming "sudo", then probably it is misnamed.
>
>> +test_lazy_prereq SUDO '
>> +	is_root sudo &&
>> +	! sudo grep -E '^[^#].*secure_path' /etc/sudoers '

/etc/sudoers is not standard although usual. This path should come from a knob somewhere. We can't run this test on our x86 system anyway - no access to root or sudo even though it is installed. Also, /etc/sudoers is typically secured 0600 so the grep will fail even if is_root passes - and I'm worried about the portability of is_root, which is mostly Linux.

>OK.
>
>> +test_lazy_prereq ROOT '
>> +	is_root
>> +'
>> +
>> +test_expect_success SUDO 'setup' '
>> +	sudo rm -rf root &&
>> +	mkdir -p root/r &&
>> +	sudo chown root root &&
>> +	(
>> +		cd root/r &&
>> +		git init
>> +	)
>> +'
>
>We have a root-owned directory "root" with a subdirectory "r" owned by us.  We
>want to be able to use our "root/r" directory as a repository.  OK.
>
>The prerequisite allows this test to be started as root, but I do not quite see the
>point.  It may pass when started as root, but it is not testing what this test is
>designed to check (i.e. an ordinary user who has repository at root/r can do things
>there).
>
>> +test_expect_success SUDO 'sudo git status as original owner' '
>> +	(
>> +		cd root/r &&
>> +		git status &&
>> +		sudo git status
>> +	)
>> +'
>
>And the directory can be used by the user under "sudo", too.  Good.
>
>The same "this is allowed to run as root, but why?" question applies.  If this was
>started by 'root', root, root/r and root/r/.git all are owned by 'root' and we are
>checking if 'root'
>can run 'git status' as 'root' (or 'root' via sudo) there.  Such a test may well pass, but
>it is not catching a future regression on the code you wrote for this series.
>
>> +test_expect_success SUDO 'setup root owned repository' '
>> +	sudo mkdir -p root/p &&
>> +	sudo git init root/p
>> +'
>
>Now we go on to create root owned repository at root/p
>
>> +test_expect_success SUDO,!ROOT 'can access if owned by root' '
>> +	(
>> +		cd root/p &&
>> +		test_must_fail git status
>> +	)
>> +'
>
>And as an ordinary user, we fail to access a repository that is owned by a wrong
>person (i.e. root).  !ROOT (or SANITY) prereq should be there NOT because the
>test written here would fail if run by root, but because running it as root, even if
>passed, is totally pointless, because we are *not* testing "person A has a
>repository, person B cannot access it" combination.
>
>The other side of the same coin is that the lack of !ROOT (or
>SANITY) prereq in earlier tests I pointed out above misses the point of why we
>have prerequisite mechanism in the first place.  It is not to mark a test that fails
>when the precondition is not met.  It is to avoid running code that would NOT test
>what we want to test.
>
>The difference is that a test that passes for a wrong reason (e.g. we wanted to see
>of person A can access a repository of their own even when the user identity is
>tentatively switched to 'root'
>via 'sudo'---if person A is 'root', the access will be granted even if the special code
>to handle 'sudo' situation we have is broken) should also be excluded with
>prerequisite.
>
>> +test_expect_success SUDO,!ROOT 'can access with sudo' '
>> +	# fail to access using sudo
>> +	(
>> +		# TODO: test_must_fail missing functionality
>
>Care to explain a bit in the log message or in this comment the reason why we do
>not use test_must_fail but use ! here?  Are we over-eager to reject anything non
>"git" be fed, or something?
>
>> +		cd root/p &&
>> +		! sudo git status
>> +	)
>> +'
>
>The repository is owned by 'root', but because of the 'sudo'
>"support", you cannot access the repository with "sudo git".
>
>The test title needs updating.  We expect that the repository cannot be accessed
>under sudo.
>
>> +test_expect_success SUDO 'can access with workaround' '
>
>"workarounds", I think.
>
>> +	# provide explicit GIT_DIR
>> +	(
>> +		cd root/p &&
>> +		sudo sh -c "
>> +			GIT_DIR=.git GIT_WORK_TREE=. git status
>> +		"
>> +	) &&
>> +	# discard SUDO_UID
>> +	(
>> +		cd root/p &&
>> +		sudo sh -c "
>> +			unset SUDO_UID &&
>> +			git status
>> +		"
>> +	)
>> +'
>
>Again, this lack !ROOT (or SANITY) because tests pass for a wrong reason.
>
>Overall, I like the simplicity and clarity of "do not start this test as 'root'" in the
>previous round much better.
>
>But other than that, the test coverage given by this patch looks quite sensible.
>
>Thanks.
>
>> +
>> +test_expect_success SUDO 'cleanup' '
>> +	sudo rm -rf root
>> +'
>> +
>> +test_done

