From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v6b 5/8] branch: drop non-commit error reporting
Date: Thu, 24 Sep 2015 23:39:08 +0530
Message-ID: <1443118148-3470-1-git-send-email-Karthik.188@gmail.com>
References: <1443031873-25280-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 20:09:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfAx8-0003Jh-Rt
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 20:09:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756062AbbIXSJA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 14:09:00 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35247 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755436AbbIXSI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 14:08:59 -0400
Received: by pacfv12 with SMTP id fv12so80878524pac.2
        for <git@vger.kernel.org>; Thu, 24 Sep 2015 11:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8muf7bAA6aK+Sp5IKq3F5Usf8qaiFJMFdrCOFLttLJs=;
        b=i42ezK49gMwV8cjQ+kCNQQk6PyZ4hem981g9zmeH0IxAlO5DmzT0NcLpEa/GEe66Zg
         t2m3ezIKYzBRmUhs1r4SrCr7/6b4YLShU2z/d4N9P1qawpqkkOJNB70kn+TVPA3Yw1GL
         ZKqUfvmFmG8uf6EBu/E578oKJq5qb9+zLDum49s6/1o+AQUpqNcRzls14L42ne7aS4xY
         ZT4eMVUxdsq8DNbBZV4aXnO7j8LN86jwiyJSRD4gK4Jlpw2fe6XpJ0wLHBiK/1W6sEzP
         fA/tXufPHeczb2lRxVUN5VsRa5jP7m8u/9jXRG3N2t58K4CQnENfAzN46v51aJYJfkwv
         41VQ==
X-Received: by 10.66.163.228 with SMTP id yl4mr1244821pab.112.1443118139502;
        Thu, 24 Sep 2015 11:08:59 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id xv12sm14857504pac.38.2015.09.24.11.08.56
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Sep 2015 11:08:58 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1443031873-25280-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278551>

Remove the error "branch '%s' does not point at a commit" in
apppend_ref() which reports branch refs which do not point to
commits. Also remove the error "some refs could not be read" in
print_ref_list() which is triggered as a consequence of the first
error.

This seems to be the wrong codepath whose purpose is not to diagnose
and report a repository corruption. If we care about such a repository
corruption, we should report it from fsck instead.

This also helps in a smooth port of branch.c to use ref-filter APIs
over the following patches. On the other hand, ref-filter ignores refs
which do not point at commits silently.

Based-on-patch-by: Jeff King <peff@peff.net>
Helped-by: Junio C Hamano <gitster@pobox.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/branch.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 1a664ed..ebc3742 100644
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
@@ -617,7 +614,7 @@ static int calc_maxwidth(struct ref_list *refs, int remote_bonus)
 	return max;
 }
 
-static int print_ref_list(int kinds, int detached, int verbose, int abbrev, struct commit_list *with_commit, const char **pattern)
+static void print_ref_list(int kinds, int detached, int verbose, int abbrev, struct commit_list *with_commit, const char **pattern)
 {
 	int i;
 	struct append_ref_cb cb;
@@ -642,7 +639,6 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
 		init_revisions(&ref_list.revs, NULL);
 	cb.ref_list = &ref_list;
 	cb.pattern = pattern;
-	cb.ret = 0;
 	/*
 	 * First we obtain all regular branch refs and if the HEAD is
 	 * detached then we insert that ref to the end of the ref_fist
@@ -693,11 +689,6 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
 			       abbrev, detached, remote_prefix);
 
 	free_ref_list(&ref_list);
-
-	if (cb.ret)
-		error(_("some refs could not be read"));
-
-	return cb.ret;
 }
 
 static void rename_branch(const char *oldname, const char *newname, int force)
@@ -913,15 +904,14 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			die(_("branch name required"));
 		return delete_branches(argc, argv, delete > 1, kinds, quiet);
 	} else if (list) {
-		int ret;
 		/*  git branch --local also shows HEAD when it is detached */
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
2.5.1
