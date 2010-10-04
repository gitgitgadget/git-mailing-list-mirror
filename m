From: Stephen Bash <bash@genarts.com>
Subject: Trac+Git: rev-list with pathspec performance?
Date: Mon, 4 Oct 2010 16:21:50 -0400 (EDT)
Message-ID: <27777603.436995.1286223710787.JavaMail.root@mail.hq.genarts.com>
References: <13399611.436896.1286218134223.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 04 22:22:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2rY1-0001cT-5y
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 22:22:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932554Ab0JDUV7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 16:21:59 -0400
Received: from hq.genarts.com ([173.9.65.1]:51547 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932232Ab0JDUV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 16:21:58 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 5047A1E268E0
	for <git@vger.kernel.org>; Mon,  4 Oct 2010 16:21:57 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s58zibXSyjiW for <git@vger.kernel.org>;
	Mon,  4 Oct 2010 16:21:50 -0400 (EDT)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id D7CA41E268DB
	for <git@vger.kernel.org>; Mon,  4 Oct 2010 16:21:50 -0400 (EDT)
In-Reply-To: <13399611.436896.1286218134223.JavaMail.root@mail.hq.genarts.com>
X-Mailer: Zimbra 6.0.7_GA_2473.UBUNTU8 (ZimbraWebClient - SAF3 (Mac)/6.0.7_GA_2473.UBUNTU8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158108>

Hi all-

I'm trying to improve the performance of Trac [1], the GitPlugin for Trac[2], and Git.  Trac is being extremely sluggish while browsing source, and profiling revealed the majority of the time was the GitPlugin calling git rev-list.  When I directly entered the rev-list calls from the shell, I found Git itself was performing slower than I would expect...

The bottleneck is while Trac is populating the "last change to file" column in the source browser (see the "rev" column of [3] for an *cough* SVN *cough* example).  This concept of "find the last change to a file" was discussed a few weeks ago [4], but unlike that thread, the GitPlugin is simply calling
   git rev-list --max-count=1 branchName -- fileName
for each file in the current directory.  For files modified recently this is very fast (thousandths of a second), but for older files rev-list takes a long time to come up with an answer (~2-3 seconds on our server).  

I created a script [5] that reproduces the rev-list behavior with 10k commits (ours is about 17k) and 500 files (we peaked at just under 600 in the root of our repo -- that's been cleaned up in the current version, but the history is still there).  On our system the test script fast case is:
   real 0m0.003s, user 0m0.000s, sys 0m0.010s
The slow case is
   real 0m1.072s, user 0m1.050s, sys 0m0.000s

If I naively profile Git I find the worst time offender is tree_entry_interesting with over 10 million calls in the slow case.  That seems high (even every commit, every file would be 500*10000=5 million), but I don't know anything about the actual search algorithm.

Is there anything obvious I can do about this performance bottleneck or is it just the nature of our repository?  Is there potentially a bug in how rev-list works with a pathspec?  Is there a more efficient way to obtain the last commit that changed each file in a directory?  (A hack I'm currently testing is just always return the current commit when Trac asks for the last change... that speeds things up but changes the user experience)

Thanks,
Stephen

References:
[1] http://trac.edgewall.org
[2] http://trac-hacks.org/wiki/GitPlugin
[3] http://trac.edgewall.org/browser/trunk
[4] http://article.gmane.org/gmane.comp.version-control.git/150183/
[5]
#!/bin/bash

git init big-repo
cd big-repo
touch foo
touch bar
for ii in {1..500}
do
   # create some files for background noise
   touch $ii
done
git add .
git commit -qm "initial import"

for ii in {1..10000}
do
   echo "Creating commit $ii"
   echo $ii >> foo
   git add foo
   git commit -qm "simple change $ii"

   if [ $(( $ii % 250 )) == 0 ]
   then
      echo "Running git gc ($ii)"
      git gc --quiet
   fi
done

# Fast case (last change is close to HEAD)
echo "git rev-list --max-count=1 HEAD -- foo ..."
time git rev-list --max-count=1 HEAD -- foo

# Slow case (last change is long before HEAD)
echo "git rev-list --max-count=1 HEAD -- bar ..."
time git rev-list --max-count=1 HEAD -- bar

cd ..

#rm -rf big-repo
