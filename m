From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 1/4] Miscellaneous const changes and utilities
Date: Mon, 29 Oct 2007 21:05:40 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0710292049140.7357@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Oct 30 02:06:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImfYn-0002uH-GV
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 02:06:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752198AbXJ3BFn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2007 21:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752100AbXJ3BFn
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Oct 2007 21:05:43 -0400
Received: from iabervon.org ([66.92.72.58]:39154 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752149AbXJ3BFm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2007 21:05:42 -0400
Received: (qmail 32653 invoked by uid 1000); 30 Oct 2007 01:05:40 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Oct 2007 01:05:40 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62642>

The list of remote refs in struct transport should be const, because
builtin-fetch will get confused if it changes.

The url in git_connect should be const (and work on a copy) instead of
requiring the caller to copy it.

match_refs doesn't modify the refspecs it gets.

get_fetch_map and get_remote_ref don't change the list they get.

Allow transport get_refs_list methods to modify the struct transport.

Add a function to copy a list of refs, when a function needs a mutable
copy of a const list.

Add a function to check the type of a ref, as per the code in connect.c

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 builtin-fetch.c |   10 +++++-----
 cache.h         |    2 +-
 connect.c       |   10 +++++++++-
 http-push.c     |    2 +-
 remote.c        |   32 ++++++++++++++++++++++----------
 remote.h        |   10 +++++++---
 send-pack.c     |    8 ++++----
 transport.c     |   10 +++++-----
 transport.h     |    6 +++---
 9 files changed, 57 insertions(+), 33 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index b9d2b0c..fb64353 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -29,7 +29,7 @@ static void unlock_pack_on_signal(int signo)
 }
 
 static void add_merge_config(struct ref **head,
-		           struct ref *remote_refs,
+			   const struct ref *remote_refs,
 		           struct branch *branch,
 		           struct ref ***tail)
 {
@@ -71,7 +71,7 @@ static struct ref *get_ref_map(struct transport *transport,
 	struct ref *ref_map = NULL;
 	struct ref **tail = &ref_map;
 
-	struct ref *remote_refs = transport_get_remote_refs(transport);
+	const struct ref *remote_refs = transport_get_remote_refs(transport);
 
 	if (ref_count || tags) {
 		for (i = 0; i < ref_count; i++) {
@@ -337,12 +337,12 @@ static struct ref *find_non_local_tags(struct transport *transport,
 	struct path_list new_refs = { NULL, 0, 0, 1 };
 	char *ref_name;
 	int ref_name_len;
-	unsigned char *ref_sha1;
-	struct ref *tag_ref;
+	const unsigned char *ref_sha1;
+	const struct ref *tag_ref;
 	struct ref *rm = NULL;
 	struct ref *ref_map = NULL;
 	struct ref **tail = &ref_map;
-	struct ref *ref;
+	const struct ref *ref;
 
 	for_each_ref(add_existing, &existing_refs);
 	for (ref = transport_get_remote_refs(transport); ref; ref = ref->next) {
diff --git a/cache.h b/cache.h
index 27485d3..0e3848d 100644
--- a/cache.h
+++ b/cache.h
@@ -503,7 +503,7 @@ struct ref {
 #define REF_TAGS	(1u << 2)
 
 #define CONNECT_VERBOSE       (1u << 0)
-extern pid_t git_connect(int fd[2], char *url, const char *prog, int flags);
+extern pid_t git_connect(int fd[2], const char *url, const char *prog, int flags);
 extern int finish_connect(pid_t pid);
 extern int path_match(const char *path, int nr, char **match);
 extern int get_ack(int fd, unsigned char *result_sha1);
diff --git a/connect.c b/connect.c
index 3d5c4ab..2d62ea9 100644
--- a/connect.c
+++ b/connect.c
@@ -36,6 +36,11 @@ static int check_ref(const char *name, int len, unsigned int flags)
 	return !(flags & ~REF_NORMAL);
 }
 
+int check_ref_type(const struct ref *ref, int flags)
+{
+	return check_ref(ref->name, strlen(ref->name), flags);
+}
+
 /*
  * Read all the refs from the other end
  */
@@ -476,8 +481,9 @@ char *get_port(char *host)
  *
  * Does not return a negative value on error; it just dies.
  */
-pid_t git_connect(int fd[2], char *url, const char *prog, int flags)
+pid_t git_connect(int fd[2], const char *url_orig, const char *prog, int flags)
 {
+	char *url = xstrdup(url_orig);
 	char *host, *path = url;
 	char *end;
 	int c;
@@ -566,6 +572,7 @@ pid_t git_connect(int fd[2], char *url, const char *prog, int flags)
 			     prog, path, 0,
 			     target_host, 0);
 		free(target_host);
+		free(url);
 		if (free_path)
 			free(path);
 		return 0;
@@ -623,6 +630,7 @@ pid_t git_connect(int fd[2], char *url, const char *prog, int flags)
 	fd[1] = pipefd[1][1];
 	close(pipefd[0][1]);
 	close(pipefd[1][0]);
+	free(url);
 	if (free_path)
 		free(path);
 	return pid;
diff --git a/http-push.c b/http-push.c
index c02a3af..f461bb3 100644
--- a/http-push.c
+++ b/http-push.c
@@ -2389,7 +2389,7 @@ int main(int argc, char **argv)
 	if (!remote_tail)
 		remote_tail = &remote_refs;
 	if (match_refs(local_refs, remote_refs, &remote_tail,
-		       nr_refspec, refspec, push_all))
+		       nr_refspec, (const char **) refspec, push_all))
 		return -1;
 	if (!remote_refs) {
 		fprintf(stderr, "No refs in common and none specified; doing nothing.\n");
diff --git a/remote.c b/remote.c
index 170015a..ec89c97 100644
--- a/remote.c
+++ b/remote.c
@@ -485,7 +485,7 @@ struct ref *alloc_ref(unsigned namelen)
 	return ret;
 }
 
-static struct ref *copy_ref(struct ref *ref)
+static struct ref *copy_ref(const struct ref *ref)
 {
 	struct ref *ret = xmalloc(sizeof(struct ref) + strlen(ref->name) + 1);
 	memcpy(ret, ref, sizeof(struct ref) + strlen(ref->name) + 1);
@@ -493,6 +493,18 @@ static struct ref *copy_ref(struct ref *ref)
 	return ret;
 }
 
+struct ref *copy_ref_list(const struct ref *ref)
+{
+	struct ref *ret = NULL;
+	struct ref **tail = &ret;
+	while (ref) {
+		*tail = copy_ref(ref);
+		ref = ref->next;
+		tail = &((*tail)->next);
+	}
+	return ret;
+}
+
 void free_refs(struct ref *ref)
 {
 	struct ref *next;
@@ -710,7 +722,7 @@ static const struct refspec *check_pattern_match(const struct refspec *rs,
  * without thinking.
  */
 int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
-	       int nr_refspec, char **refspec, int all)
+	       int nr_refspec, const char **refspec, int all)
 {
 	struct refspec *rs =
 		parse_ref_spec(nr_refspec, (const char **) refspec);
@@ -810,10 +822,10 @@ int branch_merge_matches(struct branch *branch,
 	return ref_matches_abbrev(branch->merge[i]->src, refname);
 }
 
-static struct ref *get_expanded_map(struct ref *remote_refs,
+static struct ref *get_expanded_map(const struct ref *remote_refs,
 				    const struct refspec *refspec)
 {
-	struct ref *ref;
+	const struct ref *ref;
 	struct ref *ret = NULL;
 	struct ref **tail = &ret;
 
@@ -824,7 +836,7 @@ static struct ref *get_expanded_map(struct ref *remote_refs,
 		if (strchr(ref->name, '^'))
 			continue; /* a dereference item */
 		if (!prefixcmp(ref->name, refspec->src)) {
-			char *match;
+			const char *match;
 			struct ref *cpy = copy_ref(ref);
 			match = ref->name + remote_prefix_len;
 
@@ -842,9 +854,9 @@ static struct ref *get_expanded_map(struct ref *remote_refs,
 	return ret;
 }
 
-static struct ref *find_ref_by_name_abbrev(struct ref *refs, const char *name)
+static const struct ref *find_ref_by_name_abbrev(const struct ref *refs, const char *name)
 {
-	struct ref *ref;
+	const struct ref *ref;
 	for (ref = refs; ref; ref = ref->next) {
 		if (ref_matches_abbrev(name, ref->name))
 			return ref;
@@ -852,9 +864,9 @@ static struct ref *find_ref_by_name_abbrev(struct ref *refs, const char *name)
 	return NULL;
 }
 
-struct ref *get_remote_ref(struct ref *remote_refs, const char *name)
+struct ref *get_remote_ref(const struct ref *remote_refs, const char *name)
 {
-	struct ref *ref = find_ref_by_name_abbrev(remote_refs, name);
+	const struct ref *ref = find_ref_by_name_abbrev(remote_refs, name);
 
 	if (!ref)
 		die("Couldn't find remote ref %s\n", name);
@@ -887,7 +899,7 @@ static struct ref *get_local_ref(const char *name)
 	return ret;
 }
 
-int get_fetch_map(struct ref *remote_refs,
+int get_fetch_map(const struct ref *remote_refs,
 		  const struct refspec *refspec,
 		  struct ref ***tail)
 {
diff --git a/remote.h b/remote.h
index c62636d..723c21a 100644
--- a/remote.h
+++ b/remote.h
@@ -44,6 +44,10 @@ struct refspec {
 
 struct ref *alloc_ref(unsigned namelen);
 
+struct ref *copy_ref_list(const struct ref *ref);
+
+int check_ref_type(const struct ref *ref, int flags);
+
 /*
  * Frees the entire list and peers of elements.
  */
@@ -57,7 +61,7 @@ void ref_remove_duplicates(struct ref *ref_map);
 struct refspec *parse_ref_spec(int nr_refspec, const char **refspec);
 
 int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
-	       int nr_refspec, char **refspec, int all);
+	       int nr_refspec, const char **refspec, int all);
 
 /*
  * Given a list of the remote refs and the specification of things to
@@ -68,10 +72,10 @@ int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
  * beforehand, and will be set to the tail pointer of the list of
  * results afterward.
  */
-int get_fetch_map(struct ref *remote_refs, const struct refspec *refspec,
+int get_fetch_map(const struct ref *remote_refs, const struct refspec *refspec,
 		  struct ref ***tail);
 
-struct ref *get_remote_ref(struct ref *remote_refs, const char *name);
+struct ref *get_remote_ref(const struct ref *remote_refs, const char *name);
 
 /*
  * For the given remote, reads the refspec's src and sets the other fields.
diff --git a/send-pack.c b/send-pack.c
index e9b9a39..fe56617 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -178,7 +178,7 @@ static int receive_status(int in)
 	return ret;
 }
 
-static int send_pack(int in, int out, struct remote *remote, int nr_refspec, char **refspec)
+static int send_pack(int in, int out, struct remote *remote, int nr_refspec, const char **refspec)
 {
 	struct ref *ref;
 	int new_refs;
@@ -339,7 +339,7 @@ static int send_pack(int in, int out, struct remote *remote, int nr_refspec, cha
 	return ret;
 }
 
-static void verify_remote_names(int nr_heads, char **heads)
+static void verify_remote_names(int nr_heads, const char **heads)
 {
 	int i;
 
@@ -364,7 +364,7 @@ int main(int argc, char **argv)
 {
 	int i, nr_heads = 0;
 	char *dest = NULL;
-	char **heads = NULL;
+	const char **heads = NULL;
 	int fd[2], ret;
 	pid_t pid;
 	char *remote_name = NULL;
@@ -416,7 +416,7 @@ int main(int argc, char **argv)
 			dest = arg;
 			continue;
 		}
-		heads = argv;
+		heads = (const char **) argv;
 		nr_heads = argc - i;
 		break;
 	}
diff --git a/transport.c b/transport.c
index 400af71..89b73dc 100644
--- a/transport.c
+++ b/transport.c
@@ -141,7 +141,7 @@ static void insert_packed_refs(const char *packed_refs, struct ref **list)
 	}
 }
 
-static struct ref *get_refs_via_rsync(const struct transport *transport)
+static struct ref *get_refs_via_rsync(struct transport *transport)
 {
 	struct strbuf buf = STRBUF_INIT, temp_dir = STRBUF_INIT;
 	struct ref dummy, *tail = &dummy;
@@ -427,7 +427,7 @@ static int missing__target(int code, int result)
 
 #define missing_target(a) missing__target((a)->http_code, (a)->curl_result)
 
-static struct ref *get_refs_via_curl(const struct transport *transport)
+static struct ref *get_refs_via_curl(struct transport *transport)
 {
 	struct buffer buffer;
 	char *data, *start, *mid;
@@ -524,7 +524,7 @@ struct bundle_transport_data {
 	struct bundle_header header;
 };
 
-static struct ref *get_refs_from_bundle(const struct transport *transport)
+static struct ref *get_refs_from_bundle(struct transport *transport)
 {
 	struct bundle_transport_data *data = transport->data;
 	struct ref *result = NULL;
@@ -596,7 +596,7 @@ static int set_git_option(struct transport *connection,
 	return 1;
 }
 
-static struct ref *get_refs_via_connect(const struct transport *transport)
+static struct ref *get_refs_via_connect(struct transport *transport)
 {
 	struct git_transport_data *data = transport->data;
 	struct ref *refs;
@@ -786,7 +786,7 @@ int transport_push(struct transport *transport,
 	return transport->push(transport, refspec_nr, refspec, flags);
 }
 
-struct ref *transport_get_remote_refs(struct transport *transport)
+const struct ref *transport_get_remote_refs(struct transport *transport)
 {
 	if (!transport->remote_refs)
 		transport->remote_refs = transport->get_refs_list(transport);
diff --git a/transport.h b/transport.h
index df12ea7..d27f562 100644
--- a/transport.h
+++ b/transport.h
@@ -8,7 +8,7 @@ struct transport {
 	struct remote *remote;
 	const char *url;
 	void *data;
-	struct ref *remote_refs;
+	const struct ref *remote_refs;
 
 	/**
 	 * Returns 0 if successful, positive if the option is not
@@ -18,7 +18,7 @@ struct transport {
 	int (*set_option)(struct transport *connection, const char *name,
 			  const char *value);
 
-	struct ref *(*get_refs_list)(const struct transport *transport);
+	struct ref *(*get_refs_list)(struct transport *transport);
 	int (*fetch)(struct transport *transport, int refs_nr, struct ref **refs);
 	int (*push)(struct transport *connection, int refspec_nr, const char **refspec, int flags);
 
@@ -61,7 +61,7 @@ int transport_set_option(struct transport *transport, const char *name,
 int transport_push(struct transport *connection,
 		   int refspec_nr, const char **refspec, int flags);
 
-struct ref *transport_get_remote_refs(struct transport *transport);
+const struct ref *transport_get_remote_refs(struct transport *transport);
 
 int transport_fetch_refs(struct transport *transport, struct ref *refs);
 void transport_unlock_pack(struct transport *transport);
-- 
1.5.3.4.1206.g5f96
