From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 1/4] remote: use parse_config_key
Date: Mon, 15 Feb 2016 23:39:41 +0100
Message-ID: <1455575984-24348-2-git-send-email-t.gummerer@gmail.com>
References: <1455575984-24348-1-git-send-email-t.gummerer@gmail.com>
Cc: peff@peff.net, Johannes.Schindelin@gmx.de, gitster@pobox.com
To: git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 23:40:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVRp6-0003Fp-99
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 23:40:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753107AbcBOWkB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 17:40:01 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34931 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752463AbcBOWj2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 17:39:28 -0500
Received: by mail-wm0-f66.google.com with SMTP id g62so17932880wme.2
        for <git@vger.kernel.org>; Mon, 15 Feb 2016 14:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QsvCXGnqBkAF/ee3dyHBkhOJV5wjKoO9wirAGYabUhc=;
        b=y5tzmh6PnYxkfK02adAKeJMykV9WAVFY+b4NqigPVeUxKmbsYk4+5KJ2uA66jh5wDO
         CfRHNJNM8Jj0vCSV6r+C/nCPKf90QkZGs+rM+/eikMU+3ur/BEQplfzuQlfDT9A71Nlu
         Dtg6ysqFFs/2E8Tg1yaNbgT0U8smobDbhh5/5AoKF/wGgY0ZWnYpw7nftifRA45ZgHG8
         l9Fzi/xbfMWO/iqGBijBafmfOXcYElzu9Q94RLgMFv5W/vD2Fb3fZnHSkUrO4UajfqqD
         plD4t9ChqYLHgBo9+KzVlrocCF26Vn8NFVKs3jV03QpcAUa3q8TZUW1XHMLKBbTPBHS3
         yT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QsvCXGnqBkAF/ee3dyHBkhOJV5wjKoO9wirAGYabUhc=;
        b=NQAA8xG9VS3L92qm1NPP5IDLsTnj5m9ZwMRikOrS0ovTxRWmeK8LuvH5JVCYmonxsM
         PTht45G0lV08syMkil771fuMNtGagp0aRKE6p9mU9t7sQ1sIyVxaWOc5FOCPjsfjrLa/
         pxb/FJYKaoHSu6qGrOJL797hGKqR1IZDjV0bbWf8VnxrUkDq/Pgink3L0mWlBZQTq00Y
         fHNTq+KmnhvuHOcc6ftP7D0rzd5piaJ4JkTK46fG8p0VCfI0zjkx4jmm2aGkSk67/QAK
         i8I8y67SA4W6LzgL32mUNfeDrosfjS/TCywptFCjQBzFFydLpF6qGOly2euynLDU8quC
         jV5A==
X-Gm-Message-State: AG10YOR0yE2llnnT8+SsekE3L+a8FXpcd16zTM2A18u2kmynAtCHNI9lnoS+8yzTHvqFVA==
X-Received: by 10.28.141.141 with SMTP id p135mr15462369wmd.30.1455575967462;
        Mon, 15 Feb 2016 14:39:27 -0800 (PST)
Received: from localhost (host186-106-dynamic.41-79-r.retail.telecomitalia.it. [79.41.106.186])
        by smtp.gmail.com with ESMTPSA id t3sm27370289wjz.11.2016.02.15.14.39.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Feb 2016 14:39:26 -0800 (PST)
X-Mailer: git-send-email 2.7.1.410.g6faf27b
In-Reply-To: <1455575984-24348-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286283>

95b567c7 ("use skip_prefix to avoid repeating strings") transformed
calls using starts_with() and then skipping the length of the prefix to
skip_prefix() calls.  In remote.c there are a few calls like:

  if (starts_with(foo, "bar"))
      foo += 3

These calls weren't touched by the aformentioned commit, but can be
replaced by calls to parse_config_key(), to simplify the code and
clarify the intentions.  Do that.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 remote.c | 71 ++++++++++++++++++++++++++++++----------------------------------
 1 file changed, 33 insertions(+), 38 deletions(-)

