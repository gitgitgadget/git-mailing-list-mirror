From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [RFC/PATCH] Introduce branch.<name>.pushremote
Date: Fri,  8 Feb 2013 12:49:42 +0530
Message-ID: <1360307982-20027-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 08 08:20:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3iGK-0005nD-LG
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 08:20:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751620Ab3BHHUW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 02:20:22 -0500
Received: from mail-da0-f45.google.com ([209.85.210.45]:55764 "EHLO
	mail-da0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752503Ab3BHHUU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 02:20:20 -0500
Received: by mail-da0-f45.google.com with SMTP id w4so1641691dam.32
        for <git@vger.kernel.org>; Thu, 07 Feb 2013 23:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=Xm+lQADnkrFfqGScNonXZ3OdY1NnM+s2dQHmClqXKNI=;
        b=fQVu7g72Ug+fxUDBX2XVF9PvvH9iK46LFagFe8YtBfd94G/Omg44R4uH/7jQ+EP6kW
         heqjOcaj0XGd+rHKWf0syTYpQA95yO5Z9ZBfUJDfW+59UNd2t7pi13OapHjJmpc9L8IK
         ls7BnrReDwbUS1BvayZMmZ3Q9Gtbo7EUkauvwQHmpMNQPEpT6duc9Y8oR+ZmjOxh2i+8
         8w2UjI+xEpkDWVOEZum0CBE2imUqKURX0AAJ70mN7b3nFUAf407F6iJarD/KKFeifUMH
         RcRVt4ahy9rMq5+ev/M7MbTb5oCZWcAzUDd6AFCaV/5jbaOJRu8zFcFZs93rB+aRxCjM
         Tbuw==
X-Received: by 10.66.83.196 with SMTP id s4mr14238443pay.74.1360308019584;
        Thu, 07 Feb 2013 23:20:19 -0800 (PST)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id a4sm52146662paw.21.2013.02.07.23.20.14
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 07 Feb 2013 23:20:18 -0800 (PST)
X-Mailer: git-send-email 1.8.1.2.545.g2f19ada.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215763>

This new configuration variable overrides the remote in
`branch.<name>.remote` for pushes.  It is useful in the typical
scenario, where the remote I'm pulling from is not the remote I'm
pushing to.  Although `remote.<name>.pushurl` is similar, it does not
serve the purpose as the URL would lack corresponding remote tracking
branches.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 This is a first cut.  There's code duplication at the moment, but I'm
 currently trying to figure out which other remote_get() calls to
 replace with pushremote_get().  Comments are welcome.

 I will leave it to future patches to do the following things:
 1. Fix the status output to be more meaningful when pushremote is
 set.  At the moment, I'm thinking statuses like [pull: 4 behind,
 push: 3 ahead] will make sense.
 2. Introduce a remote.pushDefault (peff)
 3. Introduce a remote.default (peff)

 Documentation/config.txt |  6 ++++++
 builtin/push.c           |  2 +-
 remote.c                 | 41 +++++++++++++++++++++++++++++++++++++++++
 remote.h                 |  2 ++
 4 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 9b11597..0b3b1f8 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -727,6 +727,12 @@ branch.<name>.remote::
 	remote to fetch from/push to.  It defaults to `origin` if no remote is
 	configured. `origin` is also used if you are not on any branch.
 
+branch.<name>.pushremote::
+	When in branch <name>, it tells 'git push' which remote to
+	push to.  It falls back to `branch.<name>.remote`, and
+	defaults to `origin` if no remote is configured. `origin` is
+	also used if you are not on any branch.
+
 branch.<name>.merge::
 	Defines, together with branch.<name>.remote, the upstream branch
 	for the given branch. It tells 'git fetch'/'git pull'/'git rebase' which
diff --git a/builtin/push.c b/builtin/push.c
index 42b129d..d447a80 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -322,7 +322,7 @@ static int push_with_options(struct transport *transport, int flags)
 static int do_push(const char *repo, int flags)
 {
 	int i, errs;
-	struct remote *remote = remote_get(repo);
+	struct remote *remote = pushremote_get(repo);
 	const char **url;
 	int url_nr;
 
diff --git a/remote.c b/remote.c
index e53a6eb..d6fcfc0 100644
--- a/remote.c
+++ b/remote.c
@@ -48,6 +48,7 @@ static int branches_nr;
 
 static struct branch *current_branch;
 static const char *default_remote_name;
+static const char *pushremote_name;
 static int explicit_default_remote_name;
 
 static struct rewrites rewrites;
@@ -363,6 +364,12 @@ static int handle_config(const char *key, const char *value, void *cb)
 				default_remote_name = branch->remote_name;
 				explicit_default_remote_name = 1;
 			}
+		} else if (!strcmp(subkey, ".pushremote")) {
+			if (!value)
+				return config_error_nonbool(key);
+			branch->pushremote_name = xstrdup(value);
+			if (branch == current_branch)
+				pushremote_name = branch->pushremote_name;
 		} else if (!strcmp(subkey, ".merge")) {
 			if (!value)
 				return config_error_nonbool(key);
@@ -700,6 +707,40 @@ struct remote *remote_get(const char *name)
 	return ret;
 }
 
+struct remote *pushremote_get(const char *name)
+{
+	struct remote *ret;
+	int name_given = 0;
+
+	read_config();
+	if (name)
+		name_given = 1;
+	else {
+		if (pushremote_name) {
+			name = pushremote_name;
+			name_given = 1;
+		} else {
+			name = default_remote_name;
+			name_given = explicit_default_remote_name;
+		}
+	}
+
+	ret = make_remote(name, 0);
+	if (valid_remote_nick(name)) {
+		if (!valid_remote(ret))
+			read_remotes_file(ret);
+		if (!valid_remote(ret))
+			read_branches_file(ret);
+	}
+	if (name_given && !valid_remote(ret))
+		add_url_alias(ret, name);
+	if (!valid_remote(ret))
+		return NULL;
+	ret->fetch = parse_fetch_refspec(ret->fetch_refspec_nr, ret->fetch_refspec);
+	ret->push = parse_push_refspec(ret->push_refspec_nr, ret->push_refspec);
+	return ret;
+}
+
 int remote_is_configured(const char *name)
 {
 	int i;
diff --git a/remote.h b/remote.h
index 251d8fd..aa42ff5 100644
--- a/remote.h
+++ b/remote.h
@@ -51,6 +51,7 @@ struct remote {
 };
 
 struct remote *remote_get(const char *name);
+struct remote *pushremote_get(const char *name);
 int remote_is_configured(const char *name);
 
 typedef int each_remote_fn(struct remote *remote, void *priv);
@@ -130,6 +131,7 @@ struct branch {
 	const char *refname;
 
 	const char *remote_name;
+	const char *pushremote_name;
 	struct remote *remote;
 
 	const char **merge_name;
-- 
1.8.1.2.545.g2f19ada.dirty
