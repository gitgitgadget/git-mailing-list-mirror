From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Errors cloning large repo
Date: Fri, 9 Mar 2007 21:10:16 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0703092057570.10832@woody.linux-foundation.org>
References: <645002.46177.qm@web52608.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Anton Tropashko <atropashko@yahoo.com>
X-From: git-owner@vger.kernel.org Sat Mar 10 06:10:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPtqh-0001QQ-Db
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 06:10:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767818AbXCJFKU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 00:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767827AbXCJFKU
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 00:10:20 -0500
Received: from smtp.osdl.org ([65.172.181.24]:60984 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767818AbXCJFKS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 00:10:18 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2A5AHo4029702
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 9 Mar 2007 21:10:17 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2A5AGRo012162;
	Fri, 9 Mar 2007 21:10:16 -0800
In-Reply-To: <645002.46177.qm@web52608.mail.yahoo.com>
X-Spam-Status: No, hits=-0.491 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41847>



On Fri, 9 Mar 2007, Anton Tropashko wrote:
> 
> My problem is git-clone though since for commit it's no big deal
> to git commit [a-c]* , or use xargs as a workaround

Sure, but there were two problems.

The "git commit" problem is trivial, and in no way fundamental. The thing 
that uses tons of memory is literally just eyecandy, to show you *what* 
you're committing.

In fact, by the time it starts using tons of memory, the commit has 
literally already happened. It's just doing statistics afterwards that 
bloats it up.

> For git clone I got this

The "git clone" problem is different, in that it's due to the 2GB 
pack-file limit. It's not "fundmentally hard" either, but it's at least 
not just a small tiny silly detail.

In fact, you can just do

	git add .
	git commit -q

and the "-q" flag (or "--quiet") will mean that the diffstat is never 
done, and the commit should be almost instantaneous (all the real work is 
done by the "git add .")

So "git commit" issue really is just a small beauty wart.

> Deltifying 144511 objects.
>  100% (144511/144511) done
> 1625.375MB  (1713 kB/s)       
> 1729.057MB  (499 kB/s)       
> /usr/bin/git-clone: line 321: 24360 File size limit exceededgit-fetch-pack --all -k $quiet "$repo"
> 
> again after git repack and don't see how to work around that aside from artifically
> splitting the tree at the top or resorting to a tarball on an ftp site.

So the "git repack" actually worked for you? It really shouldn't have 
worked.

Is the server side perhaps 64-bit? If so, the limit ends up being 4GB 
instead of 2GB, and your 8.5GB project may actually fit.

If so, we can trivially fix it with the current index file even for a 
32-bit machine. The reason we limit pack-files to 2GB on 32-bit machines 
is purely that we don't use O_LARGEFILE. If we enable O_LARGEFILE, that 
moves the limit up from 31 bits to 32 bits, and it might be enough for 
you. No new data structures for the index necessary at all.

		Linus
