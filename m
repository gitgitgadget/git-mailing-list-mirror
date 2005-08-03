From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] (preview) Renaming push.
Date: Wed, 03 Aug 2005 16:25:02 -0700
Message-ID: <7vek9a8uy9.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0508030109210.21304@wgmdd8.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.58.0508030944210.3258@g5.osdl.org>
	<Pine.LNX.4.63.0508031849270.24318@wgmdd8.biozentrum.uni-wuerzburg.de>
	<200508031908.22562.Josef.Weidendorfer@gmx.de>
	<Pine.LNX.4.58.0508031102590.3258@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu Aug 04 01:30:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0Sfj-0002ng-93
	for gcvg-git@gmane.org; Thu, 04 Aug 2005 01:29:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbVHCX2g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Aug 2005 19:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbVHCX0Q
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Aug 2005 19:26:16 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:32748 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261619AbVHCXZG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2005 19:25:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050803232502.CYGQ1860.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 3 Aug 2005 19:25:02 -0400
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0508031102590.3258@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 3 Aug 2005 11:08:29 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> The real problem with git-send-pack is that the local and remote names 
> have to be the same, which is a bug, really. It _should_ be perfectly fine 
> to do something like
>
> 	git-send-pack ..dest.. localname:remotename
>
> which would push the local "localname" branch to the remote "remotename" 
> branch.

Yes, and that is what I have been cooking today ;-).

This patch is a preview, only because I have not converted the
pull side yet.  My limited testing shows that you can push refs
under different names fine with this patch.

The plan is to also let people say the renaming for pull side
like this.

        git-fetch-pack <remote> remotename:localname...

Note that remote/local is confusing when we consider both pull
and push sides, so we should call them srcname and dstname.  The
commit message uses these words.

-jc

------------
This allows git-send-pack to push local refs to a destination
repository under different names.

Here is the name mapping rules for refs.

* If there is no ref mapping on the command line:

 - if '--all' is specified, it is equivalent to specifying
   <local> ":" <local> for all the existing local refs on the
   command line
 - otherwise, it is equivalent to specifying <ref> ":" <ref> for
   all the refs that exist on both sides.

* <name> is just a shorthand for <name> ":" <name>

* <src> ":" <dst>

  push ref that matches <src> to ref that matches <dst>.

  - It is an error if <src> does not match exactly one of local
    refs.

  - It is an error if <dst> matches more than one remote refs.

  - If <dst> does not match any remote refs, either

    - it has to start with "refs/"; <dst> is used as the
      destination literally in this case.

    - <src> == <dst> and the ref that matched the <src> must not
      exist in the set of remote refs; the ref matched <src>
      locally is used as the name of the destination.

For example,

  - "git-send-pack --all <remote>" works exactly as before;

  - "git-send-pack <remote> master:upstream" pushes local master
    to remote ref that matches "upstream".  If there is no such
    ref, it is an error.

  - "git-send-pack <remote> master:refs/heads/upstream" pushes
    local master to remote refs/heads/upstream, even when
    refs/heads/upstream does not exist.

  - "git-send-pack <remote> master" into an empty remote
    repository pushes the local ref/heads/master to the remote
    ref/heads/master.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 cache.h     |    3 +
 connect.c   |  172 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 send-pack.c |  146 ++++++++++++++++++++------------------------------
 3 files changed, 230 insertions(+), 91 deletions(-)

b959d297c7206b0b634160ac015122f70389415b
diff --git a/cache.h b/cache.h
--- a/cache.h
+++ b/cache.h
@@ -298,12 +298,15 @@ struct ref {
 	struct ref *next;
 	unsigned char old_sha1[20];
 	unsigned char new_sha1[20];
+	struct ref *peer_ref; /* when renaming */
 	char name[0];
 };
 
 extern int git_connect(int fd[2], char *url, const char *prog);
 extern int finish_connect(pid_t pid);
 extern int path_match(const char *path, int nr, char **match);
+extern int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
+		      int nr_refspec, char **refspec, int all);
 extern int get_ack(int fd, unsigned char *result_sha1);
 extern struct ref **get_remote_heads(int in, struct ref **list, int nr_match, char **match);
 
