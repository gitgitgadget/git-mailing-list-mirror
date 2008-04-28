From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH 1/7] add special "matching refs" refspec
Date: Mon, 28 Apr 2008 11:32:12 -0400
Message-ID: <af57d23aca6137c1ae7702027ce3742433840872.1209391614.git.bonzini@gnu.org>
References: <4812DA50.3000702@gnu.org>
 <cover.1209391614.git.bonzini@gnu.org>
Cc: spearce@spearce.org, gitster@pobox.com, peff@peff.net,
	johannes.schindelin@gmx.de, srb@cuci.nl
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 17:35:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqVMl-0004Kp-1e
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 17:34:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935695AbYD1Pcs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 11:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935731AbYD1Pcq
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 11:32:46 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:60624 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935572AbYD1Pcg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 11:32:36 -0400
Received: from bonzini by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <bonzini@gnu.org>)
	id 1JqVL0-0004f5-CD; Mon, 28 Apr 2008 11:32:18 -0400
X-Mailer: git-send-email 1.5.5.1.89.g36c79d
In-Reply-To: <cover.1209391614.git.bonzini@gnu.org>
In-Reply-To: <cover.1209391614.git.bonzini@gnu.org>
References: <cover.1209391614.git.bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80545>

This patch provides a way to specify "push matching heads" using a
special refspec ":".  This is used in the following patches to
remove some of the magic behind "origin", but can also be useful
independent of those patches, because it allows "push = +:" as a way
to specify that matching refs will be pushed but, in addition,
forced updates will be allowed.

Allowing +: goes in the direction of setting per-remote "git push"
options in the configuration.  Previously, it was not possible to force
updates *and* keep the default behavior of only pushing matching refs.

Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
---
 Documentation/git-push.txt |   13 ++++---
 builtin-send-pack.c        |   10 +++++-
 remote.c                   |   80 +++++++++++++++++++++++++++++---------------
 remote.h                   |    1 +
 t/t5511-refspec.sh         |    5 ++-
 t/t5516-fetch-push.sh      |   41 ++++++++++++++++++++++
 6 files changed, 115 insertions(+), 35 deletions(-)

	The new code for match_refs, which does not have to distinguish
	whether pat is NULL or not, is much more readable IMHO.
	Unfortunately, diff makes a mess out of it.

	Enabling more "git push" options to be set in the configuration
	was suggested by Dscho, and is particularly useful if "git push"
	is to work on more than one repository (as is the case at the
	end of this series).

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index f06d94e..0cc44d7 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -46,12 +46,6 @@ specified, the same ref that <src> referred to locally).  If
 the optional leading plus `+` is used, the remote ref is updated
 even if it does not result in a fast forward update.
 +
-Note: If no explicit refspec is found, (that is neither
-on the command line nor in any Push line of the
-corresponding remotes file---see below), then "matching" heads are
-pushed: for every head that exists on the local side, the remote side is
-updated if a head of the same name already exists on the remote side.
-+
 `tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`.
 +
 A parameter <ref> without a colon pushes the <ref> from the source
@@ -59,6 +53,13 @@ repository to the destination repository under the same name.
 +
 Pushing an empty <src> allows you to delete the <dst> ref from
 the remote repository.
++
+The special refspec `:` (or `+:` to allow non-fast forward updates)
+directs git to push "matching" heads: for every head that exists on
+the local side, the remote side is updated if a head of the same name
+already exists on the remote side.  This is the default operation mode
+if no explicit refspec is found (that is neither on the command line
+nor in any Push line of the corresponding remotes file---see below).
 
 \--all::
 	Instead of naming each ref to push, specifies that all
diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 7f7bddf..8d1e7be 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -642,9 +642,17 @@ static void verify_remote_names(int nr_heads, const char **heads)
 	int i;
 
 	for (i = 0; i < nr_heads; i++) {
+		const char *local = heads[i];
 		const char *remote = strrchr(heads[i], ':');
 
-		remote = remote ? (remote + 1) : heads[i];
+		if (*local == '+')
+			local++;
+
+		/* A matching refspec is okay.  */
+		if (remote == local && remote[1] == '\0')
+			continue;
+
+		remote = remote ? (remote + 1) : local;
 		switch (check_ref_format(remote)) {
 		case 0: /* ok */
 		case CHECK_REF_FORMAT_ONELEVEL:
diff --git a/remote.c b/remote.c
index 870d224..386213e 100644
--- a/remote.c
+++ b/remote.c
@@ -434,6 +434,14 @@ static struct refspec *parse_refspec_internal(int nr_refspec, const char **refsp
 		}
 
 		rhs = strrchr(lhs, ':');
+
+		/* Before going on, special case ":" (or "+:") as a refspec
+		   for matching refs.  */
+		if (!fetch && rhs == lhs && rhs[1] == '\0') {
+			rs[i].matching = 1;
+			continue;
+		}
+
 		if (rhs) {
 			rhs++;
 			rlen = strlen(rhs);
@@ -847,7 +855,7 @@ static int match_explicit(struct ref *src, struct ref *dst,
 	const char *dst_value = rs->dst;
 	char *dst_guess;
 
-	if (rs->pattern)
+	if (rs->pattern || rs->matching)
 		return errs;
 
 	matched_src = matched_dst = NULL;
@@ -937,13 +945,23 @@ static const struct refspec *check_pattern_match(const struct refspec *rs,
 						 const struct ref *src)
 {
 	int i;
+	int matching_refs = -1;
 	for (i = 0; i < rs_nr; i++) {
+		if (rs[i].matching &&
+		    (matching_refs == -1 || rs[i].force)) {
+			matching_refs = i;
+			continue;
+		}
+
 		if (rs[i].pattern &&
 		    !prefixcmp(src->name, rs[i].src) &&
 		    src->name[strlen(rs[i].src)] == '/')
 			return rs + i;
 	}
-	return NULL;
+	if (matching_refs != -1)
+		return rs + matching_refs;
+	else
+		return NULL;
 }
 
 /*
@@ -954,11 +972,17 @@ static const struct refspec *check_pattern_match(const struct refspec *rs,
 int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
 	       int nr_refspec, const char **refspec, int flags)
 {
-	struct refspec *rs =
-		parse_push_refspec(nr_refspec, (const char **) refspec);
+	struct refspec *rs;
 	int send_all = flags & MATCH_REFS_ALL;
 	int send_mirror = flags & MATCH_REFS_MIRROR;
 
+	static const char *default_refspec[] = { ":", 0 };
+	if (!nr_refspec) {
+		nr_refspec = 1;
+		refspec = default_refspec;
+	}
+
+	rs = parse_push_refspec(nr_refspec, (const char **) refspec);
 	if (match_explicit_refs(src, dst, dst_tail, rs, nr_refspec))
 		return -1;
 
@@ -969,48 +993,50 @@ int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
 		char *dst_name;
 		if (src->peer_ref)
 			continue;
-		if (nr_refspec) {
-			pat = check_pattern_match(rs, nr_refspec, src);
-			if (!pat)
-				continue;
-		}
-		else if (!send_mirror && prefixcmp(src->name, "refs/heads/"))
+
+		pat = check_pattern_match(rs, nr_refspec, src);
+		if (!pat)
+			continue;
+
+		if (pat->matching) {
 			/*
 			 * "matching refs"; traditionally we pushed everything
 			 * including refs outside refs/heads/ hierarchy, but
 			 * that does not make much sense these days.
 			 */
-			continue;
+			if (!send_mirror && prefixcmp(src->name, "refs/heads/"))
+				continue;
+			dst_name = xstrdup(src->name);
 
-		if (pat) {
+		} else {
 			const char *dst_side = pat->dst ? pat->dst : pat->src;
 			dst_name = xmalloc(strlen(dst_side) +
 					   strlen(src->name) -
 					   strlen(pat->src) + 2);
 			strcpy(dst_name, dst_side);
 			strcat(dst_name, src->name + strlen(pat->src));
-		} else
-			dst_name = xstrdup(src->name);
+		}
 		dst_peer = find_ref_by_name(dst, dst_name);
-		if (dst_peer && dst_peer->peer_ref)
-			/* We're already sending something to this ref. */
-			goto free_name;
+		if (dst_peer) {
+			if (dst_peer->peer_ref)
+				/* We're already sending something to this ref. */
+				goto free_name;
+
+		} else {
+			if (pat->matching && !(send_all || send_mirror))
+				/*
+				 * Remote doesn't have it, and we have no
+				 * explicit pattern, and we don't have
+				 * --all nor --mirror.
+				 */
+				goto free_name;
 
-		if (!dst_peer && !nr_refspec && !(send_all || send_mirror))
-			/*
-			 * Remote doesn't have it, and we have no
-			 * explicit pattern, and we don't have
-			 * --all nor --mirror.
-			 */
-			goto free_name;
-		if (!dst_peer) {
 			/* Create a new one and link it */
 			dst_peer = make_linked_ref(dst_name, dst_tail);
 			hashcpy(dst_peer->new_sha1, src->new_sha1);
 		}
 		dst_peer->peer_ref = src;
-		if (pat)
-			dst_peer->force = pat->force;
+		dst_peer->force = pat->force;
 	free_name:
 		free(dst_name);
 	}
diff --git a/remote.h b/remote.h
index 6878c52..5b0a2b4 100644
--- a/remote.h
+++ b/remote.h
@@ -47,6 +47,7 @@ int remote_has_url(struct remote *remote, const char *url);
 struct refspec {
 	unsigned force : 1;
 	unsigned pattern : 1;
+	unsigned matching : 1;
 
 	char *src;
 	char *dst;
diff --git a/t/t5511-refspec.sh b/t/t5511-refspec.sh
index 670a8f1..22ba380 100755
--- a/t/t5511-refspec.sh
+++ b/t/t5511-refspec.sh
@@ -23,10 +23,13 @@ test_refspec () {
 }
 
 test_refspec push ''						invalid
-test_refspec push ':'						invalid
+test_refspec push ':'
+test_refspec push '::'						invalid
+test_refspec push '+:'
 
 test_refspec fetch ''
 test_refspec fetch ':'
+test_refspec fetch '::'						invalid
 
 test_refspec push 'refs/heads/*:refs/remotes/frotz/*'
 test_refspec push 'refs/heads/*:refs/remotes/frotz'		invalid
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 0a757d5..53e47e1 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -165,6 +165,47 @@ test_expect_success 'push with matching heads' '
 
 '
 
+test_expect_success 'push with matching heads on the command line' '
+
+	mk_test heads/master &&
+	git push testrepo : &&
+	check_push_result $the_commit heads/master
+
+'
+
+test_expect_success 'failed (non-fast-forward) push with matching heads' '
+
+	mk_test heads/master &&
+	git push testrepo : &&
+	git commit --amend -massaged &&
+	! git push testrepo &&
+	check_push_result $the_commit heads/master &&
+	git reset --hard $the_commit
+
+'
+
+test_expect_success 'push --force with matching heads' '
+
+	mk_test heads/master &&
+	git push testrepo : &&
+	git commit --amend -massaged &&
+	git push --force testrepo &&
+	! check_push_result $the_commit heads/master &&
+	git reset --hard $the_commit
+
+'
+
+test_expect_success 'push with matching heads and forced update' '
+
+	mk_test heads/master &&
+	git push testrepo : &&
+	git commit --amend -massaged &&
+	git push testrepo +: &&
+	! check_push_result $the_commit heads/master &&
+	git reset --hard $the_commit
+
+'
+
 test_expect_success 'push with no ambiguity (1)' '
 
 	mk_test heads/master &&
-- 
1.5.5
