From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 2/8] revert: use run_command_v_opt() instead of
	execv_git_cmd()
Date: Wed, 02 Jun 2010 07:58:35 +0200
Message-ID: <20100602055842.21504.65497.chriscool@tuxfamily.org>
References: <20100602055131.21504.71923.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	Antriksh Pany <antriksh.pany@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 02 07:59:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJgz7-0006sT-3K
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 07:59:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753357Ab0FBF7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 01:59:18 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:47773 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752231Ab0FBF7S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 01:59:18 -0400
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 1227C818100;
	Wed,  2 Jun 2010 07:59:09 +0200 (CEST)
X-git-sha1: 56c827e8b7477fd6c42cc1f1c16a92594d8a7d9c 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100602055131.21504.71923.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148210>

This is needed by the following commits, because we are going
to cherry pick many commits instead of just one.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/revert.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 5df0d69..02f18c2 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -508,6 +508,8 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 		}
 	}
 
+	free_message(&msg);
+
 	/*
 	 *
 	 * If we are cherry-pick, and if the merge did not result in
@@ -520,7 +522,9 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	if (!no_commit) {
 		/* 6 is max possible length of our args array including NULL */
 		const char *args[6];
+		int res;
 		int i = 0;
+
 		args[i++] = "commit";
 		args[i++] = "-n";
 		if (signoff)
@@ -530,9 +534,12 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 			args[i++] = defmsg;
 		}
 		args[i] = NULL;
-		return execv_git_cmd(args);
+		res = run_command_v_opt(args, RUN_GIT_CMD);
+		free(defmsg);
+
+		return res;
 	}
-	free_message(&msg);
+
 	free(defmsg);
 
 	return 0;
-- 
1.7.1.362.g8d752
