Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F16C54EE9
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 19:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbiITT1j (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 15:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiITT1f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 15:27:35 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B266FA02
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 12:27:32 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id ay9so2549286qtb.0
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 12:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=8CwB06PChN3hB6HC9F4KlGTbrGTXTFsghBXtt/zlqDc=;
        b=hqaoQNlJgb2OaU+QYNPGGXtLe6oXNYyse8geX08keegeuNPFaL3bGsdS/gM57cs1j3
         Bl6jU7sB0z5Gl0n/Dc0/7c2dgceGB1VWouzxUGTRFWd3vTNzIly0ksjGYtaLJQN62mz2
         YL5TzQL/APSMfAFJsOUSEZsTCe2K6uHW7IaoAouOfOrNpAKzwgoxjCjoV+uzbjAtj0qa
         pkSfjJzqwefdxWh4Zvfef/HPceBjv0hnz+AnwBvMBlLTa8gsvH5jZblsy+OzyBhzCVdS
         7fJu4j3BWwEVUWgzs+8II2CCo+5NGvCF4hYF0tsx1SHmsLwvPnCWajCeGCwbj8mVjlPx
         ESHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=8CwB06PChN3hB6HC9F4KlGTbrGTXTFsghBXtt/zlqDc=;
        b=Xa1tP+IlZnc/FsrrO86w9SMwtnG6b26eP3yYTR+OBQlFy1mWMOD9VIA3Ouzwuk/lJt
         O2TubwJT7pBOypQHpV3WNxG0EpvhuHi5P0pOuTvagOfwoCE8kUcB3vtkvI7i0v353JTE
         2di9KbuOzBcSDvZFnIShEmYFDUUi2dSqpFT5tfDM+BW/r5nSNbxodytsYe3u/MSy21LZ
         PmOe/SnRIs9MvUGWuPuKkLJSv2M/4/oGIoOr2tzRCuQfabQkAUhIjPW5rKK+9ITSpT2T
         e4ok/HF2ILHlXzwy/dlsoIR12kahHfQkOyf+DoEUnGSeYJ4ir6Hj9vR0tjZLRBuf0/1d
         7KLg==
X-Gm-Message-State: ACrzQf08Ld1c4vQHH3v6Q3FrVpyY5aXAkdbWZ287tez32i1l0kWXvRDM
        q3+CCtg6jFlx77+2GANsnR8Bv4FZlFqrTg==
X-Google-Smtp-Source: AMsMyM5lAOkAI/5oc3i0vq9enOFWXlIEsHZsMKQkIcxL/69v0+xoVmKGLdZxkmBuj9txGTW4Zt0wzg==
X-Received: by 2002:a05:622a:1491:b0:35b:bbcc:3b17 with SMTP id t17-20020a05622a149100b0035bbbcc3b17mr20352193qtx.3.1663702050932;
        Tue, 20 Sep 2022 12:27:30 -0700 (PDT)
Received: from [10.37.129.2] (pool-71-187-159-144.nwrknj.fios.verizon.net. [71.187.159.144])
        by smtp.gmail.com with ESMTPSA id d8-20020ac85348000000b003445b83de67sm294230qto.3.2022.09.20.12.27.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Sep 2022 12:27:30 -0700 (PDT)
From:   John Cai <johncai86@gmail.com>
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>
Subject: [INVESTIGATION] why is fsck --connectivity-only so much more expensive than rev-list --objects --all?
Date:   Tue, 20 Sep 2022 15:27:29 -0400
X-Mailer: MailMate (1.14r5852)
Message-ID: <9304B938-4A59-456B-B091-DBBCAA1823B2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

I would love your thoughts about something I'm noticing in git fsck
--connectivity-only. I noticed that for large repositories, this operatio=
n can
take up alot of memory.

Here at GitLab we are exploring using `git rev-list --all --objects` as a=
 proxy
for checking connectivity. In doing so, I noticed `git fsck --connectivit=
y-only`
is much more expensive than `git rev-list --all --objects`.

Using Valgrind, here are some memory profile results from running both on=
 the
linux repo:

`git fsck --connectivity-only`:

    GB
1.916^                                                                   =
    :
     |                                                                @@:=
@@:#:
     |                                                         :::@@:@@@:=
@@:#:
     |                                                  :::@::@:::@@:@@@:=
@@:#:
     |                                           :::@@@@:: @::@:::@@:@@@:=
@@:#:
     |                                   @@::::::: :@ @@:: @::@:::@@:@@@:=
@@:#:
     |                            :::::::@@: ::: : :@ @@:: @::@:::@@:@@@:=
@@:#:
     |                     ::::@@::: :: :@@: ::: : :@ @@:: @::@:::@@:@@@:=
@@:#:
     |              ::::::@::::@ ::: :: :@@: ::: : :@ @@:: @::@:::@@:@@@:=
@@:#:
     |        :::::::::: :@::::@ ::: :: :@@: ::: : :@ @@:: @::@:::@@:@@@:=
@@:#:
     |   ::::::::: ::::: :@::::@ ::: :: :@@: ::: : :@ @@:: @::@:::@@:@@@:=
@@:#:
     | ::::: ::::: ::::: :@::::@ ::: :: :@@: ::: : :@ @@:: @::@:::@@:@@@:=
@@:#:
     | : ::: ::::: ::::: :@::::@ ::: :: :@@: ::: : :@ @@:: @::@:::@@:@@@:=
@@:#:
     | : ::: ::::: ::::: :@::::@ ::: :: :@@: ::: : :@ @@:: @::@:::@@:@@@:=
@@:#:
     | : ::: ::::: ::::: :@::::@ ::: :: :@@: ::: : :@ @@:: @::@:::@@:@@@:=
@@:#:
     | : ::: ::::: ::::: :@::::@ ::: :: :@@: ::: : :@ @@:: @::@:::@@:@@@:=
@@:#:
     | : ::: ::::: ::::: :@::::@ ::: :: :@@: ::: : :@ @@:: @::@:::@@:@@@:=
@@:#:
     | : ::: ::::: ::::: :@::::@ ::: :: :@@: ::: : :@ @@:: @::@:::@@:@@@:=
@@:#:
     | : ::: ::::: ::::: :@::::@ ::: :: :@@: ::: : :@ @@:: @::@:::@@:@@@:=
@@:#:
     | : ::: ::::: ::::: :@::::@ ::: :: :@@: ::: : :@ @@:: @::@:::@@:@@@:=
@@:#:
   0 +-------------------------------------------------------------------=
---->Gi
     0                                                                   =
233.7


`git rev-list --all --objects`:

    MB
979.8^                                                                   =
#
     |                                                                   =
#
     |                                                                   =
#
     |                                                                   =
#::::
     |                                                                   =
#::::
     |                                                                   =
#::::
     |                                                             @@@:@@=
#::::
     |                                                    ::@@@:@@@@@@:@@=
#::::
     |                                           ::::@::::::@@@:@@@@@@:@@=
#::::
     |                             @@   :::::::::: ::@::::::@@@:@@@@@@:@@=
#::::
     |                             @ :@:::::: :::: ::@::::::@@@:@@@@@@:@@=
#::::
     |                          @@:@ :@:::::: :::: ::@::::::@@@:@@@@@@:@@=
#::::
     |                ::::@::::@@@:@ :@:::::: :::: ::@::::::@@@:@@@@@@:@@=
#::::
     |          @@::::::: @::::@@@:@ :@:::::: :::: ::@::::::@@@:@@@@@@:@@=
#::::
     |          @ ::: ::: @::::@@@:@ :@:::::: :::: ::@::::::@@@:@@@@@@:@@=
#::::
     |          @ ::: ::: @::::@@@:@ :@:::::: :::: ::@::::::@@@:@@@@@@:@@=
#::::
     |        :@@ ::: ::: @::::@@@:@ :@:::::: :::: ::@::::::@@@:@@@@@@:@@=
#::::
     |       ::@@ ::: ::: @::::@@@:@ :@:::::: :::: ::@::::::@@@:@@@@@@:@@=
#::::
     |    :::::@@ ::: ::: @::::@@@:@ :@:::::: :::: ::@::::::@@@:@@@@@@:@@=
#::::
     |  :::: ::@@ ::: ::: @::::@@@:@ :@:::::: :::: ::@::::::@@@:@@@@@@:@@=
#::::
   0 +-------------------------------------------------------------------=
---->Gi
     0                                                                   =
245.5

As we can see, `git fsck` uses about twice the amount of memory as `git
rev-list`, which was a bit surprising to me.

Digging in a bit, here is the stack trace analysis:

`git fsck --connectivity-only`:

98.37% (2,008,484,573B) (heap allocation functions) malloc/new/new[], --a=
lloc-fns, etc.
->84.04% (1,715,907,794B) 0x35779F: do_xmalloc (wrapper.c:51)
| ->50.73% (1,035,816,788B) 0x35781F: do_xmallocz.part.0 (wrapper.c:85)
| | ->40.48% (826,445,820B) 0x2B2447: unpack_compressed_entry (packfile.c=
:1601)
| | | ->40.48% (826,445,820B) 0x2B46AB: unpack_entry (packfile.c:1768)
| | | | ->40.48% (826,445,820B) 0x2B4A23: cache_or_unpack_entry (packfile=
=2Ec:1438)
| | | |   ->40.48% (826,445,820B) 0x2B4A23: packed_object_info (packfile.=
c:1516)
| | | |     ->40.48% (826,445,820B) 0x29EA83: do_oid_object_info_extended=
 (object-file.c:1620)
| | | |       ->40.48% (826,445,820B) 0x29EBDB: oid_object_info_extended =
(object-file.c:1639)
| | | |         ->40.48% (826,445,820B) 0x29EDC3: read_object (object-fil=
e.c:1671)
| | | |           ->40.48% (826,445,820B) 0x29EE5B: read_object_file_exte=
nded (object-file.c:1714)
| | | |             ->40.12% (819,056,147B) 0x2143BB: repo_read_object_fi=
le (object-store.h:253)
| | | |             | ->40.12% (819,056,147B) 0x2143BB: repo_parse_commit=
_internal (commit.c:511)
| | | |             |   ->40.12% (819,056,147B) 0x2143BB: repo_parse_comm=
it_internal (commit.c:495)
| | | |             |     ->40.12% (819,056,147B) 0x25A747: repo_parse_co=
mmit (commit.h:90)
| | | |             |       ->40.12% (819,056,147B) 0x25A747: fsck_walk_c=
ommit (fsck.c:355)
| | | |             |         ->40.12% (819,056,147B) 0x25A747: fsck_walk=
 (fsck.c:441)
| | | |             |           ->40.12% (819,056,147B) 0x16C7BB: travers=
e_one_object (fsck.c:175)
| | | |             |             ->40.12% (819,056,147B) 0x16C7BB: trave=
rse_reachable (fsck.c:192)
| | | |             |               ->40.12% (819,056,147B) 0x16C7BB: che=
ck_connectivity (fsck.c:363)
| | | |             |                 ->40.12% (819,056,147B) 0x16C7BB: c=
md_fsck (fsck.c:982)
| | | |             |                   ->40.12% (819,056,147B) 0x128007:=
 run_builtin (git.c:466)
| | | |             |                     ->40.12% (819,056,147B) 0x12800=
7: handle_builtin (git.c:720)
| | | |             |                       ->40.12% (819,056,147B) 0x129=
127: cmd_main (git.c:888)
| | | |             |                         ->40.12% (819,056,147B) 0x1=
27B67: main (common-main.c:56)
| | | |             |
| | | |             ->00.36% (7,389,673B) in 1+ places, all below ms_prin=
t's threshold (01.00%)
| | | |
| | | ->00.00% (0B) in 1+ places, all below ms_print's threshold (01.00%)=

| | |
| | ->08.61% (175,870,114B) 0x2B9DC3: patch_delta (patch-delta.c:36)
| | | ->08.61% (175,870,114B) 0x2B42EB: unpack_entry (packfile.c:1829)
| | |   ->08.61% (175,870,114B) 0x2B4A23: cache_or_unpack_entry (packfile=
=2Ec:1438)
| | |     ->08.61% (175,870,114B) 0x2B4A23: packed_object_info (packfile.=
c:1516)
| | |       ->08.61% (175,870,114B) 0x29EA83: do_oid_object_info_extended=
 (object-file.c:1620)
| | |         ->08.61% (175,870,114B) 0x29EBDB: oid_object_info_extended =
(object-file.c:1639)
| | |           ->08.61% (175,870,114B) 0x29EDC3: read_object (object-fil=
e.c:1671)
| | |             ->08.61% (175,870,114B) 0x29EE5B: read_object_file_exte=
nded (object-file.c:1714)
| | |               ->04.52% (92,219,588B) 0x3461CB: repo_read_object_fil=
e (object-store.h:253)
| | |               | ->04.52% (92,219,588B) 0x3461CB: parse_tree_gently.=
part.0 (tree.c:132)
| | |               |   ->04.52% (92,219,588B) 0x25A4EB: parse_tree (tree=
=2Eh:24)
| | |               |     ->04.52% (92,219,588B) 0x25A4EB: fsck_walk_tree=
 (fsck.c:307)
| | |               |       ->04.52% (92,219,588B) 0x25A4EB: fsck_walk (f=
sck.c:439)
| | |               |         ->04.52% (92,219,588B) 0x16C7BB: traverse_o=
ne_object (fsck.c:175)
| | |               |           ->04.52% (92,219,588B) 0x16C7BB: traverse=
_reachable (fsck.c:192)
| | |               |             ->04.52% (92,219,588B) 0x16C7BB: check_=
connectivity (fsck.c:363)
| | |               |               ->04.52% (92,219,588B) 0x16C7BB: cmd_=
fsck (fsck.c:982)
| | |               |                 ->04.52% (92,219,588B) 0x128007: ru=
n_builtin (git.c:466)
| | |               |                   ->04.52% (92,219,588B) 0x128007: =
handle_builtin (git.c:720)
| | |               |                     ->04.52% (92,219,588B) 0x129127=
: cmd_main (git.c:888)
| | |               |                       ->04.52% (92,219,588B) 0x127B=
67: main (common-main.c:56)
| | |               |
| | |               ->04.10% (83,650,526B) 0x2143BB: repo_read_object_fil=
e (object-store.h:253)
| | |               | ->04.10% (83,650,526B) 0x2143BB: repo_parse_commit_=
internal (commit.c:511)
| | |               |   ->04.10% (83,650,526B) 0x2143BB: repo_parse_commi=
t_internal (commit.c:495)
| | |               |     ->04.10% (83,650,526B) 0x25A747: repo_parse_com=
mit (commit.h:90)
| | |               |       ->04.10% (83,650,526B) 0x25A747: fsck_walk_co=
mmit (fsck.c:355)
| | |               |         ->04.10% (83,650,526B) 0x25A747: fsck_walk =
(fsck.c:441)
| | |               |           ->04.10% (83,650,526B) 0x16C7BB: traverse=
_one_object (fsck.c:175)
| | |               |             ->04.10% (83,650,526B) 0x16C7BB: traver=
se_reachable (fsck.c:192)
| | |               |               ->04.10% (83,650,526B) 0x16C7BB: chec=
k_connectivity (fsck.c:363)
| | |               |                 ->04.10% (83,650,526B) 0x16C7BB: cm=
d_fsck (fsck.c:982)
| | |               |                   ->04.10% (83,650,526B) 0x128007: =
run_builtin (git.c:466)
| | |               |                     ->04.10% (83,650,526B) 0x128007=
: handle_builtin (git.c:720)
| | |               |                       ->04.10% (83,650,526B) 0x1291=
27: cmd_main (git.c:888)
| | |               |                         ->04.10% (83,650,526B) 0x12=
7B67: main (common-main.c:56)
| | |               |
| | |               ->00.00% (0B) in 1+ places, all below ms_print's thre=
shold (01.00%)
| | |
| | ->01.64% (33,500,854B) 0x357903: do_xmallocz (wrapper.c:83)
| | | ->01.64% (33,500,854B) 0x357903: xmallocz (wrapper.c:93)
| | |   ->01.64% (33,500,854B) 0x357903: xmemdupz (wrapper.c:109)
| | |     ->01.64% (33,493,416B) 0x2B476F: cache_or_unpack_entry (packfil=
e.c:1444)
| | |     | ->01.64% (33,493,416B) 0x2B476F: packed_object_info (packfile=
=2Ec:1516)
| | |     |   ->01.64% (33,493,416B) 0x29EA83: do_oid_object_info_extende=
d (object-file.c:1620)
| | |     |     ->01.64% (33,493,416B) 0x29EBDB: oid_object_info_extended=
 (object-file.c:1639)
| | |     |       ->01.64% (33,493,416B) 0x29EDC3: read_object (object-fi=
le.c:1671)
| | |     |         ->01.64% (33,493,416B) 0x29EE5B: read_object_file_ext=
ended (object-file.c:1714)
| | |     |           ->01.64% (33,438,291B) 0x2143BB: repo_read_object_f=
ile (object-store.h:253)
| | |     |           | ->01.64% (33,438,291B) 0x2143BB: repo_parse_commi=
t_internal (commit.c:511)
| | |     |           |   ->01.64% (33,438,291B) 0x2143BB: repo_parse_com=
mit_internal (commit.c:495)
| | |     |           |     ->01.64% (33,438,291B) 0x25A747: repo_parse_c=
ommit (commit.h:90)
| | |     |           |       ->01.64% (33,438,291B) 0x25A747: fsck_walk_=
commit (fsck.c:355)
| | |     |           |         ->01.64% (33,438,291B) 0x25A747: fsck_wal=
k (fsck.c:441)
| | |     |           |           ->01.64% (33,438,291B) 0x16C7BB: traver=
se_one_object (fsck.c:175)
| | |     |           |             ->01.64% (33,438,291B) 0x16C7BB: trav=
erse_reachable (fsck.c:192)
| | |     |           |               ->01.64% (33,438,291B) 0x16C7BB: ch=
eck_connectivity (fsck.c:363)
| | |     |           |                 ->01.64% (33,438,291B) 0x16C7BB: =
cmd_fsck (fsck.c:982)
| | |     |           |                   ->01.64% (33,438,291B) 0x128007=
: run_builtin (git.c:466)
| | |     |           |                     ->01.64% (33,438,291B) 0x1280=
07: handle_builtin (git.c:720)
| | |     |           |                       ->01.64% (33,438,291B) 0x12=
9127: cmd_main (git.c:888)
| | |     |           |                         ->01.64% (33,438,291B) 0x=
127B67: main (common-main.c:56)
| | |     |           |
| | |     |           ->00.00% (55,125B) in 1+ places, all below ms_print=
's threshold (01.00%)
| | |     |
| | |     ->00.00% (7,438B) in 1+ places, all below ms_print's threshold =
(01.00%)
| | |
| | ->00.00% (0B) in 1+ places, all below ms_print's threshold (01.00%)
| |
| ->31.69% (646,963,200B) 0x369A07: alloc_node (alloc.c:59)
| | ->31.69% (646,963,200B) 0x369A07: alloc_object_node (alloc.c:95)
| |   ->31.69% (646,963,200B) 0x2A3A0F: lookup_unknown_object (object.c:1=
84)
| |     ->31.69% (646,963,200B) 0x16B19B: mark_object_for_connectivity (f=
sck.c:800)
| |       ->31.69% (646,963,200B) 0x16B19B: mark_packed_for_connectivity =
(fsck.c:817)
| |         ->31.69% (646,963,200B) 0x2B50AB: for_each_object_in_pack (pa=
ckfile.c:2176)
| |           ->31.69% (646,963,200B) 0x2B5217: for_each_packed_object (p=
ackfile.c:2207)
| |             ->31.69% (646,963,200B) 0x16C6A3: cmd_fsck (fsck.c:881)
| |               ->31.69% (646,963,200B) 0x128007: run_builtin (git.c:46=
6)
| |                 ->31.69% (646,963,200B) 0x128007: handle_builtin (git=
=2Ec:720)
| |                   ->31.69% (646,963,200B) 0x129127: cmd_main (git.c:8=
88)
| |                     ->31.69% (646,963,200B) 0x127B67: main (common-ma=
in.c:56)
| |
| ->01.62% (33,127,806B) in 14 places, all below massif's threshold (1.00=
%)
|
->14.12% (288,287,504B) 0x357A37: xcalloc (wrapper.c:150)
| ->13.15% (268,435,456B) 0x2A386B: grow_object_hash (object.c:130)
| | ->13.15% (268,435,456B) 0x2A386B: create_object (object.c:152)
| |   ->13.15% (268,435,456B) 0x16B19B: mark_object_for_connectivity (fsc=
k.c:800)
| |     ->13.15% (268,435,456B) 0x16B19B: mark_packed_for_connectivity (f=
sck.c:817)
| |       ->13.15% (268,435,456B) 0x2B50AB: for_each_object_in_pack (pack=
file.c:2176)
| |         ->13.15% (268,435,456B) 0x2B5217: for_each_packed_object (pac=
kfile.c:2207)
| |           ->13.15% (268,435,456B) 0x16C6A3: cmd_fsck (fsck.c:881)
| |             ->13.15% (268,435,456B) 0x128007: run_builtin (git.c:466)=

