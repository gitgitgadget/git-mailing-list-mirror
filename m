From: kkowalczyk@gmail.com
Subject: [PATCH] Optimize common pattern of alloc_ref from string
Date: Sat, 10 May 2008 16:26:58 -0700
Message-ID: <1210462018-47060-1-git-send-email-kkowalczyk@gmail.com>
Cc: gitster@pobox.com, Krzysztof Kowalczyk <kkowalczyk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 11 01:28:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuyUC-0007DG-Ud
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 01:28:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755036AbYEJX1F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 19:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754090AbYEJX1E
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 19:27:04 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:32215 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753276AbYEJX1B (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 19:27:01 -0400
Received: by py-out-1112.google.com with SMTP id u52so2032419pyb.10
        for <git@vger.kernel.org>; Sat, 10 May 2008 16:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=q0IY9wiIxbh0p85XS1EcmcHR2AdWjmW0s1h/uXhKqp4=;
        b=gPtHPWCWdOr1WrQ5B3ky01wv0nwiR1QxGh4dsnJqWTNfJMlvzS8KKE6cwOnAezwRcCEZDwvJMiE4xHp27wxYlER1nNUxsMNjxhlY31DVXbRk6wtZTgV99FUanB2qebWUs2D9lUj0KyyhziMVHBhvTnp1szWgAN41VILev0nk73g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=TO3VQX1W3QlEpUFjmIstImjkh/qEjS8pEs9KmIbZ28+02SIr/XI2xSLwHs1BCUcz30wK0XrMaBOz1UBL+OJFrWEy5XThQTIafSMfLMVqwCK+1mH7CiMTLeOIohiJdbMn+VzNQacfNWgkwLq13VEcAIwnHwo4My/K/AK0k7euBCg=
Received: by 10.35.33.15 with SMTP id l15mr11263503pyj.35.1210462020785;
        Sat, 10 May 2008 16:27:00 -0700 (PDT)
Received: from localhost.localdomain ( [66.92.0.64])
        by mx.google.com with ESMTPS id f79sm8396818pyh.7.2008.05.10.16.26.59
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 10 May 2008 16:27:00 -0700 (PDT)
X-Mailer: git-send-email 1.5.4.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81714>

From: Krzysztof Kowalczyk <kkowalczyk@gmail.com>

As a byproduct, fixes one place where string wasn't properly terminated.
Signed-off-by: Krzysztof Kowalczyk <kkowalczyk@gmail.com>
---
 builtin-fetch.c |    6 ++----
 http-push.c     |    6 ++----
 remote.c        |   28 +++++++++++++++-------------
 remote.h        |    2 ++
 transport.c     |    6 ++----
 walker.c        |    3 +--
 6 files changed, 24 insertions(+), 27 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index e56617e..f6584ec 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -508,10 +508,8 @@ static void find_non_local_tags(struct transport *transport,
 		     will_fetch(head, ref->old_sha1))) {
 			path_list_insert(ref_name, &new_refs);
 
-			rm = alloc_ref(strlen(ref_name) + 1);
-			strcpy(rm->name, ref_name);
-			rm->peer_ref = alloc_ref(strlen(ref_name) + 1);
-			strcpy(rm->peer_ref->name, ref_name);
+			rm = alloc_ref_from_str(ref_name);
+			rm->peer_ref = alloc_ref_from_str(ref_name);
 			hashcpy(rm->old_sha1, ref_sha1);
 
 			**tail = rm;
diff --git a/http-push.c b/http-push.c
index 939a764..42727c8 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1761,8 +1761,7 @@ static void one_remote_ref(char *refname)
 	struct ref *ref;
 	struct object *obj;
 
-	ref = alloc_ref(strlen(refname) + 1);
-	strcpy(ref->name, refname);
+	ref = alloc_ref_from_str(refname);
 
 	if (http_fetch_ref(remote->url, ref) != 0) {
 		fprintf(stderr,
@@ -1894,8 +1893,7 @@ static void add_remote_info_ref(struct remote_ls_ctx *ls)
 	char *ref_info;
 	struct ref *ref;
 
-	ref = alloc_ref(strlen(ls->dentry_name) + 1);
-	strcpy(ref->name, ls->dentry_name);
+	ref = alloc_ref_from_str(ls->dentry_name);
 
 	if (http_fetch_ref(remote->url, ref) != 0) {
 		fprintf(stderr,
diff --git a/remote.c b/remote.c
index 6b480cb..4d3e0c7 100644
--- a/remote.c
+++ b/remote.c
@@ -691,6 +691,18 @@ struct ref *alloc_ref(unsigned namelen)
 	return ret;
 }
 
+struct ref *alloc_ref_from_str(const char* str)
+{
+	struct ref *ret;
+	unsigned len = strlen(str) + 1;
+	char *tmp = xmalloc(sizeof(struct ref) + len);
+	ret = (struct ref*)tmp;
+	memset(tmp, 0, sizeof(struct ref));
+	tmp += sizeof(struct ref);
+	memcpy(tmp, str, len);
+	return ret;
+}
+
 static struct ref *copy_ref(const struct ref *ref)
 {
 	struct ref *ret = xmalloc(sizeof(struct ref) + strlen(ref->name) + 1);
@@ -797,7 +809,6 @@ static struct ref *try_explicit_object_name(const char *name)
 {
 	unsigned char sha1[20];
 	struct ref *ref;
-	int len;
 
 	if (!*name) {
 		ref = alloc_ref(20);
@@ -807,21 +818,14 @@ static struct ref *try_explicit_object_name(const char *name)
 	}
 	if (get_sha1(name, sha1))
 		return NULL;
-	len = strlen(name) + 1;
-	ref = alloc_ref(len);
-	memcpy(ref->name, name, len);
+	ref = alloc_ref_from_str(name);
 	hashcpy(ref->new_sha1, sha1);
 	return ref;
 }
 
 static struct ref *make_linked_ref(const char *name, struct ref ***tail)
 {
-	struct ref *ret;
-	size_t len;
-
-	len = strlen(name) + 1;
-	ret = alloc_ref(len);
-	memcpy(ret->name, name, len);
+	struct ref *ret = alloc_ref_from_str(name);
 	tail_link_ref(ret, tail);
 	return ret;
 }
@@ -1125,9 +1129,7 @@ static struct ref *get_local_ref(const char *name)
 		return NULL;
 
 	if (!prefixcmp(name, "refs/")) {
-		ret = alloc_ref(strlen(name) + 1);
-		strcpy(ret->name, name);
-		return ret;
+		return alloc_ref_from_str(name);
 	}
 
 	if (!prefixcmp(name, "heads/") ||
diff --git a/remote.h b/remote.h
index 75d006b..2ee83a3 100644
--- a/remote.h
+++ b/remote.h
@@ -54,6 +54,8 @@ struct refspec {
 
 struct ref *alloc_ref(unsigned namelen);
 
+struct ref *alloc_ref_from_str(const char* str);
+
 struct ref *copy_ref_list(const struct ref *ref);
 
 int check_ref_type(const struct ref *ref, int flags);
diff --git a/transport.c b/transport.c
index b012a28..1bc16f2 100644
--- a/transport.c
+++ b/transport.c
@@ -504,8 +504,7 @@ static struct ref *get_refs_via_curl(struct transport *transport)
 
 	strbuf_release(&buffer);
 
-	ref = alloc_ref(strlen("HEAD") + 1);
-	strcpy(ref->name, "HEAD");
+	ref = alloc_ref_from_str("HEAD");
 	if (!walker->fetch_ref(walker, ref) &&
 	    !resolve_remote_symref(ref, refs)) {
 		ref->next = refs;
@@ -546,9 +545,8 @@ static struct ref *get_refs_from_bundle(struct transport *transport)
 		die ("Could not read bundle '%s'.", transport->url);
 	for (i = 0; i < data->header.references.nr; i++) {
 		struct ref_list_entry *e = data->header.references.list + i;
-		struct ref *ref = alloc_ref(strlen(e->name) + 1);
+		struct ref *ref = alloc_ref_from_str(e->name);
 		hashcpy(ref->old_sha1, e->sha1);
-		strcpy(ref->name, e->name);
 		ref->next = result;
 		result = ref;
 	}
diff --git a/walker.c b/walker.c
index fa96a7c..31de6c1 100644
--- a/walker.c
+++ b/walker.c
@@ -190,8 +190,7 @@ static int interpret_target(struct walker *walker, char *target, unsigned char *
 	if (!get_sha1_hex(target, sha1))
 		return 0;
 	if (!check_ref_format(target)) {
-		struct ref *ref = alloc_ref(strlen(target));
-		strcpy(ref->name, target);
+		struct ref *ref = alloc_ref_from_str(target);
 		if (!walker->fetch_ref(walker, ref)) {
 			hashcpy(sha1, ref->old_sha1);
 			free(ref);
-- 
1.5.4.5
