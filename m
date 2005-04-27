From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] Set AUTHOR_DATE in git-tools
Date: Tue, 26 Apr 2005 20:52:06 -0700
Message-ID: <20050427035206.GA27615@kroah.com>
References: <1114068737.29135.17.camel@localhost.localdomain> <20050426184442.GA20536@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: torvalds@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 05:48:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQdWC-0006MS-Ot
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 05:47:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261903AbVD0Dwe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 23:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261904AbVD0Dwe
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 23:52:34 -0400
Received: from mail.kroah.org ([69.55.234.183]:5344 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261903AbVD0Dwb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 23:52:31 -0400
Received: from [192.168.0.10] (c-24-22-118-199.hsd1.or.comcast.net [24.22.118.199])
	(authenticated)
	by perch.kroah.org (8.11.6/8.11.6) with ESMTP id j3R3qNi05364;
	Tue, 26 Apr 2005 20:52:23 -0700
Received: from greg by echidna.kroah.org with local (masqmail 0.2.19)
 id 1DQdao-7C0-00; Tue, 26 Apr 2005 20:52:06 -0700
To: David Woodhouse <dwmw2@infradead.org>
Content-Disposition: inline
In-Reply-To: <20050426184442.GA20536@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 26, 2005 at 11:44:42AM -0700, Greg KH wrote:
> On Thu, Apr 21, 2005 at 05:32:16PM +1000, David Woodhouse wrote:
> > Entirely untested.
> 
> Doesn't work :(

I take it back, it works just fine... 

My problem was that bk generates dates with a non-rfc compliant timezone
string.  And I was trying to apply patches exported from bk in plain
text format (building a udev git tree...)  The patch below to
commit-tree.c fixes this issue, if anyone runs into this same issue (I
wouldn't recommend it to be applied, as it's probably a one-off
issue...)

thanks,

greg k-h
--------------
Allow commit-tree to handle the bk date format.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


--- a/commit-tree.c	2005-04-25 22:08:49.000000000 -0700
+++ b/commit-tree.c	2005-04-26 20:46:37.000000000 -0700
@@ -204,6 +204,12 @@
 	else
 	       return;
 
+	/* Handle messed up bk dates */
+	if (p[3] == ':') {
+		p[3] = p[4];
+		p[4] = p[5];
+		p[5] = p[6];
+	}
 	if (!isdigit(p[1]) || !isdigit(p[2]) || !isdigit(p[3]) || !isdigit(p[4]))
 		return;
 