| |               ->13.15% (268,435,456B) 0x128007: handle_builtin (git.c=
:720)
| |                 ->13.15% (268,435,456B) 0x129127: cmd_main (git.c:888=
)
| |                   ->13.15% (268,435,456B) 0x127B67: main (common-main=
=2Ec:56)
| |
| ->00.97% (19,852,048B) in 1+ places, all below ms_print's threshold (01=
=2E00%)
|
->00.21% (4,289,275B) in 1+ places, all below ms_print's threshold (01.00=
%)

`git rev-list --all --objects`:

99.88% (1,026,125,720B) (heap allocation functions) malloc/new/new[], --a=
lloc-fns, etc.
->54.04% (555,159,796B) 0x35779F: do_xmalloc (wrapper.c:51)
| ->27.44% (281,960,448B) 0x369803: alloc_node (alloc.c:59)
| | ->27.44% (281,960,448B) 0x369803: alloc_tree_node (alloc.c:81)
| |   ->27.44% (281,960,448B) 0x3462DF: lookup_tree (tree.c:109)
| |     ->27.44% (281,960,448B) 0x3462DF: lookup_tree (tree.c:105)
| |       ->21.38% (219,684,864B) 0x270707: process_tree_contents (list-o=
bjects.c:142)
| |       | ->21.38% (219,684,864B) 0x270707: process_tree (list-objects.=
c:221)
| |       |   ->15.11% (155,287,552B) 0x27072B: process_tree_contents (li=
st-objects.c:149)
| |       |   | ->15.11% (155,287,552B) 0x27072B: process_tree (list-obje=
cts.c:221)
| |       |   |   ->08.64% (88,768,512B) 0x27072B: process_tree_contents =
(list-objects.c:149)
| |       |   |   | ->08.64% (88,768,512B) 0x27072B: process_tree (list-o=
bjects.c:221)
| |       |   |   |   ->04.77% (49,029,120B) 0x2708D3: traverse_non_commi=
ts (list-objects.c:378)
| |       |   |   |   | ->04.77% (49,029,120B) 0x2708D3: traverse_non_com=
mits (list-objects.c:357)
| |       |   |   |   |   ->04.77% (49,029,120B) 0x270D5B: do_traverse (l=
ist-objects.c:432)
| |       |   |   |   |     ->04.77% (49,029,120B) 0x270D5B: traverse_com=
mit_list_filtered (list-objects.c:453)
| |       |   |   |   |       ->04.77% (49,029,120B) 0x1BD3D3: cmd_rev_li=
st (rev-list.c:721)
| |       |   |   |   |         ->04.77% (49,029,120B) 0x128007: run_buil=
tin (git.c:466)
| |       |   |   |   |           ->04.77% (49,029,120B) 0x128007: handle=
_builtin (git.c:720)
| |       |   |   |   |             ->04.77% (49,029,120B) 0x129127: cmd_=
main (git.c:888)
| |       |   |   |   |               ->04.77% (49,029,120B) 0x127B67: ma=
in (common-main.c:56)
| |       |   |   |   |
| |       |   |   |   ->03.87% (39,739,392B) 0x27072B: process_tree_conte=
nts (list-objects.c:149)
| |       |   |   |     ->03.87% (39,739,392B) 0x27072B: process_tree (li=
st-objects.c:221)
| |       |   |   |       ->02.45% (25,174,016B) 0x2708D3: traverse_non_c=
ommits (list-objects.c:378)
| |       |   |   |       | ->02.45% (25,174,016B) 0x2708D3: traverse_non=
_commits (list-objects.c:357)
| |       |   |   |       |   ->02.45% (25,174,016B) 0x270D5B: do_travers=
e (list-objects.c:432)
| |       |   |   |       |     ->02.45% (25,174,016B) 0x270D5B: traverse=
_commit_list_filtered (list-objects.c:453)
| |       |   |   |       |       ->02.45% (25,174,016B) 0x1BD3D3: cmd_re=
v_list (rev-list.c:721)
| |       |   |   |       |         ->02.45% (25,174,016B) 0x128007: run_=
builtin (git.c:466)
| |       |   |   |       |           ->02.45% (25,174,016B) 0x128007: ha=
ndle_builtin (git.c:720)
| |       |   |   |       |             ->02.45% (25,174,016B) 0x129127: =
cmd_main (git.c:888)
| |       |   |   |       |               ->02.45% (25,174,016B) 0x127B67=
: main (common-main.c:56)
| |       |   |   |       |
| |       |   |   |       ->01.42% (14,565,376B) 0x27072B: process_tree_c=
ontents (list-objects.c:149)
| |       |   |   |         ->01.42% (14,565,376B) 0x27072B: process_tree=
 (list-objects.c:221)
