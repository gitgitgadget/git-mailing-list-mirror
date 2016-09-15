Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 877BB1FCA9
	for <e@80x24.org>; Thu, 15 Sep 2016 00:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755693AbcIOAme (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Sep 2016 20:42:34 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:38428 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754654AbcIOAmd (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 14 Sep 2016 20:42:33 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 3D96C2089D;
        Wed, 14 Sep 2016 20:42:32 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Wed, 14 Sep 2016 20:42:32 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=jonathonmah.com;
         h=cc:content-transfer-encoding:content-type:date:from
        :message-id:mime-version:subject:to:x-sasl-enc:x-sasl-enc; s=
        mesmtp; bh=T6K0W1Y8KTP+8zSGvE8wQR/krdc=; b=I4AZBd7Q90pxV5S6d368/
        hSWPmJB8XIU21dDZq13PeMyeF4jZLcPiP2wo8hOSI2VZcOyJFuof/WGQL4lz00En
        QtHIAn4r5FB4W+uXmyMa99x73yB7ZJpvBPFvrWul1rIPmB0VEjGPwsocJiUKscDk
        CHJf5jthE6iu/FFEbVwiU4=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-sasl-enc
        :x-sasl-enc; s=smtpout; bh=T6K0W1Y8KTP+8zSGvE8wQR/krdc=; b=OFVe4
        uK7HqsGo+9ISbPm5VsJ2gsLbeMFtsv++Js12HbbBNpZLvN54cJs6T6jVBlIt2Lug
        GhMbm/HfKTEMHlUdl2XGRf29od1IsBGJ4RGleBxsWTRdbg/O/LLF/SZEu7NsrX4u
        c47aFZioXbhDZGhHGmS0ROg+TgeINtWc1VrCmU=
X-Sasl-enc: V8gAq91i2+RZioQoBke71BHFJx90j975jcl5Gt6comGv 1473900151
Received: from [10.132.44.52] (unknown [76.74.153.49])
        by mail.messagingengine.com (Postfix) with ESMTPA id 69044F2985;
        Wed, 14 Sep 2016 20:42:31 -0400 (EDT)
From:   Jonathon Mah <me@jonathonmah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.0 \(3226\))
Subject: Tracking down a segfault in delta_base_cache
Message-Id: <3946EE74-219D-4E9C-9CED-69D53B940955@jonathonmah.com>
Date:   Wed, 14 Sep 2016 17:42:29 -0700
Cc:     Jeff King <peff@peff.net>
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3226)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi git, I've been seeing git segfault over the past few days. I'm on Mac =
OS X 10.12, 64-bit, compiling with clang (Apple LLVM version 8.0.0 =
(clang-800.0.40)).

I first noticed it during a checkout, then also during `log -u`. I'm =
still debugging, but wanted to give a heads-up in case anyone else is =
seeing this.

~/D/S/A/HLT $ git-log -u -n1000 >/dev/null
fish: 'git-log' terminated by signal SIGSEGV (Address boundary error)

~/D/S/A/HLT $ git fsck
Checking object directories: 100% (256/256), done.
fish: 'git fsck' terminated by signal SIGSEGV (Address boundary error)

~/D/S/A/HLT $ git --version
git version 2.10.0.129.g35f6318

Running git-fsck from 2.9.2 validates the repository data.

Bisect says:

8261e1f139db3f8aa6f9fd7d98c876cbeb0f927c is the first bad commit
commit 8261e1f139db3f8aa6f9fd7d98c876cbeb0f927c
Author: Jeff King <peff@peff.net>
Date:   Mon Aug 22 18:00:07 2016 -0400

    delta_base_cache: use hashmap.h


Backtrace for the `log -u` case is below. I'll follow up with my =
progress.
-Jonathon

