From: Stephen Bash <bash@genarts.com>
Subject: Re: Tags, Grafts, and Clones, oh my!
Date: Fri, 20 Aug 2010 09:00:20 -0400 (EDT)
Message-ID: <5752362.117414.1282309220152.JavaMail.root@mail.hq.genarts.com>
References: <20100820061459.GB12794@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 20 15:05:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmRHb-0006J8-Li
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 15:05:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724Ab0HTNA2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 09:00:28 -0400
Received: from hq.genarts.com ([173.9.65.1]:2053 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751508Ab0HTNA1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 09:00:27 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 3D3CD1E26267;
	Fri, 20 Aug 2010 09:00:26 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r0w-NHVtPqpJ; Fri, 20 Aug 2010 09:00:20 -0400 (EDT)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id 40E111E2625B;
	Fri, 20 Aug 2010 09:00:20 -0400 (EDT)
In-Reply-To: <20100820061459.GB12794@kytes>
X-Mailer: Zimbra 6.0.7_GA_2473.UBUNTU8 (ZimbraWebClient - SAF3 (Mac)/6.0.7_GA_2473.UBUNTU8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154029>

> >
> >    error: refs/tags/tagFoo does not point to a valid object!
> >
> 
> It seems too vague to me. Can you submit your testcase? Perhaps we can
> work from there?

Sure:

mkdir gitTagBug
cd gitTagBug

git init foo
cd foo
echo A >> foo.txt
git add foo.txt
git commit -m "Created foo"
GRAFT_PARENT=`git rev-parse master`
echo B >> foo.txt
git commit -am "Added B"
cd ..

git init bar
cd bar
echo A >> foo.txt
echo C >> foo.txt
git add foo.txt
git commit -m "Added C"
GRAFT_CHILD=`git rev-parse master`
git tag -am "Tagging foo C" tagFoo $GRAFT_CHILD
cd ..

cd foo
git fetch ../bar refs/tags/tagFoo:refs/tags/tagFoo
echo "$GRAFT_CHILD $GRAFT_PARENT" >> .git/info/grafts
git filter-branch --tag-name-filter cat tagFoo
cd ..

# Purposely use a file URL to prune any unreferenced objects
git clone file:///`pwd`/foo newFoo

My output from the clone:

   Cloning into newFoo...
   remote: Counting objects: 9, done.
   remote: Compressing objects: 100% (3/3), done.
   remote: Total 9 (delta 0), reused 0 (delta 0)
   Receiving objects: 100% (9/9), done.
   error: refs/tags/tagFoo does not point to a valid object!

Thanks,
Stephen
