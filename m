From: "Kirill A. Korinskiy" <catap@catap.ru>
Subject: [PATCH] Add config options remotes.prune and remote.<name>.prune
Date: Sat, 13 Jul 2013 19:43:07 +0400
Message-ID: <1373730187-33332-1-git-send-email-catap@catap.ru>
Cc: git@vger.kernel.org, "Kirill A. Korinskiy" <catap@catap.ru>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jul 13 17:43:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uy1yu-0003OA-SS
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jul 2013 17:43:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007Ab3GMPn3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jul 2013 11:43:29 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:63279 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752Ab3GMPn2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jul 2013 11:43:28 -0400
Received: by mail-lb0-f180.google.com with SMTP id o10so8245322lbi.25
        for <git@vger.kernel.org>; Sat, 13 Jul 2013 08:43:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:x-gm-message-state;
        bh=JgriPpu26RucT19btseLfe7+ZtByksurdJlQuNqlqYA=;
        b=AeM9xIq7wrJoD9JFJda74uRHI9RpZYZUn+SlXbgjXwKOII5xtPtpLfdj73T+7zESzW
         9L0TBHgwUiNSYWhtqoD/x4wPppISSLDtptGph2TiHoe5HtNrp/KgYSx2hjXCXVZlIyWn
         j0HR5MXxrpl45ZYvvVfZ/7IeCA06xxuWA/FMsnprJoYYm/H1YAALhpxgrQOUrdFknH2g
         oSFZIlL7/EPRmde4udUh0Yo2wRsWLayuv2Q9dUYw2VVya+pJHyeUCjbnOOhl7AEbjwSE
         wArTKjsOTmz4hmElhOKgGNEsIrAcB9sFSpOoHkGq/aekQW9QUXLJVR8V+/EfjoHwisJH
         FNcA==
X-Received: by 10.112.55.9 with SMTP id n9mr21706905lbp.5.1373730206429;
        Sat, 13 Jul 2013 08:43:26 -0700 (PDT)
Received: from localhost.localdomain ([77.241.39.208])
        by mx.google.com with ESMTPSA id c4sm16166488lae.7.2013.07.13.08.43.25
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 13 Jul 2013 08:43:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.4 (Apple Git-37)
X-Gm-Message-State: ALoCoQmljPs14R6AFL1EHJIpp7x/mhIGTTl4S/9MUGjUaQqXhHjulmy9yN1KnLI9IdcBOaVQoJ4h
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230283>

From: "Kirill A. Korinskiy" <catap@catap.ru>

Basic idea is a make behavior `git remote update --prune'
to `git remote update' as default to specify or all remotes repos.

Signed-off-by: Kirill A. Korinskiy <catap@catap.ru>
---
 builtin/fetch.c   |  4 +++-
 builtin/remote.c  | 13 +++++++++++++
 remote.c          |  2 ++
 remote.h          |  2 ++
 t/t5505-remote.sh | 33 +++++++++++++++++++++++++++++++++
 5 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index d784b2e..cf23218 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -769,7 +769,7 @@ static int do_fetch(struct transport *transport,
 		free_refs(ref_map);
 		retcode = 1;
 		goto cleanup;
-	}
+	}	
 	if (prune) {
 		/* If --tags was specified, pretend the user gave us the canonical tags refspec */
 		if (tags == TAGS_SET) {
@@ -983,7 +983,9 @@ static int fetch_one(struct remote *remote, int argc, const char **argv)
 	sigchain_push_common(unlock_pack_on_signal);
 	atexit(unlock_pack);
 	refspec = parse_fetch_refspec(ref_nr, refs);
+	prune += remote->prune;
 	exit_code = do_fetch(transport, refspec, ref_nr);
+	prune -= remote->prune;
 	free_refspec(ref_nr, refspec);
 	transport_disconnect(transport);
 	transport = NULL;
diff --git a/builtin/remote.c b/builtin/remote.c
index 5e54d36..86e4ed5 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1313,6 +1313,15 @@ static int get_remote_default(const char *key, const char *value, void *priv)
 	return 0;
 }
 
+static int get_remote_prune(const char *key, const char *value, void *priv)
+{
+	if (strcmp(key, "remotes.prune") == 0) {
+		int *found = priv;
+		*found = git_config_bool(key, value);
+	}
+	return 0;
+}
+
 static int update(int argc, const char **argv)
 {
 	int i, prune = 0;
@@ -1332,6 +1341,10 @@ static int update(int argc, const char **argv)
 
 	fetch_argv[fetch_argc++] = "fetch";
 
+	if (!prune) {
+		git_config(get_remote_prune, &prune);
+	}
+
 	if (prune)
 		fetch_argv[fetch_argc++] = "--prune";
 	if (verbose)
diff --git a/remote.c b/remote.c
index 6f57830..e6f2acb 100644
--- a/remote.c
+++ b/remote.c
@@ -404,6 +404,8 @@ static int handle_config(const char *key, const char *value, void *cb)
 		remote->skip_default_update = git_config_bool(key, value);
 	else if (!strcmp(subkey, ".skipfetchall"))
 		remote->skip_default_update = git_config_bool(key, value);
+	else if (!strcmp(subkey, ".prune"))
+		remote->prune = git_config_bool(key, value);
 	else if (!strcmp(subkey, ".url")) {
 		const char *v;
 		if (git_config_string(&v, key, value))
diff --git a/remote.h b/remote.h
index cf56724..8a79bd3 100644
--- a/remote.h
+++ b/remote.h
@@ -41,6 +41,8 @@ struct remote {
 	int skip_default_update;
 	int mirror;
 
+	int prune;
+
 	const char *receivepack;
 	const char *uploadpack;
 
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index ee5d65d..a278ac2 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -614,6 +614,39 @@ test_expect_success 'update --prune' '
 	)
 '
 
+test_expect_success 'prune update by config set remotes.prune' '
+	(
+		cd test &&
+		git remote update &&
+		git rev-parse refs/remotes/origin/side2 &&
+		git rev-parse refs/remotes/origin/side3 &&
+		git config remotes.prune true &&
+		git remote update &&
+		git config --unset remotes.prune &&
+		test_must_fail git rev-parse refs/remotes/origin/side3
+	)
+'
+
+test_expect_success 'prune update by config set remote.origin.prune' '
+	(
+		cd one &&
+		git branch -m side2 side3
+	) &&
+	(
+		cd test &&
+		git config remote.origin.prune true &&
+		git remote update &&
+		(
+			cd ../one &&
+			git branch -m side3 side2
+		) &&
+		git config --unset remote.origin.prune &&
+		git rev-parse refs/remotes/origin/side3 &&
+		test_must_fail git rev-parse refs/remotes/origin/side2
+	)
+'
+
+
 cat >one/expect <<-\EOF
   apis/master
   apis/side
-- 
1.7.12.4 (Apple Git-37)
