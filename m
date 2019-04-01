Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A985B202BB
	for <e@80x24.org>; Mon,  1 Apr 2019 15:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfDAPJy (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 11:09:54 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:4020 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbfDAPJy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 11:09:54 -0400
Received: from [192.168.1.12] ([2.101.245.142])
        by smtp.talktalk.net with SMTP
        id AyZJhOa79WIpcAyZJhJQMi; Mon, 01 Apr 2019 16:09:50 +0100
X-Originating-IP: [2.101.245.142]
X-Spam: 0
X-OAuthority: v=2.3 cv=W6NGqiek c=1 sm=1 tr=0 a=mQgiQ6BlbOv19lEfDgieCg==:117
 a=mQgiQ6BlbOv19lEfDgieCg==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=xtxXYLxNAAAA:8 a=52-Yb1kGAAAA:20 a=g92XXeER2WnUjmkk8PcA:9
 a=QEXdDO2ut3YA:10 a=xts0dhWdiJbonKbuqhAr:22
Subject: Re: test suite: why does git add large_file create a pack, rather
 than an object?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <f0c838f0-2f75-2b05-1aeb-3db4743ce89a@iee.org>
 <xmqqftr2uhmg.fsf@gitster-ct.c.googlers.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <8850d755-07ce-d8d2-6e5c-88393fce34de@iee.org>
Date:   Mon, 1 Apr 2019 16:09:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <xmqqftr2uhmg.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfDqhhH6nAYTuTC1XRxyXw0h4StIZsNJtOW/QkMtSdnH8zrO9wGfoFlvf1uO+fRFNjPW82cb+6k/SVlboxm5eME31+aNes8H0skbyiAY+ME3O2Ke9qrfK
 l38Yy8C0WPfhOoUh8MLFHJpbq9fsDJ55BuAUKTsvBJgZM1AXalUZHIIctiGhMHEDkOQGF7OxqzSE56FPN2ANWbxc41QMRTTer+eTEwBbSW58LN3RKNtQp9A9
 Xeei4dy3us5nzv7AutWEtI4tQU1J7gMSbHbRFLWvyIdOOJfdBc9MyXv8jQw9N9ChA7TUuLQonXIu/q39TNAbmQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

hi Junio,
On 01/04/2019 11:47, Junio C Hamano wrote:
> Philip Oakley <philipoakley@iee.org> writes:
>
>> At the moment I'm using an extended _test_ case that starts by adding
>> a ~5.1Gb file and then using verify-pack, which aborts with an error.
>>
>>          dd if=/dev/zero of=file bs=1M count=5100 &&
>>          git config core.compression 0 &&
>>          git config core.looseCompression 0 &&
>>          git add file &&
>>          git verify-pack -s .git/objects/pack/*.pack &&
>>          git fsck --verbose --strict --full &&
>>          ...
>>
>> If however I simple execute the commands from the GfW bash, the added
>> file is stored as a blob object, rather than a pack.
>>
>> I'm at a loss to understand the reason for the change in behaviour
>> [store file as pack, vs store as object] between running the code as a
>> test script and at the terminal. What am I missing?
> To which test are you adding the above piece?  Perhaps one of those
> that configures core.bigfilethreashold?
The test script (t-large-files-on-winows.sh: [1] below) was specific to 
this debugging.

I didn't set core.bigfilethreshold - Is that done (or unset) by the test 
setup at all?

It does prompt me to check that all the bigfilethreshold checks are 
actually size_t, rather than a simple 'long'/uInt which would only be 
32bits on Windows and potentially a downcast comparison, resulting in 
mistaken bigfile actions because of the modulo 2^32 action.

So when I run the test script [1] on Windows I get my error from 
verify-pack, and the trash directory contains a single pack file.
I tried doing the commands singly on a fresh repo, but that time found 
that the add/verify produced a blob object (rather than a pack with one 
object), so it got me wondering if I was testing like for like.

When I tried using gdb at the add stage, with a break point, I got a 
back trace [2], and when run to completion it had the loose object, so I 
was confused. (my fixup code is at [3])

Does the test_expect_success clear all the local/user config variable to 
sandbox the tests?

Philip


[1] 
https://github.com/PhilipOakley/git/blob/size_t2/t/t-large-files-on-windows.sh 


    #!/bin/sh

    test_description='test large file handling on windows'
    . ./test-lib.sh

    test_expect_success SIZE_T_IS_64BIT 'blah blubb' '

    	test-tool zlib-compile-flags >zlibFlags.txt &&
    	dd if=/dev/zero of=file bs=1M count=5100 &&
    	git config core.compression 0 &&
    	git config core.looseCompression 0 &&
    	gdb git  &&
    	git verify-pack -s .git/objects/pack/*.pack &&
    	git fsck --verbose --strict --full &&
    	git commit -m msg file &&
    	git verify-pack -s .git/objects/pack/*.pack &&
    	git log --stat &&
    	git fsck --verbose --strict --full &&
    	git repack -a -f &&
    	git verify-pack -s .git/objects/pack/*.pack &&
    	git verify-pack -v .git/objects/pack/*.pack &&
    	git gc
    '

    test_done


[2] Thread 1 hit Breakpoint 1, git_deflate (strm=0x138dac0, flush=0) at 
zlib.c:235
235                     zlib_pre_call(strm);
(gdb) bt
#0  git_deflate (strm=0x138dac0, flush=0) at zlib.c:235
#1  0x00000000005f4d11 in write_loose_object (oid=0x7ff4fda90070,
     hdr=0x138f560 "blob 5347737600", hdrlen=16, buf=0x7fff0000,
     len=5347737600, mtime=0) at sha1-file.c:1707
#2  0x00000000005f50db in write_object_file (buf=0x7fff0000, len=5347737600,
     type=0x6e3e9c <__ac_HASH_UPPER+20> "blob", oid=0x7ff4fda90070)
     at sha1-file.c:1779
#3  0x00000000005f5696 in index_mem (istate=0x78a3c0 <the_index>,
     oid=0x7ff4fda90070, buf=0x7fff0000, size=5347737600, type=OBJ_BLOB,
     path=0x13b6c2c "file", flags=1) at sha1-file.c:1901
#4  0x00000000005f5aca in index_core (istate=0x78a3c0 <the_index>,
     oid=0x7ff4fda90070, fd=4, size=5347737600, type=OBJ_BLOB,
     path=0x13b6c2c "file", flags=1) at sha1-file.c:1975
#5  0x00000000005f5c5d in index_fd (istate=0x78a3c0 <the_index>,
     oid=0x7ff4fda90070, fd=4, st=0x138f860, type=OBJ_BLOB,
     path=0x13b6c2c "file", flags=1) at sha1-file.c:2019
#6  0x00000000005f5d9a in index_path (istate=0x78a3c0 <the_index>,
     oid=0x7ff4fda90070, path=0x13b6c2c "file", st=0x138f860, flags=1)
     at sha1-file.c:2040
#7  0x000000000059e818 in add_to_index (istate=0x78a3c0 <the_index>,
     path=0x13b6c2c "file", st=0x138f860, flags=0) at read-cache.c:763
#8  0x000000000059ea04 in add_file_to_index (istate=0x78a3c0 <the_index>,
     path=0x13b6c2c "file", flags=0) at read-cache.c:796
#9  0x0000000000404b73 in add_files (dir=0x138f9c0, flags=0)
     at builtin/add.c:378
#10 0x0000000000405286 in cmd_add (argc=1, argv=0x1390658, prefix=0x0)
     at builtin/add.c:534
#11 0x0000000000402e86 in run_builtin (p=0x68a040 <commands>, argc=2,
     argv=0x1390650) at git.c:422
#12 0x000000000040326a in handle_builtin (argc=2, argv=0x1390650) at 
git.c:654
#13 0x00000000004034ac in run_argv (argcp=0x138fd90, argv=0x138fd38)
     at git.c:708
#14 0x00000000004038ca in cmd_main (argc=2, argv=0x1390650) at git.c:830
#15 0x00000000004c2c5f in main (argc=3, argv=0x1390648) at common-main.c:45
(gdb)

[3] https://github.com/PhilipOakley/git/tree/size_t2

