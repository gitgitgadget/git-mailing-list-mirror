From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFC] add test cases for the --repo option to git push
Date: Tue, 24 Feb 2009 18:40:40 +0100
Message-ID: <1235497240-20677-1-git-send-email-git@drmicha.warpmail.net>
References: <76718490902210132w2577c093tf8c2a5e7da8bc0e8@mail.gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 24 18:42:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lc1IX-0007Kt-92
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 18:42:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759028AbZBXRkx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 12:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758818AbZBXRkx
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 12:40:53 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:44292 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757305AbZBXRkw (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Feb 2009 12:40:52 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 18F852A469F;
	Tue, 24 Feb 2009 12:40:50 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 24 Feb 2009 12:40:50 -0500
X-Sasl-enc: LWa8duZ0EKizJBdQPsNHuTmOGLRR/DyX6l29fnKXS88L 1235497249
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 65911319D8;
	Tue, 24 Feb 2009 12:40:49 -0500 (EST)
X-Mailer: git-send-email 1.6.2.rc1.30.gd43c
In-Reply-To: <76718490902210132w2577c093tf8c2a5e7da8bc0e8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111324>

The --repo=myorigin option is supposed to change the default fallback
remote from "origin" to "myorigin", but not override any direct argument
nor config info of tracking branches. Add tests for this. (currently 2
known breakages)

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Tap tap tap....

This is an R for Comments on the desired behaviour of git push with
respect to --repo. I think the tests below expose that the current
behaviour does not match the current doc. I'm messing around in the code
but can't quite produce a match with the doc yet. Before investing more
time I'm wondering whether the code should adjusted to the doc or vice
versa...

The code change I'm experimenting with right now is making
default_remote_name a global and passing it from push. Does not look
nice (esp. w.r.t. libification) but seems to ibe the minimally invasive
solution.

 t/t5516-fetch-push.sh |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 89649e7..8393366 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -419,6 +419,41 @@ test_expect_success 'push with config remote.*.push = HEAD' '
 git config --remove-section remote.there
 git config --remove-section branch.master
 
+test_expect_success 'push with --repo=repourl from non-tracking branch' '
+
+	mk_test heads/master &&
+	git push --repo=testrepo &&
+	check_push_result $the_commit heads/master
+'
+
+# set up fake remote config
+test_expect_success 'push with --repo=remoterepo from non-tracking branch' '
+
+	mk_test heads/master &&
+	git config remote.testremote.url testrepo &&
+	git push --repo=testremote &&
+	check_push_result $the_commit heads/master
+'
+
+# set up fake tracking info; testrepo exists, origin does not.
+test_expect_failure 'push with --repo=repo from tracking branch with bad config' '
+
+	mk_test heads/master &&
+	git config branch.master.remote origin &&
+	test_must_fail git push --repo=testrepo
+'
+
+test_expect_failure 'push with --repo=repo from tracking branch with good config' '
+
+	mk_test heads/master &&
+	git config branch.master.remote testrepo &&
+	git push --repo=origin &&
+	check_push_result $the_commit heads/master
+'
+
+# clean up fake remote and tracking info
+git config --unset-all branch.master.remote
+
 test_expect_success 'push with dry-run' '
 
 	mk_test heads/master &&
-- 
1.6.2.rc1.30.gd43c
