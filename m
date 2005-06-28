From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: CAREFUL! No more delta object support!
Date: Mon, 27 Jun 2005 20:30:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506272016420.19755@ppc970.osdl.org>
References: <Pine.LNX.4.58.0506271755140.19755@ppc970.osdl.org>
 <20050627235857.GA21533@64m.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 28 05:21:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dn6fJ-0007j4-D7
	for gcvg-git@gmane.org; Tue, 28 Jun 2005 05:21:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbVF1D2e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Jun 2005 23:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262339AbVF1D2e
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jun 2005 23:28:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6636 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261907AbVF1D2Y (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Jun 2005 23:28:24 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5S3SKjA009500
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 27 Jun 2005 20:28:20 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5S3SHpX010715;
	Mon, 27 Jun 2005 20:28:18 -0700
To: Christopher Li <git@chrisli.org>
In-Reply-To: <20050627235857.GA21533@64m.dyndns.org>
X-Spam-Status: No, hits=0.667 required=5 tests=MANY_EXCLAMATIONS
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 27 Jun 2005, Christopher Li wrote:
> On Mon, Jun 27, 2005 at 06:14:40PM -0700, Linus Torvalds wrote:
> > 
> > The reason? The new git understands packed files natively, which ends up 
> > being a much bigger win in many many ways.
> 
> Interesting. I take a look at your change, it still support delta object
> inside the pack file right? For a second I am wondering you drop the delta
> feature completely.

Deltas do exist inside pack-files, yes. They just don't exist as 
independent objects any more, so you can never get into the situation that 
you find a delta but you don't find the delta it points to.

Because in the pack-files, there are only deltas _within_ a pack-file. You 
can't have a delta that points to outside the pack.

This means that pack-files with few objects will inevitably be larger than
they could otherwise be (ie you can never have a pack file that _only_
contains deltas to the outside world), but it's just incredibly reassuring 
to me that a pack-file is always self-sufficient. 

So when/if we start using pack-files for doing "git pull" etc, the 
pack-file won't actually help pack things for small updates: small updates 
will probably contain the whole changed file, unless the update has 
several changes to the same file (which is not unusual, of course), in 
which case it will only contain one version and then deltas from that.

But the savings get increasingly bigger the more history we have. That's
also why the packed git archive is about 1/14th of the size of the fully
unpacked disk usage of the git project, but a packed kernel archive "only"  
achieves a packing rate of 1/5th of the fully unpacked kernel archive. The
git archive is all history, while the kernel archive just "appears", and
2/3 of the files have only one single version and thus don't delta-
compress at all.

(Another reason is probably that the kernel has bigger files, which means
that it thus has relatively less loss in filesystem block padding).

But not having any outside deltas not only makes me feel safer, it also
means that you can fully validate a pack archive consistency without even
knowing what project it is from - you can check the SHA1 results of every
file in the pack against the index of the pack, and check that the SHA1's
of the pack files themselves are valid. Again, this is just a data
_consistency_ check, of course - it means that you can validate that it
downloaded fine, and that you don't have disk corruption, but it doesn't
mean that the data isn't evil and nasty and buggy ;)

			Linus
