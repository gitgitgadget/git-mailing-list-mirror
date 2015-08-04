From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 06/10] branch: drop non-commit error reporting
Date: Tue,  4 Aug 2015 18:31:19 +0530
Message-ID: <1438693282-15516-6-git-send-email-Karthik.188@gmail.com>
References: <CAOLa=ZSnn19DR_Y5MqUXHed0g5MSk_dwFc48dk8GoPYvL5DQ=Q@mail.gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 15:01:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMbqo-0003P5-VE
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 15:01:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934005AbbHDNBi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 09:01:38 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34468 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933990AbbHDNBe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 09:01:34 -0400
Received: by pawu10 with SMTP id u10so8232952paw.1
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 06:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JMT3A4gmtdzTF7g72GO6SAr3ylV/A05GFlY1WscHu3k=;
        b=mfaf5FraoZP6mFN5RypBsuNt+1Cn1Sn4IgHOnLxyGiwx6kA76XD59vFeYmW8WaBg8Z
         7dvv2e5ULkrZmoEpwxq/eeE2K9/MO0W/KNduOgWxNCWjXqEJx2CaSDABtLxjkPwa4H6m
         TvKaKP7Hy6raeK3GmWx4zFuPYoKABLxmEbNJr7N5uEXgAlaxQ86XjUJazBXEmq7/5Fmk
         J17j886E+plpeKN9ymFUcx4d5lqIJjogUKJOWDsrqMhldz5CEecqWAqVqAHfPOe0mbui
         lwvzp3liOpyL/ppbtFWxTbVoJhCm3i292r6SDVXSbw/fHp7Bf/7Z6YSkmb7eYOZik6i+
         eo9g==
X-Received: by 10.69.17.202 with SMTP id gg10mr7530218pbd.15.1438693293094;
        Tue, 04 Aug 2015 06:01:33 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id uy6sm1450657pbc.13.2015.08.04.06.01.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Aug 2015 06:01:32 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <CAOLa=ZSnn19DR_Y5MqUXHed0g5MSk_dwFc48dk8GoPYvL5DQ=Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275271>

Remove the error reporting variable to make the code easier to port
over to using ref-filter APIs.

Based-on-patch-by: Jeff King <peff@peff.net>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/branch.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index c5f2944..1ac7fbc 100644
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
@@ -616,7 +613,7 @@ static int calc_maxwidth(struct ref_list *refs, int remote_bonus)
 	return max;
 }
 
-static int print_ref_list(int kinds, int detached, int verbose, int abbrev, struct commit_list *with_commit, const char **pattern)
+static void print_ref_list(int kinds, int detached, int verbose, int abbrev, struct commit_list *with_commit, const char **pattern)
 {
 	int i, index;
 	struct append_ref_cb cb;
@@ -641,7 +638,6 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
 		init_revisions(&ref_list.revs, NULL);
 	cb.ref_list = &ref_list;
 	cb.pattern = pattern;
-	cb.ret = 0;
 	/*
 	 * First we obtain all regular branch refs and then if the
 	 * HEAD is detached then we insert that ref to the end of the
@@ -701,11 +697,6 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
 			       abbrev, detached, remote_prefix);
 
 	free_ref_list(&ref_list);
-
-	if (cb.ret)
-		error(_("some refs could not be read"));
-
-	return cb.ret;
 }
 
 static void rename_branch(const char *oldname, const char *newname, int force)
@@ -921,15 +912,14 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
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
2.5.0
