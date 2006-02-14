From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: diffstat wierdness with 'git format-patch' output
Date: Tue, 14 Feb 2006 23:30:05 +0100
Message-ID: <20060214223005.GA12652@c165.ib.student.liu.se>
References: <20060214055425.GA32261@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 23:30:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F98gf-0001Yb-Mg
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 23:30:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422838AbWBNWaS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 17:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422840AbWBNWaS
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 17:30:18 -0500
Received: from [85.8.31.11] ([85.8.31.11]:2497 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1422838AbWBNWaR (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2006 17:30:17 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id BEE274102; Tue, 14 Feb 2006 23:44:19 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1F98gP-0003Yu-00; Tue, 14 Feb 2006 23:30:05 +0100
To: Greg KH <greg@kroah.com>
Content-Disposition: inline
In-Reply-To: <20060214055425.GA32261@kroah.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16187>

On Mon, Feb 13, 2006 at 09:54:25PM -0800, Greg KH wrote:
> I was trying to use the built-in git tools to send patches off, instead
> of my horribly hacked up scripts that use the git low-level stuff, when
> I noticed that git format-patch's output confuses diffstat a bit, and
> causes it to add another line to it's count.
> 
> This isn't good when I do a 'diffstat -p1 *.txt' of the output and add
> it to an email to send off for someone to pull from, as the result will
> be off from what is really there.
> 
> Here's what I get:
> 
>  $ git format-patch -n origin..HEAD
>  0001-USB-fix-up-the-usb-early-handoff-logic-for-EHCI.txt
>  0002-USB-add-new-device-ids-to-ldusb.txt
>  0003-USB-change-ldusb-s-experimental-state.txt
>  0004-USB-PL2303-Leadtek-9531-GPS-Mouse.txt
>  0005-USB-sl811_cs-needs-platform_device-conversion-too.txt
>  0006-usb-storage-new-unusual_devs-entry.txt
>  0007-usb-storage-unusual_devs-entry.txt
>  0008-USB-unusual_devs.h-entry-TrekStor-i.Beat.txt
>  0009-USB-unusual_devs.h-entry-iAUDIO-M5.txt
>  0010-USB-unusual-devs-bugfix.txt
> 
>  $ git log | head -n 1
>  commit 16f05be7be0bf121491d83bd97337fe179b3b323
> 
>  $ git show 16f05be7be0bf121491d83bd97337fe179b3b323 | diffstat -p1
>   drivers/usb/storage/unusual_devs.h |   25 ++++++++++++++++++-------
>   1 file changed, 18 insertions(+), 7 deletions(-)
> 
>  $ diffstat -p1 0010-USB-unusual-devs-bugfix.txt
>   drivers/usb/storage/unusual_devs.h |   26 ++++++++++++++++++--------
>   1 file changed, 18 insertions(+), 8 deletions(-)
> 
> Any thoughts?
> 

If you don't have to generate the diffstat from the individual patches
then

    git-diff-tree -p origin HEAD | git-apply --stat

should give you what you want.


BTW when I tried the above command on two random tags in the git tree
I got:

    $ git-diff-tree -p v1.2.0 v1.0.8 | diffstat -p1 | tail -1
    165 files changed, 3913 insertions(+), 8092 deletions(-)

and

    $ git-diff-tree -p v1.2.0 v1.0.8 | git apply --stat | tail -1
    160 files changed, 3925 insertions(+), 8092 deletions(-)

The difference seems to be caused by diffstat which seems to think
that all lines starting with '---' are diff headers. Hence, there are
some bogus files in the diffstat output such as:

    [master]                                          |  177 ++
    [master^2~4]                                      |    9 
    [master^]                                         |   24 
    [mybranch]                                        |   56 
    [mybranch^]                                       |  616 +++++++

- Fredrik