| |       |   |   |           ->01.00% (10,321,920B) 0x2708D3: traverse_n=
on_commits (list-objects.c:378)
| |       |   |   |           | ->01.00% (10,321,920B) 0x2708D3: traverse=
_non_commits (list-objects.c:357)
| |       |   |   |           |   ->01.00% (10,321,920B) 0x270D5B: do_tra=
verse (list-objects.c:432)
| |       |   |   |           |     ->01.00% (10,321,920B) 0x270D5B: trav=
erse_commit_list_filtered (list-objects.c:453)
| |       |   |   |           |       ->01.00% (10,321,920B) 0x1BD3D3: cm=
d_rev_list (rev-list.c:721)
| |       |   |   |           |         ->01.00% (10,321,920B) 0x128007: =
run_builtin (git.c:466)
| |       |   |   |           |           ->01.00% (10,321,920B) 0x128007=
: handle_builtin (git.c:720)
| |       |   |   |           |             ->01.00% (10,321,920B) 0x1291=
27: cmd_main (git.c:888)
| |       |   |   |           |               ->01.00% (10,321,920B) 0x12=
7B67: main (common-main.c:56)
| |       |   |   |           |
| |       |   |   |           ->00.41% (4,243,456B) in 1+ places, all bel=
ow ms_print's threshold (01.00%)
| |       |   |   |
| |       |   |   ->06.47% (66,519,040B) 0x2708D3: traverse_non_commits (=
list-objects.c:378)
| |       |   |     ->06.47% (66,519,040B) 0x2708D3: traverse_non_commits=
 (list-objects.c:357)
