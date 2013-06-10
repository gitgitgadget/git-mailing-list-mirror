From: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
Subject: [PATCH 1/2] rm: better error message on failure for multiple files
Date: Mon, 10 Jun 2013 14:51:39 +0200
Message-ID: <1370868700-27189-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
Cc: gitster@pobox.com,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 10 14:51:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um1Ze-0004p5-6J
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 14:51:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164Ab3FJMvp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 08:51:45 -0400
Received: from mx1.imag.fr ([129.88.30.5]:56371 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751008Ab3FJMvp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 08:51:45 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5ACpdqu023292
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 10 Jun 2013 14:51:39 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5ACpfQI014400;
	Mon, 10 Jun 2013 14:51:41 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5ACpe5b032607;
	Mon, 10 Jun 2013 14:51:40 +0200
Received: (from lienardm@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id r5ACpelU032584;
	Mon, 10 Jun 2013 14:51:40 +0200
X-Mailer: git-send-email 1.7.8
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 10 Jun 2013 14:51:39 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227279>

When 'git rm' fails, it now displays a single message
with the list of files involved, instead of displaying
a list of messages with one file each.

As an example, the old message:
	error: 'foo.txt' has changes staged in the index
	(use --cached to keep the file, or -f to force removal)
	error: 'bar.txt' has changes staged in the index
	(use --cached to keep the file, or -f to force removal)

would now be displayed as:
	error: the following files have changes staged in the index:
		foo.txt
		bar.txt
	(use --cached to keep the file, or -f to force removal)

Signed-off-by: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
Signed-off-by: Jorge Juan Garcia Garcia <Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
---
 builtin/rm.c |   93 +++++++++++++++++++++++++++++++++++++++++++++++++---------
 1 files changed, 79 insertions(+), 14 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 7b91d52..1bff656 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -82,6 +82,11 @@ static int check_local_mod(unsigned char *head, int index_only)
 	int i, no_head;
 	int errs = 0;
 
+	struct string_list files_staged = STRING_LIST_INIT_NODUP;
+	struct string_list files_cached = STRING_LIST_INIT_NODUP;
+	struct string_list files_submodule = STRING_LIST_INIT_NODUP;
+	struct string_list files_local = STRING_LIST_INIT_NODUP;
+
 	no_head = is_null_sha1(head);
 	for (i = 0; i < list.nr; i++) {
 		struct stat st;
@@ -171,29 +176,89 @@ static int check_local_mod(unsigned char *head, int index_only)
 		 */
 		if (local_changes && staged_changes) {
 			if (!index_only || !(ce->ce_flags & CE_INTENT_TO_ADD))
-				errs = error(_("'%s' has staged content different "
-					     "from both the file and the HEAD\n"
-					     "(use -f to force removal)"), name);
+				string_list_append(&files_staged, name);
 		}
 		else if (!index_only) {
 			if (staged_changes)
-				errs = error(_("'%s' has changes staged in the index\n"
-					     "(use --cached to keep the file, "
-					     "or -f to force removal)"), name);
+				string_list_append(&files_cached, name);
 			if (local_changes) {
 				if (S_ISGITLINK(ce->ce_mode) &&
 				    !submodule_uses_gitfile(name)) {
-					errs = error(_("submodule '%s' (or one of its nested "
-						     "submodules) uses a .git directory\n"
-						     "(use 'rm -rf' if you really want to remove "
-						     "it including all of its history)"), name);
-				} else
-					errs = error(_("'%s' has local modifications\n"
-						     "(use --cached to keep the file, "
-						     "or -f to force removal)"), name);
+					string_list_append(&files_submodule,
+							   name);
+				} else {
+					string_list_append(&files_local, name);
+				}
 			}
 		}
 	}
+	if (files_staged.nr) {
+		struct strbuf msg_staged = STRBUF_INIT;
+		int j;
+		strbuf_addstr(
+			&msg_staged,
+			"the following files have staged content different "
+			"from both the\nfile and the HEAD:");
+		for (j = 0; j < files_staged.nr; j++) {
+			strbuf_addf(&msg_staged,
+				    "\n	%s",
+				    files_staged.items[j].string);
+		}
+		strbuf_addstr(&msg_staged,
+			      "\n(use -f to force removal)");
+		errs = error(_("%s"), msg_staged.buf);
+	}
+	if (files_cached.nr) {
+		struct strbuf msg_cached = STRBUF_INIT;
+		int j;
+		strbuf_addstr(
+			&msg_cached,
+			"the following files have changes staged "
+			"in the index:");
+		for (j = 0; j < files_cached.nr; j++) {
+			strbuf_addf(&msg_cached,
+				    "\n	%s",
+				    files_cached.items[j].string);
+		}
+		strbuf_addstr(&msg_cached,
+			      "\n(use --cached to keep the file, "
+			      "or -f to force removal)");
+		errs = error(_("%s"), msg_cached.buf);
+	}
+	if (files_submodule.nr) {
+		struct strbuf msg_sub = STRBUF_INIT;
+		int j;
+		strbuf_addstr(
+			&msg_sub,
+			"the following submodules (or one of its nested "
+			"submodule) use a .git directory:");
+		for (j = 0; j < files_submodule.nr; j++) {
+			strbuf_addf(&msg_sub,
+				    "\n	%s",
+				    files_submodule.items[j].string);
+		}
+		strbuf_addstr(&msg_sub,
+			      "\n(use 'rm -rf' if you really want "
+			      "to remove i including all "
+			      "of its history)");
+		errs = error(_("%s"), msg_sub.buf);
+	}
+	if (files_local.nr) {
+		struct strbuf msg_local = STRBUF_INIT;
+		int j;
+		strbuf_addstr(&msg_local,
+			      "the following files have local modifications:");
+		for (j = 0; j < files_local.nr; j++) {
+			strbuf_addf(&msg_local,
+				    "\n	%s",
+				    files_local.items[j].string);
+		}
+		strbuf_addstr(&msg_local,
+			      "\n(use --cached to keep the file, "
+			      "or -f to force removal)");
+		errs = error(_("%s"), msg_local.buf);
+	}
+
 	return errs;
 }
 
-- 
1.7.8
