From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/6] cache.h: move remote/connect API out of it
Date: Thu, 11 Jul 2013 15:26:15 -0700
Message-ID: <1373581580-13651-2-git-send-email-gitster@pobox.com>
References: <1373581580-13651-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 12 00:26:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxPJt-0002Hy-M4
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 00:26:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755142Ab3GKW01 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 18:26:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34370 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755488Ab3GKW0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 18:26:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C5989303D6
	for <git@vger.kernel.org>; Thu, 11 Jul 2013 22:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=0su+
	Uyka9uiomB2PUF8xjtuv72s=; b=vY+dKGoIajRj3+rTK9bl3ngRnxMwM685aPwP
	sXeXAS6AqxXKGCm7G3j7O/8iPmNS9BuXgW1ezIlL0QlqJB0OdO6eN/DltPsrO+KE
	wLZmzYJCFM+B9KGcVz/0kaLjLQgWk1H0idL+1YSHgRJoGZs3NEoUfIrJQ379Q1NO
	DQKUC9w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=mqTA7m
	Jxrl7Y/wXITL3/Ffmq8jNULui7SVES7gliuLEdiVR9emi0N43qUAdC41xghjW8lO
	Anm/wMj298R5sI4I5V03fhdxS7acdwbEVJaTg66swMIfTXy4GILUSmVpDCYWClL/
	olLRcwnoovIHnPycLaGM8hqAF25doQoByHcbA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B92D0303D5
	for <git@vger.kernel.org>; Thu, 11 Jul 2013 22:26:24 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B1539303D1
	for <git@vger.kernel.org>; Thu, 11 Jul 2013 22:26:23 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.2-911-g2c4daa5
In-Reply-To: <1373581580-13651-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: EB30C446-EA78-11E2-B083-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230136>

The definition of "struct ref" in "cache.h", a header file so
central to the system, always confused me.  This structure is not
about the local ref used by sha1-name API to name local objects.

It is what refspecs are expanded into, after finding out what refs
the other side has, to define what refs are updated after object
transfer succeeds to what values.  It belongs to "remote.h" together
with "struct refspec".

While we are at it, also move the types and functions related to the
Git transport connection to a new header file connect.h

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fetch-pack.c   |  2 ++
 builtin/receive-pack.c |  1 +
 builtin/send-pack.c    |  1 +
 cache.h                | 62 --------------------------------------------------
 connect.c              |  1 +
 connect.h              | 13 +++++++++++
 fetch-pack.c           |  1 +
 fetch-pack.h           |  1 +
 refs.c                 |  8 -------
 remote.c               |  8 +++++++
 remote.h               | 54 +++++++++++++++++++++++++++++++++++++++++++
 send-pack.c            |  1 +
 transport.c            |  2 ++
 transport.h            |  1 +
 upload-pack.c          |  1 +
 15 files changed, 87 insertions(+), 70 deletions(-)
 create mode 100644 connect.h

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index aba4465..c6888c6 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -1,6 +1,8 @@
 #include "builtin.h"
 #include "pkt-line.h"
 #include "fetch-pack.h"
+#include "remote.h"
+#include "connect.h"
 
 static const char fetch_pack_usage[] =
 "git fetch-pack [--all] [--stdin] [--quiet|-q] [--keep|-k] [--thin] "
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index e3eb5fc..7434d9b 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -8,6 +8,7 @@
 #include "commit.h"
 #include "object.h"
 #include "remote.h"
+#include "connect.h"
 #include "transport.h"
 #include "string-list.h"
 #include "sha1-array.h"
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 152c4ea..e86d3b5 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -5,6 +5,7 @@
 #include "sideband.h"
 #include "run-command.h"
 #include "remote.h"
+#include "connect.h"
 #include "send-pack.h"
 #include "quote.h"
 #include "transport.h"
diff --git a/cache.h b/cache.h
index dd0fb33..cb2891d 100644
--- a/cache.h
+++ b/cache.h
@@ -1035,68 +1035,6 @@ struct pack_entry {
 	struct packed_git *p;
 };
 