| |       |   |       ->06.47% (66,519,040B) 0x270D5B: do_traverse (list-=
objects.c:432)
| |       |   |         ->06.47% (66,519,040B) 0x270D5B: traverse_commit_=
list_filtered (list-objects.c:453)
| |       |   |           ->06.47% (66,519,040B) 0x1BD3D3: cmd_rev_list (=
rev-list.c:721)
| |       |   |             ->06.47% (66,519,040B) 0x128007: run_builtin =
(git.c:466)
| |       |   |               ->06.47% (66,519,040B) 0x128007: handle_bui=
ltin (git.c:720)
| |       |   |                 ->06.47% (66,519,040B) 0x129127: cmd_main=
 (git.c:888)
| |       |   |                   ->06.47% (66,519,040B) 0x127B67: main (=
common-main.c:56)
| |       |   |
| |       |   ->06.27% (64,397,312B) 0x2708D3: traverse_non_commits (list=
-objects.c:378)
| |       |     ->06.27% (64,397,312B) 0x2708D3: traverse_non_commits (li=
st-objects.c:357)
| |       |       ->06.27% (64,397,312B) 0x270D5B: do_traverse (list-obje=
cts.c:432)
| |       |         ->06.27% (64,397,312B) 0x270D5B: traverse_commit_list=
_filtered (list-objects.c:453)
| |       |           ->06.27% (64,397,312B) 0x1BD3D3: cmd_rev_list (rev-=
list.c:721)
| |       |             ->06.27% (64,397,312B) 0x128007: run_builtin (git=
=2Ec:466)
| |       |               ->06.27% (64,397,312B) 0x128007: handle_builtin=
 (git.c:720)
