X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Steven Grimm <koreth@midwinter.com>
Subject: git-svn can lose changes silently
Date: Wed, 08 Nov 2006 16:34:46 -0800
Message-ID: <455277A6.2000404@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 9 Nov 2006 00:35:09 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=gkorAR+Z0H0GGmbjfnkrJYVQjrqEseXanYr/z1cpS0PMGNyO9yqBv3+CVQScnQlk  ;
User-Agent: Mail/News 1.5.0.2 (Macintosh/20060324)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31171>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ghxsl-0001Cz-Si for gcvg-git@gmane.org; Thu, 09 Nov
 2006 01:35:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965757AbWKIAe7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006
 19:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965767AbWKIAe7
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 19:34:59 -0500
Received: from tater.midwinter.com ([216.32.86.90]:15752 "HELO
 midwinter.com") by vger.kernel.org with SMTP id S965757AbWKIAe6 (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006 19:34:58 -0500
Received: (qmail 4126 invoked from network); 9 Nov 2006 00:34:58 -0000
Received: from localhost (HELO ?127.0.0.1?) (koreth@127.0.0.1) by localhost
 with SMTP; 9 Nov 2006 00:34:57 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

git-svn is happy to overwrite changes in the svn repository with no 
warnings. Didn't seem to be known behavior when I mentioned it in #git, 
so here's an example, starting completely from scratch to make it easier 
to reproduce. I'm using git-svn 1.4.3 and svn 1.2.3 on OS X.

First I create a new svn repository and stick a test file there:

% mkdir /tmp/svntest
% cd /tmp/svntest
% svnadmin create svn-repo
% svn co file:///tmp/svntest/svn-repo /tmp/svntest/svn-client
Checked out revision 0.
% cd /tmp/svntest/svn-client
% mkdir -p project/trunk
% echo "initial contents" > project/trunk/testfile
% svn add project/trunk/testfile
svn: 'project/trunk' is not a working copy
% svn add project
A         project
A         project/trunk
A         project/trunk/testfile
% svn commit -m "initial commit"
Adding         project
Adding         project/trunk
Adding         project/trunk/testfile
Transmitting file data .
Committed revision 1.

Now I clone that svn repository using git-svn and pull in the contents 
of the svn repo:

% cd /tmp/svntest
% git-svn init file:///tmp/svntest/svn-repo/project/trunk git-repo 
% cd git-repo
% git-svn fetch
        A       project/trunk/testfile
Committing initial tree 9ca0a5a8cb5ee41744aaf17f859e945f2ebaa7d4
r1 = 63c70a5e17ffb095a31e96b1a56612f1f8423202

Now I create a development branch and commit a change to the test file:

% git-checkout -b devel
% echo "a second line from the git side" >> testfile
% git-commit -a -m "git-side commit"

Now I go make a change on the svn side and commit it.

% cd /tmp/svntest/svn-client/project/trunk
% echo "a second line from the svn side" >> testfile
% svn commit -m "a second svn commit"
Sending        trunk/testfile
Transmitting file data .
Committed revision 2.

At this point the svn repository has the testfile with two lines: 
"initial contents" and "a second line from the svn side". Now, back on 
the git side, I commit my git-side change to svn (here's where the bug 
happens):

% cd /tmp/svntest/git-repo
% git-svn dcommit                     
diff-tree 679c0db253781216b9b72b51f2dfffec5711f1a3~1 
679c0db253781216b9b72b51f2dfffec5711f1a3
        M       testfile
Committed 3
        M       project/trunk/testfile
r2 = 7d7923588ffb41eb756959d71623581df9318603
        M       project/trunk/testfile
r3 = 25a5fefe01389260274bb2617bc36a2cce18f15d
No changes between current HEAD and refs/remotes/git-svn
Hard resetting to the latest refs/remotes/git-svn

Finally, I go back to the svn side and update from the repo:

% cd /tmp/svntest/svn-client
% svn up
U    project/trunk/testfile
Updated to revision 3.
% cat project/trunk/testfile
initial contents
a second line from the git side

The change I checked in from the svn side has vanished without a trace, 
no warning messages or anything.

It is probably not a feature that you can lose changes without knowing 
about it! Even if I'd run git-svn fetch before that commit, it still 
wouldn't help if the svn version of the file changed between the time I 
ran fetch and the time I ran dcommit, totally possible with a busy svn 
repository.

Opinions? Suggestions on fixing it? Do other people agree this is a bug?