diff --git a/remote.c b/remote.c
index 02e698a..bcd8eb6 100644
--- a/remote.c
+++ b/remote.c
@@ -318,93 +318,88 @@ static void read_branches_file(struct remote *remote)
 static int handle_config(const char *key, const char *value, void *cb)
 {
 	const char *name;
+	int namelen;
 	const char *subkey;
 	struct remote *remote;
 	struct branch *branch;
-	if (starts_with(key, "branch.")) {
-		name = key + 7;
-		subkey = strrchr(name, '.');
-		if (!subkey)
+	if (parse_config_key(key, "branch", &name, &namelen, &subkey) >= 0) {
+		if (!name)
 			return 0;
-		branch = make_branch(name, subkey - name);
-		if (!strcmp(subkey, ".remote")) {
+		branch = make_branch(name, namelen);
+		if (!strcmp(subkey, "remote")) {
 			return git_config_string(&branch->remote_name, key, value);
-		} else if (!strcmp(subkey, ".pushremote")) {
+		} else if (!strcmp(subkey, "pushremote")) {
 			return git_config_string(&branch->pushremote_name, key, value);
-		} else if (!strcmp(subkey, ".merge")) {
+		} else if (!strcmp(subkey, "merge")) {
 			if (!value)
 				return config_error_nonbool(key);
 			add_merge(branch, xstrdup(value));
 		}
 		return 0;
 	}
-	if (starts_with(key, "url.")) {
+	if (parse_config_key(key, "url", &name, &namelen, &subkey) >= 0) {
 		struct rewrite *rewrite;
-		name = key + 4;
-		subkey = strrchr(name, '.');
-		if (!subkey)
+		if (!name)
 			return 0;
-		if (!strcmp(subkey, ".insteadof")) {
-			rewrite = make_rewrite(&rewrites, name, subkey - name);
+		if (!strcmp(subkey, "insteadof")) {
+			rewrite = make_rewrite(&rewrites, name, namelen);
 			if (!value)
 				return config_error_nonbool(key);
 			add_instead_of(rewrite, xstrdup(value));
-		} else if (!strcmp(subkey, ".pushinsteadof")) {
-			rewrite = make_rewrite(&rewrites_push, name, subkey - name);
+		} else if (!strcmp(subkey, "pushinsteadof")) {
+			rewrite = make_rewrite(&rewrites_push, name, namelen);
 			if (!value)
 				return config_error_nonbool(key);
 			add_instead_of(rewrite, xstrdup(value));
 		}
 	}
 
-	if (!starts_with(key,  "remote."))
+	if (parse_config_key(key, "remote", &name, &namelen, &subkey) < 0)
 		return 0;
-	name = key + 7;
 
 	/* Handle remote.* variables */
-	if (!strcmp(name, "pushdefault"))
+	if (!strcmp(subkey, "pushdefault"))
 		return git_config_string(&pushremote_name, key, value);
 
 	/* Handle remote.<name>.* variables */
-	if (*name == '/') {
+	if (*(name ? name : subkey) == '/') {
 		warning("Config remote shorthand cannot begin with '/': %s",
-			name);
+			name ? name : subkey);
 		return 0;
 	}
-	subkey = strrchr(name, '.');
-	if (!subkey)
+	if (!name)
 		return 0;
-	remote = make_remote(name, subkey - name);
+	remote = make_remote(name, namelen);
 	remote->origin = REMOTE_CONFIG;
-	if (!strcmp(subkey, ".mirror"))
+	if (!strcmp(subkey, "mirror"))
 		remote->mirror = git_config_bool(key, value);
-	else if (!strcmp(subkey, ".skipdefaultupdate"))
+	else if (!strcmp(subkey, "skipdefaultupdate"))
 		remote->skip_default_update = git_config_bool(key, value);
-	else if (!strcmp(subkey, ".skipfetchall"))
+	else if (!strcmp(subkey, "skipfetchall"))
 		remote->skip_default_update = git_config_bool(key, value);
-	else if (!strcmp(subkey, ".prune"))
+	else if (!strcmp(subkey, "prune"))
 		remote->prune = git_config_bool(key, value);
-	else if (!strcmp(subkey, ".url")) {
+	else if (!strcmp(subkey, "url")) {
 		const char *v;
 		if (git_config_string(&v, key, value))
 			return -1;
 		add_url(remote, v);
-	} else if (!strcmp(subkey, ".pushurl")) {
+	} else if (!strcmp(subkey, "pushurl")) {
 		const char *v;
 		if (git_config_string(&v, key, value))
 			return -1;
 		add_pushurl(remote, v);
-	} else if (!strcmp(subkey, ".push")) {
+	} else if (!strcmp(subkey, "push")) {
 		const char *v;
 		if (git_config_string(&v, key, value))
 			return -1;
 		add_push_refspec(remote, v);
-	} else if (!strcmp(subkey, ".fetch")) {
+	} else if (!strcmp(subkey, "fetch")) {
 		const char *v;
 		if (git_config_string(&v, key, value))
 			return -1;
 		add_fetch_refspec(remote, v);
-	} else if (!strcmp(subkey, ".receivepack")) {
+	} else if (!strcmp(subkey, "receivepack")) {
 		const char *v;
 		if (git_config_string(&v, key, value))
 			return -1;
@@ -412,7 +407,7 @@ static int handle_config(const char *key, const char *value, void *cb)
 			remote->receivepack = v;
 		else
 			error("more than one receivepack given, using the first");
-	} else if (!strcmp(subkey, ".uploadpack")) {
+	} else if (!strcmp(subkey, "uploadpack")) {
 		const char *v;
 		if (git_config_string(&v, key, value))
 			return -1;
@@ -420,18 +415,18 @@ static int handle_config(const char *key, const char *value, void *cb)
 			remote->uploadpack = v;
 		else
 			error("more than one uploadpack given, using the first");
-	} else if (!strcmp(subkey, ".tagopt")) {
+	} else if (!strcmp(subkey, "tagopt")) {
 		if (!strcmp(value, "--no-tags"))
 			remote->fetch_tags = -1;
 		else if (!strcmp(value, "--tags"))
 			remote->fetch_tags = 2;
-	} else if (!strcmp(subkey, ".proxy")) {
+	} else if (!strcmp(subkey, "proxy")) {
 		return git_config_string((const char **)&remote->http_proxy,
 					 key, value);
-	} else if (!strcmp(subkey, ".proxyauthmethod")) {
+	} else if (!strcmp(subkey, "proxyauthmethod")) {
 		return git_config_string((const char **)&remote->http_proxy_authmethod,
 					 key, value);
-	} else if (!strcmp(subkey, ".vcs")) {
+	} else if (!strcmp(subkey, "vcs")) {
 		return git_config_string(&remote->foreign_vcs, key, value);
 	}
 	return 0;
-- 
2.7.1.410.g6faf27b
