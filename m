From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Slow fetches of tags
Date: Thu, 25 May 2006 14:12:41 +0100
Message-ID: <20060525131241.GA8443@linux-mips.org>
References: <20060524131022.GA11449@linux-mips.org> <Pine.LNX.4.64.0605240931480.5623@g5.osdl.org> <Pine.LNX.4.64.0605240947580.5623@g5.osdl.org> <7v64jv8fdx.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605241200110.5623@g5.osdl.org> <Pine.LNX.4.64.0605241641250.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 25 15:13:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjFdx-0000fI-FQ
	for gcvg-git@gmane.org; Thu, 25 May 2006 15:12:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965167AbWEYNMq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 09:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965168AbWEYNMq
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 09:12:46 -0400
Received: from ftp.linux-mips.org ([194.74.144.162]:27536 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S965167AbWEYNMq
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 May 2006 09:12:46 -0400
Received: from localhost.localdomain ([127.0.0.1]:59856 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8134082AbWEYNMn (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 May 2006 15:12:43 +0200
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k4PDCgG4030473;
	Thu, 25 May 2006 14:12:42 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k4PDCfNf030472;
	Thu, 25 May 2006 14:12:41 +0100
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605241641250.5623@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20737>

On Wed, May 24, 2006 at 04:43:02PM -0700, Linus Torvalds wrote:

> Actually, maybe the problem is that Ralf's tree has two roots, because of 
> the old CVS history. It might be following the other root down for the 
> "have" part, since that one doesn't exist at all in the target and the 
> other side will never acknowledge any of it. 
> 
> I'll play with it.

Interesting idea, so I went to play with it, too.  I took a copy of the
tree and deleted all branches except the v2.6.16-stable tracking branch
which I pruned back to v2.6.16.17, then added a new branch starting at
the oldest commit, your initial import of the kernel tree:

$ git branch junk 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2
$ git checkout junk
$ seq -f "%05.0f" 1 100 | while read i; do echo $i; echo $i > Makefile;\
  git commit -s -m "Blah $i" Makefile; done

So with this I get:

$ git branch
* junk
  v2.6.16-stable
$

If I now run

$ strace git-fetch-pack --thin git://www.kernel.org/pub/scm/linux/kernel/\
	git/stable/linux-2.6.16.y.git \
	refs/heads/master refs/tags/v2.6.16.18 2>&1 | grep have /tmp/xxx

I get:

write(3, "0032have ef686028603c291ba510c66"..., 50) = 50
write(3, "0032have 150384dac99eb263c4385c7"..., 50) = 50
write(3, "0032have 4df3afbfc2d8f6c22d41c63"..., 50) = 50
...
write(3, "0032have db119fba3d9495aa9cd5a63"..., 50) = 50

Where ef686028603c291ba510c66 = junk, 150384dac99eb263c4385c7 = junk~1 ...
db119fba3d9495aa9cd5a63 = junk~99 (first commit on the junk branch).
100 "have" lines upto this point, then:

write(3, "0032have d87319c3e4d908e157a462d"..., 50) = 50
write(3, "0032have 22ddf44d54d0b2326f7b233"..., 50) = 50
write(3, "0032have 90a03936acb1c3400a5833c"..., 50) = 50
write(3, "0032have bf7d8bacaaf241a0f015798"..., 50) = 50
write(3, "0032have a120571fbdfc8f543eea642"..., 50) = 50
write(3, "0032have 42a46c74c4520174b82a60a"..., 50) = 50
write(3, "0032have f66ab685594d49e570b2176"..., 50) = 50
write(3, "0032have 834f514019e01f87657a257"..., 50) = 50
write(3, "0032have 9d395d1961a0eeb9e8b1ef2"..., 50) = 50
write(3, "0032have aa48603d1ba772d0a2b28ab"..., 50) = 50
write(3, "0032have 54e5705fd460c7621a4d73c"..., 50) = 50
write(3, "0032have 37863c8a9b7b0261ec76daa"..., 50) = 50
write(3, "0032have a7603f9099869f9aeebd6c7"..., 50) = 50
write(3, "0032have 623c30d2ae22cd4b8703c77"..., 50) = 50
write(3, "0032have e2c78fb27dd13ab8c778a96"..., 50) = 50
write(3, "0032have dbb676d1214c181e6cde4ce"..., 50) = 50
write(3, "0032have 1ffe5e06461f72b9b6a2569"..., 50) = 50

These are the commits for which this test tree has the tags left:

$ ls .git/refs/tags/
v2.6.16.1   v2.6.16.12  v2.6.16.15  v2.6.16.2  v2.6.16.5  v2.6.16.8
v2.6.16.10  v2.6.16.13  v2.6.16.16  v2.6.16.3  v2.6.16.6  v2.6.16.9
v2.6.16.11  v2.6.16.14  v2.6.16.17  v2.6.16.4  v2.6.16.7
$

And finally:

write(3, "0032have 1da177e4c3f41524e886b7f"..., 50) = 50

which is your Linux-2.6.12-rc2 import.

  Ralf
