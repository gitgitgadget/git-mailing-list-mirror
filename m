From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git rebase: unexpected conflict
Date: Wed, 7 Feb 2007 12:22:35 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702071214170.8424@woody.linux-foundation.org>
References: <20070204190519.GB29029@mellanox.co.il> <7vr6t17ohb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 07 21:22:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEtJg-0005WD-KF
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 21:22:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422765AbXBGUWx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 15:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422763AbXBGUWx
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 15:22:53 -0500
Received: from smtp.osdl.org ([65.172.181.24]:35068 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422765AbXBGUWx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 15:22:53 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l17KMadD017662
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 7 Feb 2007 12:22:37 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l17KMZ5k026117;
	Wed, 7 Feb 2007 12:22:36 -0800
In-Reply-To: <7vr6t17ohb.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.451 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.113__
X-MIMEDefang-Filter: osdl$Revision: 1.175 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38960>



On Wed, 7 Feb 2007, Junio C Hamano wrote:
> 
> That is because David Woodhouse has an evil merge at
> c45aa055c32b488fc3fd73c760df372b09acf69a.
> 
> Running "git show" on that commit would tell you the story.

It's not really "evil". It's just that our "--cc" strategy makes it look 
very odd. But if you then look at why it looks that odd, you can do:

	git diff 784f4d5..8dd851d drivers/mtd/nand/Kconfig

(those two sha1's are just the commits that got merged, as reported by 
"git show"), and you'll see what happened:

 - one branch added the MTD_NAND_CAFE entry
 - the other one had removed the MTD_NAND_AT91 entry
 - they were in the same location in the Kconfig file, so it was a real 
   data conflict
 - when David fixed it up, instead of just trivially selecting the config 
   entry that remained after the merge (MTD_NAND_CAFE), he *also* then 
   moved it to alphabetically the proper place in the file.

End result: doing a "git show" on the resulting commit does how something 
rather strange (the final result does indeed have lines that did not exist 
in *either* of the parents), but what it doesn't show is the cause of that 
strange thing, because that ended up being a non-conflict after the merge 
(ie remove the old entries from both files).

In general, the output of "--cc" for conflicting merges is really quite 
good, but it's can be a bit hard to read, and in cases like this, the 
"conflict" is shown in a way that doesn't exactly make the _original_ 
conflict obvious.

			Linus
