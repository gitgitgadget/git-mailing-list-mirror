From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/4] tmp: remote-helper: add timers to catch errors
Date: Mon,  1 Apr 2013 15:46:43 -0600
Message-ID: <1364852804-31875-4-git-send-email-felipe.contreras@gmail.com>
References: <1364852804-31875-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>, Aaron Schrab <aaron@schrab.com>,
	Clemens Buchacher <drizzd@aon.at>,
	David Michael Barr <b@rr-dav.id.au>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 01 23:48:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMmaX-0003mS-2P
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 23:48:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758973Ab3DAVrv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Apr 2013 17:47:51 -0400
Received: from mail-gh0-f169.google.com ([209.85.160.169]:63412 "EHLO
	mail-gh0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758702Ab3DAVrt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Apr 2013 17:47:49 -0400
Received: by mail-gh0-f169.google.com with SMTP id r18so470615ghr.28
        for <git@vger.kernel.org>; Mon, 01 Apr 2013 14:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=7jlsfrn3VIsxmkJVqHQ7m13p1CXSOcVt279rNw2ybY0=;
        b=azUDOIw0n+tQewQ1bdoa4+kqVNMEI5YzQpvZjRGGHZhd734lSgBMmI0t95+QfuhvIu
         iODem75dwLk4udTmtyF3N4e8d+ckPjXwL8BRzKmrtzbm0m2v+GOp153rHiwQPI9Z3Odo
         fWJzrghnnbCk0fN3/shORD+q4m4NPr1lD/JZIiFiBRqHHxFQ9cyzD5bXciYJ38X9g0y3
         GAYnd4xaFvoLKdavDLKrlCF+wfgS5L3Jk6Gr6rh64r1AR8CtogiblFtE1kC4Zlco1sUL
         g6vKPyiX3rtYn087IYmUrYLQla1VsiwJ5DcoCGNgxPkfFurWL6vvDcCvBBR9dVWV3dvx
         DE4w==
X-Received: by 10.236.135.231 with SMTP id u67mr12107456yhi.135.1364852869164;
        Mon, 01 Apr 2013 14:47:49 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id o31sm30072510yhh.21.2013.04.01.14.47.46
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Apr 2013 14:47:48 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1364852804-31875-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219715>

This way the test reliably succeeds (in catching the failure).

Not sure what's the proper way to do this, but here it is for the
record.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-remote-testgit        | 1 +
 t/t5801-remote-helpers.sh | 2 +-
 transport-helper.c        | 3 +++
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/git-remote-testgit b/git-remote-testgit
index ca0cf09..6ae1b7f 100755
--- a/git-remote-testgit
+++ b/git-remote-testgit
@@ -75,6 +75,7 @@ do
 	export)
 		if test -n "$GIT_REMOTE_TESTGIT_FAILURE"
 		then
+			sleep 1 # don't let fast-export get SIGPIPE
 			exit -1
 		fi
 
diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 26e9a5b..5bb2ca4 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -176,7 +176,7 @@ test_expect_success 'proper failure checks for fetching' '
 '
 
 # We sleep to give fast-export a chance to catch the SIGPIPE
-test_expect_failure 'proper failure checks for pushing' '
+test_expect_success 'proper failure checks for pushing' '
 	(GIT_REMOTE_TESTGIT_FAILURE=1 &&
 	export GIT_REMOTE_TESTGIT_FAILURE &&
 	cd local &&
diff --git a/transport-helper.c b/transport-helper.c
index dfdfa7a..f0d28aa 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -823,6 +823,9 @@ static int push_refs_with_export(struct transport *transport,
 	if (finish_command(&exporter))
 		die("Error while running fast-export");
 
+	if (getenv("GIT_REMOTE_TESTGIT_FAILURE"))
+		sleep(2);
+
 	if (!check_command(data->helper))
 		die("Error while running helper");
 
-- 
1.8.2
