From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 2/4] push: introduce new push.default mode "simple"
Date: Fri, 20 Apr 2012 16:59:02 +0200
Message-ID: <1334933944-13446-3-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqfwbye9re.fsf@bauges.imag.fr>
 <1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Apr 20 17:00:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLFJs-0007HI-TO
	for gcvg-git-2@plane.gmane.org; Fri, 20 Apr 2012 17:00:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255Ab2DTPAK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Apr 2012 11:00:10 -0400
Received: from mx1.imag.fr ([129.88.30.5]:33467 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932245Ab2DTPAB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2012 11:00:01 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q3KEqxfb013790
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 20 Apr 2012 16:52:59 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SLFIr-0008Ml-3U; Fri, 20 Apr 2012 16:59:17 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SLFIr-0003W9-1Q; Fri, 20 Apr 2012 16:59:17 +0200
X-Mailer: git-send-email 1.7.10.140.g8c333
In-Reply-To: <1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 20 Apr 2012 16:52:59 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q3KEqxfb013790
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1335538383.84448@924gKGAjdhsGnMQz6LlLSg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195999>

When calling "git push" without argument, we want to allow Git to do
something simple to explain and safe. push.default=matching is unsafe
when use to push to shared repositories, and hard to explain to beginners
in some context. It is debatable whether 'upstream' or 'current' is the
safest or the easiest to explain, so introduce a new mode called 'simple'
that is the intersection of them: push the upstream branch, but only if
it has the same name remotely. If not, give an error that suggest the
right command to push explicitely to 'upstream' or 'current'.

A question is whether to allow pushing when no upstream is configured. An
argument in favor of allowing the push is that it makes the new mode work
in more cases. On the other hand, refusing to push when no upstream is
configured encourages the user to set the upstream, which will be
beneficial on the next pull. Lacking better argument, we chose to deny
the push, because it will be easier to change in the future is someone
shows us wrong.

Original-patch-by: Jeff King <peff@peff.net>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
Except for the broken-ness, this adds the last line in the warning message:

"To chose either option permanently, read about push.default in git-config(1)"

 Documentation/config.txt |    3 +++
 builtin/push.c           |   32 +++++++++++++++++++++--
 cache.h                  |    1 +
 config.c                 |    4 ++-
 t/t5528-push-default.sh  |   63 +++++++++++++++++++++++++++++++++++++++++++---
 5 files changed, 97 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 368a770..05d1472 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1697,6 +1697,9 @@ push.default::
   This option allows publishing a branch to a remote repository using
   the same naming convention locally and remotely, in a more
   conservative and safer way than `matching`.
+* `simple` - like `upstream`, but refuses to push if the upstream
+  branch's name is different from the local one. This is the safest
+  option and is well-suited for beginners.
 
 rebase.stat::
 	Whether to show a diffstat of what changed upstream since the last
diff --git a/builtin/push.c b/builtin/push.c
index 6936713..ba0d6a0 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -76,7 +76,7 @@ static int push_url_of_remote(struct remote *remote, const char ***url_p)
 	return remote->url_nr;
 }
 
-static void setup_push_upstream(struct remote *remote)
+static void setup_push_upstream(struct remote *remote, int simple)
 {
 	struct strbuf refspec = STRBUF_INIT;
 	struct branch *branch = branch_get(NULL);
@@ -103,6 +103,30 @@ static void setup_push_upstream(struct remote *remote)
 		      "your current branch '%s', without telling me what to push\n"
 		      "to update which remote branch."),
 		    remote->name, branch->name);
+	if (simple && strcmp(branch->refname, branch->merge[0]->src)) {
+		/*
+		 * There's no point in using shorten_unambiguous_ref here,
+		 * as the ambiguity would be on the remote side, not what
+		 * we have locally. Plus, this is supposed to be the simple
+		 * mode. If the user is doing something crazy like setting
+		 * upstream to a non-branch, we should probably be showing
+		 * them the big ugly fully qualified ref.
+		 */
+		const char *short_up = skip_prefix(branch->merge[0]->src, "refs/heads/");
+		die(_("The upstream branch of your current branch does not match\n"
+		      "the name of your current branch.  To push to the upstream branch\n"
+		      "on the remote, use\n"
+		      "\n"
+		      "    git push %s HEAD:%s\n"
+		      "\n"
+		      "To push to the branch of the same name on the remote, use\n"
+		      "\n"
+		      "    git push %s %s\n"
+		      "\n"
+		      "To chose either option permanently, read about push.default in git-config(1)\n"),
+		    remote->name, short_up ? short_up : branch->merge[0]->src,
+		    remote->name, branch->name);
+	}
 
 	strbuf_addf(&refspec, "%s:%s", branch->name, branch->merge[0]->src);
 	add_refspec(refspec.buf);
@@ -119,8 +143,12 @@ static void setup_default_push_refspecs(struct remote *remote)
 		add_refspec(":");
 		break;
 
+	case PUSH_DEFAULT_SIMPLE:
+		setup_push_upstream(remote, 1);
+		break;
+
 	case PUSH_DEFAULT_UPSTREAM:
