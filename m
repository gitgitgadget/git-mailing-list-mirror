From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v6 23/45] builtin-am: handle stray state directory
Date: Mon, 20 Jul 2015 00:10:15 +0800
Message-ID: <1437322237-29863-24-git-send-email-pyokagan@gmail.com>
References: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 19 18:12:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGrC2-0006Qd-6w
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 18:11:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754008AbbGSQLx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 12:11:53 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:33286 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753976AbbGSQLq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 12:11:46 -0400
Received: by pdbnt7 with SMTP id nt7so18812084pdb.0
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 09:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jB1A/ghhL6mQwGIFB7qlQmY4xTOeHnHdOYuUNV1idFQ=;
        b=esDLJn+wSjuOh1UEOpXTTLQQA1QSDmp4+iUTNU8qxamYeHZcEtFsvIYgnnxL7cQhp0
         hS/kOftXddX00H6lMhKXPjNnAwtX/RDbfCrAwyPpeWZ8Q4GYvL5E2JdcxZcI+6UUqfSA
         nb4UF8ol0bk6eg82HbX9PW5kLbd64NUTwIF2Xtzj/0eGhLJtrQHN0aNuk11Bagls+pqf
         VGUbh8DRsQf27rp1UzAZ2hkJRDD1fCo1Vtd9Q4gThkRTF4PocRtx184/Q/WON2Zwc7ol
         ka2YJsVqyGxZbE80gvTbl9vB9mZxxYjPu3JWfJN4DxsRjagT20mKBIS+jMwyc/Vhun1E
         g3PQ==
X-Received: by 10.70.90.230 with SMTP id bz6mr49094826pdb.120.1437322306137;
        Sun, 19 Jul 2015 09:11:46 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id cq5sm17317869pad.11.2015.07.19.09.11.43
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jul 2015 09:11:45 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.110.gb39b692
In-Reply-To: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274247>

Should git-am terminate unexpectedly between the point where the state
directory is created, but the "next" and "last" files are not written
yet, a stray state directory will be left behind.

As such, since b141f3c (am: handle stray $dotest directory, 2013-06-15),
git-am.sh explicitly recognizes such a stray directory, and allows the
user to remove it with am --abort.

Re-implement this feature in builtin/am.c.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index 01f01bf..398debf 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1531,6 +1531,23 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		struct argv_array paths = ARGV_ARRAY_INIT;
 		int i;
 
+		/*
+		 * Handle stray state directory in the independent-run case. In
+		 * the --rebasing case, it is up to the caller to take care of
+		 * stray directories.
+		 */
+		if (file_exists(state.dir) && !state.rebasing) {
+			if (resume == RESUME_ABORT) {
+				am_destroy(&state);
+				am_state_release(&state);
+				return 0;
+			}
+
+			die(_("Stray %s directory found.\n"
+				"Use \"git am --abort\" to remove it."),
+				state.dir);
+		}
+
 		if (resume)
 			die(_("Resolve operation not in progress, we are not resuming."));
 
-- 
2.5.0.rc2.110.gb39b692
