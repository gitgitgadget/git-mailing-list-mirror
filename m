From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 2/4] remote: simplify remote_is_configured()
Date: Tue, 16 Feb 2016 10:47:50 +0100
Message-ID: <1455616072-20838-3-git-send-email-t.gummerer@gmail.com>
References: <1455575984-24348-1-git-send-email-t.gummerer@gmail.com>
 <1455616072-20838-1-git-send-email-t.gummerer@gmail.com>
Cc: sunshine@sunshineco.com, peff@peff.net, Johannes.Schindelin@gmx.de,
	gitster@pobox.com
To: git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 10:47:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVcEZ-0005m3-UE
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 10:47:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754666AbcBPJrk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 04:47:40 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38633 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754415AbcBPJrg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 04:47:36 -0500
Received: by mail-wm0-f41.google.com with SMTP id a4so90954744wme.1
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 01:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2W7tOyOuXL38iOPsxJsvUAy/yzRqbsN1cj9zMVcanzo=;
        b=iHwNrIKoyFqQx+qHjL8EvOBPs3ldoW9Li8AQxIgi5ZyrO165TL3HIZabnWuKg4ACve
         ABOndb8K8vG3SjD4RzvDcZfDegpgIrpNa77Sc3QoMcmat4ZQ6Pqpol1bz3Gbw/8HfgTJ
         f1b2n7EswNs5/bxOQe7o1IWIf1VgkM3QW7DXxYWKSRJ26872rwvW7p4esV/5ZZTqu4yQ
         tV2XBXLiGyqhBkTySgPo+hh712ihzjUyqPoM0WyN+Np6RrB6r1x0BsfrT5HVa8HBNy5Z
         lOxJGUBTpOnc0cV8sQa87LJWHsSKs4SuTCtHtIh47FDNsSyFuaOG+5q83gc3wqVfYomg
         bOEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2W7tOyOuXL38iOPsxJsvUAy/yzRqbsN1cj9zMVcanzo=;
        b=XH1XmofWO8I4bQo2kH9yjn+damdXfwtW9/9RACiaKJo0c6xjmAyQHbNxm6J8yzFOi5
         3mOUwklf6iaP1QEF4XhQJLjH1CjbM8HZsjrryG4JH5OoXMFQfMOdzEnDBj+/Fgvl75WS
         rRoqGUzAydNclmQjqw4vv6BzsaRTsCbPRRSpxWeizNijXrg0xxjXY2nQGc9m9Kk1rqgk
         deCRJabJjka9OaaKXGHWJMO9Jh7uAIZsWJAY2g5BA2KfbE1QJVkhaaulnHQyWeg76NUH
         6FAA3z8WZp6Gbc6RYeTsieeumhyAWQFrFOwwgLq9+Y0Z/I1lXIyCYIrtvBhRn9rxCIZJ
         l46g==
X-Gm-Message-State: AG10YOTyirKHwYQkz77n3EZe9+yqA+jJTqff+jVQoAGOoBEqQDCZskRZqSTbAMkAa8CGzA==
X-Received: by 10.194.61.135 with SMTP id p7mr24653379wjr.64.1455616054944;
        Tue, 16 Feb 2016 01:47:34 -0800 (PST)
Received: from localhost (host161-107-dynamic.2-87-r.retail.telecomitalia.it. [87.2.107.161])
        by smtp.gmail.com with ESMTPSA id gb9sm29335088wjb.26.2016.02.16.01.47.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2016 01:47:33 -0800 (PST)
X-Mailer: git-send-email 2.7.1.410.g6faf27b
In-Reply-To: <1455616072-20838-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286333>

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
 remote.h         |  3 ++-
 4 files changed, 12 insertions(+), 21 deletions(-)

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
index c7d67c2..f001681 100644
--- a/remote.c
+++ b/remote.c
@@ -713,18 +713,9 @@ struct remote *pushremote_get(const char *name)
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
index 4fd7a0f..c21fd37 100644
--- a/remote.h
+++ b/remote.h
@@ -5,6 +5,7 @@
 #include "hashmap.h"
 
 enum {
+	REMOTE_UNCONFIGURED = 0,
 	REMOTE_CONFIG,
 	REMOTE_REMOTES,
 	REMOTE_BRANCHES
@@ -59,7 +60,7 @@ struct remote {
 
 struct remote *remote_get(const char *name);
 struct remote *pushremote_get(const char *name);
-int remote_is_configured(const char *name);
+int remote_is_configured(struct remote *remote);
 
 typedef int each_remote_fn(struct remote *remote, void *priv);
 int for_each_remote(each_remote_fn fn, void *priv);
-- 
2.7.1.410.g6faf27b
