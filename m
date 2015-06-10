From: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
Subject: [PATCH v2 6/7] revision: fix rev-list --bisect in old/new mode
Date: Wed, 10 Jun 2015 21:01:57 +0200
Message-ID: <1433962918-6536-2-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
References: <1433962918-6536-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
Cc: remi.lespinet@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	remi.galan-alfonso@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	antoine.delaite@ensimag.grenoble-inp.fr,
	Matthieu.Moy@grenoble-inp.fr, chriscool@tuxfamily.org,
	thomasxnguy@gmail.com, valentinduperray@gmail.com,
	Louis Stuber <stuberl@ensimag.grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 10 21:02:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2lGO-0003XA-9z
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 21:02:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754295AbbFJTCG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 15:02:06 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:48091 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753044AbbFJTCB (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Jun 2015 15:02:01 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id E1809286E;
	Wed, 10 Jun 2015 21:01:58 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eoKdvAakAK0i; Wed, 10 Jun 2015 21:01:58 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr (zm-smtpauth-1.grenet.fr [130.190.244.122])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id CABED2864;
	Wed, 10 Jun 2015 21:01:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTP id BDC1020E7;
	Wed, 10 Jun 2015 21:01:58 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1wbI61DSWLv3; Wed, 10 Jun 2015 21:01:58 +0200 (CEST)
Received: from pcserveur.ensimag.fr (ensipcserveur.imag.fr [129.88.240.65])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTPSA id 7E24D20E2;
	Wed, 10 Jun 2015 21:01:58 +0200 (CEST)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1433962918-6536-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271344>

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
index 7ddbaa0..a332270 100644
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
@@ -2073,14 +2076,22 @@ void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
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
@@ -2109,6 +2120,7 @@ static int handle_revision_pseudo_opt(const char *submodule,
 		handle_refs(submodule, revs, *flags, for_each_branch_ref_submodule);
 		clear_ref_exclusion(&revs->ref_excludes);
 	} else if (!strcmp(arg, "--bisect")) {
+		read_bisect_terms(&name_bad, &name_good);
 		handle_refs(submodule, revs, *flags, for_each_bad_bisect_ref);
 		handle_refs(submodule, revs, *flags ^ (UNINTERESTING | BOTTOM), for_each_good_bisect_ref);
 		revs->bisect = 1;
-- 
1.7.1
