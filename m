From: Jared Hance <jaredhance@gmail.com>
Subject: [PATCH v3 2/3] Add function per_branch_config.
Date: Tue,  8 Feb 2011 19:23:47 -0500
Message-ID: <1297211028-14382-3-git-send-email-jaredhance@gmail.com>
References: <1297198129-3403-1-git-send-email-jaredhance@gmail.com>
 <1297211028-14382-1-git-send-email-jaredhance@gmail.com>
Cc: Jared Hance <jaredhance@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 09 01:24:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmxrK-0001bd-FX
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 01:24:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756021Ab1BIAYN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Feb 2011 19:24:13 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:45295 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755995Ab1BIAYM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Feb 2011 19:24:12 -0500
Received: by mail-qy0-f181.google.com with SMTP id 12so5311853qyk.19
        for <git@vger.kernel.org>; Tue, 08 Feb 2011 16:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=r0f76nd1XqHnv6jJju207eJ24BaCOr1ex6v4Q+QNKR0=;
        b=EBRkhBhhD5Wplu63ozscTN+U9KH4HZKOcL5K4eeKzv0fLZN2QmcQPl857QgolVnT+F
         dZfkqbtNgufTctHGA2I8NSQnobQidYw3jTy4u8MyrHghJeglPWCnMwRV5j1C1XRwrJ1F
         F93b7zqJMeT+Xnzx9h3+Fg4UAf2HX8MN0Kcx0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=DfVX9sUwaVXjzXwt9oOGozz1/hOkeE/x7XEffnKVRnykuItfjV4+mcZ65bfCLG41ef
         FjcSahq6Ch8P/tPTqn6N2/7Gq1K5NyMNsMfSPFYNPaWptplcBuJKWokC+Fy+gte6+7U/
         +siRGRzVCxYjSHLXUvwNaJnqTfkhiCfbYg9hc=
Received: by 10.224.11.146 with SMTP id t18mr15933538qat.139.1297211051810;
        Tue, 08 Feb 2011 16:24:11 -0800 (PST)
Received: from localhost.localdomain (cpe-75-186-7-248.cinci.res.rr.com [75.186.7.248])
        by mx.google.com with ESMTPS id nb15sm35516qcb.26.2011.02.08.16.24.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 Feb 2011 16:24:10 -0800 (PST)
X-Mailer: git-send-email 1.7.4
In-Reply-To: <1297211028-14382-1-git-send-email-jaredhance@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166379>

Adds a configuration function to be filled up more in the next patch.

Signed-off-by: Jared Hance <jaredhance@gmail.com>
---
 builtin/merge.c |   24 ++++++++++++++++++++----
 1 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index bc1ae94..818bfc7 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -498,11 +498,15 @@ cleanup:
 	strbuf_release(&bname);
 }
 
-static int git_merge_config(const char *k, const char *v, void *cb)
+static int per_branch_config(const char *k, const char *v, void *cb)
 {
-	if (branch && !prefixcmp(k, "branch.") &&
-		!prefixcmp(k + 7, branch) &&
-		!strcmp(k + 7 + strlen(branch), ".mergeoptions")) {
+	const char *variable;
+	if (!branch || prefixcmp(k, "branch.")
+	   || prefixcmp(k + 7, branch))
+		return 1; /* not what I handle */
+
+	variable = k + 7 + strlen(branch);
+	if (!strcmp(variable, ".mergeoptions")) {
 		const char **argv;
 		int argc;
 		char *buf;
@@ -518,8 +522,20 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 		parse_options(argc, argv, NULL, builtin_merge_options,
 			      builtin_merge_usage, 0);
 		free(buf);
+
+		return 0;
 	}
 
+	return 1; /* not what I handle */
+}
+
+static int git_merge_config(const char *k, const char *v, void *cb)
+{
+	int status = per_branch_config(k, v, cb);
+
+	if (status <= 0)
+		return status;
+
 	if (!strcmp(k, "merge.diffstat") || !strcmp(k, "merge.stat"))
 		show_diffstat = git_config_bool(k, v);
 	else if (!strcmp(k, "pull.twohead"))
-- 
1.7.4
