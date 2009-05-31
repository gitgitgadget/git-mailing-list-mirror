From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH v2] match_refs: search ref list tail internally
Date: Sun, 31 May 2009 16:26:48 +0200
Message-ID: <20090531142648.GA25946@localhost>
References: <76718490905260727v7261391uab169167978e4522@mail.gmail.com> <1243455224-3463-1-git-send-email-drizzd@aon.at> <1243455224-3463-2-git-send-email-drizzd@aon.at> <7vtz35hfk7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@googlemail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Tay Ray Chuan <rctay89@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 31 16:27:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAm0M-00021a-SJ
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 16:27:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755264AbZEaO1J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2009 10:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753472AbZEaO1I
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 10:27:08 -0400
Received: from postman.fh-hagenberg.at ([193.170.124.96]:39954 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752507AbZEaO1H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2009 10:27:07 -0400
Received: from darc.dnsalias.org ([80.123.242.182]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 31 May 2009 16:27:07 +0200
Received: from drizzd by darc.dnsalias.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1MAlzs-0007Ew-Ml; Sun, 31 May 2009 16:26:48 +0200
Content-Disposition: inline
In-Reply-To: <7vtz35hfk7.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 31 May 2009 14:27:07.0275 (UTC) FILETIME=[E049E5B0:01C9E1FB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120401>

Avoid code duplication by moving list tail search to match_refs().

This does not change the semantics, except for http-push, which now inserts
to the front of the ref list in order to get rid of the global remote_tail.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

On Thu, May 28, 2009 at 12:06:32AM -0700, Junio C Hamano wrote:
> Clemens Buchacher <drizzd@aon.at> writes:
> > Avoid code duplication by moving list tail search to match_refs().
> >
> > This does not change the semantics, not even for http-push. The NULL
> > test for remote_tail was redundant.
[...]
> Other parts of this patch removes the local "remote_tail" variables, and
> it is very clear that they do not have this problem; any third-parth patch
> will break if they used remote_tail after match_refs() returned, so this
> change is a safe one for them.

Alright, so here's the version which removes remote_tail.

> I wonder what interaction this change will have with the http-push
> clean-up Ray Chuan has been working on...

I did test on rctay's http-fix-push-fetching branch in
git://github.com/rctay/git.git with the most recent fixes.

I also squashed in your style fixes from the version currently in pu.
Thanks.

Clemens

 builtin-remote.c    |    7 ++-----
 builtin-send-pack.c |    9 ++-------
 http-push.c         |   11 ++++-------
 remote.c            |   17 +++++++++++++----
 remote.h            |    2 +-
 transport.c         |    6 +-----
 6 files changed, 23 insertions(+), 29 deletions(-)

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
index 10f64e3..c44cedd 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1850,7 +1850,7 @@ static int update_remote(unsigned char *sha1, struct remote_lock *lock)
 	return 1;
 }
 
-static struct ref *remote_refs, **remote_tail;
+static struct ref *remote_refs;
 
 static void one_remote_ref(char *refname)
 {
@@ -1880,13 +1880,12 @@ static void one_remote_ref(char *refname)
 		}
 	}
 
-	*remote_tail = ref;
-	remote_tail = &ref->next;
+	ref->next = remote_refs;
+	remote_refs = ref;
 }
 
 static void get_dav_remote_heads(void)
 {
-	remote_tail = &remote_refs;
 	remote_ls("refs/", (PROCESS_FILES | PROCESS_DIRS | RECURSIVE), process_ls_ref, NULL);
 }
 
@@ -2341,9 +2340,7 @@ int main(int argc, char **argv)
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
index 2c3e905..08a5964 100644
--- a/remote.c
+++ b/remote.c
@@ -1085,12 +1085,20 @@ static const struct refspec *check_pattern_match(const struct refspec *rs,
 		return NULL;
 }
 
+static struct ref **tail_ref(struct ref **head)
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
