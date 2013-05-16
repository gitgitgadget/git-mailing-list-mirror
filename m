From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/3] fetch: add --allow-local option
Date: Thu, 16 May 2013 02:31:12 -0500
Message-ID: <1368689474-28911-2-git-send-email-felipe.contreras@gmail.com>
References: <1368689474-28911-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 16 09:32:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcsgJ-0007nw-AP
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 09:32:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755926Ab3EPHcr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 03:32:47 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:64181 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755735Ab3EPHcq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 03:32:46 -0400
Received: by mail-ob0-f175.google.com with SMTP id wo10so1603840obc.20
        for <git@vger.kernel.org>; Thu, 16 May 2013 00:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=mSdQRuoH+QhdqBBBXsA9ydSEDMKtbSvU7XVX4eS9Z7s=;
        b=CG2vyuahaS0DJ9XIi42L6nHbLmxdgrQ+tbVuXcxsUro16tAP8Zql2ns0jsAMzX3svC
         1O/XmBG8u4udyZfeLFkMxNsqeWsbXkVU0mBgnl7567uH/lFFmwspycCGGY+v3on6E9sq
         i/8o/jcPGOFOZQp1oVexIjpeZq4y5VMJ0xC1P45zm5UPjyLv3RVpPznlBs98EHu9ehEu
         ZkY6Mjwa0OprsWrmgYE1poa6vyHIi1vxj4evuDt873/ZZ12Z+yoou5J/d+ozCVAA2X3A
         SVZwaE4LzpXKiEpVyqkC90M0mF8KWCRjJqA6Z69lDEPE43CguuSYRIeRmx/lDDWeT9Mv
         byng==
X-Received: by 10.60.34.135 with SMTP id z7mr21509471oei.68.1368689566399;
        Thu, 16 May 2013 00:32:46 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id eq4sm6816616obb.5.2013.05.16.00.32.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 16 May 2013 00:32:45 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368689474-28911-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224486>

So that it becomes possible to override the behavior when the remote
tracked is '.'; if it is, we default back to 'origin'.

To do this, we need to add a new helper fetchremote_get() that accepts
the boolean to enable/disable this behavior.

The default is 'true' which shouldn't cause any change in behavior.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/fetch.c |  6 +++++-
 remote.c        | 17 ++++++++++++++---
 remote.h        |  1 +
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 4b6b1df..2efbd7b 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -39,6 +39,7 @@ static struct strbuf default_rla = STRBUF_INIT;
 static struct transport *transport;
 static const char *submodule_prefix = "";
 static const char *recurse_submodules_default;
+static int allow_local = 1;
 
 static int option_parse_recurse_submodules(const struct option *opt,
 				   const char *arg, int unset)
@@ -90,6 +91,9 @@ static struct option builtin_fetch_options[] = {
 	{ OPTION_STRING, 0, "recurse-submodules-default",
 		   &recurse_submodules_default, NULL,
 		   N_("default mode for recursion"), PARSE_OPT_HIDDEN },
+	{ OPTION_SET_INT, 0, "allow-local", &allow_local, NULL,
+		   N_("allow fetching from local repository"),
+		   PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, 1 },
 	OPT_END()
 };
 
@@ -1006,7 +1010,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		result = fetch_multiple(&list);
 	} else if (argc == 0) {
 		/* No arguments -- use default remote */
-		remote = remote_get(NULL);
+		remote = fetchremote_get(NULL, allow_local);
 		result = fetch_one(remote, argc, argv);
 	} else if (multiple) {
 		/* All arguments are assumed to be remotes or groups */
diff --git a/remote.c b/remote.c
index 68eb99b..a7e59ab 100644
--- a/remote.c
+++ b/remote.c
@@ -682,7 +682,7 @@ static int valid_remote_nick(const char *name)
 	return !strchr(name, '/'); /* no slash */
 }
 
-static struct remote *remote_get_1(const char *name, const char *pushremote_name)
+static struct remote *remote_get_1(const char *name, const char *pushremote_name, int allow_local)
 {
 	struct remote *ret;
 	int name_given = 0;
@@ -699,6 +699,11 @@ static struct remote *remote_get_1(const char *name, const char *pushremote_name
 		}
 	}
 
+	if (!allow_local && !strcmp(name, ".")) {
+		name = "origin";
+		name_given = 0;
+	}
+
 	ret = make_remote(name, 0);
 	if (valid_remote_nick(name)) {
 		if (!valid_remote(ret))
@@ -718,13 +723,19 @@ static struct remote *remote_get_1(const char *name, const char *pushremote_name
 struct remote *remote_get(const char *name)
 {
 	read_config();
-	return remote_get_1(name, NULL);
+	return remote_get_1(name, NULL, 1);
 }
 
 struct remote *pushremote_get(const char *name)
 {
 	read_config();
-	return remote_get_1(name, pushremote_name);
+	return remote_get_1(name, pushremote_name, 1);
+}
+
+struct remote *fetchremote_get(const char *name, int allow_local)
+{
+	read_config();
+	return remote_get_1(name, NULL, allow_local);
 }
 
 int remote_is_configured(const char *name)
diff --git a/remote.h b/remote.h
index cf56724..f0d6cf3 100644
--- a/remote.h
+++ b/remote.h
@@ -52,6 +52,7 @@ struct remote {
 
 struct remote *remote_get(const char *name);
 struct remote *pushremote_get(const char *name);
+struct remote *fetchremote_get(const char *name, int allow_local);
 int remote_is_configured(const char *name);
 
 typedef int each_remote_fn(struct remote *remote, void *priv);
-- 
1.8.3.rc1.579.g184e698
