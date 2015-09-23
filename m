From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v6 5/8] branch: drop non-commit error reporting
Date: Wed, 23 Sep 2015 23:41:10 +0530
Message-ID: <1443031873-25280-6-git-send-email-Karthik.188@gmail.com>
References: <1443031873-25280-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 23 20:11:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeoVx-0001pw-B7
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 20:11:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753623AbbIWSLU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2015 14:11:20 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35803 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752238AbbIWSLR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2015 14:11:17 -0400
Received: by pacfv12 with SMTP id fv12so47699947pac.2
        for <git@vger.kernel.org>; Wed, 23 Sep 2015 11:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HZCIka8PCWFEvQHqEl5pkiQ3gQC0/XFu9iQTxDGjxUM=;
        b=f6/0FnvBA2WM8JERA4ROCTEi8fw+vpy9FvmnwvKcyppwJRkuk8E37Z3bUBK2mDh6Qj
         cD9ABM7wA4X9HzC5l0rASD16vHXdV8YNdqjAtvfvsHskv6jbzbmeIQ+3XgOBSdXI3KJJ
         1XAGByK755GHm0cvjtG42ppkrYBVM0J5zyLNw3+R8ZNpr3LTp3HdjLIs/kaEZJocwMU2
         YnuVdwX4dwVUTEySaMBKiu2jSI9/4ts6PvM/n+PMpyi3QZJnJkIRxR9+p60l8VgCEjwk
         Tk8vDQBCv2ud3TFwFVY9jfPtri0/99xlDLukZn7kIKYxvCyj3xyT1qfzRuBR+CJo21Bh
         vpvg==
X-Received: by 10.68.129.231 with SMTP id nz7mr38830433pbb.53.1443031876530;
        Wed, 23 Sep 2015 11:11:16 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id bs3sm9107777pbd.89.2015.09.23.11.11.14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Sep 2015 11:11:16 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1443031873-25280-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278496>

Remove the error reporting variable to make the code easier to port
over to using ref-filter APIs.

This also removes the error from being displayed. As branch.c will use
ref-filter APIs in the following patches, the error checking becomes
redundant with the error reporting system found in the ref-filter
(ref-filter.c:1336).

Based-on-patch-by: Jeff King <peff@peff.net>
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
