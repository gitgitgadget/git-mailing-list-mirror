Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCB3F20195
	for <e@80x24.org>; Wed, 20 Jul 2016 03:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753227AbcGTDCa (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 23:02:30 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:43284 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753202AbcGTDC1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 23:02:27 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5646B20195;
	Wed, 20 Jul 2016 03:02:26 +0000 (UTC)
Date:	Wed, 20 Jul 2016 03:02:26 +0000
From:	Eric Wong <e@80x24.org>
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Stefan Beller <sbeller@google.com>,
	David Turner <novalis@novalis.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: t7063 failure on FreeBSD 10.3 i386/amd64
Message-ID: <20160720030226.GA7112@whir>
References: <20160718223038.GA66056@plume>
 <20160718225424.GA813@plume>
 <CACsJy8CRHsyT8YLPYoHZnxCuMvF1W=S5iayy2eoHZhbSe_qmDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8CRHsyT8YLPYoHZnxCuMvF1W=S5iayy2eoHZhbSe_qmDg@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Jul 19, 2016 at 12:54 AM, Eric Wong <e@80x24.org> wrote:
> > Oops, forgot to Cc some folks who worked on this :x
> >
> > Filesystem is ufs and it fails regardless of whether
> > soft-updates is enabled or not.
> 
> Nothing stands out to my eyes, so I'm going to install freebsd this
> weekend. I hope ufs does not have any nasty surprise for me. Stay
> tuned.

Thanks, this problem might be ufs-specific, tmpfs is fine.
Tested tmpfs with:

	kldload tmpfs
	mkdir /tmp/tmpfs
	mount -t tmpfs tmpfs /tmp/tmpfs

(Documenting all this since much of this is new to me)

I noticed FreeBSD now provides ready-to-run VM images along with
normal installation stuff, including qcow2 ones for QEMU users,
so that saves some time.

http://ftp.freebsd.org/pub/FreeBSD/releases/VM-IMAGES/10.3-RELEASE/amd64/Latest/FreeBSD-10.3-RELEASE-amd64.qcow2.xz

Notes:

* "-net user" because I'm lazy (ICMP ping won't work out-of-the-box)

* kvm can be substituted for qemu-system-$ARCH for the KVM-less
  or users lacking write access to /dev/kvm

* hostfwd=... allows me to ssh into port 22215 from my Linux host
  to hit port 22 in the guest

* "dhclient vtnet0 && pkg install git gettext gmake python libiconv"
  should be enough to get started

kvm -smp 8 -m 2048 \
	-drive if=virtio,file=FreeBSD-10.3-RELEASE-amd64.qcow2 \
	-net nic,model=virtio \
	-net user,hostfwd=tcp:127.0.0.1:22215-:22 \
	-display curses
