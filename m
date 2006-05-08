From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Unresolved issues #2 (shallow clone again)
Date: Sun, 7 May 2006 17:50:42 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605071744210.3718@g5.osdl.org>
References: <7v4q065hq0.fsf@assigned-by-dhcp.cox.net> <87mzdx7mh9.wl%cworth@cworth.org>
 <7v1wv92u7o.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605050806370.3622@g5.osdl.org>
 <e3fqb9$hed$1@sea.gmane.org> <Pine.LNX.4.64.0605050848230.3622@g5.osdl.org>
 <46a038f90605052323o29f8bfadr7426f97d8dfc2319@mail.gmail.com>
 <7vbqubvdbr.fsf@assigned-by-dhcp.cox.net> <46a038f90605062308x53995076k7bf45f0aebcae0c6@mail.gmail.com>
 <20060507075631.GA24423@coredump.intra.peff.net> <20060508003338.GB17138@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 08 02:51:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fctxk-000199-AD
	for gcvg-git@gmane.org; Mon, 08 May 2006 02:51:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbWEHAuv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 20:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWEHAuv
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 20:50:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39341 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751246AbWEHAuv (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 May 2006 20:50:51 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k480ogtH022974
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 7 May 2006 17:50:43 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k480ogj8030426;
	Sun, 7 May 2006 17:50:42 -0700
To: Theodore Tso <tytso@mit.edu>
In-Reply-To: <20060508003338.GB17138@thunk.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19735>



On Sun, 7 May 2006, Theodore Tso wrote:
>> 
> If there are 233338 objects, then the average wasted space due to
> internal fragmentation is 233338 * 2k, or 466676 kilobytes, or only
> 36% of the wasted space.

That's not necessarily true.

That assumes a randomly distributed filesize. File sizes are _not_ random, 
and in particular if you have the distribution leaning towards <2kB being 
common, you can actually get >50% fragmentation.

Btw, I hit this when some people argued that the page size should be made 
64kB. The above (incorrect) logic implies that you waste 32kB on average 
per file. That's not true, if a large fraction of your files are small, in 
which case you may actually be wastign closer to 60kB on average from 
using a big page-size, because about half of the kernel files are actually 
smaller than 4kB (or something. I forget the exact statistics, I did them 
with a script at some point).

Anyway, with inode overhead and a lot of objects being just a couple of 
hundred bytes, I think I estimated at some point that you actually lost 
closer to 3kB per object.

Many of the objects actually end up being smaller than the inode they end 
up allocating ;(

			Linus
