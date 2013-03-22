From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 4/6] remote.c: introduce a way to have different remotes for fetch/push
Date: Fri, 22 Mar 2013 13:22:34 +0530
Message-ID: <1363938756-13722-5-git-send-email-artagnon@gmail.com>
References: <1363938756-13722-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 22 08:52:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIwll-0002QF-2E
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 08:52:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754562Ab3CVHvi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 03:51:38 -0400
Received: from mail-da0-f50.google.com ([209.85.210.50]:42191 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754463Ab3CVHvh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 03:51:37 -0400
Received: by mail-da0-f50.google.com with SMTP id t1so619372dae.37
        for <git@vger.kernel.org>; Fri, 22 Mar 2013 00:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=8ZrmRobMqL/rtIyXyOZgdgKHrTddMDupMkNDxyrSB5M=;
        b=qCYdXy0P8Je2pgOgNKO6fB0PFPSahg+bsU2dMBABEqOjFBDReNmy0gC3qgkgNy0pNV
         ItrtKZ96kU1dSwtSMeNEt2mAqru4DO8wSYWNomtf+YK6V48ZyZzgC9xzzMMwy116sIKH
         TpNxMAyve+LpVYcHSMQzjl80fFWeg3Cqe5EiebK/SWHsFFMTw06dmBBMx6t+sv9KyXmt
         KLYILKVa27DxWHDcYJ77Fv1GMBiYAYlw0x172JCiTXBIpv5xqNaTO1BKmfsK89fZ8ElU
         cNvfLZ43nyflrxNQzDKcnoQ91hXVa+72XuZcM70Lav0irR6KPS8+Vs/4sjWzsIpVJMAD
         VSRA==
X-Received: by 10.66.152.129 with SMTP id uy1mr1895964pab.36.1363938696647;
        Fri, 22 Mar 2013 00:51:36 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id fh1sm2025227pac.1.2013.03.22.00.51.34
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 22 Mar 2013 00:51:35 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.62.ga35d936.dirty
In-Reply-To: <1363938756-13722-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218782>

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
index 5bd59bb..185ac11 100644
--- a/remote.c
+++ b/remote.c
@@ -48,6 +48,7 @@ static int branches_nr;
 
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
1.8.2.62.ga35d936.dirty
