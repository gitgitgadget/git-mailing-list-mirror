Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F55E1F4F8
	for <e@80x24.org>; Sun, 25 Sep 2016 14:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034174AbcIYObQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Sep 2016 10:31:16 -0400
Received: from mx1.imag.fr ([129.88.30.5]:54968 "EHLO mx1.imag.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934881AbcIYObP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Sep 2016 10:31:15 -0400
X-Greylist: delayed 1105 seconds by postgrey-1.27 at vger.kernel.org; Sun, 25 Sep 2016 10:31:14 EDT
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
        by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u8PECjnL013411
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
        for <git@vger.kernel.org>; Sun, 25 Sep 2016 16:12:45 +0200
Received: from z8-mb-verimag.imag.fr (z8-mb-verimag.imag.fr [129.88.4.38])
        by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u8PECk02016965
        for <git@vger.kernel.org>; Sun, 25 Sep 2016 16:12:46 +0200
Date:   Sun, 25 Sep 2016 16:12:46 +0200 (CEST)
From:   Gustavo Grieco <gustavo.grieco@imag.fr>
To:     git@vger.kernel.org
Message-ID: <1825523389.8224664.1474812766424.JavaMail.zimbra@imag.fr>
In-Reply-To: <1399913289.8224468.1474810664933.JavaMail.zimbra@imag.fr>
Subject: Stack read out-of-bounds in parse_sha1_header_extended using git
 2.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [129.88.6.115]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF48 (Linux)/8.0.9_GA_6191)
Thread-Topic: Stack read out-of-bounds in parse_sha1_header_extended using git 2.10.0
Thread-Index: Ay05G10Kp6A9IsvDGeSD/7k29LNjow==
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Sun, 25 Sep 2016 16:12:45 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u8PECjnL013411
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: gustavo.grieco@imag.fr
MailScanner-NULL-Check: 1475417566.44364@L55uXy9IlJ6sgDiluCuGmA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

We found a stack read out-of-bounds parsing object files using git 2.10.0. It was tested on ArchLinux x86_64. To reproduce, first recompile git with ASAN support and then execute:

$ git init ; mkdir -p .git/objects/b2 ; printf 'x' > .git/objects/b2/93584ddd61af21260be75ee9f73e9d53f08cd0

Finally you can trigger the bug using several commands from git (other commands that parses all objects will work too), for instance:

$ git fsck

The ASAN report is here:

==2763==ERROR: AddressSanitizer: stack-buffer-overflow on address 0x7ffe16e4a690 at pc 0x0000006fe5dc bp 0x7ffe16e4a530 sp 0x7ffe16e4a520
READ of size 1 at 0x7ffe16e4a690 thread T0
    #0 0x6fe5db in parse_sha1_header_extended /home/g/Work/Code/git-2.10.0/sha1_file.c:1684
    #1 0x702cd4 in sha1_loose_object_info /home/g/Work/Code/git-2.10.0/sha1_file.c:2660
    #2 0x70332c in sha1_object_info_extended /home/g/Work/Code/git-2.10.0/sha1_file.c:2696
    #3 0x7038e0 in sha1_object_info /home/g/Work/Code/git-2.10.0/sha1_file.c:2745
    #4 0x648498 in parse_object /home/g/Work/Code/git-2.10.0/object.c:260
    #5 0x48d46d in fsck_sha1 builtin/fsck.c:367
    #6 0x48da47 in fsck_loose builtin/fsck.c:493
    #7 0x707514 in for_each_file_in_obj_subdir /home/g/Work/Code/git-2.10.0/sha1_file.c:3477
    #8 0x70775b in for_each_loose_file_in_objdir_buf /home/g/Work/Code/git-2.10.0/sha1_file.c:3512
    #9 0x707885 in for_each_loose_file_in_objdir /home/g/Work/Code/git-2.10.0/sha1_file.c:3532
    #10 0x48dc1d in fsck_object_dir builtin/fsck.c:521
    #11 0x48e2e6 in cmd_fsck builtin/fsck.c:644
    #12 0x407a8f in run_builtin /home/g/Work/Code/git-2.10.0/git.c:352
    #13 0x407e35 in handle_builtin /home/g/Work/Code/git-2.10.0/git.c:539
    #14 0x408175 in run_argv /home/g/Work/Code/git-2.10.0/git.c:593
    #15 0x408458 in cmd_main /home/g/Work/Code/git-2.10.0/git.c:665
    #16 0x53fc70 in main /home/g/Work/Code/git-2.10.0/common-main.c:40
    #17 0x7f0f46d43290 in __libc_start_main (/usr/lib/libc.so.6+0x20290)
    #18 0x405209 in _start (/home/g/Work/Code/git-2.10.0/git+0x405209)

Address 0x7ffe16e4a690 is located in stack of thread T0 at offset 192 in frame
    #0 0x702834 in sha1_loose_object_info /home/g/Work/Code/git-2.10.0/sha1_file.c:2614

  This frame has 5 object(s):
    [32, 40) 'mapsize'
    [96, 120) 'hdrbuf'
    [160, 192) 'hdr' <== Memory access at offset 192 overflows this variable
    [224, 368) 'st'
    [416, 576) 'stream'
HINT: this may be a false positive if your program uses some custom stack unwind mechanism or swapcontext
      (longjmp and C++ exceptions *are* supported)
SUMMARY: AddressSanitizer: stack-buffer-overflow /home/g/Work/Code/git-2.10.0/sha1_file.c:1684 in parse_sha1_header_extended
Shadow bytes around the buggy address:
  0x100042dc1480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x100042dc1490: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x100042dc14a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x100042dc14b0: 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00 f4
  0x100042dc14c0: f4 f4 f2 f2 f2 f2 00 00 00 f4 f2 f2 f2 f2 00 00
=>0x100042dc14d0: 00 00[f2]f2 f2 f2 00 00 00 00 00 00 00 00 00 00
  0x100042dc14e0: 00 00 00 00 00 00 00 00 f4 f4 f2 f2 f2 f2 00 00
  0x100042dc14f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x100042dc1500: 00 00 f3 f3 f3 f3 00 00 00 00 00 00 00 00 00 00
  0x100042dc1510: 00 00 00 00 f1 f1 f1 f1 04 f4 f4 f4 f2 f2 f2 f2
  0x100042dc1520: 00 00 00 00 00 f4 f4 f4 f3 f3 f3 f3 00 00 00 00
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
  Left alloca redzone:     ca
  Right alloca redzone:    cb


Regards,
Gustavo.
