From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: kde.git is now online
Date: Thu, 5 Apr 2007 13:51:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704051338290.6730@woody.linux-foundation.org>
References: <46152BF5.3050502@zytor.com> <Pine.LNX.4.64.0704051029240.6730@woody.linux-foundation.org>
 <alpine.LFD.0.98.0704051334590.28181@xanadu.home>
 <alpine.LFD.0.98.0704051532240.28181@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>,
	Chris Lee <clee@kde.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Apr 05 22:52:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZYwh-0004OY-2O
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 22:52:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767147AbXDEUwg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 16:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767153AbXDEUwg
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 16:52:36 -0400
Received: from smtp.osdl.org ([65.172.181.24]:51531 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767147AbXDEUwe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 16:52:34 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l35KpfPD008396
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 5 Apr 2007 13:51:41 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l35KpZgM025892;
	Thu, 5 Apr 2007 13:51:38 -0700
In-Reply-To: <alpine.LFD.0.98.0704051532240.28181@xanadu.home>
X-Spam-Status: No, hits=-0.457 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43854>



On Thu, 5 Apr 2007, Nicolas Pitre wrote:
> 
> For example I think there might be ways to improve the pack mmap 
> windowing, or git-fsck's IO patterns.  For example, git-fsck --full 
> spend 96% of the time waiting for IO completion and only 4% actually 
> performing some work according to top.  At that rate that makes fsck 
> --full rather unusable on this repo.  Without --full then fsck completes 
> in less than 2 seconds.

Without "--full", it doesn't actually really do anything much, since it 
will basically ignore objects that are in the pack.

With --full, there are certainly things that we could improve upon. We 
currently tend to walk things a few times for pack contents: 
 - first we do the SHA1 of the full pack
 - then we go back, and unpack and fsck each entry in the pack.

So if the pack-file is too big to fit in memory, we'll basically always 
read it at least twice (and that's ignoring the fact that delta lookup 
will obviously seek back and forth, which makes access patterns worse).

On the other hand, there's a perfectly good reason why we don't actually 
fsck pack-files by default. They're "stable storage". You don't normally 
need to. So I'd not worry too much about fsck performance. I suspect 
you'll find that with 1GB or RAM you'll have other performance problems 
that are more pressing ("git clone" comes to mind ;)

Me, I'm just 53% done with the download, so I probably won't be looking at 
this today ;)

			Linus
