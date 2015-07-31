From: David Turner <dturner@twopensource.com>
Subject: [PATCH 1/2] refs: workree-refs/* become per-worktree
Date: Fri, 31 Jul 2015 19:56:51 -0400
Message-ID: <1438387012-29229-2-git-send-email-dturner@twopensource.com>
References: <1438387012-29229-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com,
	chriscool@tuxfamily.org
X-From: git-owner@vger.kernel.org Sat Aug 01 01:57:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLKAr-0008Bi-MC
	for gcvg-git-2@plane.gmane.org; Sat, 01 Aug 2015 01:57:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753756AbbGaX5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2015 19:57:09 -0400
Received: from mail-qg0-f42.google.com ([209.85.192.42]:33706 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752373AbbGaX5I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2015 19:57:08 -0400
Received: by qged69 with SMTP id d69so56664832qge.0
        for <git@vger.kernel.org>; Fri, 31 Jul 2015 16:57:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uvyL8CNUo5K2JwDzK3HwmhFrCrMLvt3DyewBsy8q3Z0=;
        b=Wp4wQb64swB4eYeZyhpxXMdhtn+I+RAzqV2bVL73mzfzZKw/eAxAihNeJ8VY/OFiqT
         PYtbVL4j6DJa57EdOH+rI0IERrSMb++DqkoxugYgqck3F6D5HkC7mCEmA3e2jJ8fB0Cr
         9GMeAlt0oFPLIHb3pjs5cGa1DG7rv4oAds7rfBPmK+ZGD7o9aqXLbqoKt/m15qogEed8
         X2yMuWPWRQGMMXG5E2J2umylFjatpi/xuzdKqncwMTkxPSWh1paLMpdvnioTrW181ner
         GljOmx3Ka91CNtCXXsYcfDDZprkaMQa0Co3jWDt145f/y/s8AHuKD4WmlX4yFDcfLp1c
         FtFg==
X-Gm-Message-State: ALoCoQlzNSmqsQsiOt/iYLtD8Si3IRKF8rBpOA+kVTMjuV1ENSvTY2YfK2jzY39uoIW/efMeOBkH
X-Received: by 10.141.28.149 with SMTP id f143mr9391361qhe.97.1438387027522;
        Fri, 31 Jul 2015 16:57:07 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 25sm3038515qkp.37.2015.07.31.16.57.06
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 31 Jul 2015 16:57:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1438387012-29229-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275098>

We need a place to stick refs for bisects in progress that is not
shared between worktrees.  So we use the worktree-refs/ hierarchy
instead of the refs/.

To do this, load loose refs from "worktree-refs/" as well as from "refs/".
The is_per_worktree_ref function and associated docs learn that
worktree-refs/ is per-worktree.

The ref-packing functions learn that refs beginning with
worktree-refs/ should not be packed (since packed-refs is common
rather than per-worktree).

Signed-off-by: David Turner <dturner@twopensource.com>
---
 Documentation/glossary-content.txt |  3 ++-
 refs.c                             | 13 ++++++++++---
 t/t3210-pack-refs.sh               |  7 +++++++
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 8c6478b..e2847a9 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -413,7 +413,8 @@ exclude;;
 
 [[def_per_worktree_ref]]per-worktree ref::
 	Refs that are per-<<def_working_tree,worktree>>, rather than
-	global.  This is presently only <<def_HEAD,HEAD>>, but might
+	global.  This is presently only <<def_HEAD,HEAD>> and any refs
+	that start with `worktree-refs/` (rather than `refs/`), but might
 	later include other unusual refs.
 
 [[def_pseudoref]]pseudoref::
diff --git a/refs.c b/refs.c
index e6fc3fe..c556b6f 100644
--- a/refs.c
+++ b/refs.c
@@ -1433,15 +1433,17 @@ static struct ref_dir *get_loose_refs(struct ref_cache *refs)
 	if (!refs->loose) {
 		/*
 		 * Mark the top-level directory complete because we
-		 * are about to read the only subdirectory that can
+		 * are about to read the only subdirectories that can
 		 * hold references:
 		 */
 		refs->loose = create_dir_entry(refs, "", 0, 0);
 		/*
-		 * Create an incomplete entry for "refs/":
+		 * Create incomplete entries for "refs/" and "worktree-refs":
 		 */
 		add_entry_to_dir(get_ref_dir(refs->loose),
 				 create_dir_entry(refs, "refs/", 5, 1));
+		add_entry_to_dir(get_ref_dir(refs->loose),
+				 create_dir_entry(refs, "worktree-refs/", 14, 1));
 	}
 	return get_ref_dir(refs->loose);
 }
@@ -2656,6 +2658,10 @@ static int pack_if_possible_fn(struct ref_entry *entry, void *cb_data)
 	struct ref_entry *packed_entry;
 	int is_tag_ref = starts_with(entry->name, "refs/tags/");
 
+	/* Do not pack per-worktree refs: */
+	if (starts_with(entry->name, "worktree-refs/"))
+		return 0;
+
 	/* ALWAYS pack tags */
 	if (!(cb->flags & PACK_REFS_ALL) && !is_tag_ref)
 		return 0;
@@ -2850,7 +2856,8 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 
 static int is_per_worktree_ref(const char *refname)
 {
-	return !strcmp(refname, "HEAD");
+	return !strcmp(refname, "HEAD") ||
+		starts_with(refname, "worktree-refs/");
 }
 
 static int is_pseudoref_syntax(const char *refname)
diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index 8aae98d..0800a1c 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -160,6 +160,13 @@ test_expect_success 'pack ref directly below refs/' '
 	test_path_is_missing .git/refs/top
 '
 
+test_expect_success 'do not pack ref in worktree-refs' '
+	git update-ref worktree-refs/local HEAD &&
+	git pack-refs --all --prune &&
+	! grep worktree-refs/local .git/packed-refs >/dev/null &&
+	test_path_is_file .git/worktree-refs/local
+'
+
 test_expect_success 'disable reflogs' '
 	git config core.logallrefupdates false &&
 	rm -rf .git/logs
-- 
2.0.4.315.gad8727a-twtrsrc
