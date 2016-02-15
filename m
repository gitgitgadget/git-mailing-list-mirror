From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 0/4] git remote improvements
Date: Mon, 15 Feb 2016 23:39:40 +0100
Message-ID: <1455575984-24348-1-git-send-email-t.gummerer@gmail.com>
Cc: peff@peff.net, Johannes.Schindelin@gmx.de, gitster@pobox.com
To: git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 23:40:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVRoI-0002hv-5U
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 23:40:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752939AbcBOWj1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 17:39:27 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36732 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752463AbcBOWj0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 17:39:26 -0500
Received: by mail-wm0-f67.google.com with SMTP id a4so12779260wme.3
        for <git@vger.kernel.org>; Mon, 15 Feb 2016 14:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=GTDi0nd57RhVA+tNm5jo2BENkHwBZMlSn6WGadayYEE=;
        b=U/TMaganG13Ky3Xatfi1HoMef070SX1OrrxgpevxJ1Yr/dQVtH6gbHcWHTO8cOQnrf
         lPXuRMchDqRt4mCE48AgSsBV11GjDAf7GdCIhRa+6+yERU4Gk82F+zdNE1gLX4fPhAqb
         zWupJ68B9w9SvAI8VQhlnMsCBXEtjAcXhILUnzrwomIEsyVZX2cHyMFst0Rl764HRxeU
         LeYHaXCJNPFhUbU90VuYiGymKjvX0tq3GqDPFu/FeSgZLkpwfaa5Ldo5sl3TY81BDOBr
         hpc8SnRyG+LxEfmuoDtlxi25Y0zyB34b7f9h98NYoASssGVZR1/ZQ2zSYbXH3Vdpw3tA
         jgUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GTDi0nd57RhVA+tNm5jo2BENkHwBZMlSn6WGadayYEE=;
        b=Z0gAX1L2oDvtaRPV6lSEMlzO4iYO3MWTknSN+/lUWF/K2ge6Hpf+c/hPaYRsZOqI4k
         dpleT33lDwW1e8BGk//4XrVuGCN4ghbq4b37RMKImPFy70um5hRfcp+pgAK/1+OjNSXX
         lhrAd7KEJdC3E9ZKU1GltcqMFUiANUdZi/U4ioFz9aCScuWu1t31zuxU/TzCU6G1YV+1
         uGcvNQgicHIGkUj/n7A2YG32hvhb4ss2iwivCdNFohwCoQJ0IpSbQTbaUcTzQAz5eJ08
         7BZENFaGSO1cyl6YN4hb01+v7u1dtiMUN0uwzQuSEAgUrCykNUF0MCkzDjPNJbMCQhQr
         oAxw==
X-Gm-Message-State: AG10YOQUolce8zNjyotyp4uZZOzbDwxk7MKRQrgqqBXxADjjjgdqQjj1qEfm5BUAkL2DkQ==
X-Received: by 10.28.30.132 with SMTP id e126mr16163757wme.42.1455575965108;
        Mon, 15 Feb 2016 14:39:25 -0800 (PST)
Received: from localhost (host186-106-dynamic.41-79-r.retail.telecomitalia.it. [79.41.106.186])
        by smtp.gmail.com with ESMTPSA id g1sm23636895wmc.0.2016.02.15.14.39.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Feb 2016 14:39:23 -0800 (PST)
X-Mailer: git-send-email 2.7.1.410.g6faf27b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286278>

Thanks Peff for the review on the previous round ($gmane/286214).

The series now uses parse_config_key() instead of skip_prefix, and I
added REMOTE_UNCONFIGURED to the enum used in the origin field in
struct remote.

Interdiff below:

diff --git a/remote.c b/remote.c
index 3a4ca9b..d10ae00 100644
--- a/remote.c
+++ b/remote.c
@@ -318,90 +318,88 @@ static void read_branches_file(struct remote *remote)
 static int handle_config(const char *key, const char *value, void *cb)
 {
 	const char *name;
+	int namelen;
 	const char *subkey;
 	struct remote *remote;
 	struct branch *branch;
-	if (skip_prefix(key, "branch.", &name)) {
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
-	if (skip_prefix(key, "url.", &name)) {
+	if (parse_config_key(key, "url", &name, &namelen, &subkey) >= 0) {
 		struct rewrite *rewrite;
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
 
-	if (!skip_prefix(key, "remote.", &name))
+	if (parse_config_key(key, "remote", &name, &namelen, &subkey) < 0)
 		return 0;
 
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
@@ -409,7 +407,7 @@ static int handle_config(const char *key, const char *value, void *cb)
 			remote->receivepack = v;
 		else
 			error("more than one receivepack given, using the first");
-	} else if (!strcmp(subkey, ".uploadpack")) {
+	} else if (!strcmp(subkey, "uploadpack")) {
 		const char *v;
 		if (git_config_string(&v, key, value))
 			return -1;
@@ -417,18 +415,18 @@ static int handle_config(const char *key, const char *value, void *cb)
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
diff --git a/remote.h b/remote.h
index 7a5ee77..c21fd37 100644
--- a/remote.h
+++ b/remote.h
@@ -5,7 +5,8 @@
 #include "hashmap.h"
 
 enum {
-	REMOTE_CONFIG = 1,
+	REMOTE_UNCONFIGURED = 0,
+	REMOTE_CONFIG,
 	REMOTE_REMOTES,
 	REMOTE_BRANCHES
 };

Thomas Gummerer (4):
  remote: use parse_config_key
  remote: simplify remote_is_configured()
  remote: actually check if remote exits
  remote: use remote_is_configured() for add and rename

 builtin/fetch.c   |  5 ++--
 builtin/remote.c  | 23 +++++++--------
 remote.c          | 84 +++++++++++++++++++++++--------------------------------
 remote.h          |  3 +-
 t/t5505-remote.sh | 36 ++++++++++++++++++++++++
 5 files changed, 85 insertions(+), 66 deletions(-)

-- 
2.7.1.410.g6faf27b
