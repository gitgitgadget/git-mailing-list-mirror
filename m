Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F26E136A
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 01:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712451641; cv=none; b=JIOUOnN0MHXWhZgMQUH4A7HysGsaWE+HHYFtPZRWQBhfyJjtiyUEa3PUQCPSCpMeHoxN74tE4yCp9UbWQL6NA3N41d0/tN39wWHEWIxaxfNQAKSzjTpKIp1i45M2wriQHn29yCAbtFh77wOb6Q8W70HQa/qLVCmw74clHg8vu2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712451641; c=relaxed/simple;
	bh=/shAywjN5x3VZfZXlm6XVRQRrJ7iaJukjKg8JavxzOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b2dZmOHPKO7TSfDo+OSrcE+scN1D4KlzcVj3BVO3oxeNkJtPGPvo4aCgIo4M9McI4uMyoS3FBg9x3bRig7OTnJCGiPhi046LrZffjoKvnK6oJ7UCxg3zgIwnW1AEUnUNri1cboWGEPzkvY7I4vhd2r1HK3DugQKuDsgdj7R9sxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7297 invoked by uid 109); 7 Apr 2024 01:00:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 07 Apr 2024 01:00:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11230 invoked by uid 111); 7 Apr 2024 01:00:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 06 Apr 2024 21:00:41 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 6 Apr 2024 21:00:37 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Subject: [PATCH 03/11] config: prefer git_config_string_dup() for temp
 variables
Message-ID: <20240407010037.GC868358@coredump.intra.peff.net>
References: <20240407005656.GA436890@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240407005656.GA436890@coredump.intra.peff.net>

In some cases we may use git_config_string() or git_config_pathname() to
read a value into a temporary variable, and then either hand off memory
ownership of the new variable or free it. These are not potential leaks,
since we know that there is no previous value we are overwriting.