| |       |                 ->06.27% (64,397,312B) 0x129127: cmd_main (gi=
t.c:888)
| |       |                   ->06.27% (64,397,312B) 0x127B67: main (comm=
on-main.c:56)
| |       |
| |       ->06.06% (62,275,584B) 0x213F93: parse_commit_buffer (commit.c:=
440)
| |         ->06.06% (62,218,240B) 0x2143E7: repo_parse_commit_internal (=
commit.c:522)
| |         | ->06.06% (62,218,240B) 0x2143E7: repo_parse_commit_internal=
 (commit.c:495)
| |         |   ->06.06% (62,218,240B) 0x2FC77B: process_parents (revisio=
n.c:1169)
| |         |     ->06.06% (62,218,240B) 0x2FFEBB: get_revision_1 (revisi=
on.c:4080)
| |         |       ->06.06% (62,218,240B) 0x3000EB: get_revision_interna=
l (revision.c:4188)
| |         |         ->06.06% (62,218,240B) 0x30026F: get_revision (revi=
sion.c:4266)
| |         |           ->06.06% (62,218,240B) 0x270C63: do_traverse (lis=
t-objects.c:397)
| |         |             ->06.06% (62,218,240B) 0x270C63: traverse_commi=
t_list_filtered (list-objects.c:453)
| |         |               ->06.06% (62,218,240B) 0x1BD3D3: cmd_rev_list=
 (rev-list.c:721)
| |         |                 ->06.06% (62,218,240B) 0x128007: run_builti=
n (git.c:466)
| |         |                   ->06.06% (62,218,240B) 0x128007: handle_b=
uiltin (git.c:720)
| |         |                     ->06.06% (62,218,240B) 0x129127: cmd_ma=
in (git.c:888)
| |         |                       ->06.06% (62,218,240B) 0x127B67: main=
 (common-main.c:56)
