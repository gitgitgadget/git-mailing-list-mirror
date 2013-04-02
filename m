From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 4/6] remote.c: introduce a way to have different remotes for fetch/push
Date: Tue,  2 Apr 2013 13:10:32 +0530
Message-ID: <1364888434-30388-5-git-send-email-artagnon@gmail.com>
References: <1364888434-30388-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 02 09:40:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMvp8-0007OZ-2J
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 09:40:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101Ab3DBHja (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 03:39:30 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:49667 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932098Ab3DBHj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 03:39:29 -0400
Received: by mail-pd0-f175.google.com with SMTP id t10so93770pdi.6
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 00:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=z/N0uoGhaMBTQK7cOBBXvIG2JCdssq+iLq93JuXuyeM=;
        b=Y86fIvxgMozPPwLvwQJf1IoPA+npoD5PP/jgF3yQJ7D0PO/kO0wq4oIhY2q/pnHNLF
         wIkBzc8fC7Pzq10AxoA1klzgp4NlTZ0ivH8lwFaRkEj+V5EolD34+DljirJ4iEuq4piv
         XQOM9Y+r39xdp08eufj0rKL5p0WSSv/kdbvOjRttwMbS2joVpTwNCXYUNuVrjweTb0nV
         zcxuDfqC1uGMnWViwIkdYUtO8QlIukWV7XKHPx4uMkc/c52tDd+mXYx3qO26OdeGQ+LE
         Qr1fu2nq+k4RKZdXSD6ieWNWHfRp+A6uYVZVtvCvIfKYVCn7FNyIfcLp9k31l6jM8IP8
         DLWQ==
X-Received: by 10.66.228.194 with SMTP id sk2mr23755338pac.51.1364888368671;
        Tue, 02 Apr 2013 00:39:28 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id oq3sm1259341pac.16.2013.04.02.00.39.26
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 02 Apr 2013 00:39:27 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.363.g901f5bc
In-Reply-To: <1364888434-30388-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219749>

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
index 5e4a0e9..909c34d 100644
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
index 34ddc5b..2b06e22 100644
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
index 8743d6e..cf56724 100644
--- a/remote.h
+++ b/remote.h
@@ -51,6 +51,7 @@ struct remote {
 };
 
 struct remote *remote_get(const char *name);
+struct remote *pushremote_get(const char *name);
 int remote_is_configured(const char *name);
 
 typedef int each_remote_fn(struct remote *remote, void *priv);
-- 
1.8.2.363.g901f5bc
