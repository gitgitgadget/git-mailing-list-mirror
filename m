From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v5 43/44] builtin-am: check for valid committer ident
Date: Tue,  7 Jul 2015 22:21:01 +0800
Message-ID: <1436278862-2638-44-git-send-email-pyokagan@gmail.com>
References: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 16:24:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCTnY-0005pA-W2
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 16:24:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757805AbbGGOYT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 10:24:19 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:36339 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757727AbbGGOXR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 10:23:17 -0400
Received: by pddu5 with SMTP id u5so39253925pdd.3
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 07:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N8kFHviE2v8IXO05BlKKn3a+5RXXeylR0j69SoSj01w=;
        b=B5vbpaUA3RQziaCp0Qk6xUEDOXzbZ5zParOpQHgZfi74YNVlMOJaXG7Jd4Yhd2EicW
         8z4sKPdzYBNXwupx5FJzlzcziSzkrd4SrfANkpdXA0oo/Fp0PsM3V8G5RY1PFDZC+rL0
         tXCfpOmGSmt1qHACL7ySGdcQSz/qkn4bzrKKKLoDHAxMG4tRDhuEBmF+lE99XiUkiP5I
         n3HfEdPdymYqIxzsVXbTUXp4B2D1w9COOKGLhUjggzRQtSWkBj1unghEF1LGORyVxhUK
         P8nf/48kEOgNXPifezhmO6IRgLUIsO1Lnd5yeH6GNHFn9v1BzmDlgVFs/4pXhkIkpQcK
         2jRQ==
X-Received: by 10.68.135.73 with SMTP id pq9mr9592254pbb.46.1436278996933;
        Tue, 07 Jul 2015 07:23:16 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id z4sm3800359pdo.88.2015.07.07.07.23.14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 07:23:16 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.76.gf60a929
In-Reply-To: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273561>

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

Notes:
    v5
    
    * modified commit message

 builtin/am.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index ad07ba4..a0982d9 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2264,6 +2264,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		fprintf_ln(stderr, _("The -b/--binary option has been a no-op for long time, and\n"
 				"it will be removed. Please do not use it anymore."));
 
+	/* Ensure a valid committer ident can be constructed */
+	git_committer_info(IDENT_STRICT);
+
 	if (read_index_preload(&the_index, NULL) < 0)
 		die(_("failed to read the index"));
 
-- 
2.5.0.rc1.76.gf60a929
