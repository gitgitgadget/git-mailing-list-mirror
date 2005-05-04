From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Howto update a 'dirty' entry in the cache from the object database
Date: Wed, 4 May 2005 10:23:01 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505041014510.2328@ppc970.osdl.org>
References: <20050504142351.GL18380@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 04 19:20:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTNX9-0006FG-3A
	for gcvg-git@gmane.org; Wed, 04 May 2005 19:19:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbVEDRYn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 May 2005 13:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbVEDRYd
	(ORCPT <rfc822;git-outgoing>); Wed, 4 May 2005 13:24:33 -0400
Received: from fire.osdl.org ([65.172.181.4]:18606 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261801AbVEDRVL (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 May 2005 13:21:11 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j44HKxU3014324
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 4 May 2005 10:21:00 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j44HKwLt001965;
	Wed, 4 May 2005 10:20:59 -0700
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
In-Reply-To: <20050504142351.GL18380@cip.informatik.uni-erlangen.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 4 May 2005, Thomas Glanzmann wrote:
>
> I edited a bunch of files and notice that I want to revert back one of
> the files to the original one (the one that comes with HEAD). But I
> already updated the cache. Is there a way to 'patch' the cache with the
> original file.

Absolutely.

You can do it several ways. The easiest one is

	git-read-tree -m HEAD
	git-checkout-cache -f filename

but this means that you revert your entire index file to the old HEAD 
information, so you'll need to do git-update-cache on the files that you 
changed.

So:

> Or do I need todo a read-tree into a temporary index
> file. Check out the one file from this alternate index file and use
> update-cache to update my original index file?

Yes. If you want to touch just that one file, and you actually _want_ to
save all the other index information updates except for this one file. If
so, you can do

	# read a new index file with the HEAD information
	GIT_INDEX_FILE=tmp-index git-read-tree HEAD

	# check out just the one file you want to have
	GIT_INDEX_FILE=tmp-index git-checkout-cache -f filename

	# remove the now useless temporary index
	rm tmp-index

	# update your _real_ index file with the file information
	git-update-cache filename

and you're done - you've now updated only that _one_ file in your working 
area, and you've re-set the index file for that entry.

And yes, scripting it so that you don't make stupid mistakes is probably a
good idea. For exmple, if you misspell GIT_INDEX_FILE (like I did when I
write that at first), you'd have reverted your real index file after all.

In other words, the git core certainly is very flexible and can easily do 
what you want, but it's also certainly very very easy to screw up with.

		Linus
