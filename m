From: Simo Melenius <simo.melenius@iki.fi>
Subject: [PATCH 1/2] branch: exit status now reflects if branch listing finds an error
Date: Fri,  4 Jun 2010 12:50:10 +0300
Message-ID: <1275645011-28795-1-git-send-email-simo.melenius@iki.fi>
References: <AANLkTilGOtScr7AyF_Dsm5ItTm2QBv_aPdBXRUDH29Ad@mail.gmail.com>
Cc: git@vger.kernel.org, Simo Melenius <simo.melenius@iki.fi>
To: jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Fri Jun 04 11:50:45 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKTY3-0000oP-Nj
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 11:50:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753859Ab0FDJuj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jun 2010 05:50:39 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:54787 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753139Ab0FDJuh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jun 2010 05:50:37 -0400
Received: by pvg16 with SMTP id 16so495532pvg.19
        for <git@vger.kernel.org>; Fri, 04 Jun 2010 02:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=Rkhvuxx778Msb1UNGITNkdmD/tHhD/9/bSAfvy8WRNY=;
        b=sOCx5lM0v/AuVXrXmoURecSNY2CufiMBup3tHFyUxQQoTbbDGxQdrZw0kyPj1JBc0S
         pyJH6avD0lyMhYgqlqJiCeNAF/pPSplAIcoUWTKRsfaQJm/wcAimUH3MXkT302McE3WQ
         7mcp/0WHdNRKYTXyUi+7WpLHne9gm0u9wDMRU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=in4MQ4cZdz8DOW6LG+NKGV+cbKpFFXN/v5BdkYuQzB5xRCkothfCMlxRXy6SjmDhQs
         UFROoIeGnIpVH7R6BFWfH7knxyqQlYZs7VKLZ4UrvhqvM/OlVLknStsZnsGetoadv5gy
         nqpKDprb96Y1Kv2jws7GnfVFyfofYa6UmHM0M=
Received: by 10.115.117.40 with SMTP id u40mr8328292wam.202.1275645037194;
        Fri, 04 Jun 2010 02:50:37 -0700 (PDT)
Received: from localhost.localdomain (xdsl-83-150-84-41.nebulazone.fi [83.150.84.41])
        by mx.google.com with ESMTPS id b6sm7290819wam.9.2010.06.04.02.50.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 04 Jun 2010 02:50:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <AANLkTilGOtScr7AyF_Dsm5ItTm2QBv_aPdBXRUDH29Ad@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148394>

If some refs could not be read when listing branches, this can now be
observed in the exit status of the "git branch" command.

Signed-off-by: Simo Melenius <simo.melenius@iki.fi>
---
 builtin/branch.c |   25 +++++++++++++++++++------
 1 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 6cf7e72..72a486c 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -257,9 +257,15 @@ static char *resolve_symref(const char *src, const char *prefix)
 	return xstrdup(dst);
 }
 
+struct append_ref_cb {
+	struct ref_list *ref_list;
+	int ret;
+};
+
 static int append_ref(const char *refname, const unsigned char *sha1, int flags, void *cb_data)
 {
-	struct ref_list *ref_list = (struct ref_list*)(cb_data);
+	struct append_ref_cb *cb = (struct append_ref_cb*)(cb_data);
+	struct ref_list *ref_list = cb->ref_list;
 	struct ref_item *newitem;
 	struct commit *commit;
 	int kind, i;
@@ -293,8 +299,10 @@ static int append_ref(const char *refname, const unsigned char *sha1, int flags,
 	commit = NULL;
 	if (ref_list->verbose || ref_list->with_commit || merge_filter != NO_FILTER) {
 		commit = lookup_commit_reference_gently(sha1, 1);
-		if (!commit)
-			return error("branch '%s' does not point at a commit", refname);
+		if (!commit) {
+			cb->ret = error("branch '%s' does not point at a commit", refname);
+			return cb->ret;
+		}
 
 		/* Filter with with_commit if specified */
 		if (!is_descendant_of(commit, ref_list->with_commit))
@@ -484,9 +492,10 @@ static void show_detached(struct ref_list *ref_list)
 	}
 }
 
-static void print_ref_list(int kinds, int detached, int verbose, int abbrev, struct commit_list *with_commit)
+static int print_ref_list(int kinds, int detached, int verbose, int abbrev, struct commit_list *with_commit)
 {
 	int i;
+	struct append_ref_cb cb;
 	struct ref_list ref_list;
 
 	memset(&ref_list, 0, sizeof(ref_list));
@@ -496,7 +505,9 @@ static void print_ref_list(int kinds, int detached, int verbose, int abbrev, str
 	ref_list.with_commit = with_commit;
 	if (merge_filter != NO_FILTER)
 		init_revisions(&ref_list.revs, NULL);
-	for_each_rawref(append_ref, &ref_list);
+	cb.ref_list = &ref_list;
+	cb.ret = 0;
+	for_each_rawref(append_ref, &cb);
 	if (merge_filter != NO_FILTER) {
 		struct commit *filter;
 		filter = lookup_commit_reference_gently(merge_filter_ref, 0);
@@ -527,6 +538,8 @@ static void print_ref_list(int kinds, int detached, int verbose, int abbrev, str
 	}
 
 	free_ref_list(&ref_list);
+
+	return cb.ret;
 }
 
 static void rename_branch(const char *oldname, const char *newname, int force)
@@ -679,7 +692,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	if (delete)
 		return delete_branches(argc, argv, delete > 1, kinds);
 	else if (argc == 0)
-		print_ref_list(kinds, detached, verbose, abbrev, with_commit);
+		return print_ref_list(kinds, detached, verbose, abbrev, with_commit);
 	else if (rename && (argc == 1))
 		rename_branch(head, argv[0], rename > 1);
 	else if (rename && (argc == 2))
-- 
1.7.0.4
