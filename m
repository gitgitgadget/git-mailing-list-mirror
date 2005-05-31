From: Linus Torvalds <torvalds@osdl.org>
Subject: git-rev-list: proper lazy reachability
Date: Mon, 30 May 2005 18:58:37 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505301847120.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue May 31 03:54:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcvxG-0006JR-Bz
	for gcvg-git@gmane.org; Tue, 31 May 2005 03:54:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261736AbVEaB4j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 May 2005 21:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261791AbVEaB4j
	(ORCPT <rfc822;git-outgoing>); Mon, 30 May 2005 21:56:39 -0400
Received: from fire.osdl.org ([65.172.181.4]:22197 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261736AbVEaB4e (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2005 21:56:34 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4V1uXjA014371
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <git@vger.kernel.org>; Mon, 30 May 2005 18:56:33 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4V1uWZh027049
	for <git@vger.kernel.org>; Mon, 30 May 2005 18:56:32 -0700
To: Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Ok, I just made git-rev-list DTRT when you pass it a "beginning" and 
"end", ie it does proper reachability analysis _without_ parsing the whole 
set of commits. 

It's probably buggy, so don't get too excited, but it seems to give the 
right results for something like

	git-rev-list v2.6.12-rc5 v2.6.12-rc4

which is basically "give me a rev-list of everything that is in rc5 but is 
not in rc4".

So now "git-rev-list a b" should be equivalent to "git-rev-tree a ^b", 
except it's faster, and it doesn't print out anything else.

Because it doesn't need to go all the way back to the root (only far 
enough back to be able to determine that there can be no more unreachable 
entries), it should be constant-time in the total history size. Doesn't 
matter if you've got a million revisions, if you asked for the difference 
between two "close" ones, it will be fast.

Somebody should probably take a look at my simplistic algorithm, since it 
can probably be improved upon and/or fixed for corner-cases.

		Linus
