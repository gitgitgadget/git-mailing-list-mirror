From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 2/3] t9020-*.sh: Fix urls passed to git-remote in test setup
Date: Sat, 25 Aug 2012 18:18:42 +0100
Message-ID: <503908F2.8010303@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: florian.achleitner.2.6.31@gmail.com
X-From: git-owner@vger.kernel.org Sat Aug 25 19:29:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5KAW-0001GI-U5
	for gcvg-git-2@plane.gmane.org; Sat, 25 Aug 2012 19:29:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754518Ab2HYR24 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Aug 2012 13:28:56 -0400
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:50061 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753494Ab2HYR2z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2012 13:28:55 -0400
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id D15D4384080;
	Sat, 25 Aug 2012 18:28:53 +0100 (BST)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 174DF38407F;	Sat, 25 Aug 2012 18:28:53 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;	Sat, 25 Aug 2012 18:28:52 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204277>


In particular, the urls passed to git-remote have an extra '/' given
after the schema prefix, like so:

    git remote add svnsim testsvn::sim:///$TEST_DIRECTORY/t9154/svn.dump
    git remote add svnfile testsvn::file:///$TEST_DIRECTORY/t9154/svn.dump

Once the prefix is removed, the remainder of the url looks something
like "//home/ramsay/git/t/t9154/svn.dump", which is then interpreted
as a network path. Since there is "No such host or network path"
called "//home", this leads to the svnrdump_sim.py script to fail:

  Traceback (most recent call last):
    File ".../trash directory.t9020-remote-svn/svnrdump", line 51, in ?
      if writedump(url, r[0], r[1]): ret = 0
    File ".../trash directory.t9020-remote-svn/svnrdump", line 23, in writedump
      f = open(filename, 'r');
  IOError: [Errno 13] Permission denied: '//home/ramsay/git/t/t9154/svn.dump'

In order to fix the problem, we simply remove the extraneous '/'
character from the urls.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Florian,

This test fails on cygwin. Could you please squash this into
commit 2d597d73 ("Add a test script for remote-svn", 20-08-2012).

Thanks!

ATB,
Ramsay Jones

 t/t9020-remote-svn.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9020-remote-svn.sh b/t/t9020-remote-svn.sh
index 9ae9997..cd7604e 100755
--- a/t/t9020-remote-svn.sh
+++ b/t/t9020-remote-svn.sh
@@ -13,8 +13,8 @@ init_git () {
 	git init &&
 	#git remote add svnsim testsvn::sim:///$TEST_DIRECTORY/t9020/example.svnrdump
 	# let's reuse an exisiting dump file!?
-	git remote add svnsim testsvn::sim:///$TEST_DIRECTORY/t9154/svn.dump
-	git remote add svnfile testsvn::file:///$TEST_DIRECTORY/t9154/svn.dump
+	git remote add svnsim testsvn::sim://$TEST_DIRECTORY/t9154/svn.dump
+	git remote add svnfile testsvn::file://$TEST_DIRECTORY/t9154/svn.dump
 }
 
 if test -e "$GIT_BUILD_DIR/git-remote-testsvn"
-- 
1.7.12
