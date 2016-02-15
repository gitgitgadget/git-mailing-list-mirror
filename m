From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 2/4] remote: simplify remote_is_configured()
Date: Mon, 15 Feb 2016 18:42:28 +0100
Message-ID: <1455558150-30267-3-git-send-email-t.gummerer@gmail.com>
References: <1455558150-30267-1-git-send-email-t.gummerer@gmail.com>
Cc: Johannes.Schindelin@gmx.de, gitster@pobox.com,
	Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 15 18:43:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVNBl-0001ZW-Hq
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 18:43:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753135AbcBORnq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 12:43:46 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36555 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752638AbcBORnn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 12:43:43 -0500
Received: by mail-wm0-f67.google.com with SMTP id a4so11689897wme.3
        for <git@vger.kernel.org>; Mon, 15 Feb 2016 09:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f90rDDBuliO94M2ApMVLpBwiW6Z5ke4psCxQdepL1xs=;
        b=azKPDxklgC50eBGzfNG1jY0JZegD62Uq611EpP5FlsnND6/VlbhpjTkQyPfU+6OENQ
         IdA2zdh7C6C8+xzkDyKEIreKkJh8gebjM4rUyMyKOeSXoes4x3xkYC3PoYGrRSe1rFF1
         zmAAhAgD4K2tbyzCrF8GiQkk1zWlNVz67ag4PixdGxIyQ2xK2vkZfxc35u7ZapNpRjjN
         ibjV6AAmuTssnY85wfypyOq8UTYLP0o6uwzmXcV8bdDmrXau/1cWgkuGe0RVa92KhRQg
         SsWNswLnWfb+MzagJwWJYwIpaY7sfbM92hGRBuPmJwD8Osnjt0neUxJiub8XmvPsCwXr
         Sf8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f90rDDBuliO94M2ApMVLpBwiW6Z5ke4psCxQdepL1xs=;
        b=ChgyI0cFBM4ZbPCL6J25XyuB0U5/kstk1qVHvg8EDL3U6+pghovvnm41fZ9az7oKIN
         hjdU1X//lmYcufXU4FYX75sAK/W8R7qbcsU9dNHDQLnnx1YWbKBMvK75ql1HGAIXaZ0E
         VVG1FRI/dZrN8Dm6Glh/sVeBcl/zYe0gBxsjSmOzur1BKr/nu/bFX9NtwIXmgSR5lIBk
         ZY6i18NradCYDnw7ECXpV8bDdIgeuhslMS8AVjMrk9FX9smWcXrGqKAs5cYLlbOzDWFt
         Vk0vEbOcFK4Nc3HjmyAf6XD5y5ADSYQkOUSVzziwnm5CW4WaFvXqaGPZXIlEoiIlN2DC
         afRA==
X-Gm-Message-State: AG10YOSJJ46efdkBElfCWmQTk1q4gI5ZLWfCSPfZHig+qqQAwezNe/ZTI8D2ae9G7tvoEg==
X-Received: by 10.194.94.229 with SMTP id df5mr20643768wjb.133.1455558222651;
        Mon, 15 Feb 2016 09:43:42 -0800 (PST)
Received: from localhost (host186-106-dynamic.41-79-r.retail.telecomitalia.it. [79.41.106.186])
        by smtp.gmail.com with ESMTPSA id g1sm22662975wmc.0.2016.02.15.09.43.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Feb 2016 09:43:41 -0800 (PST)
X-Mailer: git-send-email 2.7.1.410.g6faf27b
In-Reply-To: <1455558150-30267-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286216>

The remote_is_configured() function allows checking whether a remote
exists or not.  The function however only works if remote_get() wasn't
called before calling it.  In addition, it only checks the configuration
for remotes, but not remotes or branches files.

