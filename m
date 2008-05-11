From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Optimize common pattern of alloc_ref from string
Date: Sun, 11 May 2008 15:02:45 -0700
Message-ID: <7v8wyg33ei.fsf@gitster.siamese.dyndns.org>
References: <1210462018-47060-1-git-send-email-kkowalczyk@gmail.com>
 <20080510233918.GA315@sigill.intra.peff.net>
 <7ce338ad0805101730n5b964a0em39d9fdcd9fc45f00@mail.gmail.com>
 <20080511080709.GA6971@sigill.intra.peff.net>
 <7vskwo3ct5.fsf@gitster.siamese.dyndns.org>
 <7ce338ad0805111315q3745ea7fn4c38b557170e521f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jeff King" <peff@peff.net>, git@vger.kernel.org
To: "Krzysztof Kowalczyk" <kkowalczyk@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 12 00:04:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvJeE-0004BC-Sy
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 00:04:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757229AbYEKWDN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 18:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757543AbYEKWDM
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 18:03:12 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53383 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756969AbYEKWDL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 18:03:11 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7581C421D;
	Sun, 11 May 2008 18:03:09 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 32242421A; Sun, 11 May 2008 18:03:02 -0400 (EDT)
In-Reply-To: <7ce338ad0805111315q3745ea7fn4c38b557170e521f@mail.gmail.com>
 (Krzysztof Kowalczyk's message of "Sun, 11 May 2008 13:15:52 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0AA645C4-1FA6-11DD-8590-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81820>

Thanks.  I've already queued this instead, as it is not about
"Optimization" but about refactoring.

I am actually very tempted to relabel it as "Fix underallocation in
interpret_target()" and describe the refactoring just as a side-effect,
but the commit is already buried deep in my outgoing queue for "master",
and I do not think it is worth delaying today's pushout for rewording the
commit log message again.

-- >8 --
From: Krzysztof Kowalczyk <kkowalczyk@gmail.com>
Date: Sat, 10 May 2008 16:26:58 -0700
Subject: [PATCH] alloc_ref_from_str(): factor out a common pattern of alloc_ref from string

Also fix an underallocation in walker.c::interpret_target().

Signed-off-by: Krzysztof Kowalczyk <kkowalczyk@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-fetch.c |    6 ++----
 http-push.c     |    6 ++----
 remote.c        |   23 ++++++++++-------------
 remote.h        |    2 ++
 transport.c     |    6 ++----
 walker.c        |    3 +--
 6 files changed, 19 insertions(+), 27 deletions(-)

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
index 6b480cb..91cbb72 100644
--- a/remote.c
+++ b/remote.c
@@ -691,6 +691,13 @@ struct ref *alloc_ref(unsigned namelen)
 	return ret;
 }
 
+struct ref *alloc_ref_from_str(const char* str)
+{
+	struct ref *ret = alloc_ref(strlen(str) + 1);
+	strcpy(ret->name, str);
+	return ret;
+}
+
 static struct ref *copy_ref(const struct ref *ref)
 {
 	struct ref *ret = xmalloc(sizeof(struct ref) + strlen(ref->name) + 1);
@@ -797,7 +804,6 @@ static struct ref *try_explicit_object_name(const char *name)
 {
 	unsigned char sha1[20];
 	struct ref *ref;
-	int len;
 
 	if (!*name) {
 		ref = alloc_ref(20);
@@ -807,21 +813,14 @@ static struct ref *try_explicit_object_name(const char *name)
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
@@ -1125,9 +1124,7 @@ static struct ref *get_local_ref(const char *name)
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
1.5.5.1.294.g7b425
