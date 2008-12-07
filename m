From: Thomas Jarosch <thomas.jarosch@intra2net.com>
Subject: help needed: Splitting a git repository after subversion migration
Date: Sun, 07 Dec 2008 18:41:01 +0100
Message-ID: <493C0AAD.1040208@intra2net.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 07 18:52:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9Nnn-00033J-Ix
	for gcvg-git-2@gmane.org; Sun, 07 Dec 2008 18:52:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751919AbYLGRti (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Dec 2008 12:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751692AbYLGRti
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Dec 2008 12:49:38 -0500
Received: from re01.intra2net.com ([82.165.28.202]:45443 "EHLO
	re01.intra2net.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751464AbYLGRth (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Dec 2008 12:49:37 -0500
X-Greylist: delayed 660 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Dec 2008 12:49:37 EST
Received: from intranator.m.i2n (unknown [172.16.1.99])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by re01.intra2net.com (Postfix) with ESMTP id 2E8C26428
	for <git@vger.kernel.org>; Sun,  7 Dec 2008 18:38:36 +0100 (CET)
Received: from localhost (intranator.m.i2n [127.0.0.1])
	by localhost (Postfix) with ESMTP id 97FB32AC4B
	for <git@vger.kernel.org>; Sun,  7 Dec 2008 18:38:35 +0100 (CET)
Received: from pikkukde.a.i2n (pikkukde.m.i2n [192.168.12.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by intranator.m.i2n (Postfix) with ESMTP id 74CF42AC4A
	for <git@vger.kernel.org>; Sun,  7 Dec 2008 18:38:34 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (X11/20081119)
X-Virus-Scanned: by Intranator (www.intranator.com) with AMaViS and F-Secure AntiVirus (fsavdb 2008-12-07_01)
X-Spam-Status: hits=-1.8 tests=[ALL_TRUSTED=-1.8,BAYES_50=0.001]
X-Spam-Level: 982
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102503>

Hello together,

I've successfully imported a large subversion repository into git.
The tree contains source code and binary data ("releases"),
the resulting .git directory is about 11GB.

After the import I recreated the tags/branches by converting the refs
to the subversion tags using a small shell script from the web:

for branch in `git branch -r`; do
     ...
     version=`basename $branch`
     git tag -s -f -m "$subject" "$version" "$branch^"
     git branch -d -r $branch
done

Ok, so far everything went really smooth. I wanted to split this repository
into two repositories, one for the source code and one for the binary data.
The current tree layout is like this:

sources/c++_xyz
releases/large_binary_data
...

The original tree was imported from CVS to subversion and the layout
of the trunk was once reorganized/moved later. Here's the command
I used to split out the "source" tree:

git filter-branch --index-filter 'git rm --cached --ignore-unmatch -r -f
CVSROOT Attic source/Attic develpkg/Attic
source/packages/Attic releases update_pkg' -- --all

After that I ran these commands to reclaim the space:
- git clone --no-hardlinks filtered_tree final_output
- cd final_output
- git gc
- git prune
- git repack -a -d --depth=250 --window=250

Unfortunately the .git directory of the "source" tree is still 7.5GB big.

When I just imported the "trunk" from subversion without any tags
and then ran "git filter-branch --subdirectory-filter source" + git gc,
the .git directory was about 1.5GB afterwards.

How can I find out where those other 6GB go to?
I already looked at the tags with gitk,
there's no sign of the releases/* stuff left.

The "--all" switch for "git filter-branch"
doesn't seem documented in git 1.6.0.4?
I just learned about it from the example usage.

"git filter-branch" also had trouble converting the tags
and suggested I should add "--tag-name-filter cat", which I did.
Maybe that's something for the examples, too?

I also tried running "git filter-branch --tag-name-filter cat 
--subdirectory-filter source -- --all", but that commands aborts
with these messages:

WARNING: 'refs/tags/v5-0-8' was rewritten into multiple commits:
ee180f6117597b60ee237e9da92047946dfdeec5
fd7824d1926ce9e4c89b685583eb9a9c2f2537af
WARNING: Ref 'refs/tags/v5-0-8' points to the first one now.
error: Ref refs/tags/v5-0-8 is at 4ea78238cfd6ee259c4e8bde7be4a90bc86295b0 
but expected 06c60261502acfb7b2bbe44c2e2ec371bea65827
fatal: Cannot lock the ref 'refs/tags/v5-0-8'.
Could not rewrite refs/tags/v5-0-8


Besides that git really rocks :-)

Thanks in advance,
Thomas
