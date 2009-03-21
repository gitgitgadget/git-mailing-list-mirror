From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/7] Rename interpret/substitute nth_last_branch functions
Date: Sat, 21 Mar 2009 15:13:34 -0700
Message-ID: <1237673619-12608-3-git-send-email-gitster@pobox.com>
References: <1237673619-12608-1-git-send-email-gitster@pobox.com>
 <1237673619-12608-2-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 21 23:16:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ll9U4-0007f9-LU
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 23:16:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754905AbZCUWNu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 18:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753945AbZCUWNs
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 18:13:48 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57389 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753801AbZCUWNr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 18:13:47 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id CF10A8392
	for <git@vger.kernel.org>; Sat, 21 Mar 2009 18:13:45 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 397368391 for
 <git@vger.kernel.org>; Sat, 21 Mar 2009 18:13:45 -0400 (EDT)
X-Mailer: git-send-email 1.6.2.1.299.gda643a
In-Reply-To: <1237673619-12608-2-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 8BAA3CBE-1665-11DE-BDF9-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114078>

These allow you to say "git checkout @{-2}" to switch to the branch two
"branch switching" ago by pretending as if you typed the name of that
branch.  As it is likely that we will be introducing more short-hands to
write the name of a branch without writing it explicitly, rename the
functions from "nth_last_branch" to more generic "branch_name", to prepare
for different semantics.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 branch.c           |    2 +-
 builtin-branch.c   |    2 +-
 builtin-checkout.c |    2 +-
 builtin-merge.c    |    2 +-
 cache.h            |    2 +-
 sha1_name.c        |   12 ++++++------
 6 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/branch.c b/branch.c
index 5f889fe..313bcf1 100644
--- a/branch.c
+++ b/branch.c
@@ -137,7 +137,7 @@ void create_branch(const char *head,
 	int len;
 
 	len = strlen(name);
-	if (interpret_nth_last_branch(name, &ref) != len) {
+	if (interpret_branch_name(name, &ref) != len) {
 		strbuf_reset(&ref);
 		strbuf_add(&ref, name, len);
 	}
diff --git a/builtin-branch.c b/builtin-branch.c
index 14d4b91..cacd7da 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -123,7 +123,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds)
 	for (i = 0; i < argc; i++, strbuf_release(&bname)) {
 		int len = strlen(argv[i]);
 
-		if (interpret_nth_last_branch(argv[i], &bname) != len)
+		if (interpret_branch_name(argv[i], &bname) != len)
 			strbuf_add(&bname, argv[i], len);
 
 		if (kinds == REF_LOCAL_BRANCH && !strcmp(head, bname.buf)) {
diff --git a/builtin-checkout.c b/builtin-checkout.c
index 9fdfc58..a8d9d97 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -355,7 +355,7 @@ static void setup_branch_path(struct branch_info *branch)
 	struct strbuf buf = STRBUF_INIT;
 	int ret;
 
-	if ((ret = interpret_nth_last_branch(branch->name, &buf))
+	if ((ret = interpret_branch_name(branch->name, &buf))
 	    && ret == strlen(branch->name)) {
 		branch->name = xstrdup(buf.buf);
 		strbuf_splice(&buf, 0, 0, "refs/heads/", 11);
diff --git a/builtin-merge.c b/builtin-merge.c
index 4c11935..e94ea7c 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -361,7 +361,7 @@ static void merge_name(const char *remote, struct strbuf *msg)
 	int len, early;
 
 	len = strlen(remote);
-	if (interpret_nth_last_branch(remote, &bname) == len)
+	if (interpret_branch_name(remote, &bname) == len)
 		remote = bname.buf;
 
 	memset(branch_head, 0, sizeof(branch_head));
diff --git a/cache.h b/cache.h
index 39789ee..d28fd74 100644
--- a/cache.h
+++ b/cache.h
@@ -671,7 +671,7 @@ extern int read_ref(const char *filename, unsigned char *sha1);
 extern const char *resolve_ref(const char *path, unsigned char *sha1, int, int *);
 extern int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref);
 extern int dwim_log(const char *str, int len, unsigned char *sha1, char **ref);
-extern int interpret_nth_last_branch(const char *str, struct strbuf *);
+extern int interpret_branch_name(const char *str, struct strbuf *);
 
 extern int refname_match(const char *abbrev_name, const char *full_name, const char **rules);
 extern const char *ref_rev_parse_rules[];
diff --git a/sha1_name.c b/sha1_name.c
index 2f75179..904bcd9 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -242,10 +242,10 @@ static int ambiguous_path(const char *path, int len)
  * *string and *len will only be substituted, and *string returned (for
  * later free()ing) if the string passed in is of the form @{-<n>}.
  */
-static char *substitute_nth_last_branch(const char **string, int *len)
+static char *substitute_branch_name(const char **string, int *len)
 {
 	struct strbuf buf = STRBUF_INIT;
-	int ret = interpret_nth_last_branch(*string, &buf);
+	int ret = interpret_branch_name(*string, &buf);
 
 	if (ret == *len) {
 		size_t size;
@@ -259,7 +259,7 @@ static char *substitute_nth_last_branch(const char **string, int *len)
 
 int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref)
 {
-	char *last_branch = substitute_nth_last_branch(&str, &len);
+	char *last_branch = substitute_branch_name(&str, &len);
 	const char **p, *r;
 	int refs_found = 0;
 
@@ -288,7 +288,7 @@ int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref)
 
 int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 {
-	char *last_branch = substitute_nth_last_branch(&str, &len);
+	char *last_branch = substitute_branch_name(&str, &len);
 	const char **p;
 	int logs_found = 0;
 
@@ -355,7 +355,7 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 		struct strbuf buf = STRBUF_INIT;
 		int ret;
 		/* try the @{-N} syntax for n-th checkout */
-		ret = interpret_nth_last_branch(str+at, &buf);
+		ret = interpret_branch_name(str+at, &buf);
 		if (ret > 0) {
 			/* substitute this branch name and restart */
 			return get_sha1_1(buf.buf, buf.len, sha1);
@@ -750,7 +750,7 @@ static int grab_nth_branch_switch(unsigned char *osha1, unsigned char *nsha1,
  * If the input was ok but there are not N branch switches in the
  * reflog, it returns 0.
  */
-int interpret_nth_last_branch(const char *name, struct strbuf *buf)
+int interpret_branch_name(const char *name, struct strbuf *buf)
 {
 	long nth;
 	int i, retval;
-- 
1.6.2.1.299.gda643a