$ lldb /Users/jmah/Documents/Streams/git/git-log -- -u
(lldb) target create "/Users/jmah/Documents/Streams/git/git-log"
Current executable set to '/Users/jmah/Documents/Streams/git/git-log' =
(x86_64).
(lldb) settings set -- target.run-args  "-u"
(lldb) process launch -o /dev/null
Process 92815 launched: '/Users/jmah/Documents/Streams/git/git-log' =
(x86_64)
Process 92815 stopped
* thread #1: tid =3D 0x1c30677, 0x00000001001bba80 =
git-log`release_delta_base_cache(ent=3D0xffffffffffffffd0) + 16 at =
sha1_file.c:2171, queue =3D 'com.apple.main-thread', stop reason =3D =
EXC_BAD_ACCESS (code=3D1, address=3D0x10)
    frame #0: 0x00000001001bba80 =
git-log`release_delta_base_cache(ent=3D0xffffffffffffffd0) + 16 at =
sha1_file.c:2171
   2168=09
   2169	static inline void release_delta_base_cache(struct =
delta_base_cache_entry *ent)
   2170	{
-> 2171		free(ent->data);
   2172		detach_delta_base_cache_entry(ent);
   2173	}
   2174=09
(lldb) bt
warning: could not load any Objective-C class information. This will =
significantly reduce the quality of type information available.
* thread #1: tid =3D 0x1c30677, 0x00000001001bba80 =
git-log`release_delta_base_cache(ent=3D0xffffffffffffffd0) + 16 at =
sha1_file.c:2171, queue =3D 'com.apple.main-thread', stop reason =3D =
EXC_BAD_ACCESS (code=3D1, address=3D0x10)
  * frame #0: 0x00000001001bba80 =
git-log`release_delta_base_cache(ent=3D0xffffffffffffffd0) + 16 at =
sha1_file.c:2171
    frame #1: 0x00000001001bcadf =
git-log`add_delta_base_cache(p=3D0x00000001006062f0, =
base_offset=3D1792781, base=3D0x000000015749a000, base_size=3D1617761, =
type=3DOBJ_BLOB) + 143 at sha1_file.c:2199
    frame #2: 0x00000001001bc0d6 =
git-log`unpack_entry(p=3D0x00000001006062f0, obj_offset=3D1792781, =
final_type=3D0x00007fff5fbfe7fc, final_size=3D0x000000010185a5a0) + 1590 =
at sha1_file.c:2345
    frame #3: 0x00000001001c2209 =
git-log`cache_or_unpack_entry(p=3D0x00000001006062f0, =
base_offset=3D2692554, base_size=3D0x000000010185a5a0, =
type=3D0x00007fff5fbfe7fc) + 73 at sha1_file.c:2162
    frame #4: 0x00000001001bed8d =
git-log`read_packed_sha1(sha1=3D"?c?????}\x0e'\x81=D2=84MH;yP?, =
type=3D0x00007fff5fbfe7fc, size=3D0x000000010185a5a0) + 93 at =
sha1_file.c:2765
    frame #5: 0x00000001001bcc17 =
git-log`read_object(sha1=3D"?c?????}\x0e'\x81=D2=84MH;yP?, =
type=3D0x00007fff5fbfe7fc, size=3D0x000000010185a5a0) + 119 at =
sha1_file.c:2813
    frame #6: 0x00000001001be013 =
git-log`read_sha1_file_extended(sha1=3D"?c?????}\x0e'\x81=D2=84MH;yP?, =
type=3D0x00007fff5fbfe7fc, size=3D0x000000010185a5a0, flag=3D1) + 67 at =
sha1_file.c:2841
    frame #7: 0x00000001001073ba =
git-log`read_sha1_file(sha1=3D"?c?????}\x0e'\x81=D2=84MH;yP?, =
type=3D0x00007fff5fbfe7fc, size=3D0x000000010185a5a0) + 42 at =
cache.h:1056
    frame #8: 0x0000000100106ce6 =
git-log`diff_populate_filespec(s=3D0x000000010185a570, flags=3D2) + 1334 =
at diff.c:2845
    frame #9: 0x0000000100106670 =
