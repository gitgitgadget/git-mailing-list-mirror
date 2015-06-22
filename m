From: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
Subject: [PATCH v3 5/6] revision: fix rev-list --bisect in old/new mode
Date: Mon, 22 Jun 2015 23:00:35 +0200
Message-ID: <1435006836-18182-5-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
References: <1435006836-18182-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
Cc: antoine.delaite@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	Matthieu.Moy@grenoble-inp.fr, chriscool@tuxfamily.org,
	thomasxnguy@gmail.com, valentinduperray@gmail.com,
	Louis Stuber <stuberl@ensimag.grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 22 23:00:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z78pm-0005uZ-Oy
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 23:00:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752250AbbFVVAn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 17:00:43 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:47873 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751764AbbFVVAk (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Jun 2015 17:00:40 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id F3767290D;
	Mon, 22 Jun 2015 23:00:37 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id krpaYXO1pPDH; Mon, 22 Jun 2015 23:00:37 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id DC7E52890;
	Mon, 22 Jun 2015 23:00:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id C8E1F20DD;
	Mon, 22 Jun 2015 23:00:37 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IDQ1ykoMhbGd; Mon, 22 Jun 2015 23:00:37 +0200 (CEST)
Received: from pcserveur.ensimag.fr (ensipcserveur.imag.fr [129.88.240.65])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 5E95320E6;
	Mon, 22 Jun 2015 23:00:37 +0200 (CEST)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1435006836-18182-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272411>

From: Louis Stuber <stuberl@ensimag.grenoble-inp.fr>

Calling git rev-list --bisect when an old/new mode bisection was started
shows the help notice. This has been fixed by reading BISECT_TERMS in
revision.c to find the correct bisect refs path (which was always
refs/bisect/bad (or good) before and can be refs/bisect/new (old) now).

Signed-off-by: Louis Stuber <stuberl@ensimag.grenoble-inp.fr>
Signed-off-by: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
---
 revision.c |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index 3ff8723..27750ac 100644
--- a/revision.c
+++ b/revision.c
@@ -21,6 +21,9 @@
 
 volatile show_early_output_fn_t show_early_output;
 
+static const char *name_bad;
+static const char *name_good;
+
 char *path_name(const struct name_path *path, const char *name)
 {
 	const struct name_path *p;
@@ -2076,14 +2079,22 @@ void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
 	ctx->argc -= n;
 }
 
+extern void read_bisect_terms(const char **bad, const char **good);
+
 static int for_each_bad_bisect_ref(const char *submodule, each_ref_fn fn, void *cb_data)
 {
-	return for_each_ref_in_submodule(submodule, "refs/bisect/bad", fn, cb_data);
+	char bisect_refs_path[256];
+	strcpy(bisect_refs_path, "refs/bisect/");
+	strcat(bisect_refs_path, name_bad);
+	return for_each_ref_in_submodule(submodule, bisect_refs_path, fn, cb_data);
 }
 
 static int for_each_good_bisect_ref(const char *submodule, each_ref_fn fn, void *cb_data)
 {
-	return for_each_ref_in_submodule(submodule, "refs/bisect/good", fn, cb_data);
+	char bisect_refs_path[256];
+	strcpy(bisect_refs_path, "refs/bisect/");
+	strcat(bisect_refs_path, name_good);
+	return for_each_ref_in_submodule(submodule, bisect_refs_path, fn, cb_data);
 }
 
 static int handle_revision_pseudo_opt(const char *submodule,
@@ -2112,6 +2123,7 @@ static int handle_revision_pseudo_opt(const char *submodule,
 		handle_refs(submodule, revs, *flags, for_each_branch_ref_submodule);
 		clear_ref_exclusion(&revs->ref_excludes);
 	} else if (!strcmp(arg, "--bisect")) {
+		read_bisect_terms(&name_bad, &name_good);
 		handle_refs(submodule, revs, *flags, for_each_bad_bisect_ref);
 		handle_refs(submodule, revs, *flags ^ (UNINTERESTING | BOTTOM), for_each_good_bisect_ref);
 		revs->bisect = 1;
-- 
1.7.1
