From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] clone: allow more than one --reference
Date: Mon, 22 Aug 2011 18:05:15 -0700
Message-ID: <1314061516-24964-2-git-send-email-gitster@pobox.com>
References: <7vliulun2a.fsf@alter.siamese.dyndns.org>
 <1314061516-24964-1-git-send-email-gitster@pobox.com>
Cc: Hui Wang <jason77.wang@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 23 03:05:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvfQu-0006WG-91
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 03:05:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754700Ab1HWBFX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 21:05:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50537 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754684Ab1HWBFV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 21:05:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F2794AAF;
	Mon, 22 Aug 2011 21:05:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=ucRA
	RHXk9C44I4qWLhLgXGL5TxY=; b=PrcYoIIq5yDva1GkOs5fNJErGqeCiUFW5Fck
	BrgG2s5+Xs6clff1r3tH4pwCIgZ+ZmoqgF4PcHBlv3CpBlItIbtO+iZ7pYZJcww7
	JhYcqSh+/Yxv070f0sAcGQcBbSDOUwBOGlNAPBgkH/6tNGoNZaM28GVQFOJg3/qO
	cyondmg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	YFYbDIZnKnfr9qv9E4SdyrBrjyCzeiP+pRwJi8Us746j6eT4pLPGo+LoCCLpsxvv
	NajWugOTlXdqsRs7Ah+8hyQBe7n3Qp26Ewkjo47ucgfLa7S5t3FdGjPak9B0zydl
	PFAeCxo1SXG5msgJVsnQ7y9syPUovk1oh11dLewQ8MI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 967564AAE;
	Mon, 22 Aug 2011 21:05:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D422B4AAD; Mon, 22 Aug 2011
 21:05:19 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.557.gcee42
In-Reply-To: <1314061516-24964-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: F88F1300-CD23-11E0-AC5C-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179909>

Also add a test to expose a long-standing bug that is triggered when
cloning with --reference option from a local repository that has its own
alternates. The alternate object stores specified on the command line
are lost, and only alternates copied from the source repository remain.
The bug will be fixed in the next patch.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/clone.c  |   32 ++++++++++++++++++++++++--------
 t/t5601-clone.sh |   15 +++++++++++++++
 2 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index f579794..ee5d651 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -39,13 +39,23 @@ static const char * const builtin_clone_usage[] = {
 
 static int option_no_checkout, option_bare, option_mirror;
 static int option_local, option_no_hardlinks, option_shared, option_recursive;
-static char *option_template, *option_reference, *option_depth;
+static char *option_template, *option_depth;
 static char *option_origin = NULL;
 static char *option_branch = NULL;
 static const char *real_git_dir;
 static char *option_upload_pack = "git-upload-pack";
 static int option_verbosity;
 static int option_progress;
+static struct string_list option_reference;
+
+static int opt_parse_reference(const struct option *opt, const char *arg, int unset)
+{
+	struct string_list *option_reference = opt->value;
+	if (!arg)
+		return -1;
+	string_list_append(option_reference, arg);
+	return 0;
+}
 
 static struct option builtin_clone_options[] = {
 	OPT__VERBOSITY(&option_verbosity),
@@ -71,8 +81,8 @@ static struct option builtin_clone_options[] = {
 		    "initialize submodules in the clone"),
 	OPT_STRING(0, "template", &option_template, "template-directory",
 		   "directory from which templates will be used"),
-	OPT_STRING(0, "reference", &option_reference, "repo",
-		   "reference repository"),
+	OPT_CALLBACK(0 , "reference", &option_reference, "repo",
+		     "reference repository", &opt_parse_reference),
 	OPT_STRING('o', "origin", &option_origin, "branch",
 		   "use <branch> instead of 'origin' to track upstream"),
 	OPT_STRING('b', "branch", &option_branch, "branch",
@@ -197,7 +207,7 @@ static void strip_trailing_slashes(char *dir)
 	*end = '\0';
 }
 
-static void setup_reference(const char *repo)
+static int add_one_reference(struct string_list_item *item, void *cb_data)
 {
 	const char *ref_git;
 	char *ref_git_copy;
@@ -206,13 +216,13 @@ static void setup_reference(const char *repo)
 	struct transport *transport;
 	const struct ref *extra;
 
-	ref_git = real_path(option_reference);
+	ref_git = real_path(item->string);
 
 	if (is_directory(mkpath("%s/.git/objects", ref_git)))
 		ref_git = mkpath("%s/.git", ref_git);
 	else if (!is_directory(mkpath("%s/objects", ref_git)))
 		die(_("reference repository '%s' is not a local directory."),
-		    option_reference);
+		    item->string);
 
 	ref_git_copy = xstrdup(ref_git);
 
@@ -227,6 +237,12 @@ static void setup_reference(const char *repo)
 	transport_disconnect(transport);
 
 	free(ref_git_copy);
+	return 0;
+}
+
+static void setup_reference(void)
+{
+	for_each_string_list(&option_reference, add_one_reference, NULL);
 }
 
 static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest)
@@ -521,8 +537,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	git_config_set(key.buf, repo);
 	strbuf_reset(&key);
 
-	if (option_reference)
-		setup_reference(git_dir);
+	if (option_reference.nr)
+		setup_reference();
 
 	fetch_pattern = value.buf;
 	refspec = parse_fetch_refspec(1, &fetch_pattern);
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 151ea53..0163ad1 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -207,4 +207,19 @@ test_expect_success 'clone separate gitdir where target already exists' '
 	test_must_fail git clone --separate-git-dir realgitdir src dst
 '
 
+test_expect_failure 'clone --reference from original' '
+	git clone --shared --bare src src-1 &&
+	git clone --bare src src-2 &&
+	git clone --reference=src-2 --bare src-1 target-8 &&
+	grep /src-2/ target-8/objects/info/alternates
+'
+
+test_expect_success 'clone with more than one --reference' '
+	git clone --bare src src-3 &&
+	git clone --bare src src-4 &&
+	git clone --reference=src-3 --reference=src-4 src target-9 &&
+	grep /src-3/ target-9/.git/objects/info/alternates &&
+	grep /src-4/ target-9/.git/objects/info/alternates
+'
+
 test_done
-- 
1.7.6.557.gcee42