git-log`diff_filespec_is_binary(one=3D0x000000010185a570) + 160 at =
diff.c:2248
    frame #10: 0x00000001001124bc =
git-log`builtin_diff(name_a=3D"Applications/IDE/PlugIns/IDEPlugIns/IDEPlug=
Ins.xcodeproj/project.pbxproj", =
name_b=3D"Applications/IDE/PlugIns/IDEPlugIns/IDEPlugIns.xcodeproj/project=
.pbxproj", one=3D0x000000010185a570, two=3D0x0000000101878310, =
xfrm_msg=3D"index e063d6f..288f95f 100644\n", must_show_header=3D0, =
o=3D0x00007fff5fbff4b8, complete_rewrite=3D0) + 1852 at diff.c:2383
    frame #11: 0x00000001001116ce =
git-log`run_diff_cmd(pgm=3D0x0000000000000000, =
name=3D"Applications/IDE/PlugIns/IDEPlugIns/IDEPlugIns.xcodeproj/project.p=
bxproj", other=3D0x0000000000000000, =
attr_path=3D"Applications/IDE/PlugIns/IDEPlugIns/IDEPlugIns.xcodeproj/proj=
ect.pbxproj", one=3D0x000000010185a570, two=3D0x0000000101878310, =
msg=3D0x00007fff5fbfed18, o=3D0x00007fff5fbff4b8, p=3D0x000000010186c130) =
+ 734 at diff.c:3134
    frame #12: 0x0000000100111350 git-log`run_diff(p=3D0x000000010186c130,=
 o=3D0x00007fff5fbff4b8) + 720 at diff.c:3222
    frame #13: 0x000000010010d75d =
git-log`diff_flush_patch(p=3D0x000000010186c130, o=3D0x00007fff5fbff4b8) =
+ 157 at diff.c:4202
    frame #14: 0x000000010010b9bc =
git-log`diff_flush(options=3D0x00007fff5fbff4b8) + 1148 at diff.c:4722
    frame #15: 0x000000010014418b =
git-log`log_tree_diff_flush(opt=3D0x00007fff5fbfefc0) + 507 at =
log-tree.c:781
    frame #16: 0x00000001001445fe =
git-log`log_tree_diff(opt=3D0x00007fff5fbfefc0, =
commit=3D0x0000000153506540, log=3D0x00007fff5fbfeed8) + 606 at =
log-tree.c:848
    frame #17: 0x000000010014428e =
git-log`log_tree_commit(opt=3D0x00007fff5fbfefc0, =
commit=3D0x0000000153506540) + 238 at log-tree.c:877
    frame #18: 0x0000000100064b89 =
git-log`cmd_log_walk(rev=3D0x00007fff5fbfefc0) + 185 at log.c:360
    frame #19: 0x0000000100066405 git-log`cmd_log(argc=3D2, =
argv=3D0x00007fff5fbff9d0, prefix=3D0x0000000000000000) + 309 at =
log.c:682
    frame #20: 0x000000010000274f =
git-log`run_builtin(p=3D0x0000000100264970, argc=3D2, =
argv=3D0x00007fff5fbff9d0) + 431 at git.c:352
    frame #21: 0x0000000100001a9a git-log`handle_builtin(argc=3D2, =
argv=3D0x00007fff5fbff9d0) + 138 at git.c:539
    frame #22: 0x00000001000017e4 git-log`cmd_main(argc=3D2, =
argv=3D0x00007fff5fbff9d0) + 116 at git.c:635
    frame #23: 0x00000001000c9eb4 git-log`main(argc=3D2, =
argv=3D0x00007fff5fbff9d0) + 68 at common-main.c:40
    frame #24: 0x00007fffd87ff255 libdyld.dylib`start + 1




