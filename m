From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Fwd: Re: git checkout -f branch doesn't remove extra files
Date: Fri, 12 Aug 2005 22:05:11 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508122151120.19049@g5.osdl.org>
References: <20050813041737.GB25236@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 13 07:06:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3oCz-0001Ai-4Q
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 07:05:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbVHMFFW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 01:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbVHMFFW
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 01:05:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9374 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751306AbVHMFFV (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Aug 2005 01:05:21 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7D55CjA006818
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 12 Aug 2005 22:05:13 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7D55Bxe029974;
	Fri, 12 Aug 2005 22:05:12 -0700
To: Dave Jones <davej@redhat.com>
In-Reply-To: <20050813041737.GB25236@redhat.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.44__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 13 Aug 2005, Dave Jones wrote:
>
> My git snapshot creator that builds the hourly tarballs at
> http://www.codemonkey.org.uk/projects/git-snapshots/
> currently does an rsync, and then a checkout, and finally
> it cleans up by removing all the checked out files.
> It currently does this by hand, but on learning about
> this 'new' command, I thought, cool, now I can do..
> 
> git-ls-files | xargs rm -rf
> 
> however, this then leaves a bunch of empty subdirs, as
> git-ls-files doesn't list the subdirs by themselves in
> the output.  Am I missing some other option ?

Nope, you're not missing anything, except that you shouldn't do that.

"git-ls-files" is very nice for things like

	git-ls-files | xargs grep ....

but your example is not one of them. Not without options, and not _with_
strange options.

Your example is an example of just not doing it the right way.

If you really want a temporary tree, what you do is something like

	git-checkout-cache --prefix=tmp-dir/ -f -a

and when you're done, you just do

	rm -rf tmp-dir

and you're done.

NOTE NOTE NOTE! In the above, the order of the parameters is really really 
important! "-a" takes effect when it is seen, so it needs to be last. 
Also, the "--prefix" thing really _really_ needs the slash at the end, 
because it's literally used to prefix the pathname.

HOWEVER, if all you want to do is just a tar-file, then there's a better 
solution. It's called

	snap=git-snapshot-$(date +"%Y%m%d")
	git-tar-tree HEAD $snap | gzip -9 > $snap.tar.gz

which is even easier, and a hell of a lot more efficient.

Git actually has a _lot_ of nifty tools. I didn't realize that people 
didn't know about such basic stuff as "git-tar-tree" and "git-ls-files". 

		Linus
