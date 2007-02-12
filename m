From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Mon, 12 Feb 2007 15:02:42 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702121455560.8424@woody.linux-foundation.org>
References: <45CFA30C.6030202@verizon.net> <20070212042425.GB18010@thunk.org>
 <Pine.LNX.4.64.0702120839490.8424@woody.linux-foundation.org>
 <Pine.LNX.4.63.0702122332180.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Theodore Tso <tytso@mit.edu>,
	Mark Levedahl <mlevedahl@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 13 00:03:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGkCJ-0003kq-G9
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 00:02:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030454AbXBLXCz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 18:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030455AbXBLXCz
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 18:02:55 -0500
Received: from smtp.osdl.org ([65.172.181.24]:46312 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030454AbXBLXCx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 18:02:53 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1CN2hhB029356
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 12 Feb 2007 15:02:44 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1CN2g0R014505;
	Mon, 12 Feb 2007 15:02:43 -0800
In-Reply-To: <Pine.LNX.4.63.0702122332180.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=-0.426 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.117__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39449>



On Mon, 12 Feb 2007, Johannes Schindelin wrote:
>
> >  (c) Profit!
> 
> Not so fast.

Aww! And just when I _finally_ had a "step 2".

> In order for this to be _useful_, you also have to have a way to _extract_ 
> the text blobs. Not only for read-tree, but _also_ for diff.

Actually, my argument is that we don't need it all that much.

For example, your "read-tree" argument is actually wrong. Anything that is 
in a tree is _already_ fixed to be '\n'. So as long as we keep to things 
like

	git diff version1..version2

we'll actually always get the right version.

Also, the index will make sure that we don't even *try* to diff normal 
checked out files.

So the only time you actually really need to test the .gitattributes file 
is when you do an "open blob in working tree". And once you do that 
function right, and just make sure both git-update-index and yes, the 
"diff against working tree" cases use it, you really should be mostly 
done.

Both git-update-index and git-diff-files want basically the same 
interface:

	struct file_buf {
		const char *buf;
		unsigned long size;
		int flags;
	}

	int read_file(const char *path, struct file_buf *);
	close_file(struct file_buf *);

and we should use that instead of the current "open + stat + mmap/read + 
close" sequences.

It really shouldn't be too nasty.

		Linus
