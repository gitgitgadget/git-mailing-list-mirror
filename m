From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] push: error out when the "upstream" semantics does not make
 sense
Date: Thu, 05 Apr 2012 09:00:30 -0700
Message-ID: <7v1uo26ue9.fsf_-_@alter.siamese.dyndns.org>
References: <7v8vib6pu8.fsf@alter.siamese.dyndns.org>
 <20120405124706.GA3921@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 05 18:00:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFp7A-0006wb-J9
	for gcvg-git-2@plane.gmane.org; Thu, 05 Apr 2012 18:00:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752304Ab2DEQAg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Apr 2012 12:00:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57333 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750959Ab2DEQAf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2012 12:00:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E4EC70D5;
	Thu,  5 Apr 2012 12:00:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Wnm+9Y9VmjibhMrHzY4avA1T5D0=; b=dj0Frx
	gCt3oUzh1QsYS8XwOkJNw8hlQNQ/XEju5SoWqu4hoYwznxVw0yNZWaNAkHqgVRfC
	ovBJyo2M9OhPalB2JlK82iI9AabzCh+FhObc1XEjBr9ZU5CGcc1Ns62l465YsnL6
	lEGz0eE20cGb4qxK8ZBB1nIUeKr7yP+FdBJpI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fdLmfzZE4ntI/ATrmH/7VlAaOdaIJqqa
	Cfmrr9rXg/el2ATRBIuJZND94VFGgbDchDdkpYFtLQgorWBXR0l1AgUZ2A6r214S
	WfOLk43KLEsYqppY99dMwo3rNxunhCxdCcAE0MqicMJmdfGbBJvvETW9uRMBAose
	+vKgND64jhk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5671070D4;
	Thu,  5 Apr 2012 12:00:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 79FAC70D3; Thu,  5 Apr 2012
 12:00:32 -0400 (EDT)
In-Reply-To: <20120405124706.GA3921@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 5 Apr 2012 08:47:06 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7923B5D6-7F38-11E1-915D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194783>

The user can say "git push" without specifying any refspec.  When using
the "upstream" semantics via the push.default configuration, the user
wants to update the "upstream" branch of the current branch, which is the
branch at a remote repository the current branch is set to integrate with,
with this command.

However, there are cases that such a "git push" that uses the "upstream"
semantics does not make sense:

 - The current branch does not have branch.$name.remote configured.  By
   definition, "git push" that does not name where to push to will not
   know where to push to.  The user may explicitly say "git push $there",
   but again, by definition, no branch at repository $there is set to
   integrate with the current branch in this case and we wouldn't know
   which remote branch to update.

 - The current branch does have branch.$name.remote configured, but it
   does not specify branch.$name.merge that names what branch at the
   remote this branch integrates with. "git push" knows where to push in
   this case (or the user may explicitly say "git push $remote" to tell us
   where to push), but we do not know which remote branch to update.

 - The current branch does have its remote and upstream branch configured,
   but the user said "git push $there", where $there is not the remote
   named by "branch.$name.remote".  By definition, no branch at repository
   $there is set to integrate with the current branch in this case, and
   this push is not meant to update any branch at the remote repository
   $there.

The first two cases were already checked correctly, but the third case was
not checked and we ended up updating the branch named branch.$name.merge
at repository $there, which was totally bogus.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
Jeff King <peff@peff.net> writes:

> The patch produced by squashing those together looks good to me.  Though
> it might be worth getting input from people who use "upstream" (whether
> it becomes the default or not) by re-posting the final patch under a
> more obvious subject.

One obvious glitch that used to make "upstream" an unsuitable default for
beginners is down. Any others?

 builtin/push.c          |   25 +++++++++++++++-------
 t/t5528-push-default.sh |   54 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+), 8 deletions(-)
 create mode 100755 t/t5528-push-default.sh

diff --git a/builtin/push.c b/builtin/push.c
index d315475..765b19c 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -65,6 +65,16 @@ static void set_refspecs(const char **refs, int nr)
 	}
 }
 
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
 static void setup_push_upstream(struct remote *remote)
 {
 	struct strbuf refspec = STRBUF_INIT;
@@ -76,7 +86,7 @@ static void setup_push_upstream(struct remote *remote)
 		    "\n"
 		    "    git push %s HEAD:<name-of-remote-branch>\n"),
 		    remote->name);
-	if (!branch->merge_nr || !branch->merge)
+	if (!branch->merge_nr || !branch->merge || !branch->remote_name)
 		die(_("The current branch %s has no upstream branch.\n"
 		    "To push the current branch and set the remote as upstream, use\n"
 		    "\n"
@@ -87,6 +97,11 @@ static void setup_push_upstream(struct remote *remote)
 	if (branch->merge_nr != 1)
 		die(_("The current branch %s has multiple upstream branches, "
 		    "refusing to push."), branch->name);
+	if (strcmp(branch->remote_name, remote->name))
+		die(_("You are pushing to remote '%s', which is not the "
+		      "upstream of your\ncurrent branch '%s'.\n"),
+		    remote->name, branch->name);
+
 	strbuf_addf(&refspec, "%s:%s", branch->name, branch->merge[0]->src);
 	add_refspec(refspec.buf);
 }
@@ -196,13 +211,7 @@ static int do_push(const char *repo, int flags)
 			setup_default_push_refspecs(remote);
 	}
 	errs = 0;
-	if (remote->pushurl_nr) {
-		url = remote->pushurl;
-		url_nr = remote->pushurl_nr;
-	} else {
-		url = remote->url;
-		url_nr = remote->url_nr;
-	}
+	url_nr = push_url_of_remote(remote, &url);
 	if (url_nr) {
 		for (i = 0; i < url_nr; i++) {
 			struct transport *transport =
diff --git a/t/t5528-push-default.sh b/t/t5528-push-default.sh
new file mode 100755
index 0000000..c334c51
--- /dev/null
+++ b/t/t5528-push-default.sh
@@ -0,0 +1,54 @@
+#!/bin/sh
+
+test_description='check various push.default settings'
+. ./test-lib.sh
+
+test_expect_success 'setup bare remotes' '
+	git init --bare repo1 &&
+	git remote add parent1 repo1 &&
+	git init --bare repo2 &&
+	git remote add parent2 repo2 &&
+	test_commit one &&
+	git push parent1 HEAD &&
+	git push parent2 HEAD
+'
+
+test_expect_success '"upstream" pushes to configured upstream' '
+	git checkout master &&
+	test_config branch.master.remote parent1 &&
+	test_config branch.master.merge refs/heads/foo &&
+	test_config push.default upstream &&
+	test_commit two &&
+	git push &&
+	echo two >expect &&
+	git --git-dir=repo1 log -1 --format=%s foo >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '"upstream" does not push on unconfigured remote' '
+	git checkout master &&
+	test_unconfig branch.master.remote &&
+	test_config push.default upstream &&
+	test_commit three &&
+	test_must_fail git push
+'
+
+test_expect_success '"upstream" does not push on unconfigured branch' '
+	git checkout master &&
+	test_config branch.master.remote parent1 &&
+	test_unconfig branch.master.merge &&
+	test_config push.default upstream
+	test_commit four &&
+	test_must_fail git push
+'
+
+test_expect_success '"upstream" does not push when remotes do not match' '
+	git checkout master &&
+	test_config branch.master.remote parent1 &&
+	test_config branch.master.merge refs/heads/foo &&
+	test_config push.default upstream &&
+	test_commit five &&
+	test_must_fail git push parent2
+'
+
+test_done
-- 
1.7.10.rc4.54.g1d5dd3
