From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH 3/3] push: add separate 'downstream' branch
Date: Wed, 15 May 2013 22:43:48 -0500
Message-ID: <1368675828-27418-4-git-send-email-felipe.contreras@gmail.com>
References: <1368675828-27418-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 16 05:45:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ucp8I-0007PV-SW
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 05:45:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753628Ab3EPDpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 23:45:32 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:40906 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754700Ab3EPDp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 23:45:28 -0400
Received: by mail-oa0-f53.google.com with SMTP id g12so3150981oah.26
        for <git@vger.kernel.org>; Wed, 15 May 2013 20:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=Gq706xnSoWhoaC9Q9UlZnfRf6dBGOPCbqTd5BEMVUZQ=;
        b=ZYQLy7zHFK0auaD0qnKW/Npe+y+j6ZuHk3dKSCOTG/VFQndXxRci3LnIWS+4AeiszY
         hjg506ZcyfaG0wu/e60xGS9kJbwJfRPpZxkDlFN5i/C+kwFPDdpwheCC1wnIwdjZPXvw
         RyeReD/LiFf7o65YtLo4jvT+9/CgP7C4P8kdeZIIE4m81Mw5XtVtEw/kR8yYrVbHemiZ
         /QXU/k+7x7utzjLAiUYc+83nLmqh3T5zcB9P6sVql3NjMkGe8pbmTEyH+JadZGlogAtS
         DHcAqTM7w0285fup4cUqpImmK7wEQXAbFhjbCqq5l55lLRpRTPSX88gT2FqwEQIdBxuD
         t4XA==
X-Received: by 10.182.80.5 with SMTP id n5mr16575239obx.88.1368675927945;
        Wed, 15 May 2013 20:45:27 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id ri8sm6440318oeb.0.2013.05.15.20.45.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 15 May 2013 20:45:27 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368675828-27418-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224474>

It doesn't make sense to push to the upstream branch, so create new
configurations for the notion of 'downstream' branch, which is basically
the branch to push to by default.

The upstream branch is remote+merge, the downstream branch is
pushremote+push.

  [branch "master"]
	  remote = origin
	  merge = refs/heads/master
	  pushremote = github
	  push = refs/heads/master

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/push.c | 65 ++++++++++++++++++++++++++++++++++++----------------------
 remote.c       |  8 ++++++--
 remote.h       |  3 +++
 3 files changed, 50 insertions(+), 26 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 909c34d..c062fa5 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -76,21 +76,23 @@ static int push_url_of_remote(struct remote *remote, const char ***url_p)
 	return remote->url_nr;
 }
 
