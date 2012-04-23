From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 4/7] push: introduce new push.default mode "simple"
Date: Mon, 23 Apr 2012 10:38:01 +0200
Message-ID: <1335170284-30768-5-git-send-email-Matthieu.Moy@imag.fr>
References: <1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr>
 <1335170284-30768-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Apr 23 10:39:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMEnf-0003Kc-T5
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 10:39:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754394Ab2DWIjG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Apr 2012 04:39:06 -0400
Received: from mx2.imag.fr ([129.88.30.17]:55614 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754386Ab2DWIjE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 04:39:04 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q3N8Vn28029936
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 23 Apr 2012 10:31:50 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SMEmd-0004mt-QG; Mon, 23 Apr 2012 10:38:07 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SMEmd-00081Y-OD; Mon, 23 Apr 2012 10:38:07 +0200
X-Mailer: git-send-email 1.7.10.234.ge65dd.dirty
In-Reply-To: <1335170284-30768-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 23 Apr 2012 10:31:52 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q3N8Vn28029936
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1335774714.3171@oW0tp4FfMWdukrA44jX+nw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196106>

When calling "git push" without argument, we want to allow Git to do
something simple to explain and safe. push.default=matching is unsafe
when used to push to shared repositories, and hard to explain to
beginners in some contexts. It is debatable whether 'upstream' or
'current' is the safest or the easiest to explain, so introduce a new
mode called 'simple' that is the intersection of them: push to the
upstream branch, but only if it has the same name remotely. If not, give
an error that suggests the right command to push explicitely to
'upstream' or 'current'.

A question is whether to allow pushing when no upstream is configured. An
argument in favor of allowing the push is that it makes the new mode work
in more cases. On the other hand, refusing to push when no upstream is
configured encourages the user to set the upstream, which will be
beneficial on the next pull. Lacking better argument, we chose to deny
the push, because it will be easier to change in the future if someone
shows us wrong.

Original-patch-by: Jeff King <peff@peff.net>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/config.txt |    5 ++++-
 builtin/push.c           |   44 ++++++++++++++++++++++++++++++++++++++++++--
 cache.h                  |    1 +
 config.c                 |    6 ++++--
 t/t5528-push-default.sh  |   44 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 95 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ddf6043..88d739a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1688,6 +1688,9 @@ push.default::
   repository shared by multiple users, since locally stalled
   branches will attempt a non-fast forward push if other users
   updated the branch remotely. This is the default.
+* `simple` - like `upstream`, but refuses to push if the upstream
+  branch's name is different from the local one. This is the safest
+  option and is well-suited for beginners.
 * `upstream` - push the current branch to its upstream branch. See
   "branch.<name>.merge" for how to configure the upstream branch. This
   makes `git push` and `git pull` symmetrical in the sense that `push`
@@ -1695,7 +1698,7 @@ push.default::
   `git pull`.
 * `current` - push the current branch to a branch of the same name.
   +
-  The `current` and `upstream` modes are for those who want to
+  The `simple`, `current` and `upstream` modes are for those who want to
   push out a single branch after finishing work, even when the other
   branches are not yet ready to be pushed out. They are safe when
   pushing to a shared repository.
diff --git a/builtin/push.c b/builtin/push.c
index 6936713..dae8306 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -76,7 +76,40 @@ static int push_url_of_remote(struct remote *remote, const char ***url_p)
 	return remote->url_nr;
 }
 