| |         |
| |         ->00.01% (57,344B) in 1+ places, all below ms_print's thresho=
ld (01.00%)
| |
| ->09.80% (100,703,562B) 0x35781F: do_xmallocz.part.0 (wrapper.c:85)
| | ->09.47% (97,307,344B) 0x2B9DC3: patch_delta (patch-delta.c:36)
| | | ->09.47% (97,307,344B) 0x2B42EB: unpack_entry (packfile.c:1829)
| | |   ->09.47% (97,307,344B) 0x2B4A23: cache_or_unpack_entry (packfile.=
c:1438)
| | |     ->09.47% (97,307,344B) 0x2B4A23: packed_object_info (packfile.c=
:1516)
| | |       ->09.47% (97,307,344B) 0x29EA83: do_oid_object_info_extended =
(object-file.c:1620)
| | |         ->09.47% (97,307,344B) 0x29EBDB: oid_object_info_extended (=
object-file.c:1639)
| | |           ->09.47% (97,307,344B) 0x29EDC3: read_object (object-file=
=2Ec:1671)
| | |             ->09.47% (97,307,344B) 0x29EE5B: read_object_file_exten=
ded (object-file.c:1714)
| | |               ->09.47% (97,307,344B) 0x3461CB: repo_read_object_fil=
e (object-store.h:253)
| | |               | ->09.47% (97,307,344B) 0x3461CB: parse_tree_gently.=
part.0 (tree.c:132)
| | |               |   ->09.47% (97,307,344B) 0x2703EF: process_tree (li=
st-objects.c:188)
| | |               |     ->09.07% (93,167,206B) 0x27072B: process_tree_c=
ontents (list-objects.c:149)
| | |               |     | ->09.07% (93,167,206B) 0x27072B: process_tree=
 (list-objects.c:221)
| | |               |     |   ->07.49% (76,907,030B) 0x27072B: process_tr=
ee_contents (list-objects.c:149)
| | |               |     |   | ->07.49% (76,907,030B) 0x27072B: process_=
tree (list-objects.c:221)
| | |               |     |   |   ->05.69% (58,476,176B) 0x2708D3: traver=
se_non_commits (list-objects.c:378)
| | |               |     |   |   | ->05.69% (58,476,176B) 0x2708D3: trav=
erse_non_commits (list-objects.c:357)
| | |               |     |   |   |   ->05.69% (58,476,176B) 0x270D5B: do=
_traverse (list-objects.c:432)
| | |               |     |   |   |     ->05.69% (58,476,176B) 0x270D5B: =
traverse_commit_list_filtered (list-objects.c:453)
| | |               |     |   |   |       ->05.69% (58,476,176B) 0x1BD3D3=
: cmd_rev_list (rev-list.c:721)
| | |               |     |   |   |         ->05.69% (58,476,176B) 0x1280=
07: run_builtin (git.c:466)
| | |               |     |   |   |           ->05.69% (58,476,176B) 0x12=
8007: handle_builtin (git.c:720)
| | |               |     |   |   |             ->05.69% (58,476,176B) 0x=
129127: cmd_main (git.c:888)
| | |               |     |   |   |               ->05.69% (58,476,176B) =
0x127B67: main (common-main.c:56)
| | |               |     |   |   |
| | |               |     |   |   ->01.79% (18,430,854B) 0x27072B: proces=
s_tree_contents (list-objects.c:149)
| | |               |     |   |     ->01.79% (18,430,854B) 0x27072B: proc=
ess_tree (list-objects.c:221)
| | |               |     |   |       ->01.26% (12,951,424B) 0x2708D3: tr=
averse_non_commits (list-objects.c:378)
| | |               |     |   |       | ->01.26% (12,951,424B) 0x2708D3: =
traverse_non_commits (list-objects.c:357)
| | |               |     |   |       |   ->01.26% (12,951,424B) 0x270D5B=
: do_traverse (list-objects.c:432)
| | |               |     |   |       |     ->01.26% (12,951,424B) 0x270D=
5B: traverse_commit_list_filtered (list-objects.c:453)
| | |               |     |   |       |       ->01.26% (12,951,424B) 0x1B=
D3D3: cmd_rev_list (rev-list.c:721)
| | |               |     |   |       |         ->01.26% (12,951,424B) 0x=
128007: run_builtin (git.c:466)
| | |               |     |   |       |           ->01.26% (12,951,424B) =
0x128007: handle_builtin (git.c:720)
| | |               |     |   |       |             ->01.26% (12,951,424B=
) 0x129127: cmd_main (git.c:888)
| | |               |     |   |       |               ->01.26% (12,951,42=
4B) 0x127B67: main (common-main.c:56)
| | |               |     |   |       |
| | |               |     |   |       ->00.53% (5,479,430B) in 1+ places,=
 all below ms_print's threshold (01.00%)
