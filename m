From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH 3/4] merge-recursive.c: replace `git_config()` with `git_config_get_int()`
Date: Wed, 13 Aug 2014 01:22:01 -0700
Message-ID: <1407918122-29973-3-git-send-email-tanayabh@gmail.com>
References: <1407918122-29973-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 10:22:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHTpf-0003T1-Uu
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 10:22:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928AbaHMIWv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 04:22:51 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:58813 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751718AbaHMIWu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 04:22:50 -0400
Received: by mail-pd0-f177.google.com with SMTP id p10so13976759pdj.22
        for <git@vger.kernel.org>; Wed, 13 Aug 2014 01:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xSR3nz8pCWiqAWdBGi8SrleTBT6dnVdEMK/kax29qog=;
        b=gLUfmycSK/7dEi7pWW1kp0N6vofvE7GTHg16OHky8OPOt8922Z4gLSZCcc4U2Ps1kE
         bGPp1+/wxsP1JD6v9GwtK8H5mKlnelL+bWz5f6j32/Yn6fgi6iIFDZj3MaHIOeBj486O
         /043GocWibPuQyiSNw9NRnlFZeVGXdTEPlrIOyXIucu9IRswhLjhvpOAmYOXWfWLmTJB
         5vrPsHaEv1QUVT7+A22cQK/1TXaE9UiWfWGFerODkSYthkEe3mMGNA8O+9Zx9dRCSIv4
         KySbM7i+RZq2OCB7FK/LeZDAmM9CkaBppZ7Sg7K5Aq4bkscbaTBRdgfNiDc1DkOoPfhO
         h6Cg==
X-Received: by 10.70.7.164 with SMTP id k4mr2876816pda.6.1407918170574;
        Wed, 13 Aug 2014 01:22:50 -0700 (PDT)
Received: from localhost.localdomain ([117.254.222.211])
        by mx.google.com with ESMTPSA id fm12sm1919517pdb.46.2014.08.13.01.22.47
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 13 Aug 2014 01:22:50 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1407918122-29973-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255188>

Use `git_config_get_int()` instead of `git_config()` to take advantage
of the config-set API which provides a cleaner control flow.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 merge-recursive.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 1d332b8..8ab944c 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2026,22 +2026,12 @@ int merge_recursive_generic(struct merge_options *o,
 	return clean ? 0 : 1;
 }
 
-static int merge_recursive_config(const char *var, const char *value, void *cb)
+static void merge_recursive_config(struct merge_options *o)
 {
-	struct merge_options *o = cb;
-	if (!strcmp(var, "merge.verbosity")) {
-		o->verbosity = git_config_int(var, value);
-		return 0;
-	}
-	if (!strcmp(var, "diff.renamelimit")) {
-		o->diff_rename_limit = git_config_int(var, value);
-		return 0;
-	}
-	if (!strcmp(var, "merge.renamelimit")) {
-		o->merge_rename_limit = git_config_int(var, value);
-		return 0;
-	}
-	return git_xmerge_config(var, value, cb);
+	git_config_get_int("merge.verbosity", &o->verbosity);
+	git_config_get_int("diff.renamelimit", &o->diff_rename_limit);
+	git_config_get_int("merge.renamelimit", &o->merge_rename_limit);
+	git_config(git_xmerge_config, NULL);
 }
 
 void init_merge_options(struct merge_options *o)
@@ -2052,7 +2042,7 @@ void init_merge_options(struct merge_options *o)
 	o->diff_rename_limit = -1;
 	o->merge_rename_limit = -1;
 	o->renormalize = 0;
-	git_config(merge_recursive_config, o);
+	merge_recursive_config(o);
 	if (getenv("GIT_MERGE_VERBOSITY"))
 		o->verbosity =
 			strtol(getenv("GIT_MERGE_VERBOSITY"), NULL, 10);
-- 
1.9.0.GIT
