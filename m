From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Add note about IANA confirmation
Date: Mon, 12 Sep 2005 15:40:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509121523170.3266@g5.osdl.org>
References: <Pine.LNX.4.58.0509121057520.3242@g5.osdl.org>
 <7vk6hm7ymd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 13 00:42:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEwz7-0002nN-9O
	for gcvg-git@gmane.org; Tue, 13 Sep 2005 00:41:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbVILWlG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 18:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932321AbVILWlF
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 18:41:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44694 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932180AbVILWlE (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 18:41:04 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8CMf0Bo027438
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 12 Sep 2005 15:41:00 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8CMewj2025189;
	Mon, 12 Sep 2005 15:40:59 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk6hm7ymd.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8446>



On Mon, 12 Sep 2005, Junio C Hamano wrote:
> 
> I noticed one thing that is a bit curious.  Packing the same set
> of objects with --window=50 seems to give worse packing result
> (space-wise) than with --window=10, which is the default if I
> recall correctly.

The window doesn't seem to make much of a difference any more, now that we 
sort object blobs by filename. I suspect that it's just being unlucky: it 
finds a locally smaller diff and uses it, but then that ends up causing 
some other delta to _not_ be generated, because that would overflow the 
"--depth".

At least I _think_ that's the case. Maybe there's something really wrong 
in the window handling.

Generally, it's cheaper and more efficient to just increase the "depth"  
rather than the "window". Of course, that has a possibly very bad run-time
overhead at unpacking time, so increasing it too much is bad.

Quick test (maybe I did it right, maybe I didn't):

			window=10	window=50

	 depth=10	 57240724	 57411879
	 depth=50	 56700053	 56808913
	 depth=inf	 56603101	 56541663

ie "--window=50" is actually worse than "--window=10" for depths 10 and
50, but better for the "infinite" depth case (approximated by using
"--depth=50000" which is practically infinite, since I just packed the 
2.6.12 history with less than 50,000 objects ;)

Of course, the 2.6.12 tree is not a good pack object. Half the objects 
in that tree have no history at all. It's not clear that it's particularly 
representative of any real long-term history.

		Linus
