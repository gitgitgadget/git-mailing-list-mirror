Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 584B01F404
	for <e@80x24.org>; Sun, 18 Feb 2018 22:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751738AbeBRWze (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Feb 2018 17:55:34 -0500
Received: from avasout01.plus.net ([84.93.230.227]:51243 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbeBRWzd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Feb 2018 17:55:33 -0500
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id nXrmeWm7wZqItnXrne3eNo; Sun, 18 Feb 2018 22:55:31 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=C7LHNzH+ c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=9SjrvhFOL0ROddBMRIQA:9 a=9Kbe_CTQYpTcBdbU:21
 a=hnmNKVGIY7-fvRIg:21 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v3 22/23] cat-file: tests for new atoms added
To:     Adam Dinwoodie <git@dinwoodie.org>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
References: <01020161890f4236-47989eb4-c19f-4282-9084-9d4f90c2ebeb-000000@eu-west-1.amazonses.com>
 <01020161890f4388-f6427c9d-2be6-4628-afc9-bfaeb58b1ebe-000000@eu-west-1.amazonses.com>
 <CA+kUOamJowkxp0xAPf5FA+wBkiOjQeYzW1sKMwcatQBBA1qWpw@mail.gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <58b2bdcd-d621-fd21-ab4d-6a9478319b19@ramsayjones.plus.com>
Date:   Sun, 18 Feb 2018 22:55:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CA+kUOamJowkxp0xAPf5FA+wBkiOjQeYzW1sKMwcatQBBA1qWpw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfA/mHDU0ALNAq2eLDi2bN693bmLwzvWpO8OIx4Nm9JbVE0BLK/45m2lCXLXkrOsTZnsHiTyKAcfZyTFUlYqvYva3kEw1P80tgC4N03vVvVTbwtB5Czst
 BE+z6KUV3Gb944cuigcfyaC7vdcICog3FCDv8LlXA+4SV6B0RPTbYzh0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 16/02/18 14:55, Adam Dinwoodie wrote:
> On 12 February 2018 at 08:08, Olga Telezhnaya wrote:
>> Add some tests for new formatting atoms from ref-filter.
>> Some of new atoms are supported automatically,
>> some of them are expanded into empty string
>> (because they are useless for some types of objects),
>> some of them could be supported later in other patches.
> 
> This commit appears to be introducing failures in t1006 on Cygwin.
> Specifically, tests 15, 36, 58 and 89, all titled "Check %(refname)
> gives empty output", are failing on the pu branch at 21937aad4, and
> git bisect identifies this commit, 3c1571744 ("cat-file: tests for new
> atoms added", 2018-02-12), as the culprit.

Hi Adam, Olga,

Sparse has been complaining about this 'ot/cat-batch-format' branch for
a while, so I had already noted (apart from a symbol which should be
marked as static) something that looked somewhat off - namely, the on
stack initialisation of a 'struct ref_array_item' (builtin/cat-file.c,
line 246, in function batch_object_write()).

In particular, the 'struct ref_array_item' ends with a [FLEX_ARRAY] field
for the refname, so it clearly isn't meant to be declared on the stack.
The 'ref-filter' code uses a 'constructor' function called 'new_ref_array_\
item() which, among others, takes a 'refname' parameter with which to
initialise the refname FLEX_ARRAY field.

So, on Linux, if you build with SANITIZE=address and then run that test:

  $ ./t1006-cat-file.sh -i -v
  Initialized empty Git repository in /home/ramsay/git/t/trash directory.t1006-cat-file/.git/
  expecting success: 
  	echo_without_newline "$hello_content" > hello &&
  	git update-index --add hello
  
  ok 1 - setup
  
  ...
  
  =================================================================
  ==12556==ERROR: AddressSanitizer: stack-buffer-overflow on address 0x7fff132f04a8 at pc 0x7f1c1b3ca20b bp 0x7fff132f00f0 sp 0x7fff132ef898
  READ of size 4 at 0x7fff132f04a8 thread T0
      #0 0x7f1c1b3ca20a in __interceptor_strlen (/usr/lib/x86_64-linux-gnu/libasan.so.2+0x7020a)
      #1 0x6798cc in strbuf_addstr /home/ramsay/git/strbuf.h:273
      #2 0x6798cc in quote_formatting /home/ramsay/git/ref-filter.c:496
      #3 0x68325d in format_ref_array_item /home/ramsay/git/ref-filter.c:2238
      #4 0x68358a in show_ref_array_item /home/ramsay/git/ref-filter.c:2262
      #5 0x429866 in batch_object_write builtin/cat-file.c:252
      #6 0x42b095 in batch_one_object builtin/cat-file.c:306
      #7 0x42b095 in batch_objects builtin/cat-file.c:407
      #8 0x42b095 in cmd_cat_file builtin/cat-file.c:528
      #9 0x40d3cb in run_builtin /home/ramsay/git/git.c:346
      #10 0x40d3cb in handle_builtin /home/ramsay/git/git.c:556
      #11 0x40f8ae in run_argv /home/ramsay/git/git.c:608
      #12 0x40f8ae in cmd_main /home/ramsay/git/git.c:685
      #13 0x40b667 in main /home/ramsay/git/common-main.c:43
      #14 0x7f1c1ab7982f in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x2082f)
      #15 0x40ce38 in _start (/home/ramsay/git/git+0x40ce38)
  
  Address 0x7fff132f04a8 is located in stack of thread T0 at offset 328 in frame
      #0 0x4296ff in batch_object_write builtin/cat-file.c:245
  
    This frame has 4 object(s):
      [32, 36) 'type'
      [96, 104) 'contents'
      [160, 168) 'size'
      [224, 328) 'item' <== Memory access at offset 328 overflows this variable
  HINT: this may be a false positive if your program uses some custom stack unwind mechanism or swapcontext
        (longjmp and C++ exceptions *are* supported)
  SUMMARY: AddressSanitizer: stack-buffer-overflow ??:0 __interceptor_strlen
  Shadow bytes around the buggy address:
    0x100062656040: 00 00 f3 f3 f3 f3 f3 f3 f3 f3 00 00 00 00 00 00
    0x100062656050: 00 00 00 00 f1 f1 f1 f1 00 00 00 f4 f3 f3 f3 f3
    0x100062656060: 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1
    0x100062656070: 04 f4 f4 f4 f2 f2 f2 f2 00 f4 f4 f4 f2 f2 f2 f2
    0x100062656080: 00 f4 f4 f4 f2 f2 f2 f2 00 00 00 00 00 00 00 00
  =>0x100062656090: 00 00 00 00 00[f4]f4 f4 f3 f3 f3 f3 00 00 00 00
    0x1000626560a0: 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1
    0x1000626560b0: 04 f4 f4 f4 f2 f2 f2 f2 04 f4 f4 f4 f2 f2 f2 f2
    0x1000626560c0: 04 f4 f4 f4 f2 f2 f2 f2 00 f4 f4 f4 f2 f2 f2 f2
    0x1000626560d0: 00 f4 f4 f4 f2 f2 f2 f2 00 00 f4 f4 f2 f2 f2 f2
    0x1000626560e0: 00 00 00 f4 f2 f2 f2 f2 00 00 00 f4 f2 f2 f2 f2
  Shadow byte legend (one shadow byte represents 8 application bytes):
    Addressable:           00
    Partially addressable: 01 02 03 04 05 06 07 
    Heap left redzone:       fa
    Heap right redzone:      fb
    Freed heap region:       fd
    Stack left redzone:      f1
    Stack mid redzone:       f2
    Stack right redzone:     f3
    Stack partial redzone:   f4
    Stack after return:      f5
    Stack use after scope:   f8
    Global redzone:          f9
    Global init order:       f6
    Poisoned by user:        f7
    Container overflow:      fc
    Array cookie:            ac
    Intra object redzone:    bb
    ASan internal:           fe
  ==12556==ABORTING
  Aborted (core dumped)
  not ok 15 - Check %(refname) gives empty output
  #	
  #		echo "$expected" >expect &&
  #		echo $sha1 | git cat-file --batch-check="$atoms" >actual &&
  #		test_cmp expect actual
  #	    
  $ 
 
... you get a stack-overflow at that very stackframe. Incidentally, the
output from the failed test #15 on cygwin always looked the same: 
  
  $ xxd actual
  00000000: a0c4 ffff 0a                             .....
  $ 
 
So, just as an experiment, I tried changing that variable to a heap
variable and initialising it with an empty ("") refname:
 
  diff --git a/builtin/cat-file.c b/builtin/cat-file.c
  index c9d83ceff..12a743034 100644
  --- a/builtin/cat-file.c
  +++ b/builtin/cat-file.c
  @@ -243,19 +243,20 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
   static void batch_object_write(const char *obj_name, struct batch_options *opt,
   			       struct expand_data *data)
   {
  -	struct ref_array_item item = {0};
  +	struct ref_array_item *item;
   
  -	item.oid = data->oid;
  -	item.rest = data->rest;
  -	item.objectname = obj_name;
  +	FLEX_ALLOC_STR(item, refname, "");
  +	item->oid = data->oid;
  +	item->rest = data->rest;
  +	item->objectname = obj_name;
   
  -	if (show_ref_array_item(&item, &opt->format))
  +	if (show_ref_array_item(item, &opt->format))
   		return;
   	if (!opt->buffer_output)
   		fflush(stdout);
   
   	if (opt->print_contents) {
  -		data->type = item.type;
  +		data->type = item->type;
   		print_object_or_die(opt, data);
   		batch_write(opt, "\n", 1);
   	}
  -- 

... and now this test passes on cygwin (and the SANITIZE build on Linux).

Of course, this is not a real fix, since this has probably only changed
the stack-overflow into an un-diagnosed heap-overflow bug! ;-)

However, the above should provide enough info for someone more familiar
with the code to implement a correct fix.

[BTW, the symbol that should be marked static is: cat_file_info, in file
ref-filter.c, line 103.]

ATB,
Ramsay Jones


