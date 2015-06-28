From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 43/44] builtin-am: check for valid committer ident
Date: Sun, 28 Jun 2015 22:06:05 +0800
Message-ID: <1435500366-31700-44-git-send-email-pyokagan@gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 28 16:09:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9DHJ-0003QJ-UL
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jun 2015 16:09:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752786AbbF1OJo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2015 10:09:44 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:32784 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752451AbbF1OJj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2015 10:09:39 -0400
Received: by padev16 with SMTP id ev16so91899657pad.0
        for <git@vger.kernel.org>; Sun, 28 Jun 2015 07:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=haktdzknFMvDLrS+eHJFtX8GKIuDqT9CNk1t0sCHMSs=;
        b=MfuW5LBBWpj7Nm+fLOQrXgXr2oVTYQ3m+WASHmtbwmcPQ2a0Yd+YKM7XGiNRQTIw/6
         mBDdkS5MjO6pBYHu4WZUr8F01LmLTGcQGyBs0jYv/0+ci5/IXvQthEtMEj8+ZfO14rjm
         HXZv74QqXYoi7HIsqMPDZyZH7aO2TPAoDHO/GzjsES6M1Oh0Iisu+PIr4rtB+vsubdC5
         8DGRwmKxtM3YNYC1wsLl2PFWsiCuSJex5F67wGMWX3Ib2q/7x+wj9rXj3ZYBoClCsKo+
         M957gXsY3wZtq8KV3FlB+MzMn8UA0DPLlGLdNMdXOMfO38vWCYg8ZGRbLuegCDTHi6ga
         SG6w==
X-Received: by 10.69.26.4 with SMTP id iu4mr22219949pbd.140.1435500578424;
        Sun, 28 Jun 2015 07:09:38 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qa1sm39244820pab.0.2015.06.28.07.09.36
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Jun 2015 07:09:37 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc0.76.gb2c6e93
In-Reply-To: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272918>

When commit_tree() is called, if the user does not have an explicit
committer ident configured, it will attempt to construct a default
committer ident based on the user's and system's info (e.g. gecos field,
hostname etc.) However, if a default committer ident is unable to be
constructed, commit_tree() will die(). However, at this point of git-am,
there will already be changes made to the index and work tree.

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
index a46aa74..1cb02c8 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2268,6 +2268,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		fprintf_ln(stderr, _("The -b/--binary option has been a no-op for long time, and\n"
 				"it will be removed. Please do not use it anymore."));
 
+	/* Ensure a valid committer ident can be constructed */
+	git_committer_info(IDENT_STRICT);
+
 	if (read_index_preload(&the_index, NULL) < 0)
 		die(_("failed to read the index"));
 
-- 
2.5.0.rc0.76.gb2c6e93
