From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 2/4] remote: simplify remote_is_configured()
Date: Mon, 15 Feb 2016 23:39:42 +0100
Message-ID: <1455575984-24348-3-git-send-email-t.gummerer@gmail.com>
References: <1455575984-24348-1-git-send-email-t.gummerer@gmail.com>
Cc: peff@peff.net, Johannes.Schindelin@gmx.de, gitster@pobox.com
To: git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 23:40:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVRoP-0002m2-GE
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 23:40:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753117AbcBOWkD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 17:40:03 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34439 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752948AbcBOWja (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 17:39:30 -0500
Received: by mail-wm0-f68.google.com with SMTP id b205so10534791wmb.1
        for <git@vger.kernel.org>; Mon, 15 Feb 2016 14:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0UGckEFeNFYaB0Oo+BfhPEqHUylgeFdEykjN9WTkrdo=;
        b=rezCsiiZBcBJarm0S9HDbs+0Zw6BoYeRjVpGnDFl6yQZqiSc320yJbY0c2U6+1lU46
         r2ChLhTnxiaq8RJe2Uc5GaHhaVx95WQ9D7MeXdLyXowZtpga4BrYWDk/UjMq712H1ZHD
         Usg8jGbdXtg3pan7vCGJ3kkzaGNAp26ajUyHUT5B9zGJ7C1rgWzUvc6zI87uoYPU/QZv
         ZYnQQIvU18vnzotQexU71ZItJxUUJh/xZs8aC+qWx8HRJ7tSZ1J+UxRLMjqTae4xiwjs
         P2CkirZz2GSp4heuoQPO2MQaTRc+EMaLylMD8jpaTuT6gMBZlAYCZwnUl/cvL20p/1Of
         kkHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0UGckEFeNFYaB0Oo+BfhPEqHUylgeFdEykjN9WTkrdo=;
        b=juGQNzOp8sfv2rruO97PFi8pjDo4hxImPFA9nkChevwQRK506NCbMqBYiTK5KXcgGe
         p8j2u7DgaDkFji3Hb9T6Wpw0TVybyfOTQdf2tCX1irPTsFsx3Q8eDey+rCbThwbwQKvT
         a7GNUwhkuMbU8NS4iVErPgWWA1Shr4Hv99/XMwrg3bhtDa7KgImpKxpTzZ9rjE2hoJvL
         IpgC+q1bVc/2lrkX99DxTp5tHjfg7RQ6zDuZZGl9JNJ/9PFrgi62trsgMSod02fAucrf
         9zeFzPPXjZ4XWYqs92MsKS9ncjMK5IV9KcLDCGa4ALXpyaIptjd7oU9GcZGzfgQTX9qK
         l/VQ==
X-Gm-Message-State: AG10YOSmbnGVhgdBAEHVPKnsjGn85jVN98sPKHnAey7dPa+cgxuCzsuSBLd4LOHFJ4zBSg==
X-Received: by 10.194.77.193 with SMTP id u1mr18397228wjw.73.1455575969735;
        Mon, 15 Feb 2016 14:39:29 -0800 (PST)
Received: from localhost (host186-106-dynamic.41-79-r.retail.telecomitalia.it. [79.41.106.186])
        by smtp.gmail.com with ESMTPSA id pd1sm801736wjb.19.2016.02.15.14.39.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Feb 2016 14:39:28 -0800 (PST)
X-Mailer: git-send-email 2.7.1.410.g6faf27b
In-Reply-To: <1455575984-24348-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286279>

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
index bcd8eb6..d10ae00 100644
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