| | |               |     |   |
| | |               |     |   ->01.58% (16,260,176B) 0x2708D3: traverse_n=
on_commits (list-objects.c:378)
| | |               |     |     ->01.58% (16,260,176B) 0x2708D3: traverse=
_non_commits (list-objects.c:357)
| | |               |     |       ->01.58% (16,260,176B) 0x270D5B: do_tra=
verse (list-objects.c:432)
| | |               |     |         ->01.58% (16,260,176B) 0x270D5B: trav=
erse_commit_list_filtered (list-objects.c:453)
| | |               |     |           ->01.58% (16,260,176B) 0x1BD3D3: cm=
d_rev_list (rev-list.c:721)
| | |               |     |             ->01.58% (16,260,176B) 0x128007: =
run_builtin (git.c:466)
| | |               |     |               ->01.58% (16,260,176B) 0x128007=
: handle_builtin (git.c:720)
| | |               |     |                 ->01.58% (16,260,176B) 0x1291=
27: cmd_main (git.c:888)
| | |               |     |                   ->01.58% (16,260,176B) 0x12=
7B67: main (common-main.c:56)
| | |               |     |
| | |               |     ->00.40% (4,140,138B) in 1+ places, all below m=
s_print's threshold (01.00%)
| | |               |
| | |               ->00.00% (0B) in 1+ places, all below ms_print's thre=
shold (01.00%)
| | |
| | ->00.33% (3,396,218B) in 1+ places, all below ms_print's threshold (0=
1.00%)
| |
| ->08.68% (89,210,880B) 0x36970B: alloc_node (alloc.c:59)
| | ->08.68% (89,210,880B) 0x36970B: alloc_blob_node (alloc.c:74)
| |   ->08.68% (89,210,880B) 0x1FEE17: lookup_blob (blob.c:12)
| |     ->08.68% (89,210,880B) 0x27066F: process_tree_contents (list-obje=
cts.c:155)
| |       ->08.68% (89,210,880B) 0x27066F: process_tree (list-objects.c:2=
21)
| |         ->08.59% (88,227,840B) 0x27072B: process_tree_contents (list-=
objects.c:149)
| |         | ->08.59% (88,227,840B) 0x27072B: process_tree (list-objects=
=2Ec:221)
| |         |   ->08.24% (84,623,360B) 0x27072B: process_tree_contents (l=
ist-objects.c:149)
| |         |   | ->08.24% (84,623,360B) 0x27072B: process_tree (list-obj=
ects.c:221)
| |         |   |   ->05.85% (60,088,320B) 0x27072B: process_tree_content=
s (list-objects.c:149)
| |         |   |   | ->05.85% (60,088,320B) 0x27072B: process_tree (list=
-objects.c:221)
| |         |   |   |   ->03.17% (32,604,160B) 0x27072B: process_tree_con=
tents (list-objects.c:149)
| |         |   |   |   | ->03.17% (32,604,160B) 0x27072B: process_tree (=
list-objects.c:221)
| |         |   |   |   |   ->01.92% (19,742,720B) 0x2708D3: traverse_non=
_commits (list-objects.c:378)
| |         |   |   |   |   | ->01.92% (19,742,720B) 0x2708D3: traverse_n=
on_commits (list-objects.c:357)
| |         |   |   |   |   |   ->01.92% (19,742,720B) 0x270D5B: do_trave=
rse (list-objects.c:432)
| |         |   |   |   |   |     ->01.92% (19,742,720B) 0x270D5B: traver=
se_commit_list_filtered (list-objects.c:453)
| |         |   |   |   |   |       ->01.92% (19,742,720B) 0x1BD3D3: cmd_=
rev_list (rev-list.c:721)
| |         |   |   |   |   |         ->01.92% (19,742,720B) 0x128007: ru=
n_builtin (git.c:466)
| |         |   |   |   |   |           ->01.92% (19,742,720B) 0x128007: =
handle_builtin (git.c:720)
| |         |   |   |   |   |             ->01.92% (19,742,720B) 0x129127=
: cmd_main (git.c:888)
| |         |   |   |   |   |               ->01.92% (19,742,720B) 0x127B=
67: main (common-main.c:56)
| |         |   |   |   |   |
| |         |   |   |   |   ->01.25% (12,861,440B) 0x27072B: process_tree=
_contents (list-objects.c:149)
| |         |   |   |   |     ->01.25% (12,861,440B) 0x27072B: process_tr=
ee (list-objects.c:221)
| |         |   |   |   |       ->01.25% (12,861,440B) in 2 places, all b=
elow massif's threshold (1.00%)
| |         |   |   |   |
| |         |   |   |   ->02.68% (27,484,160B) 0x2708D3: traverse_non_com=
mits (list-objects.c:378)
| |         |   |   |     ->02.68% (27,484,160B) 0x2708D3: traverse_non_c=
ommits (list-objects.c:357)
| |         |   |   |       ->02.68% (27,484,160B) 0x270D5B: do_traverse =
(list-objects.c:432)
| |         |   |   |         ->02.68% (27,484,160B) 0x270D5B: traverse_c=
ommit_list_filtered (list-objects.c:453)
| |         |   |   |           ->02.68% (27,484,160B) 0x1BD3D3: cmd_rev_=
list (rev-list.c:721)
| |         |   |   |             ->02.68% (27,484,160B) 0x128007: run_bu=
iltin (git.c:466)
| |         |   |   |               ->02.68% (27,484,160B) 0x128007: hand=
le_builtin (git.c:720)
| |         |   |   |                 ->02.68% (27,484,160B) 0x129127: cm=
d_main (git.c:888)
| |         |   |   |                   ->02.68% (27,484,160B) 0x127B67: =
main (common-main.c:56)
| |         |   |   |
| |         |   |   ->02.39% (24,535,040B) 0x2708D3: traverse_non_commits=
 (list-objects.c:378)
| |         |   |     ->02.39% (24,535,040B) 0x2708D3: traverse_non_commi=
ts (list-objects.c:357)
| |         |   |       ->02.39% (24,535,040B) 0x270D5B: do_traverse (lis=
t-objects.c:432)
| |         |   |         ->02.39% (24,535,040B) 0x270D5B: traverse_commi=
t_list_filtered (list-objects.c:453)
| |         |   |           ->02.39% (24,535,040B) 0x1BD3D3: cmd_rev_list=
 (rev-list.c:721)
| |         |   |             ->02.39% (24,535,040B) 0x128007: run_builti=
n (git.c:466)
| |         |   |               ->02.39% (24,535,040B) 0x128007: handle_b=
uiltin (git.c:720)
| |         |   |                 ->02.39% (24,535,040B) 0x129127: cmd_ma=
in (git.c:888)
| |         |   |                   ->02.39% (24,535,040B) 0x127B67: main=
 (common-main.c:56)
| |         |   |
| |         |   ->00.35% (3,604,480B) in 1+ places, all below ms_print's =
threshold (01.00%)
| |         |
| |         ->00.10% (983,040B) in 1+ places, all below ms_print's thresh=
old (01.00%)
| |
| ->07.87% (80,879,616B) 0x369B27: alloc_node (alloc.c:59)
| | ->07.87% (80,879,616B) 0x369B27: alloc_commit_node (alloc.c:119)
| |   ->07.87% (80,879,616B) 0x2133B7: lookup_commit (commit.c:66)
| |     ->07.87% (80,879,616B) 0x2133B7: lookup_commit (commit.c:62)
| |       ->07.87% (80,805,888B) 0x21411B: parse_commit_buffer (commit.c:=
466)
| |       | ->07.86% (80,732,160B) 0x2143E7: repo_parse_commit_internal (=
commit.c:522)
| |       | | ->07.86% (80,732,160B) 0x2143E7: repo_parse_commit_internal=
 (commit.c:495)
| |       | |   ->07.86% (80,732,160B) 0x2FC77B: process_parents (revisio=
n.c:1169)
| |       | |     ->07.86% (80,732,160B) 0x2FFEBB: get_revision_1 (revisi=
on.c:4080)
| |       | |       ->07.86% (80,732,160B) 0x3000EB: get_revision_interna=
l (revision.c:4188)
| |       | |         ->07.86% (80,732,160B) 0x30026F: get_revision (revi=
sion.c:4266)
| |       | |           ->07.86% (80,732,160B) 0x270C63: do_traverse (lis=
t-objects.c:397)
| |       | |             ->07.86% (80,732,160B) 0x270C63: traverse_commi=
t_list_filtered (list-objects.c:453)
| |       | |               ->07.86% (80,732,160B) 0x1BD3D3: cmd_rev_list=
 (rev-list.c:721)
