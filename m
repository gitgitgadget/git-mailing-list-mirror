From: Sean <seanlkml@sympatico.ca>
Subject: Re: On pathnames
Date: Thu, 24 Jan 2008 18:56:02 -0500
Message-ID: <BAYC1-PASMTP12CD8892FB04872736D9DEAE380@CEZ.ICE>
References: <34103945-2078-4983-B409-2D01EF071A8B@sb.org>
	<alpine.LFD.1.00.0801211846010.2957@woody.linux-foundation.org>
	<E3E4F5B3-1740-47E4-A432-C881830E2037@sb.org>
	<20080122133427.GB17804@mit.edu>
	<20080123000841.GA22704@mit.edu>
	<alpine.LFD.1.00.0801221625510.1741@woody.linux-foundation.org>
	<20080123013325.GB1320@mit.edu>
	<20080123064139.GC16297@glandium.org>
	<4697E0BA-7243-4C35-A384-0BD261EC21AF@sb.org>
	<20080123094052.GB6969@glandium.org>
	<20080123133802.GC7415@mit.edu>
	<alpine.LFD.1.00.0801230808440.1741@woody.linux-foundation.org>
	<98F90EB6-1930-4643-8C6C-CA11CB123BAA@sb.org>
	<alpine.LFD.1.00.0801230930390.1741@woody.linux-foundation.org>
	<7vprvr7x8h.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kevin Ballard <kevin@sb.org>, Theodore Tso <tytso@MIT.EDU>,
	Mike Hommey <mh@glandium.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 00:57:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIBwL-0000zU-BI
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 00:57:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751736AbYAXX4I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jan 2008 18:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751592AbYAXX4H
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 18:56:07 -0500
Received: from bay0-omc2-s16.bay0.hotmail.com ([65.54.246.152]:7115 "EHLO
	bay0-omc2-s16.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751061AbYAXX4F (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jan 2008 18:56:05 -0500
Received: from BAYC1-PASMTP12 ([65.54.191.185]) by bay0-omc2-s16.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 24 Jan 2008 15:56:05 -0800
X-Originating-IP: [74.15.76.104]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([74.15.76.104]) by bayc1-pasmtp12.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Thu, 24 Jan 2008 15:56:04 -0800
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with smtp (Exim 4.43)
	id 1JIBvG-0007Mr-Au; Thu, 24 Jan 2008 18:55:54 -0500
In-Reply-To: <7vprvr7x8h.fsf@gitster.siamese.dyndns.org>
X-Mailer: Sylpheed 2.4.7 (GTK+ 2.12.5; i686-pc-linux-gnu)
X-OriginalArrivalTime: 24 Jan 2008 23:56:04.0463 (UTC) FILETIME=[ADFCA7F0:01C85EE4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71670>

On Thu, 24 Jan 2008 13:02:54 -0800
Junio C Hamano <gitster@pobox.com> wrote:

> One bad issue during development is that we cannot sanely
> emulate case folding behaviour on non case-folding filesystems
> without wrapping open(2), lstat(2), and friends, because of the
> assumption we made above in (2) where we defined the term "case
> folding".  This means that the codepath to deal with case
> folding filesystems inevitably are harder to debug.

All true.  Though Linux support for creating and using HFS+ volumes
seems like it may be helpful.  Trying the test case patch[*] posted
by Mitch Tishmack showed the problem here.  The only slightly
strange thing was that there didn't seem to be an issue with the
gitweb/test/M=C3=A4rchen file after cloning to the HFS volume.

Sean.

[*]
$ dd bs=3D1M count=3D250 < /dev/zero > hfs_vol
  262144000 bytes (262 MB) copied, 6.12703 s, 42.8 MB/s

$ /sbin/mkfs.hfsplus -v Test -n c=3D4096,e=3D1024 hfs_vol
  Initialized hfs_vol as a 250 MB HFS Plus volume

$ mkdir hfs
$ sudo mount -t hfsplus -o loop hfs_vol hfs
$ sudo chmod a+rwx hfs
$ cd hfs
$ git clone ~/local/sources/git
  Initialized empty Git repository in ~/hfs/git/.git/
  49486 blocks

$ cd git
$ make
   ...

$ cd t
$ git apply ~/Mitch_Tishmack.patch
$ ./t0060-normalization.sh
  * FAIL 1: setup

	  touch a=CC=88 &&
	  git add a=CC=88 &&
	  git commit -m "initial"
	  git tag initial &&
	  git checkout -b topic &&
	  git mv a=CC=88 tmp &&
	  git mv tmp =C3=A4 &&
	  git commit -m "rename" &&
	  git checkout -f master
=09
  * FAIL 2: rename (silent normalization)
=09
	 git mv a=CC=88 =C3=A4 &&
	 git commit -m "rename"
=09
  * FAIL 3: merge (silent normalization)

	 git reset --hard initial &&
	 git merge topic
=09
  * failed 3 among 3 test(s)

Sean.