-		setup_push_upstream(remote);
+		setup_push_upstream(remote, 0);
 		break;
 
 	case PUSH_DEFAULT_CURRENT:
diff --git a/cache.h b/cache.h
index d8f6f1e..5e419a1 100644
--- a/cache.h
+++ b/cache.h
@@ -580,6 +580,7 @@ enum rebase_setup_type {
 enum push_default_type {
 	PUSH_DEFAULT_NOTHING = 0,
 	PUSH_DEFAULT_MATCHING,
+	PUSH_DEFAULT_SIMPLE,
 	PUSH_DEFAULT_UPSTREAM,
 	PUSH_DEFAULT_CURRENT,
 	PUSH_DEFAULT_UNSPECIFIED
diff --git a/config.c b/config.c
index 68d3294..024bc74 100644
--- a/config.c
+++ b/config.c
@@ -829,6 +829,8 @@ static int git_default_push_config(const char *var, const char *value)
 			push_default = PUSH_DEFAULT_NOTHING;
 		else if (!strcmp(value, "matching"))
 			push_default = PUSH_DEFAULT_MATCHING;
+		else if (!strcmp(value, "simple"))
+			push_default = PUSH_DEFAULT_SIMPLE;
 		else if (!strcmp(value, "upstream"))
 			push_default = PUSH_DEFAULT_UPSTREAM;
 		else if (!strcmp(value, "tracking")) /* deprecated */
@@ -837,7 +839,7 @@ static int git_default_push_config(const char *var, const char *value)
 			push_default = PUSH_DEFAULT_CURRENT;
 		else {
 			error("Malformed value for %s: %s", var, value);
-			return error("Must be one of nothing, matching, "
+			return error("Must be one of simple, nothing, matching, "
 				     "tracking or current.");
 		}
 		return 0;
diff --git a/t/t5528-push-default.sh b/t/t5528-push-default.sh
index c334c51..949dbdf 100755
--- a/t/t5528-push-default.sh
+++ b/t/t5528-push-default.sh
@@ -13,6 +13,22 @@ test_expect_success 'setup bare remotes' '
 	git push parent2 HEAD
 '
 
+# $1 = local revision
+# $2 = remote repository
+# $3 = remote revision (tested to be equal to the local one)
+check_pushed_commit () {
+	git rev-parse "$1" > expect &&
+	git --git-dir="$2" rev-parse "$3" > actual &&
+	test_cmp expect actual
+}
+
+# $1 = push.default value
+# $2 = expected target branch for the push
+test_push_success () {
+	git -c push.default="$1" push &&
+	check_pushed_commit HEAD repo1 "$2"
+}
+
 test_expect_success '"upstream" pushes to configured upstream' '
 	git checkout master &&
 	test_config branch.master.remote parent1 &&
@@ -20,9 +36,7 @@ test_expect_success '"upstream" pushes to configured upstream' '
 	test_config push.default upstream &&
 	test_commit two &&
 	git push &&
-	echo two >expect &&
-	git --git-dir=repo1 log -1 --format=%s foo >actual &&
-	test_cmp expect actual
+	check_pushed_commit HEAD repo1 foo
 '
 
 test_expect_success '"upstream" does not push on unconfigured remote' '
@@ -51,4 +65,47 @@ test_expect_success '"upstream" does not push when remotes do not match' '
 	test_must_fail git push parent2
 '
 
+test_expect_success 'push from/to new branch with upstream, matching and simple' '
+	git checkout -b new-branch &&
+	test_must_fail git -c push.default=simple push &&
+	test_must_fail git -c push.default=matching push &&
+	test_must_fail git -c push.default=upstream push
+'
+
+test_expect_success 'push from/to new branch with current creates remote branch' '
+	test_config branch.new-branch.remote repo1 &&
+	git checkout new-branch &&
+	test_push_success current new-branch
+'
+
+test_expect_success 'push to existing branch, with no upstream configured' '
+	test_config branch.master.remote repo1 &&
+	git checkout master &&
+	test_must_fail git -c push.default=simple push &&
+	test_must_fail git -c push.default=upstream push
+'
+
+test_expect_success 'push to existing branch, upstream configured with same name' '
+	test_config branch.master.remote repo1 &&
+	test_config branch.master.merge refs/heads/master &&
+	git checkout master &&
+	test_commit six &&
+	test_push_success upstream master &&
+	test_commit seven &&
+	test_push_success simple master &&
+	check_pushed_commit HEAD repo1 master
+'
+
+test_expect_success 'push to existing branch, upstream configured with different name' '
+	test_config branch.master.remote repo1 &&
+	test_config branch.master.merge refs/heads/other-name &&
+	git checkout master &&
+	test_commit eight &&
+	test_push_success upstream other-name &&
+	test_commit nine &&
+	test_must_fail git -c push.default=simple push &&
+	test_push_success current master &&
+	test_must_fail check_pushed_commit HEAD repo1 other-name
+'
+
 test_done
-- 
1.7.10.140.g8c333
