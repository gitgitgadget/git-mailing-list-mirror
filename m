From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [RFC/PATCH] Introduce remote.pushdefault
Date: Fri,  8 Feb 2013 14:32:03 +0530
Message-ID: <1360314123-1259-1-git-send-email-artagnon@gmail.com>
References: <7v1ucr43mk.fsf@alter.siamese.dyndns.org>
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 10:02:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3jqO-0002ZA-Dr
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 10:02:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946141Ab3BHJBk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 04:01:40 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:61929 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946116Ab3BHJBk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 04:01:40 -0500
Received: by mail-pa0-f42.google.com with SMTP id kq12so1968441pab.15
        for <git@vger.kernel.org>; Fri, 08 Feb 2013 01:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=fNITPtGW/uJ3aNNOsqpAcKqcbtc0KYEDT3vVjEToTv4=;
        b=rMQSyoEFC+RhkiqF3P4LOJ9u41dZ5hLv0N1P/bnnoDgacw7s+qMEcuNPvLe4pBwbcd
         9M9TPLyN6rSSGPaVKP9JyINCXad8g5/2uT1OjKVzbACalsA2J7F1uvlNKKHGzxwFCxuL
         V8M8aKaYU/sqeDkqOa4OC+eWaArExSecAJkdtoK5F7Ef6e3093mJBb9xjiJetAEktRXz
         7ZFfRzuTenszda3O7XT/KwBqSIH6ETSRzmIY/OdXs6gkjiPKb0QGrgZQYSEQAlDmngnf
         SXczqdZlNDDHgoL66ZPhz91zQaMBCDhwyMJQPmcynNkY+TmA/UOaoMyXungVL39iLDE8
         6e0g==
X-Received: by 10.66.192.162 with SMTP id hh2mr533151pac.79.1360314099305;
        Fri, 08 Feb 2013 01:01:39 -0800 (PST)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id d1sm16327458paz.17.2013.02.08.01.01.34
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 08 Feb 2013 01:01:37 -0800 (PST)
X-Mailer: git-send-email 1.8.1.3.535.ga923c31.dirty
In-Reply-To: <7v1ucr43mk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215768>

This new configuration variable overrides branch-specific
configuration `branch.<name>.remote` for pushes.  It is useful in the
typical scenario, where the remote I'm pulling from is not the remote
I'm pushing to.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Junio C Hamano wrote:
 > As the first cut, I would have expected the series to start from
 > more general (not "only this branch"), with later follow-up to let
 > more specific configuration.

 Doesn't that follow trivially from my previous patch?  I'm looking
 for comments on how best to share code between pushremote_get()/
 remote_get(), and on other remote_get() callsites.

 > Also I'd prefer to see the "push" semantics (e.g. "what does
 > upstream mean in this new world order?") designed better first.

 Why should the meaning of upstream change?  We'd probably like to
 introduce something like a branch@{downstream} pointing to the push
 remote ref sometime in the future though.  Wait, should it always be
 called downstream?

 Documentation/config.txt |  4 ++++
 builtin/push.c           |  2 +-
 remote.c                 | 45 +++++++++++++++++++++++++++++++++++++++++++--
 remote.h                 |  1 +
 4 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 9b11597..82a4a78 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1884,6 +1884,10 @@ receive.updateserverinfo::
 	If set to true, git-receive-pack will run git-update-server-info
 	after receiving data from git-push and updating refs.
 
+remote.pushdefault::
+	The remote to push to by default.  Overrides the
+	branch-specific configuration `branch.<name>.remote`.
+
 remote.<name>.url::
 	The URL of a remote repository.  See linkgit:git-fetch[1] or
 	linkgit:git-push[1].
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
index e53a6eb..08bb803 100644
--- a/remote.c
+++ b/remote.c
@@ -48,6 +48,7 @@ static int branches_nr;
 
 static struct branch *current_branch;
 static const char *default_remote_name;
+static const char *pushremote_name;
 static int explicit_default_remote_name;
 
 static struct rewrites rewrites;
@@ -349,6 +350,14 @@ static int handle_config(const char *key, const char *value, void *cb)
 	const char *subkey;
 	struct remote *remote;
 	struct branch *branch;
+	if (!prefixcmp(key,  "remote.")) {
+		name = key + 7;
+		if (!strcmp(name, "pushdefault")) {
+			if (!value)
+				return config_error_nonbool(key);
+			pushremote_name = xstrdup(value);
+		}
+	}
 	if (!prefixcmp(key, "branch.")) {
 		name = key + 7;
 		subkey = strrchr(name, '.');
@@ -388,8 +397,6 @@ static int handle_config(const char *key, const char *value, void *cb)
 			add_instead_of(rewrite, xstrdup(value));
 		}
 	}
-	if (prefixcmp(key,  "remote."))
-		return 0;
 	name = key + 7;
 	if (*name == '/') {
 		warning("Config remote shorthand cannot begin with '/': %s",
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
index 251d8fd..99a437f 100644
--- a/remote.h
+++ b/remote.h
@@ -51,6 +51,7 @@ struct remote {
 };
 
 struct remote *remote_get(const char *name);
+struct remote *pushremote_get(const char *name);
 int remote_is_configured(const char *name);
 
 typedef int each_remote_fn(struct remote *remote, void *priv);
-- 
1.8.1.3.535.ga923c31.dirty
