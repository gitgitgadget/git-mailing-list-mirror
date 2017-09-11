Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE75F209B8
	for <e@80x24.org>; Mon, 11 Sep 2017 22:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750957AbdIKWRN (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Sep 2017 18:17:13 -0400
Received: from avasout07.plus.net ([84.93.230.235]:39368 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750926AbdIKWRL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2017 18:17:11 -0400
Received: from [10.0.2.15] ([147.147.86.16])
        by avasout07 with smtp
        id 8NH81w0040M91Ur01NH9EF; Mon, 11 Sep 2017 23:17:10 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=CrLPSjwD c=1 sm=1 tr=0
 a=dubYQqM3tRRTmV8xSh8cXQ==:117 a=dubYQqM3tRRTmV8xSh8cXQ==:17
 a=IkcTkHD0fZMA:10 a=w_pzkKWiAAAA:8 a=ikGbJX_K6SiCZZa0g9UA:9 a=QEXdDO2ut3YA:10
 a=wXaVovHWwP0A:10 a=sRI3_1zDfAgwuvI8zelB:22
X-AUTH: ramsayjones@:2500
Subject: Re: Unexpected pass for t6120-describe.sh on cygwin
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     Michael J Gruber <git@grubix.eu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <20170911103142.GH10378@dinwoodie.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <32074a54-9a1c-f866-8ffe-033f188805f4@ramsayjones.plus.com>
Date:   Mon, 11 Sep 2017 23:17:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170911103142.GH10378@dinwoodie.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/09/17 11:31, Adam Dinwoodie wrote:
> On Sat, Sep 09, 2017 at 02:13:32PM +0100, Ramsay Jones wrote:
>> I ran the test-suite on the 'pu' branch last night (simply because
>> that was what I had built at the time!), which resulted in a PASS,
>> but t6120 was showing a 'TODO passed' for #52.
> 
> Confirmed, I also see this unexpected pass.
> 
>> This is a test introduced by Michael's 'mg/name-rev-tests-with-short-stack'
>> branch, which uses 'ulimit -s' to try and force a stack overflow.
>> Unfortunately, 'ulimit -s' seems to have no effect on cygwin. I created
>> a test program (see below) to eat up the stack and tried running it
>> with various ulimit values (128, 12, 8), but it always seg-faulted
>> at the same stack-frame. (after using approx 2MB stack space).
> 
> Yes, Cygwin does not implement the ulimit API from the Single Unix
> Specification, per https://cygwin.com/cygwin-api/std-notimpl.html.  I

Isn't that ulimit(3) not ulimit the bash built-in - which would
more than likely be implemented by {get,set}rlimit(). (I haven't
looked to find out, obviously!).

> suspect the Bash builtin still exists because (a) nobody has bothered to
> remove it, (b) including it avoids breaking scripts that assume it
> exists but don't particularly rely on its output being sensical, or
> (c) both.

(d) it seems to provide useful information on some of the limits anyway.

>> So, it looks like all ULIMIT_STACK_SIZE tests need to be disabled
>> on cygwin. I also wonder about the ULIMIT_FILE_DESCRIPTORS tests,
>> but haven't looked into it.
>>
>> Given that 'ulimit' is a bash built-in, this may also be a problem
>> on MinGW and Git-For-Windows, but I can't test on those platforms.
> 
> I'll leave this to the relevant folks to test; I don't have a useful
> test environment for those either.  That said, I'll note the comment in
> t6120 says the ULIMIT_STACK_SIZE prerequisite excludes running the test
> on Windows, so I assume it's not a problem there.

I suspect that was a guess. ;-)

> On Sun, Sep 10, 2017 at 05:58:49PM +0100, Ramsay Jones wrote:
>> On 10/09/17 13:27, Michael J Gruber wrote:
>>> So, I guess, short of testing the effect of "ulimit -s" with another
>>> expensive test, it's best to simply set these prerequisites based on
>>> "uname -s".
>>
>> Yes, I was going to suggest adding !CYGWIN to the test(s) (or perhaps
>> to the 'test_lazy_prereq' expression(s)).
> 
> Given the issue is Cygwin not implementing ulimit at all, but Cygwin
> Bash pretending everything's fine, I think handling this as a special
> case for Cygwin seems like the correct approach.  Something like the
> below, based on the existing code in test-lib.sh for the PIPE prereq?
> 
> -- >8 --
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 83f5d3dd2..376cd91ae 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1166,14 +1166,32 @@ test_lazy_prereq UNZIP '
>  	test $? -ne 127
>  '
>  
> +# On Cygwin, ulimit has no effect because the underlying API hasn't been
> +# implemented.  Just fail if trying to do something with ulimit.
>  run_with_limited_cmdline () {
> -	(ulimit -s 128 && "$@")
> +	case $(uname -s) in
> +	CYGWIN*)
> +		false
> +		;;
> +	*)
> +		(ulimit -s 128 && "$@")
> +		;;
> +	esac
>  }
>  
>  test_lazy_prereq CMDLINE_LIMIT 'run_with_limited_cmdline true'
>  
> +# On Cygwin, ulimit has no effect because the underlying API hasn't been
> +# implemented.  Just fail if trying to do something with ulimit.
>  run_with_limited_stack () {
> -	(ulimit -s 128 && "$@")
> +	case $(uname -s) in
> +	CYGWIN*)
> +		false
> +		;;
> +	*)
> +		(ulimit -s 128 && "$@")
> +		;;
> +	esac
>  }
>  
>  test_lazy_prereq ULIMIT_STACK_SIZE 'run_with_limited_stack true'
> 

What about the other uses of ulimit? (No, I still haven't tried
ulimit with open file descriptors - I will assume it doesn't work).

I was thinking something more like this:

  $ git diff
  diff --git a/t/test-lib.sh b/t/test-lib.sh
  index 83f5d3dd2..6c939708a 100644
  --- a/t/test-lib.sh
  +++ b/t/test-lib.sh
  @@ -1009,6 +1009,11 @@ case $uname_s in
          GIT_TEST_CMP=mingw_test_cmp
          ;;
   *CYGWIN*)
  +       # the ulimit bash built-in is ineffective
  +       # but always succeeds, so always fail instead
  +       ulimit () {
  +               false
  +       }
          test_set_prereq POSIXPERM
          test_set_prereq EXECKEEPSPID
          test_set_prereq CYGWIN
  $ 

This assumes that 'ulimit -n 32' fails to limit the number
of open files, of course.

ATB,
Ramsay Jones

