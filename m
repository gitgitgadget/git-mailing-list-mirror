From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Repacking many disconnected blobs
Date: Wed, 14 Jun 2006 11:18:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606141113130.5498@g5.osdl.org>
References: <1150269478.20536.150.camel@neko.keithp.com> 
 <Pine.LNX.4.64.0606140826200.5498@g5.osdl.org> <1150307715.20536.166.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 14 20:18:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqZwh-0002yh-0F
	for gcvg-git@gmane.org; Wed, 14 Jun 2006 20:18:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbWFNSSY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Jun 2006 14:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbWFNSSX
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jun 2006 14:18:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26549 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932347AbWFNSSX (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jun 2006 14:18:23 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5EIIGgt002255
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 14 Jun 2006 11:18:17 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5EIIFwe013759;
	Wed, 14 Jun 2006 11:18:16 -0700
To: Keith Packard <keithp@keithp.com>
In-Reply-To: <1150307715.20536.166.camel@neko.keithp.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21850>



On Wed, 14 Jun 2006, Keith Packard wrote:

> On Wed, 2006-06-14 at 08:53 -0700, Linus Torvalds wrote:
> 
> >  - You can list the objects with "most important first" order first, if 
> >    you can.  That will improve locality later (the packing will try to 
> >    generate the pack so that the order you gave the objects in will be a 
> >    rough order of the resul - the first objects will be together at the 
> >    beginning, the last objects will be at the end)
> 
> I take every ,v file and construct blobs for every revision. If I
> understand this correctly, I should be shuffling the revisions so I send
> the latest revision of every file first, then the next-latest revision.
> It would be somewhat easier to just send the whole list of revisions for
> the first file and then move to the next file, but if shuffling is what
> I want, I'll do that.

You don't _need_ to shuffle. As mentioned, it will only affect the 
location of the data in the pack-file, which in turn will mostly matter 
as an IO pattern thing, not anything really fundamental.  If the pack-file 
ends up caching well, the IO patterns obviously will never matter.

Eventually, after the whole import has finished, and you do the final 
repack, that one will do things in "recency order" (or "global 
reachability order" if you prefer), which means that all the objects in 
the final pack will be sorted by how "close" they are to the top-of-tree. 

And that will happen regardless of what the intermediate ordering has 
been.

So if shuffling is inconvenient, just don't do it.

On the other hand, if you know that you generated the blobs "oldest to 
newest", just print them in the reverse order when you end up repacking, 
and you're all done (if you just save the info into some array before you 
repack, just walk the array backwards).

			Linus
