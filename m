From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 00/15] git-note: A mechanisim for providing free-form
 after-the-fact annotations on commits
Date: Mon, 28 May 2007 20:12:29 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705282008400.26602@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0705091406350.18541@iabervon.org>
 <200705281840.50814.johan@herland.net> <alpine.LFD.0.98.0705280957070.26602@woody.linux-foundation.org>
 <200705281948.27329.johan@herland.net> <7vwsysbrtg.fsf@assigned-by-dhcp.cox.net>
 <20070528213511.GB7044@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue May 29 05:13:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hss9C-0004Me-OQ
	for gcvg-git@gmane.org; Tue, 29 May 2007 05:13:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753247AbXE2DNP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 May 2007 23:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751638AbXE2DNP
	(ORCPT <rfc822;git-outgoing>); Mon, 28 May 2007 23:13:15 -0400
Received: from smtp1.linux-foundation.org ([207.189.120.13]:46213 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751436AbXE2DNP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 May 2007 23:13:15 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l4T3CUeB027017
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 28 May 2007 20:12:31 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l4T3CT64025894;
	Mon, 28 May 2007 20:12:29 -0700
In-Reply-To: <20070528213511.GB7044@spearce.org>
X-Spam-Status: No, hits=-3.081 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.179 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48662>



On Mon, 28 May 2007, Shawn O. Pearce wrote:
> 
> What if we use a "slow" storage by "refs/notes/$objname/$notename",

This _really_ won't scale. Even if the notes don't exist, just doing the 
lookup (which will fail for most commits) will be horribly slow, and will 
populate the dentry cache with negative entries.

To get good filesystem performance, you have to
 - have reasonable hit-rates (and looking it up for each commit is _not_ 
   going to do that)
 - not have millions of objects.

So you'd have to have a separate database. You could do it with a separate 
index file (or mixing it up with the "index v4" and doing it with a single 
index file that also contains normal objects), but the point is, it's 
going to be a real separate database.

The current "decorations" approach is actually much more efficient with 
packed refs (dense in the filesystem), and probably not very bad at all 
for a smallish set (ie a few hundred to a few thousand) objects, but just 
reading all the decorations ends up being an overhead at some point.

		Linus
