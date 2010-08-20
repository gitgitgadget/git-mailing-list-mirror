From: Stephen Bash <bash@genarts.com>
Subject: refs/original breaks git-clone for tags (was Re: Tags, Grafts, and
 Clones, oh my!)
Date: Fri, 20 Aug 2010 15:08:49 -0400 (EDT)
Message-ID: <32751199.117741.1282331329553.JavaMail.root@mail.hq.genarts.com>
References: <5054888.117464.1282315250235.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 20 21:09:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmWxa-0002Wd-FR
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 21:09:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752304Ab0HTTI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 15:08:58 -0400
Received: from hq.genarts.com ([173.9.65.1]:13348 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751050Ab0HTTI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 15:08:57 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 0DA751E2635E;
	Fri, 20 Aug 2010 15:08:56 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ABqBuybo14Sj; Fri, 20 Aug 2010 15:08:49 -0400 (EDT)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id A40AF1E2631A;
	Fri, 20 Aug 2010 15:08:49 -0400 (EDT)
In-Reply-To: <5054888.117464.1282315250235.JavaMail.root@mail.hq.genarts.com>
X-Mailer: Zimbra 6.0.7_GA_2473.UBUNTU8 (ZimbraWebClient - SAF3 (Mac)/6.0.7_GA_2473.UBUNTU8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154068>

> > Thanks for the testcase! Offhand, it definitely looks like a bug.
> > I'm
> > investigating to figure out which part of the chain is at fault.
> 
> No problem. I was very happily to isolate it outside the large repo I
> was working with...
> 
> Data from further testing:
> - doing a "normal" local clone doesn't emit the error
> - a remote clone over ssh does emit the error (so it's not just
> file:///)
> - in a brand new repo (init'ed, not cloned) 'git fetch ../foo
> refs/tags/tagFoo:refs/tags/tagFoo' fails:
> error: unable to find 28fffee... (sha of tag object)
> - in a brand new repo 'git fetch ../foo
> refs/heads/branchFoo:ref/heads/branchFoo' succeeds, and correctly
> fetches tagFoo (where branchFoo is created via 'git checkout -b
> branchFoo tagFoo')

After a lot of guess and check, it appears the issue is somehow related to the refs/original directory created by filter-branch.  If that directory is moved out of refs/ or deleted the clone succeeds.  Digging further, a simple rename of refs/original/refs/tags/tagFoo to anything else also fixes the problem.

A simplified test case is:

git init foo
cd foo
echo A >> foo.txt
git add foo.txt
git commit -m "Created foo"
git tag -am "Tagging foo" tagFoo
git filter-branch --env-filter 'export GIT_AUTHOR_NAME=xyz123' --tag-name-filter cat -- --all
cd ..
git clone file:///`pwd`/foo newFoo

git clone will "succeed" (exit 0), but throw the error 

   error: refs/tags/tagFoo does not point to a valid object!

and the tagFoo will not exist in the new repo.

(The env-filter is arbitrary, just need something that will force a commit rewrite)  For this bug to occur, the filter-branch must create refs/original/refs/tags/tagFoo, so if the filter-branch command is 

git filter-branch --env-filter 'export GIT_AUTHOR_NAME=xyz123' --tag-name-filter cat master

filter-branch will happily rewrite the tag, but won't create the offending file, so the clone will succeed without error (and the tag will exist in the new repo).  

Removing refs/original is a pretty trivial work-around, so I'm going to modify my scripts and continue working on my SVN transition.  Let me know if I can be of any assistance tracking down the actual bug.

Thanks,
Stephen
