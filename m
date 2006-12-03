X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [RFC] Submodules in GIT
Date: Sun, 03 Dec 2006 23:16:30 +0100
Message-ID: <20061203221630.GA940MdfPADPa@greensroom.kotnet.org>
References: <20061130170625.GH18810@admingilde.org>
 <200612012306.41410.Josef.Weidendorfer@gmx.de>
 <Pine.LNX.4.64.0612011423100.3695@woody.osdl.org>
 <200612012355.03493.Josef.Weidendorfer@gmx.de>
 <Pine.LNX.4.64.0612011510290.3695@woody.osdl.org>
 <20061130170625.GH18810@admingilde.org> <4570AF8F.1000801@stephan-feder.de>
 <Pine.LNX.4.64.0612011505190.3695@woody.osdl.org>
 <200612020036.08826.Josef.Weidendorfer@gmx.de>
 <Pine.LNX.4.64.0612011540010.3695@woody.osdl.org>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Sun, 3 Dec 2006 22:16:49 +0000 (UTC)
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	sf <sf-gmane@stephan-feder.de>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>, sf <sf@b-i-t.de>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <Pine.LNX.4.64.0612011510290.3695@woody.osdl.org>
 <Pine.LNX.4.64.0612011540010.3695@woody.osdl.org>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33145>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gqzdb-0004tg-3B for gcvg-git@gmane.org; Sun, 03 Dec
 2006 23:16:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758397AbWLCWQk (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006
 17:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758532AbWLCWQk
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 17:16:40 -0500
Received: from smtp17.wxs.nl ([195.121.247.8]:482 "EHLO smtp17.wxs.nl") by
 vger.kernel.org with ESMTP id S1758397AbWLCWQj (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 17:16:39 -0500
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl
 [84.81.90.170]) by smtp17.wxs.nl (iPlanet Messaging Server 5.2 Patch 2 (built
 Jul 14 2004)) with SMTP id <0J9P00JCTXVIOZ@smtp17.wxs.nl> for
 git@vger.kernel.org; Sun, 03 Dec 2006 23:16:31 +0100 (CET)
Received: (qmail 14027 invoked by uid 500); Sun, 03 Dec 2006 22:16:30 +0000
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On Fri, Dec 01, 2006 at 04:12:10PM -0800, Linus Torvalds wrote:
> So within the supermodule, on a "git object" level, a submodule should 
> just be named by the SHA1 that was it's HEAD when it was committed within 
> the supermodule. So in the "tree object", you'd see something like the 
> following when you go "git ls-tree HEAD" on the superproject:
> 
> 	...
> 	100644 blob 08602f522183dc43787616f37cba9b8af4e3dade	xdiff-interface.c
> 	100644 blob 1346908bea31319aabeabdfd955e2ea9aab37456	xdiff-interface.h
> 	040000 tree 959dd5d97e665998eb26c764d3a889ae7903d9c2	xdiff
> 	050000 link 0215ffb08ce99e2bb59eca114a99499a4d06e704	xyzzy
> 
> where that 050000 is the new magic type (I picked one out of my *ss: it's 
> not a valid type for a file mode, so it's a godo choice, but it could be 
> anythign that cannot conflict with a real file), which just specifies the 
> "link" part. The SHA1 is the SHA1 of the commit, and the "xyzzy" is 
> obviously just the name within the directory of the submodule.
> 
> That's all that is actually required for a lot of git commands that 
> already expect all objects to be available (ie "git checkout", "git diff" 
> etc).

But is this object (and all the objects it points to) going to be
available (in the superproject) ?
The following seems to suggest that you think they shouldn't.
How is fsck-objects then going to check that such an object is
valid ?  Is it going to call fsck-objects recursively on the
(available) submodules ?

On Fri, Dec 01, 2006 at 03:30:32PM -0800, Linus Torvalds wrote:
> The only thing that a submodule must NOT be allowed to do on its own is 
> pruning (and it's distant cousin "git repack -d").

How are you going to enforce this if the submodule isn't supposed
to know that it is being used as a submodule ?

> You must always prune 
> from the supermodule, because the submodule cannot really know on its own 
> what references point into it.

How is one of the supermodules going to know what references from other
supermodules containing the submodule point into the submodule ?

