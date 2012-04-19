From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/3] push: introduce new push.default mode "simple"
Date: Fri, 20 Apr 2012 00:57:12 +0200
Message-ID: <1334876234-20077-2-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqaa27bgon.fsf@bauges.imag.fr>
 <1334876234-20077-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Apr 20 01:27:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SL0lY-0002mX-9h
	for gcvg-git-2@plane.gmane.org; Fri, 20 Apr 2012 01:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755601Ab2DSX1w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Apr 2012 19:27:52 -0400
Received: from mx1.imag.fr ([129.88.30.5]:44765 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754038Ab2DSX1u (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2012 19:27:50 -0400
X-Greylist: delayed 1814 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Apr 2012 19:27:48 EDT
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q3JMp49a023920
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 20 Apr 2012 00:51:04 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SL0Hw-0001mO-2f; Fri, 20 Apr 2012 00:57:20 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SL0Hw-0005Ez-0k; Fri, 20 Apr 2012 00:57:20 +0200
X-Mailer: git-send-email 1.7.10.140.g8c333
In-Reply-To: <1334876234-20077-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 20 Apr 2012 00:51:04 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q3JMp49a023920
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1335480666.57274@BzGDyyZSE17qYtRQYTqqJQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195974>

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

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 builtin/push.c        |   47 +++++++++++++++++++++++++++++++++++++++++++++--
 cache.h               |    1 +
 config.c              |    4 +++-
 t/t5516-fetch-push.sh |   33 +++++++++++++++++++++++++++++++++
 4 files changed, 82 insertions(+), 3 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index d315475..4602cd8 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -65,7 +65,17 @@ static void set_refspecs(const char **refs, int nr)
 	}
 }
 
-static void setup_push_upstream(struct remote *remote)
+static int push_url_of_remote(struct remote *remote, const char ***url_p)
+{
+	if (remote->pushurl_nr) {
+		*url_p = remote->pushurl;
+		return remote->pushurl_nr;
+	}
+	*url_p = remote->url;
+	return remote->url_nr;
+}
+
+static void setup_push_upstream(struct remote *remote, int simple)
 {
 	struct strbuf refspec = STRBUF_INIT;
 	struct branch *branch = branch_get(NULL);
@@ -87,6 +97,35 @@ static void setup_push_upstream(struct remote *remote)
 	if (branch->merge_nr != 1)
 		die(_("The current branch %s has multiple upstream branches, "
 		    "refusing to push."), branch->name);
+	if (strcmp(branch->remote_name, remote->name))
+		die(_("You are pushing to remote '%s', which is not the upstream of\n"
+		      "your current branch '%s', without telling me what to push\n"
+		      "to update which remote branch."),
+		    remote->name, branch->name);
+
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
+		      "    git push %s %s\n"),
+		    remote->name, short_up ? short_up : branch->merge[0]->src,
+		    remote->name, branch->name);
+	}
+
 	strbuf_addf(&refspec, "%s:%s", branch->name, branch->merge[0]->src);
 	add_refspec(refspec.buf);
 }
@@ -99,8 +138,12 @@ static void setup_default_push_refspecs(struct remote *remote)
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
index 806bf2b..f1c1bb8 100644
--- a/cache.h
+++ b/cache.h
@@ -624,6 +624,7 @@ enum rebase_setup_type {
 enum push_default_type {
 	PUSH_DEFAULT_NOTHING = 0,
 	PUSH_DEFAULT_MATCHING,
+	PUSH_DEFAULT_SIMPLE,
 	PUSH_DEFAULT_UPSTREAM,
 	PUSH_DEFAULT_CURRENT
 };
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
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index b5417cc..f4f9d06 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -497,6 +497,39 @@ test_expect_success 'push with config remote.*.push = HEAD' '
 	check_push_result $the_first_commit heads/local
 '
 
+test_expect_success 'push without argument (push.default)' '
+	mk_test heads/master &&
+
+	test_debug "echo no remote branch" &&
+	git checkout $the_first_commit -b new-branch &&
+	test_must_fail git -c push.default=simple push &&
+	test_must_fail git -c push.default=matching push &&
+	test_must_fail git -c push.default=upstream push &&
+
+	test_debug "echo existing branch, no upstream configured" &&
+	git config branch.new-branch.remote there &&
+	git -c push.default=current push &&
+	git -c push.default=simple push &&
+	git -c push.default=matching push &&
+	git config --unset branch.new-branch.remote &&
+	test_must_fail git -c push.default=simple push &&
+
+	test_debug "echo upstream configured" &&
+	git push --set-upstream testrepo new-branch &&
+	git -c push.default=simple push &&
+	check_push_result $the_first_commit heads/new-branch &&
+	git config branch.new-branch.merge other-branch &&
+	test_must_fail git -c push.default=simple push &&
+	git -c push.default=upstream push &&
+	check_push_result $the_first_commit heads/other-branch &&
+	git push --set-upstream there new-branch &&
+
+	test_debug "echo advance local commit" &&
+	git merge $the_commit &&
+	git -c push.default=simple push &&
+	check_push_result $the_commit heads/new-branch
+'
+
 # clean up the cruft left with the previous one
 git config --remove-section remote.there
 git config --remove-section branch.master
-- 
1.7.10.140.g8c333
