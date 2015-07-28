From: Karthik Nayak <karthik.188@gmail.com>
Subject: [RFC/PATCH 08/11] branch: drop non-commit error reporting
Date: Tue, 28 Jul 2015 12:26:33 +0530
Message-ID: <1438066594-5620-8-git-send-email-Karthik.188@gmail.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
 <1438066594-5620-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 28 08:57:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJyot-0006Hv-Ob
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 08:57:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754389AbbG1G4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 02:56:53 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:33021 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753285AbbG1G4v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 02:56:51 -0400
Received: by pdbnt7 with SMTP id nt7so65568856pdb.0
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 23:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bYsphKfoBwH3iFTt0YJLpltyn0dvvbKZthtr62hP1bE=;
        b=u7uXgPCyGCnCq7nsLYNGL5Imf8fANydYphfHmaaOZzP1P7tl6sIutcXWAthZcff6Lc
         VDbyItVBuRm2cu/9xSDmpbNKVgPp+IyJtKFuBMdO3DArBH7iEOmlcTVhshD4FNmTIifp
         HluU0kgHr5nwqu+CMpAHVwomQ5UzRfTNZpVfyW/19oxMGvaNSzjNye7L+43j1vh/1l1g
         NnxOfzyhOORQ5s+xmSNruL/650pV9JWOhQK/WsgD+B7Y0oMAKaECzqLKBxiaz9wRKe/G
         wTJdhipzsx1tzqwXlD5jSG4oxciQDnsv91IXTcphO6llA/2274bfaFhHySLR9dXlnqF8
         mwZw==
X-Received: by 10.70.36.1 with SMTP id m1mr76156838pdj.121.1438066610741;
        Mon, 27 Jul 2015 23:56:50 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id q7sm33147846pdj.31.2015.07.27.23.56.47
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jul 2015 23:56:49 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <1438066594-5620-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274745>

Based-on-patch-by: Jeff King <peff@peff.net>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/branch.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index ba9cbad..8d0521e 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -313,7 +313,6 @@ static char *resolve_symref(const char *src, const char *prefix)
 struct append_ref_cb {
 	struct ref_list *ref_list;
 	const char **pattern;
-	int ret;
 };
 
 static int match_patterns(const char **pattern, const char *refname)
@@ -370,10 +369,8 @@ static int append_ref(const char *refname, const struct object_id *oid, int flag
 	commit = NULL;
 	if (ref_list->verbose || ref_list->with_commit || merge_filter != NO_FILTER) {
 		commit = lookup_commit_reference_gently(oid->hash, 1);
-		if (!commit) {
-			cb->ret = error(_("branch '%s' does not point at a commit"), refname);
+		if (!commit)
 			return 0;
-		}
 
 		/* Filter with with_commit if specified */
 		if (!is_descendant_of(commit, ref_list->with_commit))
@@ -609,7 +606,7 @@ static int calc_maxwidth(struct ref_list *refs, int remote_bonus)
 	return max;
 }
 
-static int print_ref_list(int kinds, int detached, int verbose, int abbrev, struct commit_list *with_commit, const char **pattern)
+static void print_ref_list(int kinds, int detached, int verbose, int abbrev, struct commit_list *with_commit, const char **pattern)
 {
 	int i, index;
 	struct append_ref_cb cb;
@@ -634,7 +631,6 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
 		init_revisions(&ref_list.revs, NULL);
 	cb.ref_list = &ref_list;
 	cb.pattern = pattern;
-	cb.ret = 0;
 	for_each_rawref(append_ref, &cb);
 	if (detached)
 		head_ref(append_ref, &cb);
@@ -689,11 +685,6 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
 			       abbrev, detached, remote_prefix);
 
 	free_ref_list(&ref_list);
-
-	if (cb.ret)
-		error(_("some refs could not be read"));
-
-	return cb.ret;
 }
 
 static void rename_branch(const char *oldname, const char *newname, int force)
@@ -909,14 +900,13 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			die(_("branch name required"));
 		return delete_branches(argc, argv, delete > 1, kinds, quiet);
 	} else if (list) {
-		int ret;
 		if (kinds & REF_LOCAL_BRANCH)
 			kinds |= REF_DETACHED_HEAD;
-		ret = print_ref_list(kinds, detached, verbose, abbrev,
+		print_ref_list(kinds, detached, verbose, abbrev,
 					 with_commit, argv);
 		print_columns(&output, colopts, NULL);
 		string_list_clear(&output, 0);
-		return ret;
+		return 0;
 	}
 	else if (edit_description) {
 		const char *branch_name;
-- 
2.4.6
