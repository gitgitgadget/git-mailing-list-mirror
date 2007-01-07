From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: How git affects kernel.org performance
Date: Sun, 7 Jan 2007 10:17:38 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701070957080.3661@woody.osdl.org>
References: <1166297434.26330.34.camel@localhost.localdomain>
 <1166304080.13548.8.camel@nigel.suspend2.net> <459152B1.9040106@zytor.com>
 <1168140954.2153.1.camel@nigel.suspend2.net> <45A08269.4050504@zytor.com>
 <45A083F2.5000000@zytor.com> <Pine.LNX.4.64.0701062130260.3661@woody.osdl.org>
 <20070107085526.GR24090@1wt.eu> <45A0B63E.2020803@zytor.com>
 <20070107090336.GA7741@1wt.eu> <20070107102853.GB26849@infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Willy Tarreau <w@1wt.eu>, "H. Peter Anvin" <hpa@zytor.com>,
	git@vger.kernel.org, nigel@nigel.suspend2.net,
	"J.H." <warthog9@kernel.org>,
	Randy Dunlap <randy.dunlap@oracle.com>,
	Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>,
	webmaster@kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 07 19:19:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3cc5-00024A-QN
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 19:19:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbXAGSTR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 13:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbXAGSTR
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 13:19:17 -0500
Received: from smtp.osdl.org ([65.172.181.24]:39216 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751456AbXAGSTQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 13:19:16 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l07IHeWi029871
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 7 Jan 2007 10:17:40 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l07IHc0b022714;
	Sun, 7 Jan 2007 10:17:39 -0800
To: Christoph Hellwig <hch@infradead.org>
In-Reply-To: <20070107102853.GB26849@infradead.org>
X-Spam-Status: No, hits=-0.668 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.107__
X-MIMEDefang-Filter: osdl$Revision: 1.167 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36181>



On Sun, 7 Jan 2007, Christoph Hellwig wrote:
>
> On Sun, Jan 07, 2007 at 10:03:36AM +0100, Willy Tarreau wrote:
> > The problem is that I have no sufficient FS knowledge to argument why
> > it helps here. It was a desperate attempt to fix the problem for us
> > and it definitely worked well.
> 
> XFS does rather efficient btree directories, and it does sophisticated
> readahead for directories.  I suspect that's what is helping you there.

The sad part is that this is a long-standing issue, and the directory 
reading code in ext3 really _should_ be able to do ok. 

A year or two ago I did a totally half-assed code for the non-hashed 
readdir that improved performance by an order of magnitude for ext3 for a 
test-case of mine, but it was subtly buggy and didn't do the hashed case 
AT ALL. Andrew fixed it up so that it at least wasn't subtly buggy any 
more, but in the process it also lost all capability of doing fragmented 
directories (so it doesn't help very much any more under exactly the 
situation that is the worst case), and it still doesn't do the hashed 
directory case.

It's my personal pet peeve with ext3 (as Andrew can attest). And it's 
really sad, because I don't think it is fundamental per se, but the way 
the directory handling and jdb are done, it's apparently very hard to fix.

(It's clearly not _impossible_ to do: I think that it should be possible 
to treat ext3 directories the same way we treat files, except they would 
always be in "data=journal" mode. But I understand ext2, not ext3 (and 
absolutely not jbd), so I'm not going to be able to do anything about it 
personally).

Anyway, I think that disabling hashing can actually help. And I suspect 
that even with hashing enabled, there should be some quick hack for making 
the directory reading at least be able to do multiple outstanding reads in 
parallel, instead of reading the blocks totally synchronously ("read five 
blocks, then wait for the one we care" rather than the current "read one 
block at a time, wait for it, read the next one, wait for it.." 
situation).

			Linus
