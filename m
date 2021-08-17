Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C77C4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 14:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4B3760F39
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 14:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237910AbhHQOaW convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 17 Aug 2021 10:30:22 -0400
Received: from elephants.elehost.com ([216.66.27.132]:22742 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbhHQOaW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 10:30:22 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 17HETYkv051759
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 17 Aug 2021 10:29:35 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jeff King'" <peff@peff.net>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
References: <009101d7904e$a3703e50$ea50baf0$@nexbridge.com> <YRaYnDR6RlgJRr/P@coredump.intra.peff.net> <01b501d792cc$f4071ed0$dc155c70$@nexbridge.com> <YRqwIAL/JgJp+RyI@coredump.intra.peff.net> <01c501d792df$5fcb24b0$1f616e10$@nexbridge.com> <YRrSXhbaZMLMq+1/@coredump.intra.peff.net> <01d001d792e9$55f45470$01dcfd50$@nexbridge.com> <YRrlQwLENaWs8zWm@coredump.intra.peff.net>
In-Reply-To: <YRrlQwLENaWs8zWm@coredump.intra.peff.net>
Subject: RE: [ANNOUNCE] Git v2.33.0-rc2 (Build/Test Report)
Date:   Tue, 17 Aug 2021 10:29:28 -0400
Message-ID: <01f801d79374$4cca6160$e65f2420$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQMBTs001OO8pWyP/FbVHKiIK4dspwGtgrwqAxbvBFwBEWuByQH2kUqUAce4wogCG03ybQI0aYL9qLUo5bA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On August 16, 2021 6:23 PM, Jeff King wrote:
>On Mon, Aug 16, 2021 at 05:54:44PM -0400, Randall S. Becker wrote:
>
>> Running git-send-email reports completion 162. The code variable is
>> optimized out but looks like it also is 162 when returning. The
>> WIFEXITED(status) code did not appear to execute, although I think
>> that also was optimized out. finish_command ret is 162. So perl looks
>> like it is completing with a bad completion code. This percolates up
>> to git, which also reports the same value.
>
>OK, at least that absolves git.c. :)

Too right 😊

>> I went to the perl maintainer on this subject. What I got back was
>> that die is not guaranteed to return a specific value other than 0 for
>> success and non-zero for failure. There are platforms where the return
>> might known and has meaning but that is not portable. According to the
>> current official perl documentation:
>>
>> "die raises an exception. Inside an eval the exception is stuffed into
>> $@ and the eval is terminated with the undefined value. If the
>> exception is outside of all enclosing evals, then the uncaught
>> exception is printed to STDERR and perl exits with an exit code
>> indicating failure. If you need to exit the process with a specific
>> exit code, see exit."
>
>Ouch. I mean, sure, if you need a specific code, I get that die is not a good tool. But getting arbitrary values seems kind of weird and
>unfriendly. The perldoc for die does say it gives you $! (errno), or $?
>(the last child exit value) if appropriate. So it's not completely arbitrary, but I think your errno value may just be unlucky.

Very unlucky.
>
>> So assuming that a signal occurred because the value is between 129
>> and 192 is not correct in the case of perl. Could we do something like
>> test_expect_perl_die that does not perform the signal check at line
>> 980 in test-lib-functions.sh so just checks 0 vs. non-zero, which
>> would be semantically correct no matter what the platform?
>> Alternatively, and possibly better, the die could be caught and then
>> exit() called in git-send-email, as in:
>>
>> eval { die "Something bad happened" };
>> exit(255) if $@;
>
>Yeah, I think we are better to get a consistent exit code from perl.
>There are a few options here:
>
> - wrapping in an eval works, as you showed above. It's a little awkward
>   to wrap the whole script, though.
>
> - there's $SIG{__DIE__}, but the manpage warns against using it. You
>   can use it something like this:
>
>     sub catch_top {
>       CORE::die @_ if $^S; # in an eval; use regular die
>       CORE::die @_ if !defined $^S; in perl's parser
>       print STDERR "@_\n";
>       exit 255; # or whatever we want
>     }
>     $SIG{__DIE__} = \&catch_top;
>
> - you can hook die() like this:
>
>     BEGIN { *CORE::GLOBAL::die = \&my_die; }
>
>   but I expect would still need to check that you're not in an eval, as
>   above.
>
>  - The SIG{__DIE__} docs mention using an END{} block, but I'm not sure
>    how you determine if we hit a die or not (at that point, $@ won't
>    actually be set).
>
>I've used the catch_top() thing before and it does work (it's just ugly that you have to deal with $^S).
>
>I guess yet another alternative is that we could avoid using perl's
>die() in favor of our own custom-named function. It seems like that may confuse folks who come later, though.

I have tried to arrange a more consistent error code from the perl team. There are too many platform mods, and getting this particular change done won't happen - I have already been told something like "Sure, but in an RFE. We'll evaluate it.", which will mean 18 months minimum on x86 if approved (unlikely) and won't happen on the ia64 platform - ever. I think this is ultimately resulting from what is on the stack when the exception is thrown inside perl that is different on the platform. It did change - it was actually 169 two years ago with the same effect. Changing it will mean a custom mod to base perl - not likely going to happen.

What it we left the perl code as is and went with the following, since this seems to happen only above 128:

# Similar to test_must_fail, but just considers pass/fail on completion codes
test_perl_must_die () {
        case "$1" in
        ok=*)
                _test_ok=${1#ok=}
                shift
                ;;
        *)
                _test_ok=
                ;;
        esac
        if ! test_must_fail_acceptable "$@"
        then
                echo >&7 " test_perl_must_die: only 'git' is allowed: $*"
                return 1
        fi
        "$@" 2>&7
        exit_code=$?
        if test $exit_code -eq 0 && ! list_contains "$_test_ok" success
        then
                echo >&4 " test_perl_must_die: command succeeded: $*"
                return 1
        elif test_match_signal 13 $exit_code && list_contains "$_test_ok" sigpipe
        then
                return 0
        elif test $exit_code -eq 127
        then
                echo >&4 " test_perl_must_die: command not found: $*"
                return 1
        elif test $exit_code -eq 126
        then
                echo >&4 " test_perl_must_die: valgrind error: $*"
                return 1
        fi
        return 0
} 7>&2 2>&4

Then change t9001 to refer to this function instead of test_must_fail.

