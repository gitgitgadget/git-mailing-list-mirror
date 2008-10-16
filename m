From: Andriy Gapon <avg@icyb.net.ua>
Subject: git-svn and svnsync
Date: Thu, 16 Oct 2008 11:07:13 +0300
Message-ID: <48F6F631.90709@icyb.net.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 16 11:03:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqOkk-0006mh-Fz
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 11:02:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755365AbYJPJBX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 05:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755360AbYJPJBW
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 05:01:22 -0400
Received: from hosted.kievnet.com ([193.138.144.10]:64363 "EHLO
	hosted.kievnet.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755105AbYJPJBU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 05:01:20 -0400
X-Greylist: delayed 3240 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Oct 2008 05:01:20 EDT
Received: from localhost ([127.0.0.1] helo=edge.pp.kiev.ua)
	by hosted.kievnet.com with esmtpa (Exim 4.62)
	(envelope-from <avg@icyb.net.ua>)
	id 1KqNt7-0009Tu-Qb
	for git@vger.kernel.org; Thu, 16 Oct 2008 11:07:17 +0300
User-Agent: Thunderbird 2.0.0.17 (X11/20081005)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98353>


I did the following:
1. mirror svn repository using svnsync
2. clone the mirror with git-svn --use-svnsync-props and some tweaking[*]
3. run git svn info in the clone
4. get error "Unable to determine upstream SVN information from working 
tree history"

git svn log and git svn rebase do not work either.
git log does work.

I have git version 1.6.0.2 (from FreeBSD ports).
[*] About the tweaking - I manually massaged config file to get the 
branches I was interested in, so .git/config is this:
[core]
         repositoryformatversion = 0
         filemode = true
         bare = false
         logallrefupdates = true
[svn-remote "svn"]
         useSvnsyncProps = 1
         url = file:///system/devel/svn/base
         fetch = head:refs/remotes/trunk
         fetch = stable/6:refs/remotes/stable_6
         fetch = stable/7:refs/remotes/stable_7
         fetch = releng/6.3:refs/remotes/releng_6_3
         fetch = releng/6.4:refs/remotes/releng_6_4
         fetch = releng/7.0:refs/remotes/releng_7_0
         fetch = release/6.3.0:refs/remotes/release_6_3_0
         fetch = release/7.0.0:refs/remotes/release_7_0_0

This is .git/svn/.metadata:
; This file is used internally by git-svn
; You should not have to edit it
[svn-remote "svn"]
         reposRoot = file:///system/devel/svn/base
         uuid = ccf9f872-aa2e-dd11-9fc8-001c23d0bc1f
         svnsync-uuid = ccf9f872-aa2e-dd11-9fc8-001c23d0bc1f
         svnsync-url = svn://svn.freebsd.org/base

So you can see the original svn repository URL.

git log reports svn info like the following:
git-svn-id: svn://svn.freebsd.org/base/stable/7@183898 
ccf9f872-aa2e-dd11-9fc8-001c23d0bc1f

It seems that the problem is that the code in find_by_url() and/or 
read_all_remotes() subroutines (in git-svn.perl) are not aware of 
svnsync and do not realize an URL in logs and URL in svn-remote are 
different.
BTW, I see that there is some special svm logic in read_all_remotes.

Thank you very much for any help in advance.

-- 
Andriy Gapon
