From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: How git affects kernel.org performance
Date: Sun, 7 Jan 2007 11:50:57 +0100 (MET)
Message-ID: <Pine.LNX.4.61.0701071141580.4365@yvahk01.tjqt.qr>
References: <458434B0.4090506@oracle.com> <1166297434.26330.34.camel@localhost.localdomain>
 <1166304080.13548.8.camel@nigel.suspend2.net> <459152B1.9040106@zytor.com>
 <1168140954.2153.1.camel@nigel.suspend2.net> <45A08269.4050504@zytor.com>
 <45A083F2.5000000@zytor.com> <Pine.LNX.4.64.0701062130260.3661@woody.osdl.org>
 <20070107085526.GR24090@1wt.eu> <45A0B63E.2020803@zytor.com>
 <20070107090336.GA7741@1wt.eu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	nigel@nigel.suspend2.net, "J.H." <warthog9@kernel.org>,
	Randy Dunlap <randy.dunlap@oracle.com>,
	Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>,
	webmaster@kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 07 12:05:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3VqM-0006uO-Gb
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 12:05:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932501AbXAGLFY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 06:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932500AbXAGLFY
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 06:05:24 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:36246 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932499AbXAGLFU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 06:05:20 -0500
Received: from linux01.gwdg.de ([134.76.13.21])
	by mailer.gwdg.de with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.63)
	(envelope-from <jengelh@linux01.gwdg.de>)
	id 1H3VpW-0006WL-6m; Sun, 07 Jan 2007 12:04:47 +0100
Received: from linux01.gwdg.de (localhost [127.0.0.1])
	by linux01.gwdg.de (8.13.3/8.13.3/SuSE Linux 0.7) with ESMTP id l07Aov24006652;
	Sun, 7 Jan 2007 11:50:59 +0100
Received: from localhost (jengelh@localhost)
	by linux01.gwdg.de (8.13.3/8.13.3/Submit) with ESMTP id l07AovOe006646;
	Sun, 7 Jan 2007 11:50:57 +0100
To: Willy Tarreau <w@1wt.eu>
In-Reply-To: <20070107090336.GA7741@1wt.eu>
X-Spam-Level: /
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
X-Virus-Scanned: (clean) by exiscan+sophie
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36153>


On Jan 7 2007 10:03, Willy Tarreau wrote:
>On Sun, Jan 07, 2007 at 12:58:38AM -0800, H. Peter Anvin wrote:
>> >[..]
>> >entries in directories with millions of files on disk. I'm not
>> >certain it would be that easy to try other filesystems on
>> >kernel.org though :-/
>> 
>> Changing filesystems would mean about a week of downtime for a server. 
>> It's painful, but it's doable; however, if we get a traffic spike during 
>> that time it'll hurt like hell.

Then make sure noone releases a kernel ;-)

>> However, if there is credible reasons to believe XFS will help, I'd be 
>> inclined to try it out.
>
>Hmmm I'm thinking about something very dirty : would it be possible
>to reduce the current FS size to get more space to create another
>FS ? Supposing you create a XX GB/TB XFS after the current ext3,
>you would be able to mount it in some directories with --bind and
>slowly switch some parts to it. The problem with this approach is
>that it will never be 100% converted, but as an experiment it might
>be worth it, no ?

Much better: rsync from /oldfs to /newfs, stop all ftp uploads, rsync
again to catch any new files that have been added until the ftp
upload was closed, then do _one_ (technically two) mountpoint moves
(as opposed to Willy's idea of "some directories") in a mere second
along the lines of

  mount --move /oldfs /older; mount --move /newfs /oldfs.

let old transfers that still use files in /older complete (lsof or
fuser -m), then disconnect the old volume. In case /newfs (now
/oldfs) is a volume you borrowed from someone and need to return it,
well, I guess you need to rsync back somehow.


	-`J'
-- 
