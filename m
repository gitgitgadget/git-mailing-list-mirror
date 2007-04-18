From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Wed, 18 Apr 2007 08:02:45 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0704180748460.2828@woody.linux-foundation.org>
References: <200704171041.46176.andyparkins@gmail.com> <"200704171803.58940.a
 n  dyparkins"@gmail.com> <200704172012.31280.andyparkins@gmail.com>
 <alpine.LFD.0.98.0704171530220.4504@xanadu.home>
 <Pine.LNX.4.63.0704171244450.1696@qynat.qvtvafvgr.pbz>
 <alpine.LFD.0.98.0704171624190.4504@xanadu.home>
 <Pine.LNX.4.63.0704171302200.1696@qynat.qvtvafvgr.pbz>
 <alpine.LFD.0.98.0704171708360.4504@xanadu.home>
 <4625B99D.9090409@dawes.za.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	David Lang <david.lang@digitalinsight.com>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: Rogan Dawes <lists@dawes.za.net>
X-From: git-owner@vger.kernel.org Wed Apr 18 17:03:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeBgh-00058r-PW
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 17:03:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992705AbXDRPDM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 11:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992714AbXDRPDM
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 11:03:12 -0400
Received: from smtp.osdl.org ([65.172.181.24]:34945 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992705AbXDRPDL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 11:03:11 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3IF2kYC017122
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 18 Apr 2007 08:02:46 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3IF2jAb026589;
	Wed, 18 Apr 2007 08:02:45 -0700
In-Reply-To: <4625B99D.9090409@dawes.za.net>
X-Spam-Status: No, hits=-0.964 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44896>



On Wed, 18 Apr 2007, Rogan Dawes wrote:
> 
> Or similarly, when checking an "ODF" file in, the attribute would lead to an
> appropriate script creating the "tree" of individual files.
> 
> Does this sound workable?

I think it sounds very interesting, and I'd much rather do _those_ kinds 
of rewrites than keyword unexpansion. And yes, some kind of generic 
support for rewriting might give people effectively the keywords they want 
(I think the CVS semantics are not likely to be logical, but people can 
probably do something that works for them), and at that point maybe the 
keyword discussion goes away too.

However, I don't know if it is "workable".

The thing is, it's easy enough (although potentially _very_ expensive) to 
run some per-file script at each commit and at each checkout. But there 
are some fundamental operations that are even more common:

 - checking for "file changed", aka the "git status" kind of thing

   Anything we do would have to follow the same "stat" rules, at a 
   minimum. You can *not* afford to have to check the file manually.

   So especially if you combine several pieces into one, or split one file 
   into several pieces, your index would have to contain the entry 
   that matches the _filesystem_ (because that's what the index is all 
   about), but then the *tree* would contain the pieces (or the single 
   entry that matches several filesystem entries).

 - what about diffs (once the stat information says something has 
   potentially changed)? You'd have to script those too, and it really 
   sounds like some very basic operations get a _lot_ more expensive and 
   complex.

   This is also related to the above: one of the most fundamental diffs is 
   the diff of the index and a tree - so if the index matches the 
   "filesystem state" and the trees contain some "combined entry" or 
   "split entry", you'd have to teach some very core diff functionality 
   about that kind of mapping.

In other words, I think it's too complicated. Not necessarily impossible, 
but likely harder and more complex than it's really worth.

Having a 1:1 file mapping (like the CRLF<->LF object mapping is) is a lot 
easier. You just have to make sure that the index has the *stat* 
information from the filesystem, but the *sha1* identity information from 
the git internal format, and things automatically just fall out right. But 
if you have anything but a 1:1 relationship, it gets hugely more complex.

			Linus
