From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: How git affects kernel.org performance
Date: Sun, 7 Jan 2007 11:35:40 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701071132450.3661@woody.osdl.org>
References: <1166297434.26330.34.camel@localhost.localdomain> 
 <45A08269.4050504@zytor.com> <45A083F2.5000000@zytor.com> 
 <Pine.LNX.4.64.0701062130260.3661@woody.osdl.org>  <20070107085526.GR24090@1wt.eu>
 <45A0B63E.2020803@zytor.com>  <20070107090336.GA7741@1wt.eu>
 <20070107102853.GB26849@infradead.org>  <Pine.LNX.4.64.0701070957080.3661@woody.osdl.org>
  <Pine.LNX.4.64.0701071028450.3661@woody.osdl.org>
 <9e4733910701071126r7931042eldfb73060792f4f41@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Christoph Hellwig <hch@infradead.org>, Willy Tarreau <w@1wt.eu>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org,
	nigel@nigel.suspend2.net, "J.H." <warthog9@kernel.org>,
	Randy Dunlap <randy.dunlap@oracle.com>,
	Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>,
	webmaster@kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 07 20:38:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3dpG-00089C-7m
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 20:37:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964984AbXAGTg6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 14:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964990AbXAGTg5
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 14:36:57 -0500
Received: from smtp.osdl.org ([65.172.181.24]:43043 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964984AbXAGTg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 14:36:56 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l07JZgWi031775
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 7 Jan 2007 11:35:42 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l07JZeoF023958;
	Sun, 7 Jan 2007 11:35:41 -0800
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910701071126r7931042eldfb73060792f4f41@mail.gmail.com>
X-Spam-Status: No, hits=-0.668 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.107__
X-MIMEDefang-Filter: osdl$Revision: 1.167 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36190>



On Sun, 7 Jan 2007, Jon Smirl wrote:
> > 
> >  - proper read-ahead. Right now, even if the directory is totally
> >    contiguous on disk (just remove the thing that writes data to the
> >    files, so that you'll have empty files instead of 8kB files), I think
> >    we do those reads totally synchronously if the filesystem was mounted
> >    with directory hashing enabled.
> 
> What's the status on the Adaptive Read-ahead patch from Wu Fengguang
> <wfg@mail.ustc.edu.cn> ? That patch really helped with read ahead
> problems I was having with mmap. It was in mm forever and I've lost
> track of it.

Won't help. ext3 does NO readahead at all. It doesn't use the general VFS 
helper routines to read data (because it doesn't use the page cache), it 
just does the raw buffer-head IO directly.

(In the non-indexed case, it does do some read-ahead, and it uses the 
generic routines for it, but because it does everything by physical 
address, even the generic routines will decide that it's just doing random 
reading if the directory isn't physically contiguous - and stop reading 
ahead).

(I may have missed some case where it does do read-ahead in the index 
routines, so don't take my word as being unquestionably true. I'm _fairly_ 
sure, but..)

			Linus
