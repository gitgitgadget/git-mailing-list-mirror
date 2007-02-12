From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Efficiency of initial clone from server
Date: Mon, 12 Feb 2007 12:04:03 -0500
Message-ID: <20070212170403.GA29621@spearce.org>
References: <7vd54gau3r.fsf@assigned-by-dhcp.cox.net> <9e4733910702112029k6ef3fb7bl3bdb134a787512e8@mail.gmail.com> <7v4ppsatbr.fsf@assigned-by-dhcp.cox.net> <9e4733910702112053q2c196ddcr970a062281d332b7@mail.gmail.com> <9e4733910702112101h256b1468j5de65c6e89109a22@mail.gmail.com> <7vzm7k9c3c.fsf@assigned-by-dhcp.cox.net> <9e4733910702112155m3f5da9abgbeb2b6783005296f@mail.gmail.com> <7vr6svaowm.fsf@assigned-by-dhcp.cox.net> <9e4733910702120724y2a0ba6b0h3f571aa2306872a5@mail.gmail.com> <9e4733910702120840p3fd2a18ar2e3b91564556dc43@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 12 18:05:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGecB-0005WD-Un
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 18:05:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964970AbXBLRER (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 12:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964971AbXBLRER
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 12:04:17 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:57905 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964983AbXBLREP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 12:04:15 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HGeat-0005sY-Dn; Mon, 12 Feb 2007 12:03:59 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7CBF920FBAE; Mon, 12 Feb 2007 12:04:03 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <9e4733910702120840p3fd2a18ar2e3b91564556dc43@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39415>

Jon Smirl <jonsmirl@gmail.com> wrote:
> On 2/12/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> >On 2/12/07, Junio C Hamano <junkio@cox.net> wrote:
> >> Time to learn to use --reference perhaps?
> >>
> >>         git clone --reference linux-2.6 
> >git://.../linville/wireless-dev.git
> >>
> >> where "linux-2.6" is local repository which is my personal copy
> >> of Linus's repo.
> 
> Does this use hard links so that if I whack my linux-2.6 it won't also
> destroy my wireless-dev repo?

No.  It uses a Git specific 'symlink workalike'.  We record
the path to the reference repository in the plain text file

  .git/objects/info/alternates

This file can list multiple repositories that this repository borrows
objects from.  If you delete any of those, then this repository
will likely lose access to objects it thinks should be here,
thereby totally screwing this repository.

There's also some risk with repacking or pruneing the reference
source (your linux-2.6 repository) as that repository doesn't know
what objects it has which it itself doesn't need, but which are in
use by the other repositories.


The easiest way to prevent this from destroying a repository later
on is to make your shiny new wireless-dev clone standalone by
completely repacking it after creation (*without* -l !) :

  git repack -a -d
  rm .git/objects/info/alternates

Another solution is don't clone from the remote, but instead clone
locally then update the origin and refetch:

  git clone -l -n linux-2.6 wireless-dev
  cd wireless-dev
  git config remote.origin.url git://.../linville/wireless-dev.git
  git fetch

The initial clone will setup hardlinks, but also uses the wrong
origin URL.  Hence we have to change it just before we attempt to
fetch from wireless-dev.

-- 
Shawn.
