From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Tue, 13 Feb 2007 08:52:04 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702130845330.8424@woody.linux-foundation.org>
References: <45CFA30C.6030202@verizon.net> <200702130932.51601.litvinov2004@gmail.com>
 <Pine.LNX.4.63.0702131105240.1300@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alexander Litvinov <litvinov2004@gmail.com>,
	Mark Levedahl <mlevedahl@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 13 17:52:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH0te-0000K5-CM
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 17:52:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbXBMQw3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 11:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbXBMQw3
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 11:52:29 -0500
Received: from smtp.osdl.org ([65.172.181.24]:44189 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750832AbXBMQw2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 11:52:28 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1DGq6hB028484
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 13 Feb 2007 08:52:06 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1DGq4i9003071;
	Tue, 13 Feb 2007 08:52:05 -0800
In-Reply-To: <Pine.LNX.4.63.0702131105240.1300@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=-0.424 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.117__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39542>



On Tue, 13 Feb 2007, Johannes Schindelin wrote:
> 
> On Tue, 13 Feb 2007, Alexander Litvinov wrote:
> 
> > When I have file that was converted from dos to unix format (or from 
> > unix to dos) git genereta big diff. But anyway, c++ compiler works well 
> > with both formats and in this case I simply convert file to dos format 
> > and git shows again nice diff. If unix format was commited to git I 
> > simply change the format and commit that file again.
> 
> That's awful!
> 
> > The only trouble is the rebase, it does not like \r\n ending and othen 
> > produce unexpected merge conflict. But I don't use rebse to othen to 
> > realy investigate and try to solve the problem.
> 
> Well, if everybody thinks like you, maybe we do not have to change 
> anything for Windows after all?

No no no.

It's going to be _horrible_ if people start interesting projects in 
Windows, and there are files in a git repository that are encoded with 
CRLF. 

I'd much rather just get this right, and that means "no hooks". If people 
start using commit hooks etc, that will just mean that they won't use them 
for all-windows environments (why use it? Everybody hass CRLF, and 
everybody _wants_ CRLF), or it will just be relatively expensive to have a 
complex hook anyway.

So I think we should plan on something like .gitattributes or similar, so 
that we _can_ handle mixed environments well, without any real setup or 
any real costs.

The costs really shouldn't be too high - we tend to avoid doing any 
expensive working tree changes *anyway*. For example, even "git checkout" 
has a huge optimization to avoid rewriting files that are already ok, so 
doing things like switching whole branches usually wouldn't even need any 
conversion for most files - even on platforms like Windows that need the 
conversion in the first place.

So considering that it looks _trivial_ for git-update-index, fairly easy 
for diff generation, and I doubt "git checkout" is really likely to be any 
worse either, this should just be somethign we do.

The *ONLY* case where we may not be able to do things automatically is 
actually a much more subtle one: "git cat-file". If we just get a SHA1, we 
don't know what the path to look it up was like, and thus we can never 
know whether it's a binary or a text object. With "-p" we can trivially 
guess, of course, but "git cat-file blob" simply must not do that!

But that really doesn't sound like a big problem to me ;)

		Linus
