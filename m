From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] clone: quell the progress report from init and report on clone
Date: Fri,  2 Apr 2010 00:03:06 +0200
Message-ID: <4462210481812dc3b720b34f59e3051a65e41336.1270159202.git.git@drmicha.warpmail.net>
References: <7v7houxu8n.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 02 00:02:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxSTU-000806-EM
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 00:02:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757910Ab0DAWCq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Apr 2010 18:02:46 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:44843 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755255Ab0DAWCp (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Apr 2010 18:02:45 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 6CF5BE99B6;
	Thu,  1 Apr 2010 18:02:44 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 01 Apr 2010 18:02:44 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=jgSEdxhnuy9eY9B46RE98sBTpeU=; b=pRmySxIT9GCTbo1e6pim5iCv/kXw/tV3eKTZukgxmem/WNMDtn8DUQi65dfO5PzizXUCYeIivApT5Ps4z8B1Z78/gxBbeiKPYFgWZqPl4+GGlvEeH2WI7wE6sd1v9J2enRR1FVF7SG5OBcyxijWz+Lr/NiaCBewae1m5uDZekHA=
X-Sasl-enc: HWBeg+X/ed4UCMN5VWMU8fdmlP9Q52g958QPP5DdK47W 1270159363
Received: from localhost (p3EE28F40.dip0.t-ipconnect.de [62.226.143.64])
	by mail.messagingengine.com (Postfix) with ESMTPSA id AC28949F03C;
	Thu,  1 Apr 2010 18:02:43 -0400 (EDT)
X-Mailer: git-send-email 1.7.0.3.448.g82eeb
In-Reply-To: <7v7houxu8n.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143753>

From: Junio C Hamano <gitster@pobox.com>

Currently, a local glit clone reports only initializing an empty
git dir, which is potentially confusing.

Instead, report that cloning is in progress and when it is done
(unless -q) is given, and suppres the init report (unless -v
is given).

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
I checked the documentation, there is really no place where the output
of git clone is documented - no documentation or test change is necesessary.

I made it so that -v will restore the init message. Other than that this is really
your path, Junio.

 builtin/clone.c  |    4 ++++
 t/t5601-clone.sh |    2 +-
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 05f8fb4..6e0584c 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -302,6 +302,8 @@ static const struct ref *clone_local(const char *src_repo,
 	transport = transport_get(remote, src_repo);
 	ret = transport_get_remote_refs(transport);
 	transport_disconnect(transport);
+	if (0 <= option_verbosity)
+		printf("done.\n");
 	return ret;
 }
 
@@ -462,6 +464,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	set_git_dir(make_absolute_path(git_dir));
 
 	init_db(option_template, (option_verbosity < 0) ? INIT_DB_QUIET : 0);
+	if (0 <= option_verbosity)
+		printf("Cloning into %s...\n", get_git_dir());
 
 	/*
 	 * At this point, the config exists, so we do not need the
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 2147567..678cee5 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -34,7 +34,7 @@ test_expect_success 'clone with excess parameters (2)' '
 test_expect_success 'output from clone' '
 	rm -fr dst &&
 	git clone -n "file://$(pwd)/src" dst >output &&
-	test $(grep Initialized output | wc -l) = 1
+	test $(grep Clon output | wc -l) = 1
 '
 
 test_expect_success 'clone does not keep pack' '
-- 
1.7.0.3.448.g82eeb
