From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] branch.c: use the parsed branch name
Date: Fri, 19 Aug 2011 13:45:43 +0200
Message-ID: <8258e2fc0a61642053e285c4f498e7cf1d2dc7df.1313754086.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 19 13:45:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuNWJ-0004NI-8G
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 13:45:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752642Ab1HSLpr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Aug 2011 07:45:47 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:56862 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751378Ab1HSLpq (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Aug 2011 07:45:46 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.messagingengine.com (Postfix) with ESMTP id D95A121445
	for <git@vger.kernel.org>; Fri, 19 Aug 2011 07:45:45 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute4.internal (MEProxy); Fri, 19 Aug 2011 07:45:45 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:subject:date:message-id; s=
	smtpout; bh=NuILfgqAJZxM6Rpsx1AxuYwAuIY=; b=eiPrLAGBm0ezvd9W5Mu5
	2Shy8rn7YAK3RX+9pXUKEE7WoO3tNXOAgYYIeeZcFdUEKl5EIRmf8seZOy8Ntayy
	0lgbS66xBP0dVR0FJMYaMI0e09CFj9HWoCqDcxjxKXZr5VD+bluu2JIzZ3+h/M2A
	NKwvflJ1ySYXPFK5zr4lU94=
X-Sasl-enc: gqoE+CQRic9ZUTyB8uA402NJKBjze1uNDIO/9eN2sYC1 1313754345
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 5897C8C0029;
	Fri, 19 Aug 2011 07:45:45 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.678.gaaad0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179692>

When setting up tracking info, branch.c uses the given branch specifier
("name"). Use the parsed name ("ref.buf") instead so that

git branch --set-upstream @{-1} foo

sets up tracking info for the previous branch rather than for a branch
named "@{-1}".

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
That's actually 1 of n in my branch pattern series, but independent,
and ready to go now.

 branch.c                 |    2 +-
 t/t6040-tracking-info.sh |   14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/branch.c b/branch.c
index c0c865a..d62cc01 100644
--- a/branch.c
+++ b/branch.c
@@ -210,7 +210,7 @@ void create_branch(const char *head,
 			 start_name);
 
 	if (real_ref && track)
-		setup_tracking(name, real_ref, track);
+		setup_tracking(ref.buf+11, real_ref, track);
 
 	if (!dont_change_ref)
 		if (write_ref_sha1(lock, sha1, msg) < 0)
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index a9b0ac1..19de5b1 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -110,4 +110,18 @@ test_expect_success '--set-upstream does not change branch' '
 	grep -q "^refs/heads/master$" actual &&
 	cmp expect2 actual2
 '
+
+test_expect_success '--set-upstream @{-1}' '
+	git checkout from-master &&
+	git checkout from-master2 &&
+	git config branch.from-master2.merge > expect2 &&
+	git branch --set-upstream @{-1} follower &&
+	git config branch.from-master.merge > actual &&
+	git config branch.from-master2.merge > actual2 &&
+	git branch --set-upstream from-master follower &&
+	git config branch.from-master.merge > expect &&
+	test_cmp expect2 actual2 &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.7.6.678.gaaad0
