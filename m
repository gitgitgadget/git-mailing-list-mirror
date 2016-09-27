Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C5B8207EC
	for <e@80x24.org>; Tue, 27 Sep 2016 02:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933064AbcI0Ca3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 22:30:29 -0400
Received: from mx2.imag.fr ([129.88.30.17]:47752 "EHLO mx2.imag.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751220AbcI0Ca1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 22:30:27 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
        by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u8R2UNU9012665
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
        for <git@vger.kernel.org>; Tue, 27 Sep 2016 04:30:23 +0200
Received: from z8-mb-verimag.imag.fr (z8-mb-verimag.imag.fr [129.88.4.38])
        by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u8R2UN9B013434
        for <git@vger.kernel.org>; Tue, 27 Sep 2016 04:30:23 +0200
Date:   Tue, 27 Sep 2016 04:30:23 +0200 (CEST)
From:   Gustavo Grieco <gustavo.grieco@imag.fr>
To:     git@vger.kernel.org
Message-ID: <381383122.8376940.1474943423005.JavaMail.zimbra@imag.fr>
In-Reply-To: <1825523389.8224664.1474812766424.JavaMail.zimbra@imag.fr>
Subject: Possible integer overflow parsing malformed objects in git 2.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [129.88.6.115]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF48 (Linux)/8.0.9_GA_6191)
Thread-Topic: Possible integer overflow parsing malformed objects in git 2.10.0
Thread-Index: KW6fOjM7OfRWif1grfy3JGfeWXe4oQ==
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Tue, 27 Sep 2016 04:30:23 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u8R2UNU9012665
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: gustavo.grieco@imag.fr
MailScanner-NULL-Check: 1475548224.34255@ygp51wCWXHCPzYJX3krB1g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

We found a malformed object file that triggers an allocation with a negative size when parsed in git 2.10.0. It can be caused by an integer overflow somewhere, so it is better to verify how the code got such value. It was tested on ArchLinux x86_64. To reproduce, first recompile git with ASAN support and then execute:

$ git init ; mkdir -p .git/objects/b2 ; printf 'eJyVT8ERAjEIXKiEBpyBHJdcCroGHAvQjyX49m1ZtmADQjL68uMnZFnYZU/HfRfb3Gtz17Y07etqXhX6ul9uAnCJh6DCAKxUCWABok9J2PN8jYn42iwqYA2OYoKRzVAY67mYgIOfQP8WOthUKubNt6V6/yn5YSPEowsxKGPk0Jdq6ZLKxJYX2LTjYTNi52WTAN4RVyPd' | base64 -d > .git/objects/b2/93584ddd61af21260be75ee9f73e9d53f08cd0

Finally you can trigger the bug using several commands from git (other commands that parses all objects will work too), for instance:

$ git fsck

The ASAN report is here:

==24709==WARNING: AddressSanitizer failed to allocate 0xffffffffffffff65 bytes
==24709==AddressSanitizer's allocator is terminating the process instead of returning 0
==24709==If you don't like this behavior set allocator_may_return_null=1
==24709==AddressSanitizer CHECK failed: /build/gcc-multilib/src/gcc/libsanitizer/sanitizer_common/sanitizer_allocator.cc:145 "((0)) != (0)" (0x0, 0x0)
    #0 0x7f571ae467aa in AsanCheckFailed /build/gcc-multilib/src/gcc/libsanitizer/asan/asan_rtl.cc:65
    #1 0x7f571ae4d163 in __sanitizer::CheckFailed(char const*, int, char const*, unsigned long long, unsigned long long) /build/gcc-multilib/src/gcc/libsanitizer/sanitizer_common/sanitizer_common.cc:157
    #2 0x7f571ae4b326 in __sanitizer::ReportAllocatorCannotReturnNull() /build/gcc-multilib/src/gcc/libsanitizer/sanitizer_common/sanitizer_allocator.cc:145
    #3 0x7f571ad9b2f4 in __sanitizer::CombinedAllocator<__sanitizer::SizeClassAllocator64<105553116266496ul, 4398046511104ul, 0ul, __sanitizer::SizeClassMap<17ul, 128ul, 16ul>, __asan::AsanMapUnmapCallback>, __sanitizer::SizeClassAllocatorLocalCache<__sanitizer::SizeClassAllocator64<105553116266496ul, 4398046511104ul, 0ul, __sanitizer::SizeClassMap<17ul, 128ul, 16ul>, __asan::AsanMapUnmapCallback> >, __sanitizer::LargeMmapAllocator<__asan::AsanMapUnmapCallback> >::ReturnNullOrDie() /build/gcc-multilib/src/gcc/libsanitizer/sanitizer_common/sanitizer_allocator.h:1315
    #4 0x7f571ad9b2f4 in __asan::Allocator::Allocate(unsigned long, unsigned long, __sanitizer::BufferedStackTrace*, __asan::AllocType, bool) /build/gcc-multilib/src/gcc/libsanitizer/asan/asan_allocator.cc:357
    #5 0x7f571ad9b2f4 in __asan::asan_malloc(unsigned long, __sanitizer::BufferedStackTrace*) /build/gcc-multilib/src/gcc/libsanitizer/asan/asan_allocator.cc:716
    #6 0x7f571ae3ce24 in __interceptor_malloc /build/gcc-multilib/src/gcc/libsanitizer/asan/asan_malloc_linux.cc:63
    #7 0x767816 in do_xmalloc /home/g/Work/Code/git-2.10.0/wrapper.c:59
    #8 0x76794c in do_xmallocz /home/g/Work/Code/git-2.10.0/wrapper.c:99
    #9 0x7679bd in xmallocz /home/g/Work/Code/git-2.10.0/wrapper.c:107
    #10 0x6fe36c in unpack_sha1_rest /home/g/Work/Code/git-2.10.0/sha1_file.c:1625
    #11 0x6feb40 in unpack_sha1_file /home/g/Work/Code/git-2.10.0/sha1_file.c:1751
    #12 0x703fe0 in read_object /home/g/Work/Code/git-2.10.0/sha1_file.c:2811
    #13 0x70410a in read_sha1_file_extended /home/g/Work/Code/git-2.10.0/sha1_file.c:2834
    #14 0x647676 in read_sha1_file /home/g/Work/Code/git-2.10.0/cache.h:1056
    #15 0x648545 in parse_object /home/g/Work/Code/git-2.10.0/object.c:269
    #16 0x48d46d in fsck_sha1 builtin/fsck.c:367
    #17 0x48da47 in fsck_loose builtin/fsck.c:493
    #18 0x707514 in for_each_file_in_obj_subdir /home/g/Work/Code/git-2.10.0/sha1_file.c:3477
    #19 0x70775b in for_each_loose_file_in_objdir_buf /home/g/Work/Code/git-2.10.0/sha1_file.c:3512
    #20 0x707885 in for_each_loose_file_in_objdir /home/g/Work/Code/git-2.10.0/sha1_file.c:3532
    #21 0x48dc1d in fsck_object_dir builtin/fsck.c:521
    #22 0x48e2e6 in cmd_fsck builtin/fsck.c:644
    #23 0x407a8f in run_builtin /home/g/Work/Code/git-2.10.0/git.c:352
    #24 0x407e35 in handle_builtin /home/g/Work/Code/git-2.10.0/git.c:539
    #25 0x408175 in run_argv /home/g/Work/Code/git-2.10.0/git.c:593
    #26 0x408458 in cmd_main /home/g/Work/Code/git-2.10.0/git.c:665
    #27 0x53fc70 in main /home/g/Work/Code/git-2.10.0/common-main.c:40
    #28 0x7f5719f46290 in __libc_start_main (/usr/lib/libc.so.6+0x20290)
    #29 0x405209 in _start (/home/g/Work/Code/git-2.10.0/git+0x405209)


This test case was found using QuickFuzz.


Regards,
Gustavo.
