From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] write-tree performance problems
Date: Tue, 19 Apr 2005 10:36:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504191017300.19286@ppc970.osdl.org>
References: <200504191250.10286.mason@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 19:30:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNwY8-0005E4-Gu
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 19:30:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbVDSReS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 13:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261393AbVDSReS
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 13:34:18 -0400
Received: from fire.osdl.org ([65.172.181.4]:34250 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261386AbVDSReN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 13:34:13 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3JHY9s4030769
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 19 Apr 2005 10:34:09 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3JHY8sX020814;
	Tue, 19 Apr 2005 10:34:09 -0700
To: Chris Mason <mason@suse.com>
In-Reply-To: <200504191250.10286.mason@suse.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 19 Apr 2005, Chris Mason wrote:
> 
> I did a quick experiment with applying/commit 100 patches from the suse kernel 
> into a kernel git tree, which quilt can do in 2 seconds.  git needs 1m5s.

Note that I don't think you want to replace quilt with git. The approaches 
are totally different, and git does _not_ obviate the need for the quilt 
kind of "patch testing".

In fact, git has all the same issues that BK had, and for the same 
fundamental reason: if you do distributed work, you have to always 
"append" stuff, and that means that you can never re-order anything after 
the fact.

So git really is _not_ very good at all at doing what quilt does. Also, 
there's an inevitable cost of being careful, and as you note, the sha1 
calculation is expensive (*).

However, I hate your modification. Yeah, I know, performance is important 
to me, but even more than performance is that I can trust the end results, 
and that means that we calculate the hashes instead of just taking them 
from somewhere else..

What I _would_ like is the ability to re-use an old tree, though. What you 
really want to do is not pass in a set of directory names and just trust 
that they are correct, but just pass in a directory to compare with, and 
if the contents match, you don't need to write out a new one.

I'll try to whip up something that does what you want done, but doesn't
need (or take) any untrusted information from the user in the form "trust
me, it hasn't changed".

		Linus

(*) Actually, I think it's the compression that ends up being the most
expensive part.
