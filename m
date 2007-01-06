From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-svnimport failed and now git-repack hates me
Date: Fri, 5 Jan 2007 16:15:28 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701051611550.3661@woody.osdl.org>
References: <204011cb0701031552j8292d23v950f828279702d3@mail.gmail.com>
 <Pine.LNX.4.64.0701031737300.4989@woody.osdl.org> <7v1wmbnw9x.fsf@assigned-by-dhcp.cox.net>
 <204011cb0701040958k884b613i8a4639201ae6443b@mail.gmail.com>
 <7v1wmalez6.fsf@assigned-by-dhcp.cox.net> <204011cb0701050919w2001105asefe2fd99165dfa95@mail.gmail.com>
 <7vbqldfg56.fsf@assigned-by-dhcp.cox.net> <204011cb0701051133r1ede14a6gd5093a3e7fa88cb5@mail.gmail.com>
 <20070105193958.GE8753@spearce.org> <7vtzz5duk1.fsf@assigned-by-dhcp.cox.net>
 <204011cb0701051503m3a431e07qc12662eecc08884f@mail.gmail.com>
 <7v64bldqas.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701051515000.3661@woody.osdl.org>
 <7vac0xc9g8.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701051610290.3661@woody.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Chris Lee <chris133@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 06 01:15:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2zDm-0002ea-TU
	for gcvg-git@gmane.org; Sat, 06 Jan 2007 01:15:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbXAFAPg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 19:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750993AbXAFAPg
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 19:15:36 -0500
Received: from smtp.osdl.org ([65.172.181.24]:44949 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750906AbXAFAPf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 19:15:35 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l060FTWi014741
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 5 Jan 2007 16:15:30 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l060FSmr011504;
	Fri, 5 Jan 2007 16:15:29 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0701051610290.3661@woody.osdl.org>
X-Spam-Status: No, hits=-0.67 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.107__
X-MIMEDefang-Filter: osdl$Revision: 1.167 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36056>



On Fri, 5 Jan 2007, Linus Torvalds wrote:
> 
> But it really shouldn't be a problem. 

Basically, this boils down to the same old issue: if you have a fixed 
access pattern (like SHA1_Update() over the whole buffer), you're actually 
likely to perform better with a loop of read() calls than with mmap.

So if we ONLY did the SHA1 thing, we shouldn't do mmap, we should just 
chunk things up into 16kB buffers or something, and read them.

But the mmap in pack-check _also_ ends up being for the subsequent object 
checking (with unpacking etc), so the mmap here actually is probably the 
right thing to do. I really wouldn't worry, unless we get people who 
report real problems (and I think the problems with svn-import of the huge 
KDE repos are all elsewhere, notably in teh SVN import itself, not in any 
pack handling ;)

		Linus
