Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20085C55189
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 08:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC97B206B9
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 08:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbgDVInc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 04:43:32 -0400
Received: from v6.sk ([167.172.42.174]:53276 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725786AbgDVInb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 04:43:31 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 89FF4610A8
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 08:42:58 +0000 (UTC)
Date:   Wed, 22 Apr 2020 10:42:54 +0200
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     git@vger.kernel.org
Subject: Git 2.26 fetches many times more objects than it should, wasting
 gigabytes
Message-ID: <20200422084254.GA27502@furthur.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

my git repository with Linux grows several gigabytes each time I fetch:

  [lkundrak@furthur linux]$ git fetch --all
  Fetching origin
  Receiving objects: 100% (431/431), 72.19 KiB | 345.00 KiB/s, done.
  Fetching stable
  Receiving objects: 100% (127228/127228), 22.01 MiB | 1.93 MiB/s, done.
  Fetching next
  Receiving objects: 100% (31113/31113), 6.51 MiB | 1.11 MiB/s, done.
  Fetching net
  Receiving objects: 100% (7331963/7331963), 1.20 GiB | 2.48 MiB/s, done.
  Fetching tip
  Receiving objects: 100% (7334643/7334643), 1.20 GiB | 2.44 MiB/s, done.
  Fetching irqchip
  Receiving objects: 100% (7333669/7333669), 1.20 GiB | 2.44 MiB/s, done.
  Fetching drm
  Receiving objects:  26% (1931483/7336388), 687.05 MiB | 1.55 MiB/s
  ...

Note the 1.2 GiB fetches from irqchip, tip, drm, net, etc. It looks like
the whole history gets fetched instead of the few changes that were
added since the fetch.

When I've first noticed this happening I've thrown away the repository,
initialized a new one with Git 2.26.0 and fetched everything anew, but
that didn't help.

I have very little clue about how to debug this. I'd be thankful for
suggestions about how to provide more details if necessary. I'm using
git from a Fedora package with this version number:

  [lkundrak@furthur linux]$ rpm -q git
  git-2.26.0-1.fc32.x86_64

Here's a full log of my today's unfortunate fetch (still running...)

  [lkundrak@furthur linux]$ git fetch --all
  Fetching origin
  remote: Enumerating objects: 766, done.
  remote: Counting objects: 100% (636/636), done.
  remote: Compressing objects: 100% (154/154), done.
  remote: Total 431 (delta 355), reused 335 (delta 275)
  Receiving objects: 100% (431/431), 72.19 KiB | 345.00 KiB/s, done.
  Resolving deltas: 100% (355/355), completed with 120 local objects.
  From git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux
     ae83d0b416db00..18bf34080c4c3b  master     -> origin/master
  Fetching stable
  remote: Enumerating objects: 164963, done.
  remote: Counting objects: 100% (156255/156255), done.
  remote: Compressing objects: 100% (35062/35062), done.
  remote: Total 127228 (delta 109912), reused 101371 (delta 91954)
  Receiving objects: 100% (127228/127228), 22.01 MiB | 1.93 MiB/s, done.
  Resolving deltas: 100% (109912/109912), completed with 12616 local objects.
  From git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux
     8488c3f3bc867e..8e2406c8518775  linux-4.19.y -> stable/linux-4.19.y
     dc4059d21d87e8..6ccc74c083c0d4  linux-5.4.y  -> stable/linux-5.4.y
     0634aa9416af81..937381741d02cc  linux-5.5.y  -> stable/linux-5.5.y
     f07f08b09f05e3..7c572703216073  linux-5.6.y  -> stable/linux-5.6.y
   * [new tag]                       v4.19.117    -> v4.19.117
   * [new tag]                       v5.4.34      -> v5.4.34
   * [new tag]                       v5.5.19      -> v5.5.19
   * [new tag]                       v5.6.6       -> v5.6.6
  Fetching next
  remote: Enumerating objects: 75381, done.
  remote: Counting objects: 100% (38266/38266), done.
  remote: Compressing objects: 100% (9052/9052), done.
  remote: Total 31113 (delta 26421), reused 26574 (delta 22000)
  Receiving objects: 100% (31113/31113), 6.51 MiB | 1.11 MiB/s, done.
  Resolving deltas: 100% (26421/26421), completed with 4591 local objects.
  From git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next
   + e98ff732aff9f7...d7b7d5f7953a08 akpm          -> next/akpm  (forced update)
   + 29d027a641745b...8e32e79bb64e7e akpm-base     -> next/akpm-base  (forced update)
   + 6735c84f78e417...a5840f9618a90e master        -> next/master  (forced update)
   + f507be28f9e551...aa411fab3c05eb pending-fixes -> next/pending-fixes  (forced update)
     ae83d0b416db00..18bf34080c4c3b  stable        -> next/stable
   * [new tag]                       next-20200422 -> next-20200422
  Fetching xo
  From github.com:hackerspace/olpc-xo175-linux
   * [new branch]                    lr/8250-json-schema-v2 -> xo/lr/8250-json-schema-v2
   + 3942092b6c20ea...483c7451896cff lr/ariel               -> xo/lr/ariel  (forced update)
   * [new branch]                    lr/ch7033-v4           -> xo/lr/ch7033-v4
     0472b4080244b7..d2339c1aeb192d  lr/mmp-adma            -> xo/lr/mmp-adma
   * [new branch]                    lr/mmp-dts             -> xo/lr/mmp-dts
   + 3dc167b0785d17...2a1d6d9af30e19 lr/mmp2-clk-audio-gpu  -> xo/lr/mmp2-clk-audio-gpu  (forced update)
  Fetching olpc
  Fetching spi
  From git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi
     0dadde344d9655..0392727c261bab  for-5.7    -> spi/for-5.7
     59fc9ad5cb108b..2f5f5302c569f7  for-5.8    -> spi/for-5.8
   + 5e60c07c8615e8...bedad93ec5f83a for-linus  -> spi/for-linus  (forced update)
   + 36792a4aa66c21...c5a7b42434ff12 for-next   -> spi/for-next  (forced update)
  Fetching arm-soc
  From git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
   + 512e8d40f91d7e...e9801213465aa8 arm/fixes  -> arm-soc/arm/fixes  (forced update)
   + 512e8d40f91d7e...e9801213465aa8 for-next   -> arm-soc/for-next  (forced update)
  Fetching net
  remote: Enumerating objects: 7331963, done.
  remote: Counting objects: 100% (7331963/7331963), done.
  remote: Compressing objects: 100% (1114459/1114459), done.
  remote: Total 7331963 (delta 6171286), reused 7329526 (delta 6169706)
  Receiving objects: 100% (7331963/7331963), 1.20 GiB | 2.48 MiB/s, done.
  Resolving deltas: 100% (6171286/6171286), done.
  From git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
     9bacd256f13548..b9663b7ca6ff78  master     -> net/master
  Fetching net-next
  From git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next
     0fde6e3b55a15a..44dd5efc97dae0  master     -> net-next/master
  Fetching arm
  From git://git.armlinux.org.uk/~rmk/linux-arm
     89604523a76eb3..8f3d9f35428674  fixes      -> arm/fixes
   + 52d3b2f98483c3...365a6327cd643e for-next   -> arm/for-next  (forced update)
     8632e9b5645bbc..ae83d0b416db00  master     -> arm/master
  Fetching tip
  remote: Enumerating objects: 7334643, done.
  remote: Counting objects: 100% (7334643/7334643), done.
  remote: Compressing objects: 100% (1115060/1115060), done.
  Receiving objects: 100% (7334643/7334643), 1.20 GiB | 2.44 MiB/s, done.
  remote: Total 7334643 (delta 6173502), reused 7332019 (delta 6171782)
  Resolving deltas: 100% (6173502/6173502), done.
  From git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
   + 36d1b5ecb41546...f091a1f17abdba auto-latest   -> tip/auto-latest  (forced update)
     11e31f608b499f..6e0d6ac5f3d9d9  core/core     -> tip/core/core
   + 37d2e30492116b...22105aa089a7f5 master        -> tip/master  (forced update)
     94d440d6184678..ac84bac4062e7f  timers/urgent -> tip/timers/urgent
     4caffe6a28d315..675a59b7dec6e0  x86/build     -> tip/x86/build
     aa61ee7b9ee3cb..a85573f7e74191  x86/mm        -> tip/x86/mm
     79a3aaa7b82e31..cd2f45b7514cdd  x86/vdso      -> tip/x86/vdso
  Fetching irqchip
  remote: Enumerating objects: 7333669, done.
  remote: Counting objects: 100% (7333669/7333669), done.
  remote: Compressing objects: 100% (1114570/1114570), done.
  Receiving objects: 100% (7333669/7333669), 1.20 GiB | 2.44 MiB/s, done.
  remote: Total 7333669 (delta 6172952), reused 7331159 (delta 6171299)
  Resolving deltas: 100% (6172952/6172952), done.
  From git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms
   + a2ffd41b964081...41932c0b588f27 hack/vim3l-crap          -> irqchip/hack/vim3l-crap  (forced update)
   + a97bd23c9e3762...751551c45552e3 kvm-arm64/nv-5.7-rc1-WIP -> irqchip/kvm-arm64/nv-5.7-rc1-WIP  (forced update)
  Fetching gpio
  Fetching dvhart
  remote: Enumerating objects: 23, done.
  remote: Counting objects: 100% (23/23), done.
  remote: Total 28 (delta 23), reused 23 (delta 23), pack-reused 5
  Unpacking objects: 100% (28/28), 5.19 KiB | 13.00 KiB/s, done.
  From https://github.com/dvhart/linux-pdx86
     8f3d9f35428674..f7ea285b626682  for-next            -> dvhart/for-next
   * [new branch]                    ib-pdx86-properties -> dvhart/ib-pdx86-properties
     00086336a8d96a..ae83d0b416db00  master              -> dvhart/master
   + 79777a3891c69e...5a93adbdbb42e9 review-andy         -> dvhart/review-andy  (forced update)
  Fetching power-supply
  Fetching mmp
  Fetching usb
  From git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
     be34a5854b4606..8f97250c21f0cf  usb-linus  -> usb/usb-linus
  Fetching pinchartl
  Fetching drm
  remote: Enumerating objects: 7336388, done.
  remote: Counting objects: 100% (7336388/7336388), done.
  remote: Compressing objects: 100% (1091614/1091614), done.
  Receiving objects:  26% (1931483/7336388), 687.05 MiB | 1.55 MiB/s

Here's my .git/config:

  [lkundrak@furthur linux]$ cat .git/config 
  [core]
  	repositoryformatversion = 0
  	filemode = true
  	bare = false
  	logallrefupdates = true
  [gui]
  	wmstate = normal
  	geometry = 1400x954+-1+26 453 376
  [merge]
  	renamelimit = 65535
  [remote "origin"]
  	url = git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
  	fetch = +refs/heads/*:refs/remotes/origin/*
  [branch "master"]
  	remote = origin
  	merge = refs/heads/master
  [remote "stable"]
  	url = git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
  	fetch = +refs/heads/*:refs/remotes/stable/*
  [remote "next"]
  	url = git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
  	fetch = +refs/heads/*:refs/remotes/next/*
  [remote "xo"]
  	url = git@github.com:hackerspace/olpc-xo175-linux.git
  	fetch = +refs/heads/*:refs/remotes/xo/*
  [branch "lr/olpc-xo175"]
  	remote = xo
  	merge = refs/heads/lr/olpc-xo175
  [remote "olpc"]
  	url = http://dev.laptop.org/git/olpc-kernel/
  	fetch = +refs/heads/*:refs/remotes/olpc/*
  [remote "spi"]
  	url = git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
  	fetch = +refs/heads/*:refs/remotes/spi/*
  [branch "lr/olpc-xo175-fixes5-mmp"]
  	remote = xo
  	merge = refs/heads/lr/olpc-xo175-fixes5-mmp
  [branch "lr/olpc-xo175-fixes4-ap-sp"]
  	remote = xo
  	merge = refs/heads/lr/olpc-xo175-fixes4-ap-sp
  [branch "lr/olpc-xo175-fixes4-ec"]
  	remote = xo
  	merge = refs/heads/lr/olpc-xo175-fixes4-ec
  [branch "lr/olpc-xo175-fixes2-trivial"]
  	remote = xo
  	merge = refs/heads/lr/olpc-xo175-fixes2-trivial
  [branch "lr/olpc-xo175-fixes3-mmp-camera"]
  	remote = xo
  	merge = refs/heads/lr/olpc-xo175-fixes3-mmp-camera
  [branch "lr/olpc-xo175-drm"]
  	remote = xo
  	merge = refs/heads/lr/olpc-xo175-drm
  [remote "arm-soc"]
  	url = git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
  	fetch = +refs/heads/*:refs/remotes/arm-soc/*
  [branch "lr/olpc-xo175-fixes5-ec"]
  	remote = xo
  	merge = refs/heads/lr/olpc-xo175-fixes5-ec
  [branch "lr/olpc-xo175-fixes7-ec"]
  	remote = xo
  	merge = refs/heads/lr/olpc-xo175-fixes7-ec
  [branch "lr/olpc-xo175-fixes7-battery"]
  	remote = xo
  	merge = refs/heads/lr/olpc-xo175-fixes7-battery
  [branch "lr/olpc-xo175-fixes4-mmp-camera"]
  	remote = xo
  	merge = refs/heads/lr/olpc-xo175-fixes4-mmp-camera
  [branch "lr/olpc-xo175-fixes6"]
  	remote = xo
  	merge = refs/heads/lr/olpc-xo175-fixes6
  [branch "lr/olpc-xo175-fixes1-drm"]
  	remote = xo
  	merge = refs/heads/lr/olpc-xo175-fixes1-drm
  [branch "lr/olpc-xo175-fixes1-drm-dt"]
  	remote = xo
  	merge = refs/heads/lr/olpc-xo175-fixes1-drm-dt
  [branch "lr/olpc-xo175-fixes2-drm"]
  	remote = xo
  	merge = refs/heads/lr/olpc-xo175-fixes2-drm
  [remote "net"]
  	url = git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git
  	fetch = +refs/heads/*:refs/remotes/net/*
  [remote "net-next"]
  	url = git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git
  	fetch = +refs/heads/*:refs/remotes/net-next/*
  #[remote "olpc-wifi"]
  #	url = git://dev.laptop.org/users/javier/wireless-testing
  #	fetch = +refs/heads/*:refs/remotes/olpc-wifi/*
  [remote "arm"]
  	url = git://git.armlinux.org.uk/~rmk/linux-arm.git
  	fetch = +refs/heads/*:refs/remotes/arm/*
  [branch "lr/olpc-xo175-fixes3-drm"]
  	remote = xo
  	merge = refs/heads/lr/olpc-xo175-fixes3-drm
  [remote "tip"]
  	url = git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
  	fetch = +refs/heads/*:refs/remotes/tip/*
  [remote "irqchip"]
  	url = git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git
  	fetch = +refs/heads/*:refs/remotes/irqchip/*
  [branch "lr/olpc-xo175-fixes6-next"]
  	remote = xo
  	merge = refs/heads/lr/olpc-xo175-fixes6-next
  [remote "gpio"]
  	url = git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
  	fetch = +refs/heads/*:refs/remotes/gpio/*
  [branch "lr/olpc-xo175-fixes8-battery"]
  	remote = xo
  	merge = refs/heads/lr/olpc-xo175-fixes8-battery
  [remote "dvhart"]
  	url = https://github.com/dvhart/linux-pdx86.git
  	fetch = +refs/heads/*:refs/remotes/dvhart/*
  [remote "power-supply"]
  	url = git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git
  	fetch = +refs/heads/*:refs/remotes/power-supply/*
  [branch "lr/olpc-xo175-battery-v6"]
  	remote = xo
  	merge = refs/heads/lr/olpc-xo175-battery-v6
  [branch "lr/olpc-xo175-fixes2-drm-dt"]
  	remote = xo
  	merge = refs/heads/lr/olpc-xo175-fixes2-drm-dt
  [branch "lr/olpc-xo175-fixes4-drm"]
  	remote = xo
  	merge = refs/heads/lr/olpc-xo175-fixes4-drm
  [branch "olpc-5.0"]
  	remote = xo
  	merge = refs/heads/olpc-5.0
  [branch "lr/olpc-xo175-fixes8-ec"]
  	remote = xo
  	merge = refs/heads/lr/olpc-xo175-fixes8-ec
  [branch "lr/olpc-xo175-drm-dt-v3"]
  	remote = xo
  	merge = refs/heads/lr/olpc-xo175-drm-dt-v3
  [branch "lr/olpc-xo175-mmp-camera-v5"]
  	remote = xo
  	merge = refs/heads/lr/olpc-xo175-mmp-camera-v5
  [branch "lr/olpc-xo175-drm-dt-v4"]
  	remote = xo
  	merge = refs/heads/lr/olpc-xo175-drm-dt-v4
  [branch "lr/olpc-xo175-ec-v6"]
  	remote = xo
  	merge = refs/heads/lr/olpc-xo175-ec-v6
  [branch "lr/olpc-xo175-ec-v7"]
  	remote = xo
  	merge = refs/heads/lr/olpc-xo175-ec-v7
  [branch "lr/olpc-xo175-galcore-v1"]
  	remote = xo
  	merge = refs/heads/lr/olpc-xo175-galcore-v1
  [branch "lr/mmp3-1"]
  	remote = xo
  	merge = refs/heads/lr/mmp3-1
  [branch "lr/mmp3-2"]
  	remote = xo
  	merge = refs/heads/lr/mmp3-2
  [branch "lr/mmp3-4"]
  	remote = xo
  	merge = refs/heads/lr/mmp3-4
  [branch "lr/ch7033"]
  	remote = xo
  	merge = refs/heads/lr/ch7033
  [branch "lr/ch7033-1"]
  	remote = xo
  	merge = refs/heads/lr/ch7033-1
  [branch "lr/w000000t"]
  	remote = xo
  	merge = refs/heads/lr/w000000t
  [branch "lr/ariel"]
  	remote = xo
  	merge = refs/heads/lr/ariel
  [remote "mmp"]
  	url = git://git.kernel.org/pub/scm/linux/kernel/git/lkundrak/linux-mmp
  	pushurl = git@gitolite.kernel.org:pub/scm/linux/kernel/git/lkundrak/linux-mmp
  	fetch = +refs/heads/*:refs/remotes/mmp/*
  [branch "lr/mmp3-hsic"]
  	remote = xo
  	merge = refs/heads/lr/mmp3-hsic
  [branch "lr/mmp3-hsic-v2"]
  	remote = xo
  	merge = refs/heads/lr/mmp3-hsic-v2
  [branch "lr/mmp2-galcore-v1"]
  	remote = xo
  	merge = refs/heads/lr/olpc-xo175-galcore-v1
  [remote "usb"]
  	url = git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
  	fetch = +refs/heads/*:refs/remotes/usb/*
  [remote "pinchartl"]
  	url = git://linuxtv.org/pinchartl/media.git
  	fetch = +refs/heads/*:refs/remotes/pinchartl/*
  [remote "drm"]
  	url = git://anongit.freedesktop.org/drm/drm
  	fetch = +refs/heads/*:refs/remotes/drm/*
  [branch "lr/marvell-dt-validation-v2"]
  	remote = xo
  	merge = refs/heads/lr/marvell-dt-validation-v2
  [branch "lr/mmp3-thermal-v1"]
  	remote = xo
  	merge = refs/heads/lr/mmp3-thermal-v1
  [remote "clk"]
  	url = git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
  	fetch = +refs/heads/*:refs/remotes/clk/*
  [remote "drm-misc"]
  	url = git://anongit.freedesktop.org/drm/drm-misc
  	fetch = +refs/heads/*:refs/remotes/drm-misc/*

Thank you
Lubo
