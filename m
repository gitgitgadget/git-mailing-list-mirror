From: "Patrick Reynolds" <patrick.reynolds@github.com>
Subject: [PATCH v2] use a hashmap to make remotes faster
Date: Tue, 29 Jul 2014 14:43:39 +0000
Message-ID: <25222.0938886865-sendEmail@debian>
Mime-Version: 1.0
Content-Type: multipart/related; boundary="----MIME delimiter for sendEmail-128858.688128279"
To: "Git" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 29 16:43:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XC8d1-00041P-9x
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 16:43:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753606AbaG2Onn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2014 10:43:43 -0400
Received: from mail-qa0-f52.google.com ([209.85.216.52]:63740 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752719AbaG2Onm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 10:43:42 -0400
Received: by mail-qa0-f52.google.com with SMTP id j15so9349117qaq.25
        for <git@vger.kernel.org>; Tue, 29 Jul 2014 07:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:from:to:subject:date:mime-version:content-type;
        bh=dl5wcZGjz4Uq2B52X07F9zlw22k/2aepcPrEG8oekIU=;
        b=ZHPY2Sxwv0Dnj0KPRW1RX1OM9j94MF5kuMzaPOjIlhloYv4V04+VSoO5DD+Ha4YhfY
         WAKZEBXxlq4fGcftMySMy/DUwOuDstNR1cnXMg76PMHjEk0wzu1Ahjw0lgO7osJ2zeOD
         g8qjRW4H6hKgZVr7wQc3bKjMPei60V4HXrW8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:from:to:subject:date:mime-version
         :content-type;
        bh=dl5wcZGjz4Uq2B52X07F9zlw22k/2aepcPrEG8oekIU=;
        b=Q7NoEPCML2i/NYpzf+TKCvQcCWZGagq01+YbidbME1c+ASX/k0+/Z+rJOuHbSZ2ZFX
         V7G6qryuxZ0ipcvIK6JG4yKEp2KhB+f5a9ALVe/1PSQBSQiFU0fWiSx8IT7muHzmbY1g
         pqUqwnDCjXEV0LSwGgsbqsps5VFpOOZLTmcqzXeAdHpV7ulkwu9wMsmZUCnaOP0GdVYz
         +FNbOKNO8pSEYJn5Ow9e9bV9Pd+NBVGG+42390+vHllCQN4mkPS4TPfxa3lv95s2+sk5
         nYMBYxNgxpBIajzNJUzK9vRddRWHQHNoyRdNDoe3dYlslvpuQgJ/R0uXXnbVf0AmMxWq
         qGJA==
X-Gm-Message-State: ALoCoQkTlPqaXTCPRfsyKHkxOESScQmoxX2d1AN6kiCnTZNzrosTjnPzfxmPbVp7NxwQ/MwXq/mX
X-Received: by 10.224.65.196 with SMTP id k4mr4425757qai.56.1406645021720;
        Tue, 29 Jul 2014 07:43:41 -0700 (PDT)
Received: from debian (ip68-1-72-35.pn.at.cox.net. [68.1.72.35])
        by mx.google.com with ESMTPSA id y79sm26526773qgy.18.2014.07.29.07.43.40
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Jul 2014 07:43:41 -0700 (PDT)
X-Mailer: sendEmail-1.56
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254444>

This is a multi-part message in MIME format. To properly display this message you need a MIME-Version 1.0 compliant Email program.

------MIME delimiter for sendEmail-128858.688128279
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Remotes are stored as an array, so looking one up or adding one without
duplication is an O(n) operation.  Reading an entire config file full of
remotes is O(n^2) in the number of remotes.  For a repository with tens of
thousands of remotes, the running time can hit multiple minutes.

Hash tables are way faster.  So we add a hashmap from remote name to
struct remote and use it for all lookups.  The time to add a new remote to
a repo that already has 50,000 remotes drops from ~2 minutes to < 1
second.

We retain the old array of remotes so iterators proceed in config-file
order.

Signed-off-by: Patrick Reynolds <patrick.reynolds@github.com>
---
mark function with no arguments as taking void

 remote.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++-----------------
 remote.h |  3 +++
 2 files changed, 49 insertions(+), 17 deletions(-)

diff --git a/remote.c b/remote.c
index a0701f6..52533e4 100644
--- a/remote.c
+++ b/remote.c
@@ -42,6 +42,7 @@ struct rewrites {
 static struct remote **remotes;
 static int remotes_alloc;
 static int remotes_nr;
+static struct hashmap remotes_hash;
 
 static struct branch **branches;
 static int branches_alloc;
@@ -136,26 +137,51 @@ static void add_url_alias(struct remote *remote, const char *url)
 	add_pushurl_alias(remote, url);
 }
 
+struct remotes_hash_key {
+	const char *str;
+	int len;
+};
+
+static int remotes_hash_cmp(const struct remote *a, const struct remote *b, const struct remotes_hash_key *key)
+{
+	if (key)
+		return strncmp(a->name, key->str, key->len) || a->name[key->len];
+	else
+		return strcmp(a->name, b->name);
+}
+
+static inline void init_remotes_hash(void)
+{
+	if (!remotes_hash.cmpfn)
+		hashmap_init(&remotes_hash, (hashmap_cmp_fn)remotes_hash_cmp, 0);
+}
+
 static struct remote *make_remote(const char *name, int len)
 {
-	struct remote *ret;
-	int i;
+	struct remote *ret, *replaced;
+	struct remotes_hash_key lookup;
+	struct hashmap_entry lookup_entry;
 
-	for (i = 0; i < remotes_nr; i++) {
-		if (len ? (!strncmp(name, remotes[i]->name, len) &&
-			   !remotes[i]->name[len]) :
-		    !strcmp(name, remotes[i]->name))
-			return remotes[i];
-	}
+	if (!len)
+		len = strlen(name);
+
+	init_remotes_hash();
+	lookup.str = name;
+	lookup.len = len;
+	hashmap_entry_init(&lookup_entry, memhash(name, len));
+
+	if ((ret = hashmap_get(&remotes_hash, &lookup_entry, &lookup)) != NULL)
+		return ret;
 
 	ret = xcalloc(1, sizeof(struct remote));
 	ret->prune = -1;  /* unspecified */
 	ALLOC_GROW(remotes, remotes_nr + 1, remotes_alloc);
 	remotes[remotes_nr++] = ret;
-	if (len)
-		ret->name = xstrndup(name, len);
-	else
-		ret->name = xstrdup(name);
+	ret->name = xstrndup(name, len);
+
+	hashmap_entry_init(ret, lookup_entry.hash);
+	replaced = hashmap_put(&remotes_hash, ret);
+	assert(replaced == NULL);  /* no previous entry overwritten */
 	return ret;
 }
 
@@ -722,13 +748,16 @@ struct remote *pushremote_get(const char *name)
 
 int remote_is_configured(const char *name)
 {
-	int i;
+	struct remotes_hash_key lookup;
+	struct hashmap_entry lookup_entry;
 	read_config();
 
-	for (i = 0; i < remotes_nr; i++)
-		if (!strcmp(name, remotes[i]->name))
-			return 1;
-	return 0;
+	init_remotes_hash();
+	lookup.str = name;
+	lookup.len = strlen(name);
+	hashmap_entry_init(&lookup_entry, memhash(name, lookup.len));
+
+	return hashmap_get(&remotes_hash, &lookup_entry, &lookup) != NULL;
 }
 
 int for_each_remote(each_remote_fn fn, void *priv)
diff --git a/remote.h b/remote.h
index 917d383..81cb5ff 100644
--- a/remote.h
+++ b/remote.h
@@ -1,6 +1,7 @@
 #ifndef REMOTE_H
 #define REMOTE_H
 
+#include "hashmap.h"
 #include "parse-options.h"
 
 enum {
@@ -10,6 +11,8 @@ enum {
 };
 
 struct remote {
+	struct hashmap_entry ent;  /* must be first */
+
 	const char *name;
 	int origin;
 
-- 
2.0.0.rc4



------MIME delimiter for sendEmail-128858.688128279--