-struct ref {
-	struct ref *next;
-	unsigned char old_sha1[20];
-	unsigned char new_sha1[20];
-	char *symref;
-	unsigned int
-		force:1,
-		forced_update:1,
-		deletion:1,
-		matched:1;
-
-	/*
-	 * Order is important here, as we write to FETCH_HEAD
-	 * in numeric order. And the default NOT_FOR_MERGE
-	 * should be 0, so that xcalloc'd structures get it
-	 * by default.
-	 */
-	enum {
-		FETCH_HEAD_MERGE = -1,
-		FETCH_HEAD_NOT_FOR_MERGE = 0,
-		FETCH_HEAD_IGNORE = 1
-	} fetch_head_status;
-
-	enum {
-		REF_STATUS_NONE = 0,
-		REF_STATUS_OK,
-		REF_STATUS_REJECT_NONFASTFORWARD,
-		REF_STATUS_REJECT_ALREADY_EXISTS,
-		REF_STATUS_REJECT_NODELETE,
-		REF_STATUS_REJECT_FETCH_FIRST,
-		REF_STATUS_REJECT_NEEDS_FORCE,
-		REF_STATUS_UPTODATE,
-		REF_STATUS_REMOTE_REJECT,
-		REF_STATUS_EXPECTING_REPORT
-	} status;
-	char *remote_status;
-	struct ref *peer_ref; /* when renaming */
-	char name[FLEX_ARRAY]; /* more */
-};
-
-#define REF_NORMAL	(1u << 0)
-#define REF_HEADS	(1u << 1)
-#define REF_TAGS	(1u << 2)
-
-extern struct ref *find_ref_by_name(const struct ref *list, const char *name);
-
-#define CONNECT_VERBOSE       (1u << 0)
-extern struct child_process *git_connect(int fd[2], const char *url, const char *prog, int flags);
-extern int finish_connect(struct child_process *conn);
-extern int git_connection_is_socket(struct child_process *conn);
-struct extra_have_objects {
-	int nr, alloc;
-	unsigned char (*array)[20];
-};
-extern struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
-				     struct ref **list, unsigned int flags,
-				     struct extra_have_objects *);
-extern int server_supports(const char *feature);
-extern int parse_feature_request(const char *features, const char *feature);
-extern const char *server_feature_value(const char *feature, int *len_ret);
-extern const char *parse_feature_value(const char *feature_list, const char *feature, int *len_ret);
-
 extern struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path);
 
 /* A hook for count-objects to report invalid files in pack directory */
diff --git a/connect.c b/connect.c
index a0783d4..a80ebd3 100644
--- a/connect.c
+++ b/connect.c
@@ -5,6 +5,7 @@
 #include "refs.h"
 #include "run-command.h"
 #include "remote.h"
+#include "connect.h"
 #include "url.h"
 
 static char *server_capabilities;
diff --git a/connect.h b/connect.h
new file mode 100644
index 0000000..9dff25c
--- /dev/null
+++ b/connect.h
@@ -0,0 +1,13 @@
+#ifndef CONNECT_H
+#define CONNECT_H
+
+#define CONNECT_VERBOSE       (1u << 0)
+extern struct child_process *git_connect(int fd[2], const char *url, const char *prog, int flags);
+extern int finish_connect(struct child_process *conn);
+extern int git_connection_is_socket(struct child_process *conn);
+extern int server_supports(const char *feature);
+extern int parse_feature_request(const char *features, const char *feature);
+extern const char *server_feature_value(const char *feature, int *len_ret);
+extern const char *parse_feature_value(const char *feature_list, const char *feature, int *len_ret);
+
+#endif
diff --git a/fetch-pack.c b/fetch-pack.c
index abe5ffb..c2bab42 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -9,6 +9,7 @@
 #include "fetch-pack.h"
 #include "remote.h"
 #include "run-command.h"
+#include "connect.h"
 #include "transport.h"
 #include "version.h"
 
diff --git a/fetch-pack.h b/fetch-pack.h
index 40f08ba..461cbf3 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -2,6 +2,7 @@
 #define FETCH_PACK_H
 
 #include "string-list.h"
