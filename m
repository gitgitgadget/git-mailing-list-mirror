From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: How git affects kernel.org performance
Date: Sun, 7 Jan 2007 10:49:43 -0800
Organization: Oracle Linux Eng.
Message-ID: <20070107104943.ee2c5e6f.randy.dunlap@oracle.com>
References: <458434B0.4090506@oracle.com>
	<1166297434.26330.34.camel@localhost.localdomain>
	<1166304080.13548.8.camel@nigel.suspend2.net>
	<459152B1.9040106@zytor.com>
	<1168140954.2153.1.camel@nigel.suspend2.net>
	<45A08269.4050504@zytor.com>
	<45A083F2.5000000@zytor.com>
	<Pine.LNX.4.64.0701062130260.3661@woody.osdl.org>
	<20070107085526.GR24090@1wt.eu>
	<45A0B63E.2020803@zytor.com>
	<20070107090336.GA7741@1wt.eu>
	<Pine.LNX.4.61.0701071141580.4365@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Willy Tarreau <w@1wt.eu>, "H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	nigel@nigel.suspend2.net, "J.H." <warthog9@kernel.org>,
	Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>,
	webmaster@kernel.org
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964919AbXAGSw3@vger.kernel.org Sun Jan 07 19:53:04 2007
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964919AbXAGSw3@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3d8a-0000Qv-D1
	for glk-linux-kernel-3@gmane.org; Sun, 07 Jan 2007 19:52:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964919AbXAGSw3 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sun, 7 Jan 2007 13:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964921AbXAGSw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 13:52:29 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:32178 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964919AbXAGSw1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 13:52:27 -0500
Received: from rgmgw2.us.oracle.com (rgmgw2.us.oracle.com [138.1.186.111])
	by rgminet01.oracle.com (Switch-3.2.4/Switch-3.1.6) with ESMTP id l07Ip1Zf019698;
	Sun, 7 Jan 2007 11:51:01 -0700
Received: from rcsmt251.oracle.com (rcsmt251.oracle.com [148.87.90.196])
	by rgmgw2.us.oracle.com (Switch-3.2.4/Switch-3.1.7) with ESMTP id l07Ip0Nk029691;
	Sun, 7 Jan 2007 11:51:00 -0700
Received: from pool-71-245-99-70.ptldor.fios.verizon.net by rcsmt252.oracle.com
	with ESMTP id 2344124011168195771; Sun, 07 Jan 2007 11:49:31 -0700
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
In-Reply-To: <Pine.LNX.4.61.0701071141580.4365@yvahk01.tjqt.qr>
X-Mailer: Sylpheed 2.3.0 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36183>

On Sun, 7 Jan 2007 11:50:57 +0100 (MET) Jan Engelhardt wrote:

> 
> On Jan 7 2007 10:03, Willy Tarreau wrote:
> >On Sun, Jan 07, 2007 at 12:58:38AM -0800, H. Peter Anvin wrote:
> >> >[..]
> >> >entries in directories with millions of files on disk. I'm not
> >> >certain it would be that easy to try other filesystems on
> >> >kernel.org though :-/
> >> 
> >> Changing filesystems would mean about a week of downtime for a server. 
> >> It's painful, but it's doable; however, if we get a traffic spike during 
> >> that time it'll hurt like hell.
> 
> Then make sure noone releases a kernel ;-)

maybe the week of LCA ?

> >> However, if there is credible reasons to believe XFS will help, I'd be 
> >> inclined to try it out.
> >
> >Hmmm I'm thinking about something very dirty : would it be possible
> >to reduce the current FS size to get more space to create another
> >FS ? Supposing you create a XX GB/TB XFS after the current ext3,
> >you would be able to mount it in some directories with --bind and
> >slowly switch some parts to it. The problem with this approach is
> >that it will never be 100% converted, but as an experiment it might
> >be worth it, no ?
> 
> Much better: rsync from /oldfs to /newfs, stop all ftp uploads, rsync
> again to catch any new files that have been added until the ftp
> upload was closed, then do _one_ (technically two) mountpoint moves
> (as opposed to Willy's idea of "some directories") in a mere second
> along the lines of
> 
>   mount --move /oldfs /older; mount --move /newfs /oldfs.
> 
> let old transfers that still use files in /older complete (lsof or
> fuser -m), then disconnect the old volume. In case /newfs (now
> /oldfs) is a volume you borrowed from someone and need to return it,
> well, I guess you need to rsync back somehow.

---
~Randy