diff --git a/connect.c b/connect.c
--- a/connect.c
+++ b/connect.c
@@ -31,11 +31,9 @@ struct ref **get_remote_heads(int in, st
 		name = buffer + 41;
 		if (nr_match && !path_match(name, nr_match, match))
 			continue;
-		ref = xmalloc(sizeof(*ref) + len - 40);
+		ref = xcalloc(1, sizeof(*ref) + len - 40);
 		memcpy(ref->old_sha1, old_sha1, 20);
-		memset(ref->new_sha1, 0, 20);
 		memcpy(ref->name, buffer + 41, len - 40);
-		ref->next = NULL;
 		*list = ref;
 		list = &ref->next;
 	}
@@ -81,6 +79,174 @@ int path_match(const char *path, int nr,
 	return 0;
 }
 
+struct refspec {
+	char *src;
+	char *dst;
+};
+
+static struct refspec *parse_ref_spec(int nr_refspec, char **refspec)
+{
+	int i;
+	struct refspec *rs = xmalloc(sizeof(*rs) * (nr_refspec + 1));
+	for (i = 0; i < nr_refspec; i++) {
+		char *sp, *dp, *ep;
+		sp = refspec[i];
+		ep = strchr(sp, ':');
+		if (ep) {
+			dp = ep + 1;
+			*ep = 0;
+		}
+		else
+			dp = sp;
+		rs[i].src = sp;
+		rs[i].dst = dp;
+	}
+	rs[nr_refspec].src = rs[nr_refspec].dst = NULL;
+	return rs;
+}
+
+static int count_refspec_match(const char *pattern,
+			       struct ref *refs,
+			       struct ref **matched_ref)
+{
+	int match;
+	int patlen = strlen(pattern);
+
+	for (match = 0; refs; refs = refs->next) {
+		char *name = refs->name;
+		int namelen = strlen(name);
+		if (namelen < patlen ||
+		    memcmp(name + namelen - patlen, pattern, patlen))
+			continue;
+		if (namelen != patlen && name[namelen - patlen - 1] != '/')
+			continue;
+		match++;
+		*matched_ref = refs;
+	}
+	return match;
+}
+
+static void link_dst_tail(struct ref *ref, struct ref ***tail)
+{
+	**tail = ref;
+	*tail = &ref->next;
+	**tail = NULL;
+}
+
+static int match_explicit_refs(struct ref *src, struct ref *dst,
+			       struct ref ***dst_tail, struct refspec *rs)
+{
+	int i, errs;
+	for (i = errs = 0; rs[i].src; i++) {
+		struct ref *matched_src, *matched_dst;
+
+		matched_src = matched_dst = NULL;
+		switch (count_refspec_match(rs[i].src, src, &matched_src)) {
+		case 1:
+			break;
+		case 0:
+			errs = 1;
+			error("src refspec %s does not match any.");
+			break;
+		default:
+			errs = 1;
+			error("src refspec %s matches more than one.",
+			      rs[i].src);
+			break;
+		}
+		switch (count_refspec_match(rs[i].dst, dst, &matched_dst)) {
+		case 1:
+			break;
+		case 0:
+			if (!memcmp(rs[i].dst, "refs/", 5)) {
+				int len = strlen(rs[i].dst) + 1;
+				matched_dst = xcalloc(1, sizeof(*dst) + len);
+				memcpy(matched_dst->name, rs[i].dst, len);
+				link_dst_tail(matched_dst, dst_tail);
+			}
+			else if (!strcmp(rs[i].src, rs[i].dst) &&
+				 matched_src) {
+				/* pushing "master:master" when
+				 * remote does not have master yet.
+				 */
+				int len = strlen(matched_src->name);
+				matched_dst = xcalloc(1, sizeof(*dst) + len);
+				memcpy(matched_dst->name, matched_src->name,
+				       len);
+				link_dst_tail(matched_dst, dst_tail);
+			}
+			else {
+				errs = 1;
+				error("dst refspec %s does not match any "
+				      "existing ref on the remote and does "
+				      "not start with refs/.", rs[i].dst);
+			}
+			break;
+		default:
+			errs = 1;
+			error("dst refspec %s matches more than one.",
+			      rs[i].dst);
+			break;
+		}
+		if (errs)
+			continue;
+		if (matched_src->peer_ref) {
+			errs = 1;
+			error("src ref %s is sent to more than one dst.",
+			      matched_src->name);
+		}
+		else
+			matched_src->peer_ref = matched_dst;
+		if (matched_dst->peer_ref) {
+			errs = 1;
+			error("dst ref %s receives from more than one src.",
+			      matched_dst->name);
+		}
+		else
+			matched_dst->peer_ref = matched_src;
+	}
+	return -errs;
+}
+
+static struct ref *find_ref_by_name(struct ref *list, const char *name)
+{
+	for ( ; list; list = list->next)
+		if (!strcmp(list->name, name))
+			return list;
+	return NULL;
+}
+
+int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
+	       int nr_refspec, char **refspec, int all)
+{
+	struct refspec *rs = parse_ref_spec(nr_refspec, refspec);
+
+	if (nr_refspec)
+		return match_explicit_refs(src, dst, dst_tail, rs);
+
+	/* pick the remainder */
+	for ( ; src; src = src->next) {
+		struct ref *dst_peer;
+		if (src->peer_ref)
+			continue;
+		dst_peer = find_ref_by_name(dst, src->name);
+		if (dst_peer && dst_peer->peer_ref)
+			continue;
+		if (!dst_peer) {
+			if (!all)
+				continue;
+			/* Create a new one and link it */
+			int len = strlen(src->name) + 1;
+			dst_peer = xcalloc(1, sizeof(*dst_peer) + len);
+			memcpy(dst_peer->name, src->name, len);
+			memcpy(dst_peer->new_sha1, src->new_sha1, 20);
+			link_dst_tail(dst_peer, dst_tail);
+		}
+		dst_peer->peer_ref = src;
+	}
+	return 0;
+}
+
 enum protocol {
 	PROTO_LOCAL = 1,
 	PROTO_SSH,
diff --git a/send-pack.c b/send-pack.c
--- a/send-pack.c
+++ b/send-pack.c
@@ -43,7 +43,8 @@ static void exec_rev_list(struct ref *re
 		char *buf = malloc(100);
 		if (i > 900)
 			die("git-rev-list environment overflow");
-		if (!is_zero_sha1(refs->old_sha1)) {
+		if (!is_zero_sha1(refs->old_sha1) &&
+		    has_sha1_file(refs->old_sha1)) {
 			args[i++] = buf;
 			snprintf(buf, 50, "^%s", sha1_to_hex(refs->old_sha1));
 			buf += 50;
@@ -103,21 +104,6 @@ static int pack_objects(int fd, struct r
 	return 0;
 }
 
-static int read_ref(const char *ref, unsigned char *sha1)
-{
-	int fd, ret;
-	char buffer[60];
-
-	fd = open(git_path("%s", ref), O_RDONLY);
-	if (fd < 0)
-		return -1;
-	ret = -1;
-	if (read(fd, buffer, sizeof(buffer)) >= 40)
-		ret = get_sha1_hex(buffer, sha1);
-	close(fd);
-	return ret;
-}
-
 static int ref_newer(const unsigned char *new_sha1, const unsigned char *old_sha1)
 {
 	struct commit *new, *old;
@@ -143,108 +129,92 @@ static int ref_newer(const unsigned char
 	return 0;
 }
 
-static int local_ref_nr_match;
-static char **local_ref_match;
-static struct ref *local_ref_list;
-static struct ref **local_last_ref;
+static struct ref *local_refs, **local_tail;
+static struct ref *remote_refs, **remote_tail;
 
-static int try_to_match(const char *refname, const unsigned char *sha1)
+static int one_local_ref(const char *refname, const unsigned char *sha1)
 {
 	struct ref *ref;
-	int len;
-
-	if (!path_match(refname, local_ref_nr_match, local_ref_match)) {
-		if (!send_all)
-			return 0;
-
-		/* If we have it listed already, skip it */
-		for (ref = local_ref_list ; ref ; ref = ref->next) {
-			if (!strcmp(ref->name, refname))
-				return 0;
-		}
-	}
-
-	len = strlen(refname)+1;
-	ref = xmalloc(sizeof(*ref) + len);
-	memset(ref->old_sha1, 0, 20);
+	int len = strlen(refname) + 1;
+	ref = xcalloc(1, sizeof(*ref) + len);
 	memcpy(ref->new_sha1, sha1, 20);
 	memcpy(ref->name, refname, len);
-	ref->next = NULL;
-	*local_last_ref = ref;
-	local_last_ref = &ref->next;
+	*local_tail = ref;
+	local_tail = &ref->next;
 	return 0;
 }
 
-static int send_pack(int in, int out, int nr_match, char **match)
+static void get_local_heads(void)
+{
+	local_tail = &local_refs;
+	for_each_ref(one_local_ref);
+}
+
+static int send_pack(int in, int out, int nr_refspec, char **refspec)
 {
-	struct ref *ref_list, **last_ref;
 	struct ref *ref;
 	int new_refs;
 
-	/* First we get all heads, whether matching or not.. */
-	last_ref = get_remote_heads(in, &ref_list, 0, NULL);
-
+	/* No funny business with the matcher */
+	remote_tail = get_remote_heads(in, &remote_refs, 0, NULL);
+	get_local_heads();
+
+	/* match them up */
+	if (!remote_tail)
+		remote_tail = &remote_refs;
+	if (match_refs(local_refs, remote_refs, &remote_tail,
+		       nr_refspec, refspec, send_all))
+		return -1;
 	/*
-	 * Go through the refs, see if we want to update
-	 * any of them..
+	 * Finally, tell the other end!
 	 */
-	for (ref = ref_list; ref; ref = ref->next) {
-		unsigned char new_sha1[20];
-		char *name = ref->name;
-
-		if (nr_match && !path_match(name, nr_match, match))
-			continue;
-
-		if (read_ref(name, new_sha1) < 0)
-			continue;
-
-		if (!memcmp(ref->old_sha1, new_sha1, 20)) {
-			fprintf(stderr, "'%s' unchanged\n", name);
+	new_refs = 0;
+	for (ref = remote_refs; ref; ref = ref->next) {
+		char old_hex[60], *new_hex;
+		if (!ref->peer_ref)
 			continue;
+		if (!is_zero_sha1(ref->old_sha1)) {
+			if (!has_sha1_file(ref->old_sha1)) {
+				error("remote '%s' object %s does not "
+				      "exist on local",
+				      ref->name, sha1_to_hex(ref->old_sha1));
+				continue;
+			}
+			if (!ref_newer(ref->peer_ref->new_sha1,
+				       ref->old_sha1)) {
+				error("remote ref '%s' is not a strict "
+				      "subset of local ref '%s'.", ref->name,
+				      ref->peer_ref->name);
+				continue;
+			}
 		}
-
-		if (!ref_newer(new_sha1, ref->old_sha1)) {
-			error("remote '%s' isn't a strict parent of local", name);
+		if (!memcmp(ref->old_sha1, ref->peer_ref->new_sha1, 20)) {
+			fprintf(stderr, "'%s': up-to-date\n", ref->name);
 			continue;
 		}
-
-		/* Ok, mark it for update */
-		memcpy(ref->new_sha1, new_sha1, 20);
-	}
-
-	/*
-	 * See if we have any refs that the other end didn't have
-	 */
-	if (nr_match || send_all) {
-		local_ref_nr_match = nr_match;
-		local_ref_match = match;
-		local_ref_list = ref_list;
-		local_last_ref = last_ref;
-		for_each_ref(try_to_match);
-	}
-
-	/*
-	 * Finally, tell the other end!
-	 */
-	new_refs = 0;
-	for (ref = ref_list; ref; ref = ref->next) {
-		char old_hex[60], *new_hex;
-		if (is_zero_sha1(ref->new_sha1))
+		memcpy(ref->new_sha1, ref->peer_ref->new_sha1, 20);
+		if (is_zero_sha1(ref->new_sha1)) {
+			error("cannot happen anymore");
 			continue;
+		}
 		new_refs++;
 		strcpy(old_hex, sha1_to_hex(ref->old_sha1));
 		new_hex = sha1_to_hex(ref->new_sha1);
 		packet_write(out, "%s %s %s", old_hex, new_hex, ref->name);
-		fprintf(stderr, "'%s': updating from %s to %s\n", ref->name, old_hex, new_hex);
+		fprintf(stderr, "updating '%s'", ref->name);
+		if (strcmp(ref->name, ref->peer_ref->name))
+			fprintf(stderr, " using '%s'", ref->peer_ref->name);
+		fprintf(stderr, "\n  from %s\n  to   %s\n", old_hex, new_hex);
 	}
-	
+
 	packet_flush(out);
 	if (new_refs)
-		pack_objects(out, ref_list);
+		pack_objects(out, remote_refs);
 	close(out);
 	return 0;
 }
 
+
 int main(int argc, char **argv)
 {
 	int i, nr_heads = 0;