+#include "run-command.h"
 
 struct fetch_pack_args {
 	const char *uploadpack;
diff --git a/refs.c b/refs.c
index 4302206..330060c 100644
--- a/refs.c
+++ b/refs.c
@@ -3193,14 +3193,6 @@ int update_ref(const char *action, const char *refname,
 	return 0;
 }
 
-struct ref *find_ref_by_name(const struct ref *list, const char *name)
-{
-	for ( ; list; list = list->next)
-		if (!strcmp(list->name, name))
-			return (struct ref *)list;
-	return NULL;
-}
-
 /*
  * generate a format suitable for scanf from a ref_rev_parse_rules
  * rule, that is replace the "%.*s" spec with a "%s" spec
diff --git a/remote.c b/remote.c
index 6f57830..b1ff7a2 100644
--- a/remote.c
+++ b/remote.c
@@ -1302,6 +1302,14 @@ static void add_missing_tags(struct ref *src, struct ref **dst, struct ref ***ds
 	free(sent_tips.tip);
 }
 
+struct ref *find_ref_by_name(const struct ref *list, const char *name)
+{
+	for ( ; list; list = list->next)
+		if (!strcmp(list->name, name))
+			return (struct ref *)list;
+	return NULL;
+}
+
 /*
  * Given the set of refs the local repository has, the set of refs the
  * remote repository has, and the refspec used for push, determine
diff --git a/remote.h b/remote.h
index cf56724..a850059 100644
--- a/remote.h
+++ b/remote.h
@@ -71,6 +71,52 @@ struct refspec {
 
 extern const struct refspec *tag_refspec;
 
+struct ref {
+	struct ref *next;
+	unsigned char old_sha1[20];
+	unsigned char new_sha1[20];
+	char *symref;
+	unsigned int
+		force:1,
+		forced_update:1,
+		deletion:1,
+		matched:1;
+
+	/*
+	 * Order is important here, as we write to FETCH_HEAD
+	 * in numeric order. And the default NOT_FOR_MERGE
+	 * should be 0, so that xcalloc'd structures get it
+	 * by default.
+	 */
+	enum {
+		FETCH_HEAD_MERGE = -1,
+		FETCH_HEAD_NOT_FOR_MERGE = 0,
+		FETCH_HEAD_IGNORE = 1
+	} fetch_head_status;
+
+	enum {
+		REF_STATUS_NONE = 0,
+		REF_STATUS_OK,
+		REF_STATUS_REJECT_NONFASTFORWARD,
+		REF_STATUS_REJECT_ALREADY_EXISTS,
+		REF_STATUS_REJECT_NODELETE,
+		REF_STATUS_REJECT_FETCH_FIRST,
+		REF_STATUS_REJECT_NEEDS_FORCE,
+		REF_STATUS_UPTODATE,
+		REF_STATUS_REMOTE_REJECT,
+		REF_STATUS_EXPECTING_REPORT
+	} status;
+	char *remote_status;
+	struct ref *peer_ref; /* when renaming */
+	char name[FLEX_ARRAY]; /* more */
+};
+
+#define REF_NORMAL	(1u << 0)
+#define REF_HEADS	(1u << 1)
+#define REF_TAGS	(1u << 2)
+
+extern struct ref *find_ref_by_name(const struct ref *list, const char *name);
+
 struct ref *alloc_ref(const char *name);
 struct ref *copy_ref(const struct ref *ref);
 struct ref *copy_ref_list(const struct ref *ref);
@@ -84,6 +130,14 @@ int check_ref_type(const struct ref *ref, int flags);
  */
 void free_refs(struct ref *ref);
 
+struct extra_have_objects {
+	int nr, alloc;
+	unsigned char (*array)[20];
+};
+extern struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
+				     struct ref **list, unsigned int flags,
+				     struct extra_have_objects *);
+
 int resolve_remote_symref(struct ref *ref, struct ref *list);
 int ref_newer(const unsigned char *new_sha1, const unsigned char *old_sha1);
 
diff --git a/send-pack.c b/send-pack.c
index 7d172ef..9a9908c 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -5,6 +5,7 @@
 #include "sideband.h"
 #include "run-command.h"
 #include "remote.h"
+#include "connect.h"
 #include "send-pack.h"
 #include "quote.h"
 #include "transport.h"
diff --git a/transport.c b/transport.c
index e15db98..b84dbf0 100644
--- a/transport.c
+++ b/transport.c
@@ -3,6 +3,8 @@
 #include "run-command.h"
 #include "pkt-line.h"
 #include "fetch-pack.h"
+#include "remote.h"
+#include "connect.h"
 #include "send-pack.h"
 #include "walker.h"
 #include "bundle.h"
diff --git a/transport.h b/transport.h
index ea70ea7..b551f99 100644
--- a/transport.h
+++ b/transport.h
@@ -2,6 +2,7 @@
 #define TRANSPORT_H
 
 #include "cache.h"
+#include "run-command.h"
 #include "remote.h"
 
 struct git_transport_options {
diff --git a/upload-pack.c b/upload-pack.c
index 127e59a..b03492e 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -10,6 +10,7 @@
 #include "revision.h"
 #include "list-objects.h"
 #include "run-command.h"
+#include "connect.h"
 #include "sigchain.h"
 #include "version.h"
 #include "string-list.h"
-- 
1.8.3.2-912-g65cf5cf