Make use of the origin member of struct remote instead, which indicates
where the remote comes from.  It will be set to some value if the remote
is configured in any file in the repository, but is initialized to 0 if
the remote is only created in make_remote().

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/fetch.c  |  5 ++---
 builtin/remote.c | 12 ++++++------
 remote.c         | 13 ++-----------
 remote.h         |  4 ++--
 4 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 8e74213..8121830 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1016,10 +1016,9 @@ static int add_remote_or_group(const char *name, struct string_list *list)
 
 	git_config(get_remote_group, &g);
 	if (list->nr == prev_nr) {
-		struct remote *remote;
-		if (!remote_is_configured(name))
+		struct remote *remote = remote_get(name);
+		if (!remote_is_configured(remote))
 			return 0;
-		remote = remote_get(name);
 		string_list_append(list, remote->name);
 	}
 	return 1;
diff --git a/builtin/remote.c b/builtin/remote.c
index 2b2ff9b..d966262 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1441,9 +1441,9 @@ static int set_remote_branches(const char *remotename, const char **branches,
 
 	strbuf_addf(&key, "remote.%s.fetch", remotename);
 
-	if (!remote_is_configured(remotename))
-		die(_("No such remote '%s'"), remotename);
 	remote = remote_get(remotename);
+	if (!remote_is_configured(remote))
+		die(_("No such remote '%s'"), remotename);
 
 	if (!add_mode && remove_all_fetch_refspecs(remotename, key.buf)) {
 		strbuf_release(&key);
@@ -1498,9 +1498,9 @@ static int get_url(int argc, const char **argv)
 
 	remotename = argv[0];
 
-	if (!remote_is_configured(remotename))
-		die(_("No such remote '%s'"), remotename);
 	remote = remote_get(remotename);
+	if (!remote_is_configured(remote))
+		die(_("No such remote '%s'"), remotename);
 
 	url_nr = 0;
 	if (push_mode) {
@@ -1566,9 +1566,9 @@ static int set_url(int argc, const char **argv)
 	if (delete_mode)
 		oldurl = newurl;
 
-	if (!remote_is_configured(remotename))
-		die(_("No such remote '%s'"), remotename);
 	remote = remote_get(remotename);
+	if (!remote_is_configured(remote))
+		die(_("No such remote '%s'"), remotename);
 
 	if (push_mode) {
 		strbuf_addf(&name_buf, "remote.%s.pushurl", remotename);
diff --git a/remote.c b/remote.c
index 4b5b576..3a4ca9b 100644
--- a/remote.c
+++ b/remote.c
@@ -715,18 +715,9 @@ struct remote *pushremote_get(const char *name)
 	return remote_get_1(name, pushremote_for_branch);
 }
 
-int remote_is_configured(const char *name)
+int remote_is_configured(struct remote *remote)
 {
-	struct remotes_hash_key lookup;
-	struct hashmap_entry lookup_entry;
-	read_config();
-
-	init_remotes_hash();
-	lookup.str = name;
-	lookup.len = strlen(name);
-	hashmap_entry_init(&lookup_entry, memhash(name, lookup.len));
-
-	return hashmap_get(&remotes_hash, &lookup_entry, &lookup) != NULL;
+	return remote && remote->origin;
 }
 
 int for_each_remote(each_remote_fn fn, void *priv)
diff --git a/remote.h b/remote.h
index 4fd7a0f..7a5ee77 100644
--- a/remote.h
+++ b/remote.h
@@ -5,7 +5,7 @@
 #include "hashmap.h"
 
 enum {
-	REMOTE_CONFIG,
+	REMOTE_CONFIG = 1,
 	REMOTE_REMOTES,
 	REMOTE_BRANCHES
 };
@@ -59,7 +59,7 @@ struct remote {
 
 struct remote *remote_get(const char *name);
 struct remote *pushremote_get(const char *name);
-int remote_is_configured(const char *name);
+int remote_is_configured(struct remote *remote);
 
 typedef int each_remote_fn(struct remote *remote, void *priv);
 int for_each_remote(each_remote_fn fn, void *priv);
-- 
2.7.1.410.g6faf27b