-static NORETURN int die_push_simple(struct branch *branch, struct remote *remote) {
+static NORETURN int die_push_simple(struct branch *branch, struct remote *remote,
+		const char *kind, const char *related)
+{
 	/*
 	 * There's no point in using shorten_unambiguous_ref here,
 	 * as the ambiguity would be on the remote side, not what
 	 * we have locally. Plus, this is supposed to be the simple
 	 * mode. If the user is doing something crazy like setting
-	 * upstream to a non-branch, we should probably be showing
+	 * upstream/downstream to a non-branch, we should probably be showing
 	 * them the big ugly fully qualified ref.
 	 */
 	const char *advice_maybe = "";
-	const char *short_upstream =
-		skip_prefix(branch->merge[0]->src, "refs/heads/");
+	const char *short_upstream = skip_prefix(related, "refs/heads/");
 
 	if (!short_upstream)
-		short_upstream = branch->merge[0]->src;
+		short_upstream = related;
+
 	/*
 	 * Don't show advice for people who explicitely set
 	 * push.default.
@@ -99,8 +101,8 @@ static NORETURN int die_push_simple(struct branch *branch, struct remote *remote
 		advice_maybe = _("\n"
 				 "To choose either option permanently, "
 				 "see push.default in 'git help config'.");
-	die(_("The upstream branch of your current branch does not match\n"
-	      "the name of your current branch.  To push to the upstream branch\n"
+	die(_("The %s branch of your current branch does not match\n"
+	      "the name of your current branch.  To push to the %s branch\n"
 	      "on the remote, use\n"
 	      "\n"
 	      "    git push %s HEAD:%s\n"
@@ -109,6 +111,7 @@ static NORETURN int die_push_simple(struct branch *branch, struct remote *remote
 	      "\n"
 	      "    git push %s %s\n"
 	      "%s"),
+	    kind, kind,
 	    remote->name, short_upstream,
 	    remote->name, branch->name, advice_maybe);
 }
@@ -117,6 +120,8 @@ static void setup_push_upstream(struct remote *remote, int simple)
 {
 	struct strbuf refspec = STRBUF_INIT;
 	struct branch *branch = branch_get(NULL);
+	const char *related, *kind, *pushremote_name;
+
 	if (!branch)
 		die(_("You are not currently on a branch.\n"
 		    "To push the history leading to the current (detached HEAD)\n"
@@ -124,26 +129,38 @@ static void setup_push_upstream(struct remote *remote, int simple)
 		    "\n"
 		    "    git push %s HEAD:<name-of-remote-branch>\n"),
 		    remote->name);
-	if (!branch->merge_nr || !branch->merge || !branch->remote_name)
-		die(_("The current branch %s has no upstream branch.\n"
-		    "To push the current branch and set the remote as upstream, use\n"
-		    "\n"
-		    "    git push --set-upstream %s %s\n"),
-		    branch->name,
-		    remote->name,
-		    branch->name);
-	if (branch->merge_nr != 1)
-		die(_("The current branch %s has multiple upstream branches, "
-		    "refusing to push."), branch->name);
-	if (strcmp(branch->remote_name, remote->name))
-		die(_("You are pushing to remote '%s', which is not the upstream of\n"
+
+	if (branch->push) {
+		kind = _("downstream");
+		related = branch->push;
+		pushremote_name = branch->pushremote_name;
+	} else {
+		if (!branch->merge_nr || !branch->merge || !branch->remote_name)
+			die(_("The current branch %s has no upstream branch.\n"
+			    "To push the current branch and set the remote as upstream, use\n"
+			    "\n"
+			    "    git push --set-upstream %s %s\n"),
+			    branch->name,
+			    remote->name,
+			    branch->name);
+		if (branch->merge_nr != 1)
+			die(_("The current branch %s has multiple upstream branches, "
+			    "refusing to push."), branch->name);
+
+		kind = _("upstream");
+		related = branch->merge[0]->src;
+		pushremote_name = branch->remote_name;
+	}
+
+	if (strcmp(pushremote_name, remote->name))
+		die(_("You are pushing to remote '%s', which is not the %s of\n"
 		      "your current branch '%s', without telling me what to push\n"
 		      "to update which remote branch."),
-		    remote->name, branch->name);
-	if (simple && strcmp(branch->refname, branch->merge[0]->src))
-		die_push_simple(branch, remote);
+		    remote->name, kind, branch->name);
+	if (simple && strcmp(branch->refname, related))
+		die_push_simple(branch, remote, kind, related);
 
-	strbuf_addf(&refspec, "%s:%s", branch->name, branch->merge[0]->src);
+	strbuf_addf(&refspec, "%s:%s", branch->name, related);
 	add_refspec(refspec.buf);
 }
 
diff --git a/remote.c b/remote.c
index 322a1b6..f057b5f 100644
--- a/remote.c
+++ b/remote.c
@@ -365,13 +365,17 @@ static int handle_config(const char *key, const char *value, void *cb)
 				explicit_default_remote_name = 1;
 			}
 		} else if (!strcmp(subkey, ".pushremote")) {
+			if (git_config_string(&branch->pushremote_name, key, value))
+				return -1;
 			if (branch == current_branch)
-				if (git_config_string(&pushremote_name, key, value))
-					return -1;
+				pushremote_name = xstrdup(branch->pushremote_name);
 		} else if (!strcmp(subkey, ".merge")) {
 			if (!value)
 				return config_error_nonbool(key);
 			add_merge(branch, xstrdup(value));
+		} else if (!strcmp(subkey, ".push")) {
+			if (git_config_string(&branch->push, key, value))
+				return -1;
 		}
 		return 0;
 	}
diff --git a/remote.h b/remote.h
index cf56724..24433af 100644
--- a/remote.h
+++ b/remote.h
@@ -138,6 +138,9 @@ struct branch {
 	struct refspec **merge;
 	int merge_nr;
 	int merge_alloc;
+
+	const char *pushremote_name;
+	const char *push;
 };
 
 struct branch *branch_get(const char *name);
-- 
1.8.3.rc1.579.g184e698
