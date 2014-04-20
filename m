From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 2/8] Add concept of 'publish' branch
Date: Sun, 20 Apr 2014 14:45:00 -0500
Message-ID: <1398023106-25958-3-git-send-email-felipe.contreras@gmail.com>
References: <1398023106-25958-1-git-send-email-felipe.contreras@gmail.com>
Cc: Matthieu Moy <matthieu.moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>,
	John Szakmeister <john@szakmeister.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 20 21:56:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wbxqk-0006r9-BF
	for gcvg-git-2@plane.gmane.org; Sun, 20 Apr 2014 21:56:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755535AbaDTTz5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2014 15:55:57 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:55467 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755481AbaDTTzd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2014 15:55:33 -0400
Received: by mail-yk0-f173.google.com with SMTP id 10so2799907ykt.4
        for <git@vger.kernel.org>; Sun, 20 Apr 2014 12:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EaiIe1MXPvrUBqOY2lTxXtrWcBMdRqjgk5eXw+725pk=;
        b=bMKahZGJVWM1DfLqwEwohLtD93LBfukxEBFuzPUWPL+EWD6F6CXgyx8ggRhU9s1Zoq
         zuZPEeeMCraSI2vBbHpbCL96Lw/SpjVcDtbnkkLqgOhRxoBYp1KCJcVGul49nHIGxkGE
         vfn9OlVyEwJLoaEhdQDN9UHeeB5hc6STKR194DvCUBL+/yHy8QfziRT8wJ0UvkrNa2Wu
         8j5Os8+bj7m5JHXPXP0RvElYAbNEJEhPagUUTglISE1eR9qg1gpjgB2qnOFfrXQOGxvW
         /6y7+EYRr6jXgOixSA4kj649BMWYY6H1KyPT7uurFD+oguhNrhszSZykodQ74v9KOYOs
         ReZw==
X-Received: by 10.236.39.72 with SMTP id c48mr18531yhb.89.1398023732869;
        Sun, 20 Apr 2014 12:55:32 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id t24sm65566905yhb.39.2014.04.20.12.55.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Apr 2014 12:55:31 -0700 (PDT)
X-Mailer: git-send-email 1.9.1+fc3.9.gc73078e
In-Reply-To: <1398023106-25958-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246576>

The publish branch is the branch the user wants to push to, akin to the
upstream branch, which is the branch the user wants to use as a
baseline. It overrides other configurations, such as push.default, and
remote.<name>.push.

The upstream branch is:

  branch.$name.remote
  branch.$name.merge

The publish branch is:

  branch.$name.pushremote
  branch.$name.push

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/config.txt |  7 +++++++
 builtin/push.c           |  9 ++++++++-
 remote.c                 | 34 ++++++++++++++++++++++++++++------
 remote.h                 |  4 ++++
 t/t5516-fetch-push.sh    | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 95 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5f4d793..1569353 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -764,6 +764,13 @@ branch.<name>.mergeoptions::
 	option values containing whitespace characters are currently not
 	supported.
 
+branch.<name>.push::
+	Defines, together with branch.<name>.pushremote, the publish branch for
+	the given branch. It tells 'git push' which branch to push to, and
+	overrides any other configurations, such as push.default. It also tells
+	commands such as 'git status' and 'git branch' which remote branch to
+	use for tracking information (commits ahead and behind).
+
 branch.<name>.rebase::
 	When true, rebase the branch <name> on top of the fetched branch,
 	instead of merging the default branch from the default remote when
diff --git a/builtin/push.c b/builtin/push.c
index 0e50ddb..fe48c95 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -441,7 +441,14 @@ static int do_push(const char *repo, int flags)
 	}
 
 	if (!refspec && !(flags & TRANSPORT_PUSH_ALL)) {
-		if (remote->push_refspec_nr) {
+		struct branch *branch = branch_get(NULL);
+		/* Is there a publish branch */
+		if (branch && branch->pushremote_name && !strcmp(remote->name, branch->pushremote_name) &&
+				branch->push_name) {
+			struct strbuf refspec = STRBUF_INIT;
+			strbuf_addf(&refspec, "%s:%s", branch->name, branch->push_name);
+			add_refspec(refspec.buf);
+		} else if (remote->push_refspec_nr) {
 			refspec = remote->push_refspec;
 			refspec_nr = remote->push_refspec_nr;
 		} else if (!(flags & TRANSPORT_PUSH_MIRROR))
diff --git a/remote.c b/remote.c
index 5f63d55..eda6192 100644
--- a/remote.c
+++ b/remote.c
@@ -352,13 +352,17 @@ static int handle_config(const char *key, const char *value, void *cb)
 				explicit_default_remote_name = 1;
 			}
 		} else if (!strcmp(subkey, ".pushremote")) {
+			if (git_config_string(&branch->pushremote_name, key, value))
+				return -1;
 			if (branch == current_branch)
-				if (git_config_string(&branch_pushremote_name, key, value))
-					return -1;
+				branch_pushremote_name = xstrdup(branch->pushremote_name);
 		} else if (!strcmp(subkey, ".merge")) {
 			if (!value)
 				return config_error_nonbool(key);
 			add_merge(branch, xstrdup(value));
+		} else if (!strcmp(subkey, ".push")) {
+			if (git_config_string(&branch->push_name, key, value))
+				return -1;
 		}
 		return 0;
 	}
