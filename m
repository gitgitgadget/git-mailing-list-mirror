From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v6 44/45] builtin-am: check for valid committer ident
Date: Mon, 20 Jul 2015 00:10:36 +0800
Message-ID: <1437322237-29863-45-git-send-email-pyokagan@gmail.com>
References: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 19 18:12:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGrCv-0006tQ-Ua
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 18:12:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbbGSQMu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 12:12:50 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33806 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932083AbbGSQMj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 12:12:39 -0400
Received: by pacan13 with SMTP id an13so89916561pac.1
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 09:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9aICb4JYKeb5/1nC6abxnj3OSoYfLktJIyS0L2ju0Ko=;
        b=b/mgGXHo4/aDDXAm/IRC8ky+84ZRTd7GinTUm96MH41i/Rzu2OEA4dSO+MmIpoC6Vc
         PaCGbG99vPHvP7Krw1NCG67Gy0dy0+5vIl8bgdavhT0Z3W1AFGXJ5jlA7OTVgpauNJKy
         tdI1FAmW6Tu3qKG73pQmBDr3cf3D6pdf/ZL75zmXDmtPk09wtBMm6aBA/Wq6jwQKSAdg
         AcMlcouGBDlbLkmeKAShZxemxm6NUozDLPvxUwFd9QaOobLz3GNowmMlHGFUHOpu2BHu
         F6aYZqHmZ7ZOBowWjV/EHjTr9uYxTJoIjBvnRjgGl2ux8rlIE+q6U+q0havfhJiUEnBD
         J7wQ==
X-Received: by 10.68.237.105 with SMTP id vb9mr49067464pbc.149.1437322358906;
        Sun, 19 Jul 2015 09:12:38 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id cq5sm17317869pad.11.2015.07.19.09.12.36
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jul 2015 09:12:37 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.110.gb39b692
In-Reply-To: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274262>

When commit_tree() is called, if the user does not have an explicit
committer ident configured, it will attempt to construct a default
committer ident based on the user's and system's info (e.g. gecos field,
hostname etc.) However, if a default committer ident is unable to be
constructed, commit_tree() will die(), but at this point of git-am's
execution, there will already be changes made to the index and work
tree.

This can be confusing to new users, and as such since d64e6b0 (Keep
Porcelainish from failing by broken ident after making changes.,
2006-02-18) git-am.sh will check to see if the committer ident has been
configured, or a default one can be constructed, before even starting to
apply patches.

Re-implement this in builtin/am.c.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index 6a2b887..1fe2c65 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2247,6 +2247,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		fprintf_ln(stderr, _("The -b/--binary option has been a no-op for long time, and\n"
 				"it will be removed. Please do not use it anymore."));
 
+	/* Ensure a valid committer ident can be constructed */
+	git_committer_info(IDENT_STRICT);
+
 	if (read_index_preload(&the_index, NULL) < 0)
 		die(_("failed to read the index"));
 
-- 
2.5.0.rc2.110.gb39b692