| |       | |                 ->07.86% (80,732,160B) 0x128007: run_builti=
n (git.c:466)
| |       | |                   ->07.86% (80,732,160B) 0x128007: handle_b=
uiltin (git.c:720)
| |       | |                     ->07.86% (80,732,160B) 0x129127: cmd_ma=
in (git.c:888)
| |       | |                       ->07.86% (80,732,160B) 0x127B67: main=
 (common-main.c:56)
| |       | |
| |       | ->00.01% (73,728B) in 1+ places, all below ms_print's thresho=
ld (01.00%)
| |       |
| |       ->00.01% (73,728B) in 1+ places, all below ms_print's threshold=
 (01.00%)
| |
| ->00.23% (2,405,290B) in 1+ places, all below ms_print's threshold (01.=
00%)
|
->39.29% (403,708,926B) 0x357A37: xcalloc (wrapper.c:150)
| ->39.19% (402,653,184B) 0x2A386B: grow_object_hash (object.c:130)
| | ->39.19% (402,653,184B) 0x2A386B: create_object (object.c:152)
| |   ->39.19% (402,653,184B) 0x270707: process_tree_contents (list-objec=
ts.c:142)
| |   | ->39.19% (402,653,184B) 0x270707: process_tree (list-objects.c:22=
1)
| |   |   ->26.13% (268,435,456B) 0x2708D3: traverse_non_commits (list-ob=
jects.c:378)
| |   |   | ->26.13% (268,435,456B) 0x2708D3: traverse_non_commits (list-=
objects.c:357)
| |   |   |   ->26.13% (268,435,456B) 0x270D5B: do_traverse (list-objects=
=2Ec:432)
| |   |   |     ->26.13% (268,435,456B) 0x270D5B: traverse_commit_list_fi=
ltered (list-objects.c:453)
| |   |   |       ->26.13% (268,435,456B) 0x1BD3D3: cmd_rev_list (rev-lis=
t.c:721)
| |   |   |         ->26.13% (268,435,456B) 0x128007: run_builtin (git.c:=
466)
| |   |   |           ->26.13% (268,435,456B) 0x128007: handle_builtin (g=
it.c:720)
| |   |   |             ->26.13% (268,435,456B) 0x129127: cmd_main (git.c=
:888)
| |   |   |               ->26.13% (268,435,456B) 0x127B67: main (common-=
main.c:56)
| |   |   |
| |   |   ->13.06% (134,217,728B) 0x27072B: process_tree_contents (list-o=
bjects.c:149)
| |   |     ->13.06% (134,217,728B) 0x27072B: process_tree (list-objects.=
c:221)
| |   |       ->13.06% (134,217,728B) 0x27072B: process_tree_contents (li=
st-objects.c:149)
| |   |         ->13.06% (134,217,728B) 0x27072B: process_tree (list-obje=
cts.c:221)
| |   |           ->13.06% (134,217,728B) 0x2708D3: traverse_non_commits =
(list-objects.c:378)
| |   |             ->13.06% (134,217,728B) 0x2708D3: traverse_non_commit=
s (list-objects.c:357)
| |   |               ->13.06% (134,217,728B) 0x270D5B: do_traverse (list=
-objects.c:432)
| |   |                 ->13.06% (134,217,728B) 0x270D5B: traverse_commit=
_list_filtered (list-objects.c:453)
| |   |                   ->13.06% (134,217,728B) 0x1BD3D3: cmd_rev_list =
(rev-list.c:721)
| |   |                     ->13.06% (134,217,728B) 0x128007: run_builtin=
 (git.c:466)
| |   |                       ->13.06% (134,217,728B) 0x128007: handle_bu=
iltin (git.c:720)
| |   |                         ->13.06% (134,217,728B) 0x129127: cmd_mai=
n (git.c:888)
| |   |                           ->13.06% (134,217,728B) 0x127B67: main =
(common-main.c:56)
| |   |
| |   ->00.00% (0B) in 1+ places, all below ms_print's threshold (01.00%)=

| |
| ->00.10% (1,055,742B) in 1+ places, all below ms_print's threshold (01.=
00%)
|
->06.54% (67,228,381B) 0x3579CF: xrealloc (wrapper.c:136)
| ->06.53% (67,106,816B) 0x2A406B: add_object_array_with_path (object.c:3=
53)
| | ->06.53% (67,106,816B) 0x2F8427: add_pending_object_with_path (revisi=
on.c:343)
| |   ->06.53% (67,106,816B) 0x270D17: add_pending_tree (list-objects.c:3=
54)
| |   | ->06.53% (67,106,816B) 0x270D17: do_traverse (list-objects.c:413)=

| |   |   ->06.53% (67,106,816B) 0x270D17: traverse_commit_list_filtered =
(list-objects.c:453)
| |   |     ->06.53% (67,106,816B) 0x1BD3D3: cmd_rev_list (rev-list.c:721=
)
| |   |       ->06.53% (67,106,816B) 0x128007: run_builtin (git.c:466)
| |   |         ->06.53% (67,106,816B) 0x128007: handle_builtin (git.c:72=
0)
| |   |           ->06.53% (67,106,816B) 0x129127: cmd_main (git.c:888)
| |   |             ->06.53% (67,106,816B) 0x127B67: main (common-main.c:=
56)
| |   |
| |   ->00.00% (0B) in 1+ places, all below ms_print's threshold (01.00%)=

| |
| ->00.01% (121,565B) in 1+ places, all below ms_print's threshold (01.00=
%)
|
->00.00% (28,617B) in 1+ places, all below ms_print's threshold (01.00%)

One observation is that `git-fsck` seems to use up alot more memory in ca=
lling
unpack_compressed_entry() than `git-rev-list` does.

But, not having delved too deeply into the code, I wanted to ask the list=
 if
anything jumps out as to why `git-fsck` consumes so much more memory than=

`git-rev-list`--perhaps there is opportunity for improvement/optimization=
?

thanks!
John