However, it's worth converting these to use git_config_string_dup() and
git_config_pathname_dup(). It makes it easier to audit for leaky cases,
and possibly we can get rid of the leak-prone functions in the future.
Plus it lets the const-ness of our variables match their expected memory
ownership, which avoids some casts when calling free().

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/blame.c        |  4 ++--
 builtin/config.c       |  6 +++---
 builtin/receive-pack.c |  6 +++---
 fetch-pack.c           |  6 +++---
 fsck.c                 |  6 +++---
 remote.c               | 28 ++++++++++++++--------------
 setup.c                |  6 +++---
 7 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index db1f56de61..0b07ceb110 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -718,10 +718,10 @@ static int git_blame_config(const char *var, const char *value,
 		return 0;
 	}
 	if (!strcmp(var, "blame.ignorerevsfile")) {
-		const char *str;
+		char *str = NULL;
 		int ret;
 
-		ret = git_config_pathname(&str, var, value);
+		ret = git_config_pathname_dup(&str, var, value);
 		if (ret)
 			return ret;
 		string_list_insert(&ignore_revs_file_list, str);
diff --git a/builtin/config.c b/builtin/config.c
index 0015620dde..fc5d96bb4c 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -282,11 +282,11 @@ static int format_config(struct strbuf *buf, const char *key_,
 			else
 				strbuf_addstr(buf, v ? "true" : "false");
 		} else if (type == TYPE_PATH) {
-			const char *v;
-			if (git_config_pathname(&v, key_, value_) < 0)
+			char *v = NULL;
+			if (git_config_pathname_dup(&v, key_, value_) < 0)
 				return -1;
 			strbuf_addstr(buf, v);
-			free((char *)v);
+			free(v);
 		} else if (type == TYPE_EXPIRY_DATE) {
 			timestamp_t t;
 			if (git_config_expiry_date(&t, key_, value_) < 0)
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 56d8a77ed7..15ed81a3f6 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -168,13 +168,13 @@ static int receive_pack_config(const char *var, const char *value,
 	}
 
 	if (strcmp(var, "receive.fsck.skiplist") == 0) {
-		const char *path;
+		char *path = NULL;
 
-		if (git_config_pathname(&path, var, value))
+		if (git_config_pathname_dup(&path, var, value))
 			return 1;
 		strbuf_addf(&fsck_msg_types, "%cskiplist=%s",
 			fsck_msg_types.len ? ',' : '=', path);
-		free((char *)path);
+		free(path);
 		return 0;
 	}
 
diff --git a/fetch-pack.c b/fetch-pack.c
index 091f9a80a9..fd59c497b4 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1863,13 +1863,13 @@ static int fetch_pack_config_cb(const char *var, const char *value,
 	const char *msg_id;
 
 	if (strcmp(var, "fetch.fsck.skiplist") == 0) {
-		const char *path;
+		char *path = NULL;
 
-		if (git_config_pathname(&path, var, value))
+		if (git_config_pathname_dup(&path, var, value))
 			return 1;
 		strbuf_addf(&fsck_msg_types, "%cskiplist=%s",
 			fsck_msg_types.len ? ',' : '=', path);
-		free((char *)path);
+		free(path);
 		return 0;
 	}
 
diff --git a/fsck.c b/fsck.c
index 78af29d264..a9d27a660f 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1274,13 +1274,13 @@ int git_fsck_config(const char *var, const char *value,
 	const char *msg_id;
 
 	if (strcmp(var, "fsck.skiplist") == 0) {
-		const char *path;
+		char *path = NULL;
 		struct strbuf sb = STRBUF_INIT;
 
-		if (git_config_pathname(&path, var, value))
+		if (git_config_pathname_dup(&path, var, value))
 			return 1;
 		strbuf_addf(&sb, "skiplist=%s", path);
-		free((char *)path);
+		free(path);
 		fsck_set_msg_types(options, sb.buf);
 		strbuf_release(&sb);
 		return 0;
diff --git a/remote.c b/remote.c
index 2b650b813b..09912bebf1 100644
--- a/remote.c
+++ b/remote.c
@@ -428,38 +428,38 @@ static int handle_config(const char *key, const char *value,
 	else if (!strcmp(subkey, "prunetags"))
 		remote->prune_tags = git_config_bool(key, value);
 	else if (!strcmp(subkey, "url")) {
-		const char *v;
-		if (git_config_string(&v, key, value))
+		char *v = NULL;
+		if (git_config_string_dup(&v, key, value))
 			return -1;
 		add_url(remote, v);
 	} else if (!strcmp(subkey, "pushurl")) {
-		const char *v;
-		if (git_config_string(&v, key, value))
+		char *v = NULL;
+		if (git_config_string_dup(&v, key, value))
 			return -1;
 		add_pushurl(remote, v);
 	} else if (!strcmp(subkey, "push")) {
-		const char *v;
-		if (git_config_string(&v, key, value))
+		char *v = NULL;
+		if (git_config_string_dup(&v, key, value))
 			return -1;
 		refspec_append(&remote->push, v);
-		free((char *)v);
+		free(v);
 	} else if (!strcmp(subkey, "fetch")) {
-		const char *v;
-		if (git_config_string(&v, key, value))
+		char *v = NULL;
+		if (git_config_string_dup(&v, key, value))
 			return -1;
 		refspec_append(&remote->fetch, v);
-		free((char *)v);
+		free(v);
 	} else if (!strcmp(subkey, "receivepack")) {
-		const char *v;
-		if (git_config_string(&v, key, value))
+		char *v = NULL;
+		if (git_config_string_dup(&v, key, value))
 			return -1;
 		if (!remote->receivepack)
 			remote->receivepack = v;
 		else
 			error(_("more than one receivepack given, using the first"));
 	} else if (!strcmp(subkey, "uploadpack")) {
-		const char *v;
-		if (git_config_string(&v, key, value))
+		char *v = NULL;
+		if (git_config_string_dup(&v, key, value))
 			return -1;
 		if (!remote->uploadpack)
 			remote->uploadpack = v;
diff --git a/setup.c b/setup.c
index f4b32f76e3..9f35a27978 100644
--- a/setup.c
+++ b/setup.c
@@ -1176,13 +1176,13 @@ static int safe_directory_cb(const char *key, const char *value,
 	} else if (!strcmp(value, "*")) {
 		data->is_safe = 1;
 	} else {
-		const char *interpolated = NULL;
+		char *interpolated = NULL;
 
-		if (!git_config_pathname(&interpolated, key, value) &&
+		if (!git_config_pathname_dup(&interpolated, key, value) &&
 		    !fspathcmp(data->path, interpolated ? interpolated : value))
 			data->is_safe = 1;
 
-		free((char *)interpolated);
+		free(interpolated);
 	}
 
 	return 0;
-- 
2.44.0.872.g288abe5b5b

