From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 2/2] match_refs: search ref list tail internally
Date: Wed, 27 May 2009 22:13:44 +0200
Message-ID: <1243455224-3463-2-git-send-email-drizzd@aon.at>
References: <76718490905260727v7261391uab169167978e4522@mail.gmail.com>
 <1243455224-3463-1-git-send-email-drizzd@aon.at>
Cc: Erik Faye-Lund <kusmabite@googlemail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 27 22:14:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9PW8-00041L-QB
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 22:14:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761582AbZE0UN4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 16:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbZE0UNz
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 16:13:55 -0400
Received: from postman.fh-hagenberg.at ([193.170.124.96]:50731 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763310AbZE0UNv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 16:13:51 -0400
Received: from darc.dnsalias.org ([84.154.120.211]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 27 May 2009 22:13:47 +0200
Received: from drizzd by darc.dnsalias.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1M9PVX-0000yA-Gn; Wed, 27 May 2009 22:13:51 +0200
X-Mailer: git-send-email 1.6.3.1.147.g637c3
In-Reply-To: <1243455224-3463-1-git-send-email-drizzd@aon.at>
X-OriginalArrivalTime: 27 May 2009 20:13:48.0441 (UTC) FILETIME=[A518F090:01C9DF07]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120102>

Avoid code duplication by moving list tail search to match_refs().

This does not change the semantics, not even for http-push. The NULL
test for remote_tail was redundant.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

On Tue, May 26, 2009 at 10:27:15AM -0400, Jay Soffian wrote:
> On Mon, May 25, 2009 at 3:01 PM, Clemens Buchacher <drizzd@aon.at> wrote:
> > I simply copied this from other uses of match_refs. I wonder if this calls
> > for a find_link_ref_tail() function, but I didn't know where to put it.
>-
> Since the primary use case is in combination with match_refs(),
> remote.[ch] perhaps.

Fair enough. Here it goes.

 builtin-remote.c    |    7 ++-----
 builtin-send-pack.c |    9 ++-------
 http-push.c         |    4 +---
 remote.c            |   17 +++++++++++++----
 remote.h            |    2 +-
 transport.c         |    6 +-----
 6 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index fda9a54..9248e0a 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -294,17 +294,14 @@ static int get_push_ref_states(const struct ref *remote_refs,
 	struct ref_states *states)
 {
 	struct remote *remote = states->remote;
-	struct ref *ref, *local_refs, *push_map, **push_tail;
+	struct ref *ref, *local_refs, *push_map;
 	if (remote->mirror)
 		return 0;
 
 	local_refs = get_local_heads();
 	push_map = copy_ref_list(remote_refs);
 
-	push_tail = &push_map;
-	while (*push_tail)
-		push_tail = &((*push_tail)->next);
-	match_refs(local_refs, push_map, &push_tail, remote->push_refspec_nr,
+	match_refs(local_refs, &push_map, remote->push_refspec_nr,
 		   remote->push_refspec, MATCH_REFS_NONE);
 
 	states->push.strdup_strings = 1;
diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index be3b092..c375a3d 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -473,7 +473,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 	int fd[2];
 	struct child_process *conn;
 	struct extra_have_objects extra_have;
-	struct ref *remote_refs, **remote_tail, *local_refs;
+	struct ref *remote_refs, *local_refs;
 	int ret;
 	int send_all = 0;
 	const char *receivepack = "git-receive-pack";
@@ -567,13 +567,8 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 		flags |= MATCH_REFS_MIRROR;
 
 	/* match them up */
-	remote_tail = &remote_refs;
-	while (*remote_tail)
-		remote_tail = &((*remote_tail)->next);
-	if (match_refs(local_refs, remote_refs, &remote_tail,
-		       nr_refspecs, refspecs, flags)) {
+	if (match_refs(local_refs, &remote_refs, nr_refspecs, refspecs, flags))
 		return -1;
-	}
 
 	ret = send_pack(&args, fd, conn, remote_refs, &extra_have);
 
diff --git a/http-push.c b/http-push.c
index dac2c6e..02f1ff5 100644
--- a/http-push.c
+++ b/http-push.c
@@ -2310,9 +2310,7 @@ int main(int argc, char **argv)
 	}
 
 	/* match them up */
-	if (!remote_tail)
-		remote_tail = &remote_refs;
-	if (match_refs(local_refs, remote_refs, &remote_tail,
+	if (match_refs(local_refs, &remote_refs,
 		       nr_refspec, (const char **) refspec, push_all)) {
 		rc = -1;
 		goto cleanup;
diff --git a/remote.c b/remote.c
index 2c3e905..f3c4b99 100644
--- a/remote.c
+++ b/remote.c
@@ -1085,12 +1085,20 @@ static const struct refspec *check_pattern_match(const struct refspec *rs,
 		return NULL;
 }
 
+static struct ref** tail_ref(struct ref** head)
+{
+	struct ref **tail = head;
+	while (*tail)
+		tail = &((*tail)->next);
+	return tail;
+}
+
 /*
  * Note. This is used only by "push"; refspec matching rules for
  * push and fetch are subtly different, so do not try to reuse it
  * without thinking.
  */
-int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
+int match_refs(struct ref *src, struct ref **dst,
 	       int nr_refspec, const char **refspec, int flags)
 {
 	struct refspec *rs;
@@ -1098,13 +1106,14 @@ int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
 	int send_mirror = flags & MATCH_REFS_MIRROR;
 	int errs;
 	static const char *default_refspec[] = { ":", 0 };
+	struct ref **dst_tail = tail_ref(dst);
 
 	if (!nr_refspec) {
 		nr_refspec = 1;
 		refspec = default_refspec;
 	}
 	rs = parse_push_refspec(nr_refspec, (const char **) refspec);
-	errs = match_explicit_refs(src, dst, dst_tail, rs, nr_refspec);
+	errs = match_explicit_refs(src, *dst, &dst_tail, rs, nr_refspec);
 
 	/* pick the remainder */
 	for ( ; src; src = src->next) {
@@ -1134,7 +1143,7 @@ int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
 						     dst_side, &dst_name))
 				die("Didn't think it matches any more");
 		}
-		dst_peer = find_ref_by_name(dst, dst_name);
+		dst_peer = find_ref_by_name(*dst, dst_name);
 		if (dst_peer) {
 			if (dst_peer->peer_ref)
 				/* We're already sending something to this ref. */
@@ -1150,7 +1159,7 @@ int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
 				goto free_name;
 
 			/* Create a new one and link it */
-			dst_peer = make_linked_ref(dst_name, dst_tail);
+			dst_peer = make_linked_ref(dst_name, &dst_tail);
 			hashcpy(dst_peer->new_sha1, src->new_sha1);
 		}
 		dst_peer->peer_ref = copy_ref(src);
diff --git a/remote.h b/remote.h
index 99706a8..257a555 100644
--- a/remote.h
+++ b/remote.h
@@ -85,7 +85,7 @@ void ref_remove_duplicates(struct ref *ref_map);
 int valid_fetch_refspec(const char *refspec);
 struct refspec *parse_fetch_refspec(int nr_refspec, const char **refspec);
 
-int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
+int match_refs(struct ref *src, struct ref **dst,
 	       int nr_refspec, const char **refspec, int all);
 
 /*
diff --git a/transport.c b/transport.c
index 17891d5..d8a2392 100644
--- a/transport.c
+++ b/transport.c
@@ -1003,7 +1003,6 @@ int transport_push(struct transport *transport,
 	if (transport->push_refs) {
 		struct ref *remote_refs =
 			transport->get_refs_list(transport, 1);
-		struct ref **remote_tail;
 		struct ref *local_refs = get_local_heads();
 		int match_flags = MATCH_REFS_NONE;
 		int verbose = flags & TRANSPORT_PUSH_VERBOSE;
@@ -1014,10 +1013,7 @@ int transport_push(struct transport *transport,
 		if (flags & TRANSPORT_PUSH_MIRROR)
 			match_flags |= MATCH_REFS_MIRROR;
 
-		remote_tail = &remote_refs;
-		while (*remote_tail)
-			remote_tail = &((*remote_tail)->next);
-		if (match_refs(local_refs, remote_refs, &remote_tail,
+		if (match_refs(local_refs, &remote_refs,
 			       refspec_nr, refspec, match_flags)) {
 			return -1;
 		}
-- 
1.6.3.1.147.g637c3
