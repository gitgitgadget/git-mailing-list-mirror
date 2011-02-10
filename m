From: Jared Hance <jaredhance@gmail.com>
Subject: [PATCH v4 3/5] merge: introduce setup_merge_commit helper function
Date: Thu, 10 Feb 2011 18:40:06 -0500
Message-ID: <1297381209-6377-7-git-send-email-jaredhance@gmail.com>
References: <1297381209-6377-1-git-send-email-jaredhance@gmail.com>
Cc: Jared Hance <jaredhance@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 11 00:40:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Png80-0005G9-K0
	for gcvg-git-2@lo.gmane.org; Fri, 11 Feb 2011 00:40:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468Ab1BJXkf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Feb 2011 18:40:35 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:38027 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932447Ab1BJXkb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Feb 2011 18:40:31 -0500
Received: by vws16 with SMTP id 16so1296435vws.19
        for <git@vger.kernel.org>; Thu, 10 Feb 2011 15:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=trg5qFrg+N3mC813Mfk1pvUH+qq+KKCXHzgnmz+ojhM=;
        b=QY1H8h6mpKRTo4CZB4esoWlnptQH2KQCrGlRvKSWRVb0rGh+csOdX0peMmcyy05sTn
         J2quk6TwCjfCnJg07h+fiDgV6aP7irV8JkKFJ6PCpWCQP0V0PuSLWFQNZ43caIivBCle
         4yqJopiDDSbul0Yj7LLGC82gR0eq1nc1EMGWw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=nZf1Sm9/KLUwjBloF9vZMOJS7lHhqUBHoZU7OUs8AGy1+I6gkEegvPlrE9qn34XLJa
         CyXsuLp+TV2C4SODNDUEZjdiL3liZFkXiEtpiEyZ7HN/XTGm1Q7xviY4G8/5h/nlfqjD
         DrnF3HZHCM2DYpMLsV58bXQyADiNVTfJlvTZ0=
Received: by 10.220.176.12 with SMTP id bc12mr5944723vcb.55.1297381230670;
        Thu, 10 Feb 2011 15:40:30 -0800 (PST)
Received: from localhost.localdomain (cpe-75-186-7-248.cinci.res.rr.com [75.186.7.248])
        by mx.google.com with ESMTPS id r7sm126736vbx.19.2011.02.10.15.40.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Feb 2011 15:40:30 -0800 (PST)
X-Mailer: git-send-email 1.7.4
In-Reply-To: <1297381209-6377-1-git-send-email-jaredhance@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166517>

Add a new function to set up a merge commit given a branch
or commit, which is currently used when parsing argv.

Signed-off-by: Jared Hance <jaredhance@gmail.com>
---
 builtin/merge.c |   44 +++++++++++++++++++++++++++-----------------
 1 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 439d2c7..cd23880 100644
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
+	if (!branch || prefixcmp(k, "branch.") ||
+	   prefixcmp(k + 7, branch))
+		return 1; /* not what I handle */
+
+	variable = k + 7 + strlen(branch);
+	if (!strcmp(variable, ".mergeoptions")) {
 		const char **argv;
 		int argc;
 		char *buf;
@@ -911,6 +915,24 @@ static int evaluate_result(void)
 	return cnt;
 }
 
+static void setup_merge_commit(struct strbuf *buf,
+	struct commit_list ***remotes, const char *s)
+{
+	struct object *o;
+	struct commit *commit;
+
+	o = peel_to_type(s, 0, NULL, OBJ_COMMIT);
+	if (!o)
+		die("%s - not something we can merge", s);
+	commit = lookup_commit(o->sha1);
+	commit->util = (void *)s;
+	*remotes = &commit_list_insert(commit, *remotes)->next;
+
+	strbuf_addf(buf, "GITHEAD_%s", sha1_to_hex(o->sha1));
+	setenv(buf->buf, s, 1);
+	strbuf_reset(buf);
+}
+
 int cmd_merge(int argc, const char **argv, const char *prefix)
 {
 	unsigned char result_tree[20];
@@ -1059,19 +1081,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	strbuf_reset(&buf);
 
 	for (i = 0; i < argc; i++) {
-		struct object *o;
-		struct commit *commit;
-
-		o = peel_to_type(argv[i], 0, NULL, OBJ_COMMIT);
-		if (!o)
-			die("%s - not something we can merge", argv[i]);
-		commit = lookup_commit(o->sha1);
-		commit->util = (void *)argv[i];
-		remotes = &commit_list_insert(commit, remotes)->next;
-
-		strbuf_addf(&buf, "GITHEAD_%s", sha1_to_hex(o->sha1));
-		setenv(buf.buf, argv[i], 1);
-		strbuf_reset(&buf);
+		setup_merge_commit(&buf, &remotes, argv[i]);
 	}
 
 	if (!use_strategies) {
-- 
1.7.4
