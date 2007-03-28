From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Sanity checking request
Date: Wed, 28 Mar 2007 08:13:38 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703280759230.6730@woody.linux-foundation.org>
References: <7vwt11itbz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 28 17:14:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWZqZ-0000aV-U0
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 17:14:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbXC1PNn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Mar 2007 11:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbXC1PNn
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Mar 2007 11:13:43 -0400
Received: from smtp.osdl.org ([65.172.181.24]:47370 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932224AbXC1PNm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2007 11:13:42 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2SFDdU2011978
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 28 Mar 2007 08:13:39 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2SFDcUM013471;
	Wed, 28 Mar 2007 08:13:38 -0700
In-Reply-To: <7vwt11itbz.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.467 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43375>



On Wed, 28 Mar 2007, Junio C Hamano wrote:
>
> We've been saying that:
> 
> 	git read-tree -m $tree
> 
> is a quicker way to do "git read-tree $tree" (i.e. populate the
> index from a given tree), and except for the reuse of cached
> stat info to gain performance, there is no difference.

That was never technically correct. You need to use the "--reset" flag 
instead of "-m" if you want to just do a "git-read-tree" that also 
populates the index stat information.

Without "--reset", any old unmerged entries will be error cases.

Of course, when it comes to "git commit", you do *not* want to use 
"--reset", as erroring out when hitting an unmerged index entry is likely 
the right thing, even for the "git commit <paths>" case.

That said, I actually think the newer "git read-tree -m" behaviour makes 
sense. So I think we're much better off adding "-i" to git-commit.sh, than 
to force "-i" on when doing the one-way merge. The latter change just 
effectively disables a possible check entirely, the former at least allows 
other users to actually use that form if they ever want to.

(Looking at git-commit.sh, the thing I *really* think we should do is to 
have a "GIT_INDEX_FILE_OUTPUT" environment variable that does locking on 
the input file, but writes the result to another file: rigth now 
git-commit.sh (a) wastes time copying the old index file by hand and (b) 
as a result doesn't even honor any locking on it. I think whether it uses 
"-i" or not is actually less important - if you commit only a subset of 
files, maybe the extra checks in git-read-tree are actually ok?)

		Linus
