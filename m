From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 0/2] A new merge algorithm, take 3
Date: Thu, 8 Sep 2005 10:19:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509081012540.3208@g5.osdl.org>
References: <20050907164734.GA20198@c165.ib.student.liu.se>
 <7v1x407min.fsf@assigned-by-dhcp.cox.net> <431F34FF.5050301@citi.umich.edu>
 <7vvf1cz64l.fsf@assigned-by-dhcp.cox.net> <4320536D.2010706@citi.umich.edu>
 <7v7jdrwlih.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: cel@citi.umich.edu, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 08 19:22:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDQ4g-0002yp-4n
	for gcvg-git@gmane.org; Thu, 08 Sep 2005 19:20:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964899AbVIHRUT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Sep 2005 13:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbVIHRUT
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Sep 2005 13:20:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39367 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964899AbVIHRUR (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Sep 2005 13:20:17 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j88HK3Bo030760
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 8 Sep 2005 10:20:03 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j88HJvC7025964;
	Thu, 8 Sep 2005 10:20:00 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7jdrwlih.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8204>



On Thu, 8 Sep 2005, Junio C Hamano wrote:
> 
> Yes, the reading of three trees upfront is probably the culprit
> in your case

However, note that _most_ tree reading just reads one.

Merges may take half a second, and yes, when I did it, the fact that we 
move things around in the array is by far the highest cost. But the thing 
is, if merges take half a second, that's still not only damn good, it's 
not even the most common operation.

Yes, the active_cache[] layout as one big array is inconvenient for 
read_tree(), which tends to want to interleave different trees in the 
array and thus forces things to be moved around.

But remember what the most common use for the index is - it's the "single 
tree" case from read_cache(). That's _so_ much more common than 
read_tree() that it's not even funny.

So the data structure is optimized for a different case than reading in 
trees. Big deal. That optimization is definitely worth it: it allows us to 
do the read_cache() with the actual index entries being totally read-only 
(a linked list would have to add a "next" pointer to the cache entries and 
not allow the in-place thing that read_cache() does).

		Linus
