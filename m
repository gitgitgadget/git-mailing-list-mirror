From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 4/6] remote.c: introduce a way to have different remotes for fetch/push
Date: Thu, 28 Mar 2013 18:56:40 +0530
Message-ID: <1364477202-5742-5-git-send-email-artagnon@gmail.com>
References: <1364477202-5742-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 28 14:26:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULCqO-0003hF-24
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 14:26:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756118Ab3C1NZo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 09:25:44 -0400
Received: from mail-pb0-f54.google.com ([209.85.160.54]:39354 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756093Ab3C1NZj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 09:25:39 -0400
Received: by mail-pb0-f54.google.com with SMTP id rq13so1764396pbb.41
        for <git@vger.kernel.org>; Thu, 28 Mar 2013 06:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=H0sSPeju8e1fopDS4rJwpGbEIbhWkMnHPhJq1RUSX0M=;
        b=aoaZ+gXw1HhC4W/FNS0YnCcWRCZqPeWkyTzz1fgknA+mz/AeeAmA1C6E6yQ1EEpki7
         Tsu+mcG/r8s+4lSoxQNr3cXQt1irWEt5/fed1w1qhDUOGiYWx69LGM3GWym8wBvoVkgt
         5AchBMDZ4PhSw819ddJg9VqkNeaUbxtvihVTtyinqGscFmumriDYUjA3K2y4M6YbFtuT
         +VwIRVwCaylEuByt9r9Dmuo4wf9x2OkqqMOPtdaKMHuSvYbzsz5ZXDpuq0B+gu8WLvua
         /l2AaesJkJ81/LPRzuYQf+RG26icBRaA1GmEtbzsiYFzYUa1CTeYAuT+CNf2jjy8lRkn
         YK3g==
X-Received: by 10.66.231.103 with SMTP id tf7mr35653132pac.97.1364477138573;
        Thu, 28 Mar 2013 06:25:38 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id tm1sm25586603pbc.11.2013.03.28.06.25.36
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 28 Mar 2013 06:25:37 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.141.g3797f84
In-Reply-To: <1364477202-5742-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219392>

Currently, do_push() in push.c calls remote_get(), which gets the
configured remote for fetching and pushing.  Replace this call with a
call to pushremote_get() instead, a new function that will return the
remote configured specifically for pushing.  This function tries to
work with the string pushremote_name, before falling back to the
codepath of remote_get().  This patch has no visible impact, but
serves to enable future patches to introduce configuration variables
to set pushremote_name.  For example, you can now do the following in
handle_config():

    if (!strcmp(key, "remote.pushdefault"))
       git_config_string(&pushremote_name, key, value);

Then, pushes will automatically go to the remote specified by
remote.pushdefault.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/push.c |  2 +-
 remote.c       | 25 +++++++++++++++++++++----
 remote.h       |  1 +
 3 files changed, 23 insertions(+), 5 deletions(-)

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
index 02e6c4c..b733aec 100644
--- a/remote.c
+++ b/remote.c
@@ -49,6 +49,7 @@ static int branches_nr;
 
 static struct branch *current_branch;
 static const char *default_remote_name;
+static const char *pushremote_name;
 static int explicit_default_remote_name;
 
 static struct rewrites rewrites;
@@ -670,17 +671,21 @@ static int valid_remote_nick(const char *name)
 	return !strchr(name, '/'); /* no slash */
 }
 
-struct remote *remote_get(const char *name)
+static struct remote *remote_get_1(const char *name, const char *pushremote_name)
 {
 	struct remote *ret;
 	int name_given = 0;
 
-	read_config();
 	if (name)
 		name_given = 1;
 	else {
-		name = default_remote_name;
-		name_given = explicit_default_remote_name;
+		if (pushremote_name) {
+			name = pushremote_name;
+			name_given = 1;
+		} else {
+			name = default_remote_name;
+			name_given = explicit_default_remote_name;
+		}
 	}
 
 	ret = make_remote(name, 0);
@@ -699,6 +704,18 @@ struct remote *remote_get(const char *name)
 	return ret;
 }
 
+struct remote *remote_get(const char *name)
+{
+	read_config();
+	return remote_get_1(name, NULL);
+}
+
+struct remote *pushremote_get(const char *name)
+{
+	read_config();
+	return remote_get_1(name, pushremote_name);
+}
+
 int remote_is_configured(const char *name)
 {
 	int i;
diff --git a/remote.h b/remote.h
index f7b08f1..5fe5f53 100644
--- a/remote.h
+++ b/remote.h
@@ -51,6 +51,7 @@ struct remote {
 };
 
 struct remote *remote_get(const char *name);
+struct remote *pushremote_get(const char *name);
 int remote_is_configured(const char *name);
 
 typedef int each_remote_fn(struct remote *remote, void *priv);
-- 
1.8.2.141.g3797f84
