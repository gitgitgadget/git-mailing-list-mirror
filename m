From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/4] remote.c: introduce a way to have different remotes for fetch/ push
Date: Mon, 18 Mar 2013 18:46:13 +0530
Message-ID: <1363612575-7340-3-git-send-email-artagnon@gmail.com>
References: <1363612575-7340-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 18 14:20:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHZzY-0007jj-3U
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 14:20:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751888Ab3CRNUO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 09:20:14 -0400
Received: from mail-da0-f50.google.com ([209.85.210.50]:55331 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156Ab3CRNUN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 09:20:13 -0400
Received: by mail-da0-f50.google.com with SMTP id t1so1339927dae.37
        for <git@vger.kernel.org>; Mon, 18 Mar 2013 06:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=ZpkJcVxclg5c7wrmG2h3HNzRabVtvrGOg5afZeEHCyg=;
        b=UJyoJ9Yz0sqmKG7YBj1Fr8bTVuOPFE5FAbo7zp89pwRnf95bEmmlfH27zDC6E4xuwk
         NXWiZg6iAFLP/L4RzmOI5+wUh/WSGOY3M1RB7Jn63K6u7hIp9mRtTz0DHjLsj/3frHju
         zv1dPa3aT5jGSfiOS+3hVS2jA7heG/+ecsWR4XiknkGuHpP0ylILIPtLUGWg/y+hKQ2M
         wQc5yCozvndT8Pb5DK8Rf0LP9sUHdzfHH1Ej5k1x6IzDSqtsDrXURkIXcgBALR4ezZtd
         hSI+F0BfWOQ3bZtkbQKlT38B0dqiWn47KfzoV/1aNfC7eDEp8cFkNypxs99pNjvXQw4m
         GuhQ==
X-Received: by 10.68.129.101 with SMTP id nv5mr32705283pbb.204.1363612511669;
        Mon, 18 Mar 2013 06:15:11 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id y1sm20178280pbg.10.2013.03.18.06.15.09
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 Mar 2013 06:15:10 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1363612575-7340-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218414>

Currently, do_push() in push.c calls remote_get(), which gets the
configured remote for fetching and pushing.  Replace this call with a
call to pushremote_get() instead, a new function that will return the
remote configured specifically for pushing.  This function tries to
work with the string pushremote_name, before falling back to the
codepath of remote_get().  This patch has no visible impact, but
serves to enable future patches to introduce configuration variables
to set this variable.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/push.c |  2 +-
 remote.c       | 49 ++++++++++++++++++++++++++++++++++++-------------
 remote.h       |  1 +
 3 files changed, 38 insertions(+), 14 deletions(-)

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
index 45b69d6..4704404 100644
--- a/remote.c
+++ b/remote.c
@@ -48,6 +48,7 @@ static int branches_nr;
 
 static struct branch *current_branch;
 static const char *default_remote_name;
+static const char *pushremote_name;
 static int explicit_default_remote_name;
 
 static struct rewrites rewrites;
@@ -669,20 +670,9 @@ static int valid_remote_nick(const char *name)
 	return !strchr(name, '/'); /* no slash */
 }
 
-struct remote *remote_get(const char *name)
+static struct remote *remote_get_1(const char *name, int name_given)
 {
-	struct remote *ret;
-	int name_given = 0;
-
-	read_config();
-	if (name)
-		name_given = 1;
-	else {
-		name = default_remote_name;
-		name_given = explicit_default_remote_name;
-	}
-
-	ret = make_remote(name, 0);
+	struct remote *ret = make_remote(name, 0);
 	if (valid_remote_nick(name)) {
 		if (!valid_remote(ret))
 			read_remotes_file(ret);
@@ -698,6 +688,39 @@ struct remote *remote_get(const char *name)
 	return ret;
 }
 
+struct remote *remote_get(const char *name)
+{
+	int name_given = 0;
+
+	read_config();
+	if (name)
+		name_given = 1;
+	else {
+		name = default_remote_name;
+		name_given = explicit_default_remote_name;
+	}
+	return remote_get_1(name, name_given);
+}
+
+struct remote *pushremote_get(const char *name)
+{
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
+	return remote_get_1(name, name_given);
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
1.8.2