@@ -1562,6 +1566,14 @@ struct branch *branch_get(const char *name)
 			}
 		}
 	}
+	if (ret && ret->pushremote_name && ret->push_name) {
+		struct remote *pushremote;
+		pushremote = pushremote_get(ret->pushremote_name);
+		ret->push.src = xstrdup(ret->push_name);
+		if (remote_find_tracking(pushremote, &ret->push)
+		    && !strcmp(ret->pushremote_name, "."))
+			ret->push.dst = xstrdup(ret->push_name);
+	}
 	return ret;
 }
 
@@ -1771,6 +1783,15 @@ int ref_newer(const unsigned char *new_sha1, const unsigned char *old_sha1)
 	return found;
 }
 
+static char *get_base(struct branch *branch)
+{
+	if (branch->push.dst)
+		return branch->push.dst;
+	if (branch->merge && branch->merge[0] && branch->merge[0]->dst)
+		return branch->merge[0]->dst;
+	return NULL;
+}
+
 /*
  * Compare a branch with its upstream, and save their differences (number
  * of commits) in *num_ours and *num_theirs.
@@ -1788,12 +1809,13 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs)
 	int rev_argc;
 
 	/* Cannot stat unless we are marked to build on top of somebody else. */
-	if (!branch ||
-	    !branch->merge || !branch->merge[0] || !branch->merge[0]->dst)
+	if (!branch)
+		return 0;
+	base = get_base(branch);
+	if (!base)
 		return 0;
 
 	/* Cannot stat if what we used to build on no longer exists */
-	base = branch->merge[0]->dst;
 	if (read_ref(base, sha1))
 		return -1;
 	theirs = lookup_commit_reference(sha1);
@@ -1869,7 +1891,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
 		break;
 	}
 
-	base = branch->merge[0]->dst;
+	base = get_base(branch);
 	base = shorten_unambiguous_ref(base, 0);
 	if (upstream_is_gone) {
 		strbuf_addf(sb,
diff --git a/remote.h b/remote.h
index fb7647f..08e93c4 100644
--- a/remote.h
+++ b/remote.h
@@ -204,6 +204,10 @@ struct branch {
 	struct refspec **merge;
 	int merge_nr;
 	int merge_alloc;
+
+	const char *pushremote_name;
+	const char *push_name;
+	struct refspec push;
 };
 
 struct branch *branch_get(const char *name);
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index f4cf0db..80a00e3 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1279,4 +1279,52 @@ EOF
 	git push --no-thin --receive-pack="$rcvpck" no-thin/.git refs/heads/master:refs/heads/foo
 '
 
+mk_publish_test () {
+	mk_test up_repo heads/master &&
+	mk_test down_repo heads/master &&
+	test_config remote.up.url up_repo &&
+	test_config remote.down.url down_repo &&
+	test_config branch.master.pushremote down &&
+	test_config branch.master.push for-john &&
+	test_config branch.master.remote up &&
+	test_config branch.master.merge master
+}
+
+test_expect_success 'push with publish branch' '
+	mk_publish_test &&
+	git push &&
+	check_push_result up_repo $the_first_commit heads/master &&
+	check_push_result down_repo $the_commit heads/for-john
+'
+
+test_expect_success 'push with publish branch for different remote' '
+	mk_publish_test &&
+	git push up &&
+	check_push_result up_repo $the_commit heads/master &&
+	check_push_result down_repo $the_first_commit heads/master
+'
+
+test_expect_success 'push with publish branch with pushdefault' '
+	mk_publish_test &&
+	test_config remote.pushdefault up &&
+	git push &&
+	check_push_result up_repo $the_first_commit heads/master &&
+	check_push_result down_repo $the_commit heads/for-john
+'
+
+test_expect_success 'push with publish branch with remote refspec' '
+	mk_publish_test &&
+	test_config remote.down.push refs/heads/master:refs/heads/bad &&
+	git push &&
+	check_push_result up_repo $the_first_commit heads/master &&
+	check_push_result down_repo $the_commit heads/for-john
+'
+
+test_expect_success 'push with publish branch with manual refspec' '
+	mk_publish_test &&
+	git push down master:good &&
+	check_push_result up_repo $the_first_commit heads/master &&
+	check_push_result down_repo $the_commit heads/good
+'
+
 test_done
-- 
1.9.1+fc3.9.gc73078e
