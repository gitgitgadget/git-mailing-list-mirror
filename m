From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] clone: quell the progress report from init and report on clone
Date: Fri, 23 Apr 2010 14:37:22 +0200
Message-ID: <35f1aab26b685ab5f124cfe1bf99b2d3a9fbaaa5.1272025319.git.git@drmicha.warpmail.net>
References: <1270386135.1675.1368217929@webmail.messagingengine.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 23 14:40:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5IBS-0002CW-BM
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 14:40:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757015Ab0DWMkc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Apr 2010 08:40:32 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:48775 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756741Ab0DWMkc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Apr 2010 08:40:32 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 44BE6EB407;
	Fri, 23 Apr 2010 08:40:31 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 23 Apr 2010 08:40:31 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=rqh+d6mGTOqUFlQFf2gfkPtpYqs=; b=miuiicSAnZtQh0bmgaMK2A3a13PCG1fW/hj+ZJTgXUDhUEDzOC6ZXhvzSbXrfe6b32gvydNXCUfIOdoYfbMAkIg9M29L6X9nSkm4hWlppORA7EMTcFXn/Tr+hL1GVpp6zD+vKQ1tGP3t5tTY8QMg2llZ2VhnM30iZWQquv61H/Q=
X-Sasl-enc: 6jGPXLBuf9wPHD/XExq71wXewebIWz/mTiQuup8oW0+3 1272026430
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id ACEBD2C097;
	Fri, 23 Apr 2010 08:40:30 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.rc1.248.gcefbb
In-Reply-To: <1270386135.1675.1368217929@webmail.messagingengine.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145613>

From: Junio C Hamano <gitster@pobox.com>

Currently, a local git clone reports only initializing an empty
git dir, which is potentially confusing.

Instead, report that cloning is in progress and when it is done
(unless -q) is given, and suppress the init report.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Basically this is your patch now, Junio, which is why it disappeared from my
radar. But I don't think you applied it, so I'm resubmitting.

v2 shuts up init unconditionally (even with -v), as you preferred.

 builtin/clone.c  |    6 +++++-
 t/t5601-clone.sh |    2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 05f8fb4..0bedde4 100644
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
 
@@ -461,7 +463,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		die("could not create leading directories of '%s'", git_dir);
 	set_git_dir(make_absolute_path(git_dir));
 
-	init_db(option_template, (option_verbosity < 0) ? INIT_DB_QUIET : 0);
+	if (0 <= option_verbosity)
+		printf("Cloning into %s...\n", get_git_dir());
+	init_db(option_template, INIT_DB_QUIET);
 
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
1.7.1.rc1.248.gcefbb
