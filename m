From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: tree corrupted on disk quota full
Date: Thu, 11 Jan 2007 10:31:05 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701111023090.3594@woody.osdl.org>
References: <20070111125726.GJ1759@mellanox.co.il>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 19:32:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H54ie-00011Y-EL
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 19:32:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbXAKSbd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 13:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbXAKSbd
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 13:31:33 -0500
Received: from smtp.osdl.org ([65.172.181.24]:53383 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751371AbXAKSbc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 13:31:32 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0BIV6Wi032566
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 11 Jan 2007 10:31:09 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0BIV5OV031917;
	Thu, 11 Jan 2007 10:31:06 -0800
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
In-Reply-To: <20070111125726.GJ1759@mellanox.co.il>
X-Spam-Status: No, hits=-0.664 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.107__
X-MIMEDefang-Filter: osdl$Revision: 1.167 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36602>



On Thu, 11 Jan 2007, Michael S. Tsirkin wrote:
>
> I hit a quota limit on a disk my tree was on, but did not notice.
> Doing git pull on a tree seems to have corrupted it.
> Now I have:
> 
> $ git-fsck-objects
> error: 4d4d30be967d3284cbf59afd4fba6ab536e295f5: object not found
> error: c03590b581d51d5fa43adbef9415e935d0229412: object not found
> missing tree 10147d79b2418168d9433067b6439971bd4f1261
> broken link from  commit 322a6c93ad86d2a151dd97a4c6b0e014a4893437
>               to    tree 10147d79b2418168d9433067b6439971bd4f1261
> dangling commit 322a6c93ad86d2a151dd97a4c6b0e014a4893437
> 
> The tree can not be pulled into, or from.

That's nasty, but something as simple a "git reset --hard ORIG_HEAD" 
should fix it (of course, if the disk-full happened earlier, or you've 
done some other reset or something else that over-write your ORIG_HEAD, 
you'd need to find the most recent commit that wasn't broken).

The good news is that there's no way your old data got corrupted. You just 
need to _find_ it (and normally ORIG_HEAD points to it, so it's trivial to 
find).

The suggestion to use "HEAD~1" is *not* a good one, simply because the 
pull (if it was a fast-forward) will not have HEAD~1 as your previous 
head: it will depend on how many commits you pulled. If you had reflog 
enabled, a "HEAD@{1}" might have worked (or "HEAD@{2}" as you already did 
the "git reset").

That said, clearly something didn't check the error return of a write() 
call. Some of that got fixed up recently, so it might even be fixed in 
current git already.

The most likely case (for a pull) is "git-unpack-objects", I guess.

		Linus
