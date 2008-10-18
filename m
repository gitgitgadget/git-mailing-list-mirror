From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 3/3]  make alloc_ref_from_str() the new alloc_ref()
Date: Sat, 18 Oct 2008 10:44:18 +0200
Message-ID: <48F9A1E2.50000@lsrfire.ath.cx>
References: <48F9A054.4010703@lsrfire.ath.cx> <48F9A13D.3090401@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Sat Oct 18 10:45:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kr7RI-0001qp-Oj
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 10:45:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbYJRIoY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2008 04:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750912AbYJRIoY
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Oct 2008 04:44:24 -0400
Received: from india601.server4you.de ([85.25.151.105]:37971 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910AbYJRIoX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2008 04:44:23 -0400
Received: from [10.0.1.101] (p57B7E475.dip.t-dialin.net [87.183.228.117])
	by india601.server4you.de (Postfix) with ESMTPSA id 184B82F8058;
	Sat, 18 Oct 2008 10:44:21 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
In-Reply-To: <48F9A13D.3090401@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98529>

With all calls to alloc_ref() gone, we can remove it and then we're free
to give alloc_ref_from_str() the shorter name.  It's a much nicer
interface, as the callers always need to have a name string when they
allocate a ref anyway and don't need to calculate and pass its length+1
any more.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 builtin-fetch.c |    4 ++--
 connect.c       |    2 +-
 http-push.c     |    4 ++--
 remote.c        |   21 +++++++--------------
 remote.h        |    4 +---
 transport.c     |    8 ++++----
 walker.c        |    2 +-
 7 files changed, 18 insertions(+), 27 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index ee93d3a..e008ee9 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -521,8 +521,8 @@ static void find_non_local_tags(struct transport *transport,
 		     will_fetch(head, ref->old_sha1))) {
 			string_list_insert(ref_name, &new_refs);
 
-			rm = alloc_ref_from_str(ref_name);
-			rm->peer_ref = alloc_ref_from_str(ref_name);
+			rm = alloc_ref(ref_name);
+			rm->peer_ref = alloc_ref(ref_name);
 			hashcpy(rm->old_sha1, ref_sha1);
 
 			**tail = rm;
diff --git a/connect.c b/connect.c
index b69060b..0c50d0a 100644
--- a/connect.c
+++ b/connect.c
@@ -90,7 +90,7 @@ struct ref **get_remote_heads(int in, struct ref **list,
 			continue;
 		if (nr_match && !path_match(name, nr_match, match))
 			continue;
-		ref = alloc_ref_from_str(buffer + 41);
+		ref = alloc_ref(buffer + 41);
 		hashcpy(ref->old_sha1, old_sha1);
 		*list = ref;
 		list = &ref->next;
diff --git a/http-push.c b/http-push.c
index 42f4d78..5cecef4 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1780,7 +1780,7 @@ static void one_remote_ref(char *refname)
 	struct ref *ref;
 	struct object *obj;
 
-	ref = alloc_ref_from_str(refname);
+	ref = alloc_ref(refname);
 
 	if (http_fetch_ref(remote->url, ref) != 0) {
 		fprintf(stderr,
@@ -1887,7 +1887,7 @@ static void add_remote_info_ref(struct remote_ls_ctx *ls)
 	char *ref_info;
 	struct ref *ref;
 
-	ref = alloc_ref_from_str(ls->dentry_name);
+	ref = alloc_ref(ls->dentry_name);
 
 	if (http_fetch_ref(remote->url, ref) != 0) {
 		fprintf(stderr,
diff --git a/remote.c b/remote.c
index 44d681d..e530a21 100644
--- a/remote.c
+++ b/remote.c
@@ -759,15 +759,9 @@ static struct ref *alloc_ref_with_prefix(const char *prefix, size_t prefixlen,
 	return ref;
 }
 
-struct ref *alloc_ref(unsigned namelen)
+struct ref *alloc_ref(const char *name)
 {
-	struct ref *ret = xcalloc(1, sizeof(struct ref) + namelen);
-	return ret;
-}
-
-struct ref *alloc_ref_from_str(const char* str)
-{
-	return alloc_ref_with_prefix("", 0, str);
+	return alloc_ref_with_prefix("", 0, name);
 }
 
 static struct ref *copy_ref(const struct ref *ref)
@@ -878,20 +872,20 @@ static struct ref *try_explicit_object_name(const char *name)
 	struct ref *ref;
 
 	if (!*name) {
-		ref = alloc_ref_from_str("(delete)");
+		ref = alloc_ref("(delete)");
 		hashclr(ref->new_sha1);
 		return ref;
 	}
 	if (get_sha1(name, sha1))
 		return NULL;
-	ref = alloc_ref_from_str(name);
+	ref = alloc_ref(name);
 	hashcpy(ref->new_sha1, sha1);
 	return ref;
 }
 
 static struct ref *make_linked_ref(const char *name, struct ref ***tail)
 {
-	struct ref *ret = alloc_ref_from_str(name);
+	struct ref *ret = alloc_ref(name);
 	tail_link_ref(ret, tail);
 	return ret;
 }
@@ -1196,9 +1190,8 @@ static struct ref *get_local_ref(const char *name)
 	if (!name)
 		return NULL;
 
-	if (!prefixcmp(name, "refs/")) {
-		return alloc_ref_from_str(name);
-	}
+	if (!prefixcmp(name, "refs/"))
+		return alloc_ref(name);
 
 	if (!prefixcmp(name, "heads/") ||
 	    !prefixcmp(name, "tags/") ||
diff --git a/remote.h b/remote.h
index c6163ff..d2e170c 100644
--- a/remote.h
+++ b/remote.h
@@ -55,9 +55,7 @@ struct refspec {
 
 extern const struct refspec *tag_refspec;
 
-struct ref *alloc_ref(unsigned namelen);
-
-struct ref *alloc_ref_from_str(const char* str);
+struct ref *alloc_ref(const char *name);
 
 struct ref *copy_ref_list(const struct ref *ref);
 
diff --git a/transport.c b/transport.c
index 3d03475..cfb7350 100644
--- a/transport.c
+++ b/transport.c
@@ -75,7 +75,7 @@ static int read_loose_refs(struct strbuf *path, int name_offset,
 
 			if (fd < 0)
 				continue;
-			next = alloc_ref_from_str(path->buf + name_offset);
+			next = alloc_ref(path->buf + name_offset);
 			if (read_in_full(fd, buffer, 40) != 40 ||
 					get_sha1_hex(buffer, next->old_sha1)) {
 				close(fd);
@@ -126,7 +126,7 @@ static void insert_packed_refs(const char *packed_refs, struct ref **list)
 				      (*list)->next->name)) > 0)
 			list = &(*list)->next;
 		if (!(*list)->next || cmp < 0) {
-			struct ref *next = alloc_ref_from_str(buffer + 41);
+			struct ref *next = alloc_ref(buffer + 41);
 			buffer[40] = '\0';
 			if (get_sha1_hex(buffer, next->old_sha1)) {
 				warning ("invalid SHA-1: %s", buffer);
@@ -499,7 +499,7 @@ static struct ref *get_refs_via_curl(struct transport *transport)
 
 	strbuf_release(&buffer);
 
-	ref = alloc_ref_from_str("HEAD");
+	ref = alloc_ref("HEAD");
 	if (!walker->fetch_ref(walker, ref) &&
 	    !resolve_remote_symref(ref, refs)) {
 		ref->next = refs;
@@ -540,7 +540,7 @@ static struct ref *get_refs_from_bundle(struct transport *transport)
 		die ("Could not read bundle '%s'.", transport->url);
 	for (i = 0; i < data->header.references.nr; i++) {
 		struct ref_list_entry *e = data->header.references.list + i;
-		struct ref *ref = alloc_ref_from_str(e->name);
+		struct ref *ref = alloc_ref(e->name);
 		hashcpy(ref->old_sha1, e->sha1);
 		ref->next = result;
 		result = ref;
diff --git a/walker.c b/walker.c
index 6b4cf70..679adab 100644
--- a/walker.c
+++ b/walker.c
@@ -191,7 +191,7 @@ static int interpret_target(struct walker *walker, char *target, unsigned char *
 	if (!get_sha1_hex(target, sha1))
 		return 0;
 	if (!check_ref_format(target)) {
-		struct ref *ref = alloc_ref_from_str(target);
+		struct ref *ref = alloc_ref(target);
 		if (!walker->fetch_ref(walker, ref)) {
 			hashcpy(sha1, ref->old_sha1);
 			free(ref);
-- 
1.6.0.2.542.gde55
