From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH/RFC] config: Give error message when not changing a multivar
Date: Tue, 17 May 2011 13:34:58 +0200
Message-ID: <42ab57ae5a2cb7d6860e43e7c3061f9c38cf1b99.1305632091.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 17 13:35:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMIYQ-00021L-R1
	for gcvg-git-2@lo.gmane.org; Tue, 17 May 2011 13:35:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753901Ab1EQLfD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2011 07:35:03 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:41917 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753272Ab1EQLfD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 May 2011 07:35:03 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 3974320940
	for <git@vger.kernel.org>; Tue, 17 May 2011 07:35:01 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Tue, 17 May 2011 07:35:01 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:subject:date:message-id; s=smtpout; bh=s6TmUBDgN3xTsAUtIay+Z4OPxWk=; b=U8d4Zp7bxdl51l1L/V7CrCtSSnGvuBWFrBdBzEcFnO3fHEGM+8QeaDpWrEVn5vg/yqGS1RZSWVrZMqsMLTEEyMRW1YiQGtMcIExAYb8sNMSSwhRPHsLvCJ0zwObykZN5jk/SzK7DP5mwvJWe01XetOUXaOVbRCXJQyVhdO4BJYc=
X-Sasl-enc: 6Wj8TQQsoXeqf4It+FX2My1Sr/qSMp0w+9s45pp5xglu 1305632100
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id AFD38443153;
	Tue, 17 May 2011 07:35:00 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.1.514.gd181fb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173794>

When trying to set a multivar with "git config var value", "git config"
issues

warning: remote.repoor.push has multiple values

leaving the user under the impression that the operation succeeded,
unless one checks the return value.

Instead, make it

warning: remote.repoor.push has multiple values
error: Use a regexp, --add or --set-all to change remote.repoor.push.

to be clear and helpful.

Note: The "warning" is raised through other code paths also so that it
needs to remain a warning for these (which do not raise the error). Only
the caller can determine how to go on from that.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin/config.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 3e3c528..c438ef4 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -436,9 +436,13 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			      NULL, NULL);
 	}
 	else if (actions == ACTION_SET) {
+		int ret;
 		check_argc(argc, 2, 2);
 		value = normalize_value(argv[0], argv[1]);
-		return git_config_set(argv[0], value);
+		ret = git_config_set(argv[0], value);
+		if (ret == 5)
+			error("Use a regexp, --add or --set-all to change %s.", argv[0]);
+		return ret;
 	}
 	else if (actions == ACTION_SET_ALL) {
 		check_argc(argc, 2, 3);
-- 
1.7.5.1.514.gd181fb
