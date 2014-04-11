From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 2/8] Add concept of 'publish' branch
Date: Fri, 11 Apr 2014 12:59:05 -0500
Message-ID: <1397239151-2391-3-git-send-email-felipe.contreras@gmail.com>
References: <1397239151-2391-1-git-send-email-felipe.contreras@gmail.com>
Cc: Matthieu Moy <matthieu.moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>,
	John Szakmeister <john@szakmeister.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 11 20:09:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYftK-0006v1-0q
	for gcvg-git-2@plane.gmane.org; Fri, 11 Apr 2014 20:09:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754808AbaDKSJW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2014 14:09:22 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:63381 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754795AbaDKSJS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2014 14:09:18 -0400
Received: by mail-ob0-f175.google.com with SMTP id vb8so30332obc.34
        for <git@vger.kernel.org>; Fri, 11 Apr 2014 11:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vC/LLMKkxKRnNcg87a6NLxsJ0X5t8aS1RQUzP0KS5r0=;
        b=pCV9YjJp67hdWz/CHr63/2KKdIg6FzsPJsCP8877W5h1V8k+ZZUrTb4JF3NtUfY8lq
         UViTXb0i1E8g17Qc0PuUCFgJy5ymNW08MRF02dGR+mw7AqpJYiQKVJk30XBYZjyyvxgh
         GVJg949YDQPERsOl2/RdpEEq93A4qZJqz/f5lvZ0L5vtRu6ycAhRj6mh47x/Kp//ej53
         Anc+rWx9swc4gYcS+ABVJP+hvc6w31Wh7WQO8OS5+eolsZejgrtw9iPfMgzEFed51okx
         7kwY1O1Y2zmRv+hX//vuOcHOV6SJeJSqzaYOgjXmqoaayIthJW5aA7+arahmR++SSgMi
         NhoQ==
X-Received: by 10.182.231.138 with SMTP id tg10mr20838346obc.44.1397239757647;
        Fri, 11 Apr 2014 11:09:17 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id wy2sm13442271obc.21.2014.04.11.11.09.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Apr 2014 11:09:16 -0700 (PDT)
X-Mailer: git-send-email 1.9.1+fc1
In-Reply-To: <1397239151-2391-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246118>

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
 Documentation/config.txt |  7 ++++++
 builtin/push.c           |  9 ++++++-
 remote.c                 | 34 +++++++++++++++++++++-----
 remote.h                 |  4 ++++
 t/t5516-fetch-push.sh    | 62 ++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 109 insertions(+), 7 deletions(-)

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
index 0e50ddb..2a78c2b 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -441,7 +441,14 @@ static int do_push(const char *repo, int flags)
 	}
 
 	if (!refspec && !(flags & TRANSPORT_PUSH_ALL)) {
-		if (remote->push_refspec_nr) {
+		struct branch *branch = branch_get(NULL);
+		/* Is there a publish branch */
+		if (branch->pushremote_name && !strcmp(remote->name, branch->pushremote_name) &&
+				branch && branch->push_name) {
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
index f4cf0db..f9c528d 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1279,4 +1279,66 @@ EOF
 	git push --no-thin --receive-pack="$rcvpck" no-thin/.git refs/heads/master:refs/heads/foo
 '
 
+test_expect_success 'push with publish branch' '
+	mk_test up_repo heads/master &&
+	mk_test down_repo heads/master &&
+	test_config remote.up.url up_repo &&
+	test_config remote.down.url down_repo &&
+	test_config branch.master.pushremote down &&
+	test_config branch.master.push for-john &&
+	git push &&
+	check_push_result up_repo $the_first_commit heads/master &&
+	check_push_result down_repo $the_commit heads/for-john
+'
+
+test_expect_success 'push with publish branch for different remote' '
+	mk_test up_repo heads/master &&
+	mk_test down_repo heads/master &&
+	test_config remote.up.url up_repo &&
+	test_config remote.down.url down_repo &&
+	test_config branch.master.pushremote down &&
+	test_config branch.master.push for-john &&
+	git push up &&
+	check_push_result up_repo $the_commit heads/master &&
+	check_push_result down_repo $the_first_commit heads/master
+'
+
+test_expect_success 'push with publish branch with pushdefault' '
+	mk_test up_repo heads/master &&
+	mk_test down_repo heads/master &&
+	test_config remote.up.url up_repo &&
+	test_config remote.down.url down_repo &&
+	test_config remote.pushdefault up &&
+	test_config branch.master.pushremote down &&
+	test_config branch.master.push for-john &&
+	git push &&
+	check_push_result up_repo $the_first_commit heads/master &&
+	check_push_result down_repo $the_commit heads/for-john
+'
+
+test_expect_success 'push with publish branch with remote refspec' '
+	mk_test up_repo heads/master &&
+	mk_test down_repo heads/master &&
+	test_config remote.up.url up_repo &&
+	test_config remote.down.url down_repo &&
+	test_config remote.down.push refs/heads/master:refs/heads/bad &&
+	test_config branch.master.pushremote down &&
+	test_config branch.master.push for-john &&
+	git push &&
+	check_push_result up_repo $the_first_commit heads/master &&
+	check_push_result down_repo $the_commit heads/for-john
+'
+
+test_expect_success 'push with publish branch with manual refspec' '
+	mk_test up_repo heads/master &&
+	mk_test down_repo heads/master &&
+	test_config remote.up.url up_repo &&
+	test_config remote.down.url down_repo &&
+	test_config branch.master.pushremote down &&
+	test_config branch.master.push for-john &&
+	git push down master:good &&
+	check_push_result up_repo $the_first_commit heads/master &&
+	check_push_result down_repo $the_commit heads/good
+'
+
 test_done
-- 
1.9.1+fc1
