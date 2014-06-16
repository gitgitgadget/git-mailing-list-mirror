From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH/RFC] alias.c: Replace git_config with git_config_get_string
Date: Mon, 16 Jun 2014 02:15:54 -0700
Message-ID: <1402910154-417-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 11:17:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwT2M-0000GZ-Fd
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 11:17:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754986AbaFPJRF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 05:17:05 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:60896 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754667AbaFPJRB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 05:17:01 -0400
Received: by mail-pb0-f42.google.com with SMTP id ma3so4008609pbc.15
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 02:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=2Lboj91YMPtnMd+MSRHilAd+LfIqOxZa9SOt95khjSI=;
        b=Ly1KEZDZOi9Pg7B/e6OR0xSftfUD1uqDiJcMOj0Gfw5kWNBM9uoFIxDtWHpw/a4Au5
         AMRbPrYrxlGtOAfPc/HDtTUzareqHgEcACXpj4JYNzL9NgjV6TfzVgT7TJ+NCLI3n9oa
         cM4ei+AoaKP0T/gU7w4P3wyckQbVE3c7/K6y2Cs+WuBYFHv2at0YmOX7JKWePQTdy7rs
         uj67Z5VSXdTbja5GueIbnl85RuFc3sQVmVGqyA4nj0iEtBgo/Htd1P72yFWuK1IWYCTP
         GmU6XHj+XKNTCy0JSFL5VHhuQJQ1YV0tFCpd/gz/1joxhYBB+GRrOt00huJFW2RlWcki
         QcvQ==
X-Received: by 10.66.138.48 with SMTP id qn16mr3078690pab.152.1402910221060;
        Mon, 16 Jun 2014 02:17:01 -0700 (PDT)
Received: from localhost.localdomain ([117.254.222.96])
        by mx.google.com with ESMTPSA id og3sm17548111pbc.48.2014.06.16.02.16.51
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 16 Jun 2014 02:17:00 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251708>

Original implementation uses a callback based approach which has some
deficiencies like a convoluted control flow and redundant variables.
Use git_config_get_string instead of git_config to take advantage of
the config hash-table.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---

**DOUBT**
This patch builds on top of patch series[1]. The first patch in the 
replace `git_config` series is [2], which passed all the tests.

But this patch falters at this test in t1300-repo-config.sh,

git config alias.checkconfig "-c foo.check=bar config foo.check" &&
		echo bar >expect &&
		git checkconfig >actual &&
		test_cmp expect actual

I hand tested this case and the outputs match. But I don't know why the tests
are failing.

In t1300-repo-config this test also fails,

#		git config alias.split-cmdline-fix 'echo "' &&
#		test_must_fail git split-cmdline-fix &&
#		echo foo > foo &&
#		git add foo &&
#		git commit -m 'initial commit' &&
#		git config branch.master.mergeoptions 'echo "' &&
#		test_must_fail git merge master

Can anybody help me with this one?
Thanks.

[1] http://thread.gmane.org/gmane.comp.version-control.git/251704
[2] http://thread.gmane.org/gmane.comp.version-control.git/251707

Cheers,
Tanay Abhra.

 alias.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/alias.c b/alias.c
index 5efc3d6..fffad73 100644
--- a/alias.c
+++ b/alias.c
@@ -1,24 +1,17 @@
 #include "cache.h"
 
-static const char *alias_key;
-static char *alias_val;
-
-static int alias_lookup_cb(const char *k, const char *v, void *cb)
-{
-	if (starts_with(k, "alias.") && !strcmp(k + 6, alias_key)) {
-		if (!v)
-			return config_error_nonbool(k);
-		alias_val = xstrdup(v);
-		return 0;
-	}
-	return 0;
-}
-
 char *alias_lookup(const char *alias)
 {
-	alias_key = alias;
-	alias_val = NULL;
-	git_config(alias_lookup_cb, NULL);
+	char *alias_key, *alias_val;
+	const char *v;
+	alias_key = xmalloc(7+strlen(alias));
+	strcpy(alias_key, "alias.");
+	strcat(alias_key, alias);
+	v = git_config_get_string(alias_key);
+	if (!v)
+		config_error_nonbool(alias_key);
+	alias_val = xstrdup(v);
+	free(alias_key);
 	return alias_val;
 }
 
-- 
1.9.0.GIT
