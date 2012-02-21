From: Ivan Tolstosheyev <ivan.tolstosheyev@gmail.com>
Subject: Git tree object storing policy
Date: Tue, 21 Feb 2012 09:22:12 +0000 (UTC)
Message-ID: <loom.20120221T094746-680@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 21 10:25:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzlyE-0006jd-RG
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 10:25:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754061Ab2BUJZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 04:25:08 -0500
Received: from plane.gmane.org ([80.91.229.3]:42111 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753442Ab2BUJZF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 04:25:05 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Rzly3-0006e9-Ve
	for git@vger.kernel.org; Tue, 21 Feb 2012 10:25:04 +0100
Received: from dhcp-217-126-wifi.yandex.net ([213.180.217.126])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 21 Feb 2012 10:25:03 +0100
Received: from ivan.tolstosheyev by dhcp-217-126-wifi.yandex.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 21 Feb 2012 10:25:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 213.180.217.126 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.46 Safari/535.11 YE)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191146>

Hello,

now tree object is a simple list of <attributes, hash, name>sorted by name
(tricky sorted, cause we assuming that directory name "$X" is actually "$X/"
in comparison function). The problem is, that if I want to insert 10k files
in empty git repository on / folder there will be 10k new 
trees with sizes from (1 to 10k)*(hash+name+attribute)+eps  .

itroot@localhost ~/tmp> cat git-test.sh 
#!/usr/bin/env bash

git init test
cd test
for i in `seq 1 10000` 
do
touch ${i} ; git add ${i} ; git commit -m "Add ${i}" ;
done
cd ..
du -hs test
itroot@localhost ~/tmp>

itroot@localhost ~/tmp> ./git-test.sh
...
180M	test
itroot@localhost ~/tmp>

180 MB!!!?? and 7.4M after `git gc` - thanks to delta compression!

Ok, you can say that this example is artificial, and I can add 10k files
with 1 commit. Thats true. But manipulating files in big tree objects
(in a big directories) is storage-expensive, and if I need to store a 
lot of files in one directory and frequently change them - git just
don't scales now properly at this use-case.

What do I propose? 
We can add another git object, named for example "btree" , 
that contains another "btree" objects or files.  This will be a simple
btree structure (tree entries sorted practically by name, BTW,
maybe it's time to fix sorting =] ), that allows us to do insertion,
removal, search in ln(n) time. But - we do not have troubles 
with big direcories now. BTW, if all directories are small, btree
will be tree-like - just btree pointing to  files.
So, one big tree with 10k files transforms to (hmm, for example...)
101 btrees - one, pointing to 100 btrees, and thay points to files.
(100 entries per btree is a wild guess =) )

Suggestions?

 
