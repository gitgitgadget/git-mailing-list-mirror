From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 6/7] strbuf_check_branch_ref(): a helper to check a refname
 for a branch
Date: Sat, 21 Mar 2009 15:13:38 -0700
Message-ID: <1237673619-12608-7-git-send-email-gitster@pobox.com>
References: <1237673619-12608-1-git-send-email-gitster@pobox.com>
 <1237673619-12608-2-git-send-email-gitster@pobox.com>
 <1237673619-12608-3-git-send-email-gitster@pobox.com>
 <1237673619-12608-4-git-send-email-gitster@pobox.com>
 <1237673619-12608-5-git-send-email-gitster@pobox.com>
 <1237673619-12608-6-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 21 23:16:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ll9U7-0007f9-LJ
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 23:16:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755268AbZCUWOC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 18:14:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755407AbZCUWN7
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 18:13:59 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52632 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755248AbZCUWN4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 18:13:56 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DD154A317E
	for <git@vger.kernel.org>; Sat, 21 Mar 2009 18:13:54 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 227EAA317D for
 <git@vger.kernel.org>; Sat, 21 Mar 2009 18:13:53 -0400 (EDT)
X-Mailer: git-send-email 1.6.2.1.299.gda643a
In-Reply-To: <1237673619-12608-6-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 910E2ECC-1665-11DE-9F0B-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114079>

This allows a common calling sequence

	strbuf_branchname(&ref, name);
	strbuf_splice(&ref, 0, 0, "refs/heads/", 11);
	if (check_ref_format(ref.buf))
		die(...);

to be refactored into

	if (strbuf_check_branch_ref(&ref, name))
		die(...);

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 branch.c                   |    5 +----
 builtin-branch.c           |    8 ++------
 builtin-check-ref-format.c |    5 ++---
 builtin-checkout.c         |    7 +++----
 strbuf.c                   |    8 ++++++++
 strbuf.h                   |    1 +
 6 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/branch.c b/branch.c
index 558f092..62030af 100644
--- a/branch.c
+++ b/branch.c
@@ -135,10 +135,7 @@ void create_branch(const char *head,
 	struct strbuf ref = STRBUF_INIT;
 	int forcing = 0;
 
-	strbuf_branchname(&ref, name);
-	strbuf_splice(&ref, 0, 0, "refs/heads/", 11);
-
-	if (check_ref_format(ref.buf))
+	if (strbuf_check_branch_ref(&ref, name))
 		die("'%s' is not a valid branch name.", name);
 
 	if (resolve_ref(ref.buf, sha1, 1, NULL)) {
diff --git a/builtin-branch.c b/builtin-branch.c
index e15440f..cd8f42d 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -468,14 +468,10 @@ static void rename_branch(const char *oldname, const char *newname, int force)
 	if (!oldname)
 		die("cannot rename the current branch while not on any.");
 
-	strbuf_branchname(&oldref, oldname);
-	strbuf_splice(&oldref, 0, 0, "refs/heads/", 11);
-	if (check_ref_format(oldref.buf))
+	if (strbuf_check_branch_ref(&oldref, oldname))
 		die("Invalid branch name: '%s'", oldname);
 
-	strbuf_branchname(&newref, newname);
-	strbuf_splice(&newref, 0, 0, "refs/heads/", 11);
-	if (check_ref_format(newref.buf))
+	if (strbuf_check_branch_ref(&newref, newname))
 		die("Invalid branch name: '%s'", newname);
 
 	if (resolve_ref(newref.buf, sha1, 1, NULL) && !force)
diff --git a/builtin-check-ref-format.c b/builtin-check-ref-format.c
index 39db6cb..f9381e0 100644
--- a/builtin-check-ref-format.c
+++ b/builtin-check-ref-format.c
@@ -11,9 +11,8 @@ int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
 {
 	if (argc == 3 && !strcmp(argv[1], "--branch")) {
 		struct strbuf sb = STRBUF_INIT;
-		strbuf_branchname(&sb, argv[2]);
-		strbuf_splice(&sb, 0, 0, "refs/heads/", 11);
-		if (check_ref_format(sb.buf))
+
+		if (strbuf_check_branch_ref(&sb, argv[2]))
 			die("'%s' is not a valid branch name", argv[2]);
 		printf("%s\n", sb.buf + 11);
 		exit(0);
diff --git a/builtin-checkout.c b/builtin-checkout.c
index b268046..66df0c0 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -733,12 +733,11 @@ no_reference:
 
 	if (opts.new_branch) {
 		struct strbuf buf = STRBUF_INIT;
-		strbuf_addstr(&buf, "refs/heads/");
-		strbuf_addstr(&buf, opts.new_branch);
+		if (strbuf_check_branch_ref(&buf, opts.new_branch))
+			die("git checkout: we do not like '%s' as a branch name.",
+			    opts.new_branch);
 		if (!get_sha1(buf.buf, rev))
 			die("git checkout: branch %s already exists", opts.new_branch);
-		if (check_ref_format(buf.buf))
-			die("git checkout: we do not like '%s' as a branch name.", opts.new_branch);
 		strbuf_release(&buf);
 	}
 
diff --git a/strbuf.c b/strbuf.c
index a60b0ad..a884960 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "refs.h"
 
 int prefixcmp(const char *str, const char *prefix)
 {
@@ -366,3 +367,10 @@ int strbuf_branchname(struct strbuf *sb, const char *name)
 	strbuf_add(sb, name, len);
 	return len;
 }
+
+int strbuf_check_branch_ref(struct strbuf *sb, const char *name)
+{
+	strbuf_branchname(sb, name);
+	strbuf_splice(sb, 0, 0, "refs/heads/", 11);
+	return check_ref_format(sb->buf);
+}
diff --git a/strbuf.h b/strbuf.h
index 68923e1..9ee908a 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -132,5 +132,6 @@ extern void stripspace(struct strbuf *buf, int skip_comments);
 extern int launch_editor(const char *path, struct strbuf *buffer, const char *const *env);
 
 extern int strbuf_branchname(struct strbuf *sb, const char *name);
+extern int strbuf_check_branch_ref(struct strbuf *sb, const char *name);
 
 #endif /* STRBUF_H */
-- 
1.6.2.1.299.gda643a
