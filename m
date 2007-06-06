From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: git does the wrong thing with ambiguous names
Date: Wed, 06 Jun 2007 17:13:48 -0500
Message-ID: <4667319C.9070302@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 07 00:14:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hw3lO-0002VW-My
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 00:13:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935684AbXFFWNy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 18:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935638AbXFFWNy
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 18:13:54 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:46961 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935568AbXFFWNx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 18:13:53 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id l56MBm96012820
	for <git@vger.kernel.org>; Wed, 6 Jun 2007 17:11:51 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 6 Jun 2007 17:13:49 -0500
User-Agent: Thunderbird 2.0.0.0 (X11/20070326)
X-OriginalArrivalTime: 06 Jun 2007 22:13:49.0346 (UTC) FILETIME=[F5561820:01C7A887]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-3.6.0.1039-15220001
X-TM-AS-Result: : Yes--10.819500-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTQ3MDE4LTcwMzc4OC03MDE1?=
	=?us-ascii?B?NzYtNzAzMTc2LTcwNDE3OS03MDU1MDgtNzAyOTAwLTcwNTg2MS03?=
	=?us-ascii?B?MDQ0MzAtNzAyMTkyLTcwMzgwMi03MDY3MjUtNzAxNTU5LTcwMDc1?=
	=?us-ascii?B?Ni0xMzk3MDMtNzAwODU1LTcwMTQ2MS03MDAzNzMtNzAwNDc2LTcw?=
	=?us-ascii?B?MTMwNS03MDMzMzAtNzAxOTE0LTcwNDc3NC03MDA1NzMtNzAzNzEy?=
	=?us-ascii?B?LTcwMDk3MC0xMzYwNzAtNzAzMjY3LTcwMDYyNC03MDY4OTEtNzAy?=
	=?us-ascii?B?MDg0LTcwMDE2MC03MDM1MjktNzA0NDI1LTcwMDk3MS0xODgwMTkt?=
	=?us-ascii?B?NzAwMzI0LTcwNDU2OC03MDE0MDctNzAxMjk5LTcwNDQyMS0xMDUy?=
	=?us-ascii?B?NTAtNzA1NDUwLTE0ODA1MQ==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49326>


When a branch and tag have the same name, a git-checkout using that name 
succeeds (exits zero without complaining), switches to the _branch_, but 
updates the working directory contents to that specified by the _tag_. 
git-status show modified files.

Looks like the ambiguity issue was brought up last year, and git is now 
*supposed* to warn when it encounters an ambiguous name. I agree with 
Petr, it should fail violently, preferably as Josef Weidendorfer 
suggests also printing out the ambiguous matches so the user can cut and 
paste.

http://article.gmane.org/gmane.comp.version-control.git/17720

But it doesn't, git-checkout.sh redirects stderr on git-rev-parse 
--verify so the message is lost. git-log complains, but most users will 
never see it since it is pushed off the screen so quickly.

In another portion of the same thread Junio describes the caveats and 
his experience:

http://article.gmane.org/gmane.comp.version-control.git/16996

The tag==branch name case is trivial to reproduce and a test script is 
provided below. It should fail, so it's not really a submission as a 
test script until this is fixed.

-brandon

ps. I was told a previous patch was ws munged. I'm using thunderbird, if 
it happens this time suggestions welcome.



Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
  t/t2006-checkout-name-clash.sh |   39 
+++++++++++++++++++++++++++++++++++++++
  1 files changed, 39 insertions(+), 0 deletions(-)
  create mode 100755 t/t2006-checkout-name-clash.sh

diff --git a/t/t2006-checkout-name-clash.sh b/t/t2006-checkout-name-clash.sh
new file mode 100755
index 0000000..2220578
--- /dev/null
+++ b/t/t2006-checkout-name-clash.sh
@@ -0,0 +1,39 @@
+#!/bin/sh
+
+test_description='git-checkout with tag/branch naming clash
+
+This tests whether git does something sane when a tag
+and a branch have the same name.'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+echo initial >file1 &&
+echo initial >file2 &&
+git-add file1 file2 &&
+git-commit -m initial
+'
+
+test_expect_success 'create modified branch named test' '
+git-branch test &&
+git-checkout test &&
+echo test >file1 &&
+git-commit -a -m test
+'
+
+test_expect_success 'create tag named test on master branch' '
+git-checkout master &&
+git-tag test
+'
+
+test_expect_success 'modify master and commit' '
+echo master >file2 &&
+git-commit -a -m master
+'
+
+test_expect_success 'checkout test and check consistency' '
+git-checkout test &&
+test "`git diff-index --name-only HEAD`" = ""
+'
+
+test_done
-- 
1.5.2.1.126.g6abd0
