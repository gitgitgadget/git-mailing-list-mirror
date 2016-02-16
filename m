From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 1/4] remote: use parse_config_key
Date: Tue, 16 Feb 2016 10:47:49 +0100
Message-ID: <1455616072-20838-2-git-send-email-t.gummerer@gmail.com>
References: <1455575984-24348-1-git-send-email-t.gummerer@gmail.com>
 <1455616072-20838-1-git-send-email-t.gummerer@gmail.com>
Cc: sunshine@sunshineco.com, peff@peff.net, Johannes.Schindelin@gmx.de,
	gitster@pobox.com
To: git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 10:47:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVcEZ-0005m3-2E
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 10:47:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754648AbcBPJri (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 04:47:38 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37834 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754464AbcBPJre (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 04:47:34 -0500
Received: by mail-wm0-f43.google.com with SMTP id g62so143861055wme.0
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 01:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IpcSz1dtc0qAnOgQJQAoOaGW5wryF/KuK2NEaSEfrm8=;
        b=WJlCF4fLTILevNyf/t/xWBw1Aw7O0Kulxe3d1T/zIr/YTBSpLRXPwmHHrrmdOw+m/D
         5bVrPWkLqZUxWDbxJAKa3hnKhWwHUB3DZ8fx1o8EhHGvM7AZ6ote7Sjapi6fbG0PeC7o
         lLLqTy0GEO2sOR/6asnijkMEhs7wy7K4rwjQYZby0IJpSRZsRvYgFFYTbKzXPrBDCt0L
         3RLlqYSeYkVOIo8aTBHJipaAfbKu6XJiMuBJrSijhUI/VPkKcQgvFwpDL6WOuWNOhJOk
         Ex205ukPdQLjJjzTeJA8Q/NRI/7lG9zrgHNrDy7gINbBDVCnpcCLqJgI3fAauS6aFxg9
         TQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IpcSz1dtc0qAnOgQJQAoOaGW5wryF/KuK2NEaSEfrm8=;
        b=kUWEdLXuhEIP+1u7xZSiitmzzqZaKDINMqQDivomxtzVOFEGGXigA+MzOGnoThfknA
         cw3o0PT2bXJIJp5o0PovHOpwW/qmbboyTWqiiSlBvDOjKdGQa8OKwlVI6fhlTO30e0W9
         YFsg4OfhAqfnd+yLhR6vhPjLifD7lqWZhyZ95NdFRaL1Ben0axE0FhWlwsxw1HQAD0ZL
         vJHXA+su4pDoXyyxHzbJc6EcOqdpaUArTZfjLt155GJsqlqPiUSvxzOL5I5RWOxIiOCH
         oijVfU6MqD1gku/ppnXDS0GmxffqizfbY8MQbiZVoE4Q8Td74L762qctIkTxifMwxFjh
         JV9w==
X-Gm-Message-State: AG10YOQqupTrZUh9EIZ++OouTSWqhObQpu1Lyat3Z6KEv1nw7gvWut11FECNvKXtL0E7AA==
X-Received: by 10.194.71.46 with SMTP id r14mr23884077wju.100.1455616052608;
        Tue, 16 Feb 2016 01:47:32 -0800 (PST)
Received: from localhost (host161-107-dynamic.2-87-r.retail.telecomitalia.it. [87.2.107.161])
        by smtp.gmail.com with ESMTPSA id ko2sm29334240wjc.9.2016.02.16.01.47.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2016 01:47:31 -0800 (PST)
X-Mailer: git-send-email 2.7.1.410.g6faf27b
In-Reply-To: <1455616072-20838-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286332>

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
 remote.c | 69 ++++++++++++++++++++++++++++++----------------------------------
 1 file changed, 32 insertions(+), 37 deletions(-)

diff --git a/remote.c b/remote.c
index 02e698a..c7d67c2 100644
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
+	if (!name && !strcmp(subkey, "pushdefault"))
 		return git_config_string(&pushremote_name, key, value);
 
+	if (!name)
+		return 0;
 	/* Handle remote.<name>.* variables */
 	if (*name == '/') {
 		warning("Config remote shorthand cannot begin with '/': %s",
 			name);
 		return 0;
 	}
-	subkey = strrchr(name, '.');
-	if (!subkey)
-		return 0;
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
