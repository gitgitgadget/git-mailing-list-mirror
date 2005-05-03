From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Date: Mon, 2 May 2005 19:48:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505021932270.3594@ppc970.osdl.org>
References: <20050429165232.GV21897@waste.org> <427650E7.2000802@tmr.com>
 <Pine.LNX.4.58.0505021457060.3594@ppc970.osdl.org> <20050502223002.GP21897@waste.org>
 <Pine.LNX.4.58.0505021540070.3594@ppc970.osdl.org> <20050503000011.GA22038@waste.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Bill Davidsen <davidsen@tmr.com>,
	Morten Welinder <mwelinder@gmail.com>,
	Sean <seanlkml@sympatico.ca>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 04:40:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSnKw-0006h4-2G
	for gcvg-git@gmane.org; Tue, 03 May 2005 04:40:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbVECCqs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 22:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbVECCqs
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 22:46:48 -0400
Received: from fire.osdl.org ([65.172.181.4]:61886 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261314AbVECCqk (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2005 22:46:40 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j432kTs4001235
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 2 May 2005 19:46:30 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j432kR9k003738;
	Mon, 2 May 2005 19:46:28 -0700
To: Matt Mackall <mpm@selenic.com>
In-Reply-To: <20050503000011.GA22038@waste.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 2 May 2005, Matt Mackall wrote:
> 
> Umm.. I am _not_ calculating the SHA of the delta itself. That'd be
> silly.

It's not silly.

Meta-data consistency is supremely important. If people can corrupt their 
metadata in strange an unobservable ways, that's almost as bad as 
corrupting the data itself. In fact, to some degree it's worse, since you 
make people trust the thing, but you don't actually guarantee it.

So how _do_ you guarantee consistency of a tree and the history that led 
up to it? 

And by that I don't mean any of the individual blobs - I realize that it's 
perfectly valid to just check out every single version, and have the sha1 
of that. But how do you guarantee that the sha's you check are the sha's 
that you saved in the first place, and somebody didn't replace something 
in the middle?

In other words, you need to hash the metadata too. Otherwise how do you
consistency-check the _collection_ of files?

It's absolutely not enough to just protect single-file content. That 
doesn't help one whit. It's not what a SCM is all about. You have to 
protect the state of _multiple_ files, ie the metadata has to be 
verifiable too.

If that meta-data is the index, then the index needs to be protected by a
SHA1. In git, that's why we don't just sha1 every blob, but every tree and
every commit. That's the thing that gets consistency _beyond_ a single
file.

> As various people have pointed out, you can hack delta transmission
> and file revision indexing on top of git. But to do that, you'll need
> to build the same indices that Mercurial has. And you'll need to check
> their integrity.

No, absolutely not.

Building indeces on top of git would be stupid. You can _cache_ deltas,
but there's a big difference between a index that actually describes how
random blobs go together, and a cache of a delta between two
well-specified end-points. And in particular, there is no "consistency" to
a delta. You don't need it.

Why? Because either the delta is correct, or it isn't. If it's correct,
the end result will be the right sha1. If it's not, the end result will be
something else. So when you do a "pull" from another repository, you can
trivially check whether the delta's you got were valid: did applying them
result in the same sha1 that the other repository had?

So git really validates the _only_ thing that matters: it validates the 
state of the data. It doesn't validate anything else, but if validates 
that one thing very completely indeed.

		Linus