-static void setup_push_upstream(struct remote *remote)
+NORETURN die_push_simple(struct branch *branch, struct remote *remote) {
+	/*
+	 * There's no point in using shorten_unambiguous_ref here,
+	 * as the ambiguity would be on the remote side, not what
+	 * we have locally. Plus, this is supposed to be the simple
+	 * mode. If the user is doing something crazy like setting
+	 * upstream to a non-branch, we should probably be showing
+	 * them the big ugly fully qualified ref.
+	 */
+	const char *short_up = skip_prefix(branch->merge[0]->src, "refs/heads/");
+	/*
+	 * Don't show advice for people who explicitely set
+	 * push.default.
+	 */
+	const char *advice_maybe = "";
+	if (push_default == PUSH_DEFAULT_UNSPECIFIED)
+		advice_maybe = _("\n"
+				 "To choose either option permanently, "
+				 "see push.default in 'git help config'.");
+	die(_("The upstream branch of your current branch does not match\n"
+	      "the name of your current branch.  To push to the upstream branch\n"
+	      "on the remote, use\n"
+	      "\n"
+	      "    git push %s HEAD:%s\n"
+	      "\n"
+	      "To push to the branch of the same name on the remote, use\n"
+	      "\n"
+	      "    git push %s %s\n"
+	      "%s"),
+	    remote->name, short_up ? short_up : branch->merge[0]->src,
+	    remote->name, branch->name, advice_maybe);
+}
+
+static void setup_push_upstream(struct remote *remote, int simple)
 {
 	struct strbuf refspec = STRBUF_INIT;
 	struct branch *branch = branch_get(NULL);
@@ -103,6 +136,9 @@ static void setup_push_upstream(struct remote *remote)
 		      "your current branch '%s', without telling me what to push\n"
 		      "to update which remote branch."),
 		    remote->name, branch->name);
+	if (simple && strcmp(branch->refname, branch->merge[0]->src)) {
+		die_push_simple(branch, remote);
+	}
 
 	strbuf_addf(&refspec, "%s:%s", branch->name, branch->merge[0]->src);
 	add_refspec(refspec.buf);
@@ -119,8 +155,12 @@ static void setup_default_push_refspecs(struct remote *remote)
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
index 5bf59ff..b60d490 100644
--- a/cache.h
+++ b/cache.h
@@ -624,6 +624,7 @@ enum rebase_setup_type {
 enum push_default_type {
 	PUSH_DEFAULT_NOTHING = 0,
 	PUSH_DEFAULT_MATCHING,
+	PUSH_DEFAULT_SIMPLE,
 	PUSH_DEFAULT_UPSTREAM,
 	PUSH_DEFAULT_CURRENT,
 	PUSH_DEFAULT_UNSPECIFIED
diff --git a/config.c b/config.c
index 68d3294..bfe0c79 100644
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
@@ -837,8 +839,8 @@ static int git_default_push_config(const char *var, const char *value)
 			push_default = PUSH_DEFAULT_CURRENT;
 		else {
 			error("Malformed value for %s: %s", var, value);
-			return error("Must be one of nothing, matching, "
-				     "tracking or current.");
+			return error("Must be one of nothing, matching, simple, "
+				     "upstream or current.");
 		}
 		return 0;
 	}
diff --git a/t/t5528-push-default.sh b/t/t5528-push-default.sh
index da7d3d8..43dec43 100755
--- a/t/t5528-push-default.sh
+++ b/t/t5528-push-default.sh
@@ -82,4 +82,48 @@ test_expect_success '"upstream" does not push when remotes do not match' '
 	test_must_fail git push parent2
 '
 
+test_expect_success 'push from/to new branch with upstream, matching and simple' '
+	git checkout -b new-branch &&
+	test_push_failure simple new-branch &&
+	test_push_failure matching new-branch &&
+	test_push_failure upstream new-branch
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
+	test_push_failure simple master &&
+	test_push_failure upstream master
+'
+
+test_expect_success 'push to existing branch, upstream configured with same name' '
+	test_config branch.master.remote repo1 &&
+	test_config branch.master.merge refs/heads/master &&
+	git checkout master &&
+	test_commit six &&
+	test_push_success upstream master &&
+	test_commit seven &&
+	test_push_success simple master
+'
+
+test_expect_success 'push to existing branch, upstream configured with different name' '
+	test_config branch.master.remote repo1 &&
+	test_config branch.master.merge refs/heads/other-name &&
+	git checkout master &&
+	test_commit eight &&
+	test_push_success upstream other-name &&
+	test_commit nine &&
+	test_push_failure simple new-branch &&
+	git --git-dir=repo1 log -1 --format="%h %s" "other-name" >expect-other-name &&
+	test_push_success current master &&
+	git --git-dir=repo1 log -1 --format="%h %s" "other-name" >actual-other-name &&
+	test_cmp expect-other-name actual-other-name
+'
+
 test_done
-- 
1.7.10.234.ge65dd.dirty
