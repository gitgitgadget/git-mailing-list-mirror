From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: git-diff-cache uses checked-out-working-directory-files if files are newer than the cache entry
Date: Fri, 6 May 2005 00:37:27 +0200
Message-ID: <20050505223727.GR20994@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri May 06 00:31:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTos2-0006Gc-6B
	for gcvg-git@gmane.org; Fri, 06 May 2005 00:31:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbVEEWhh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 May 2005 18:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbVEEWhg
	(ORCPT <rfc822;git-outgoing>); Thu, 5 May 2005 18:37:36 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:15551 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261976AbVEEWh3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2005 18:37:29 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j45MbRS8004490
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Thu, 5 May 2005 22:37:28 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j45MbR2A004489
	for git@vger.kernel.org; Fri, 6 May 2005 00:37:27 +0200 (CEST)
To: GIT <git@vger.kernel.org>
Mail-Followup-To: GIT <git@vger.kernel.org>
Content-Disposition: inline
X-URL: http://wwwcip.informatik.uni-erlangen.de/~sithglan/
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,
I have trouble with git-diff-cache, because it uses the file from the
working directory instead of the cache file if the working directory is
newer than the entry in the cache:

	(faui01) [~/work/git/git] echo 1 > 1
	(faui01) [~/work/git/git] ./git-update-cache --add 1
	(faui01) [~/work/git/git] ./git-diff-cache -r HEAD
	+100644 blob    d00491fd7e5bb6fa28c517a0bb32b8b506539d4d        1
	(faui01) [~/work/git/git] echo 2 > 1
	(faui01) [~/work/git/git] ./git-diff-cache -r HEAD
	+100644 blob    0000000000000000000000000000000000000000        1
	(faui01) [~/work/git/git] ./git-diff-cache -p -r HEAD
	Created: 1 (mode:100644)
	--- /dev/null
	+++ b/1
	@@ -0,0 +1 @@
	+2

Note this Output is wrong because the '1' get committed, if I call write-tree

	(faui01) [~/work/git/git] write-tree
	5a38ca90309671c5029f32f67e1aba970a4f1e08
	(faui01) [~/work/git/git] ./git-ls-tree 5a38ca90309671c5029f32f67e1aba970a4f1e08 | grep 1\$
	100644  blob    d00491fd7e5bb6fa28c517a0bb32b8b506539d4d        1
	040000  tree    9823f134bfb89097ce796f931d3efc92aadfcfbf        mozilla-sha1

Same for modification:

	(faui01) [~/work/git/git] echo 1 >> COPYING
	(faui01) [~/work/git/git] update-cache COPYING
	(faui01) [~/work/git/git] ./git-diff-cache -r HEAD
	*100644->100644 blob    6ff87c4664981e4397625791c8ea3bbb5f2279a3->c17665dc78a012a55b11d083bfa065d8cd2b0df1      COPYING
	(faui01) [~/work/git/git] echo 2 >> COPYING
	(faui01) [~/work/git/git] ./git-diff-cache -r HEAD
	*100644->100644 blob    6ff87c4664981e4397625791c8ea3bbb5f2279a3->0000000000000000000000000000000000000000      COPYING
	(faui01) [~/work/git/git] write
	write       write-tree  writevt
	(faui01) [~/work/git/git] write-tree
	a3f88e4c7c6818ee880d97bf3293ea56fe12c478
	(faui01) [~/work/git/git] ./git-ls-tree a3f88e4c7c6818ee880d97bf3293ea56fe12c478 | grep COPYING\$
	100644  blob    c17665dc78a012a55b11d083bfa065d8cd2b0df1        COPYING

Is this behaviour intended? I would like to see that git-diff-cache
doesn't even look at the working directory but only operates on the
cache.

Greetings,
	Thomas
