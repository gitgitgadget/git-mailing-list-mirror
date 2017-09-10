Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B692E202A4
	for <e@80x24.org>; Sun, 10 Sep 2017 16:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750985AbdIJQ6y (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Sep 2017 12:58:54 -0400
Received: from avasout07.plus.net ([84.93.230.235]:47671 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750810AbdIJQ6x (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Sep 2017 12:58:53 -0400
Received: from [10.0.2.15] ([147.147.86.16])
        by avasout07 with smtp
        id 7syp1w00G0M91Ur01syrvF; Sun, 10 Sep 2017 17:58:51 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=CrLPSjwD c=1 sm=1 tr=0
 a=dubYQqM3tRRTmV8xSh8cXQ==:117 a=dubYQqM3tRRTmV8xSh8cXQ==:17
 a=IkcTkHD0fZMA:10 a=h38pAekbA06D3PRPN2cA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: Unexpected pass for t6120-describe.sh on cygwin
To:     Michael J Gruber <git@grubix.eu>,
        Adam Dinwoodie <adam@dinwoodie.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <7c3db153-2a56-f27d-af71-e4b61f1252a1@ramsayjones.plus.com>
 <947699e6-c206-7818-3780-c4367e0996f0@grubix.eu>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <2ef4b3b3-fa2f-ef06-203e-521b8cd6ecaa@ramsayjones.plus.com>
Date:   Sun, 10 Sep 2017 17:58:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <947699e6-c206-7818-3780-c4367e0996f0@grubix.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/09/17 13:27, Michael J Gruber wrote:
> Ramsay Jones venit, vidit, dixit 09.09.2017 15:13:
[snip]
>> So, it looks like all ULIMIT_STACK_SIZE tests need to be disabled
>> on cygwin. I also wonder about the ULIMIT_FILE_DESCRIPTORS tests,
>> but haven't looked into it.
>>
>> Given that 'ulimit' is a bash built-in, this may also be a problem
>> on MinGW and Git-For-Windows, but I can't test on those platforms.
>>

> Thanks for the note. We have this in t/test-lib.sh:
> 
> run_with_limited_cmdline () {
>         (ulimit -s 128 && "$@")
> }
> 
> test_lazy_prereq CMDLINE_LIMIT 'run_with_limited_cmdline true'
> 
> This apparantly expects "ulimit -s" to fail on platforms that don't
> support it, 

Indeed, but cygwin lies (about the stack, anyway) ... :-D

  $ ulimit -a
  core file size          (blocks, -c) unlimited
  data seg size           (kbytes, -d) unlimited
  file size               (blocks, -f) unlimited
  open files                      (-n) 256
  pipe size            (512 bytes, -p) 8
  stack size              (kbytes, -s) 2032
  cpu time               (seconds, -t) unlimited
  max user processes              (-u) 256
  virtual memory          (kbytes, -v) unlimited
  $ 
  $ ulimit -a -H
  core file size          (blocks, -c) unlimited
  data seg size           (kbytes, -d) unlimited
  file size               (blocks, -f) unlimited
  open files                      (-n) 3200
  pipe size            (512 bytes, -p) 8
  stack size              (kbytes, -s) unlimited
  cpu time               (seconds, -t) unlimited
  max user processes              (-u) 256
  virtual memory          (kbytes, -v) unlimited
  $ 

Note that ulimit claims that the soft limit for the stack
is (2MB - 16kb), but the hard limit is unlimited. Using the
test program, it is clear that it always segfaults on the
soft limit, no matter what value is requested. (while not
'failing' the request).

Note, also, that the soft/hard limit on open files is 256/3200.
(but I still haven't investigated if ulimit honours that limit
yet).

               so set the prereq accordingly. I moved the following to
> t/test-lib.sh:
> 
> run_with_limited_stack () {
>         (ulimit -s 128 && "$@")
> }
> 
> test_lazy_prereq ULIMIT_STACK_SIZE 'run_with_limited_stack true'
> 
> Same things as above. Two things to note:
> - Those requisites could be the same, also they are used in different ways.
> - "ulimit -s" returning success without doing anything means that, all
> along, we ran the existing tests when we didn't mean to (on Win), and
> they succeeded for the wrong reason, which we did not notice.

Yes.

> So, I guess, short of testing the effect of "ulimit -s" with another
> expensive test, it's best to simply set these prerequisites based on
> "uname -s".

Yes, I was going to suggest adding !CYGWIN to the test(s) (or perhaps
to the 'test_lazy_prereq' expression(s)).

ATB,
Ramsay Jones


