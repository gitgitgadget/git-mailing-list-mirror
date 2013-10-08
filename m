From: Jeff King <peff@peff.net>
Subject: [PATCH 2/5] assume parse_commit checks for NULL commit
Date: Tue, 8 Oct 2013 09:56:25 -0400
Message-ID: <20131008135625.GB7650@sigill.intra.peff.net>
References: <20131008134843.GA7530@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 09 18:37:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTwlf-0001zL-4h
	for gcvg-git-2@plane.gmane.org; Wed, 09 Oct 2013 18:37:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755004Ab3JIQhd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Oct 2013 12:37:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:46329 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754467Ab3JIQhQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Oct 2013 12:37:16 -0400
Received: (qmail 22465 invoked by uid 102); 8 Oct 2013 13:56:27 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 08 Oct 2013 08:56:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Oct 2013 09:56:25 -0400
Content-Disposition: inline
In-Reply-To: <20131008134843.GA7530@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235827>

The parse_commit function will check whether it was passed a
NULL commit pointer, and if so, return an error. There is no
need for callers to check this separately.

Signed-off-by: Jeff King <peff@peff.net>
---
There are a few cases left untouched, because they actually produce a
different result for the NULL case (e.g., printing a different error
message, as in read_tree_1).

Note also the case of:

  if (parent && parse_commit(parent) < 0)

in sequencer.c, which looks at first glance like it falls in this class,
but doesn't (it is specifically avoiding the NULL check and reporting an
error only when we actually have something to parse at all).

 builtin/branch.c | 2 +-
 builtin/commit.c | 4 ++--
 commit.c         | 2 +-
 notes-utils.c    | 2 +-
 sha1_name.c      | 2 --
 5 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index ad0f86d..491090f 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -496,7 +496,7 @@ static void add_verbose_info(struct strbuf *out, struct ref_item *item,
 	const char *sub = _(" **** invalid ref ****");
 	struct commit *commit = item->commit;
 
-	if (commit && !parse_commit(commit)) {
+	if (!parse_commit(commit)) {
 		pp_commit_easy(CMIT_FMT_ONELINE, commit, &subject);
 		sub = subject.buf;
 	}
diff --git a/builtin/commit.c b/builtin/commit.c
index 6ab4605..e89c519 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1338,7 +1338,7 @@ static void print_summary(const char *prefix, const unsigned char *sha1,
 	commit = lookup_commit(sha1);
 	if (!commit)
 		die(_("couldn't look up newly created commit"));
-	if (!commit || parse_commit(commit))
+	if (parse_commit(commit))
 		die(_("could not parse newly created commit"));
 
 	strbuf_addstr(&format, "format:%h] %s");
@@ -1525,7 +1525,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		current_head = NULL;
 	else {
 		current_head = lookup_commit_or_die(sha1, "HEAD");
-		if (!current_head || parse_commit(current_head))
+		if (parse_commit(current_head))
 			die(_("could not parse HEAD commit"));
 	}
 	argc = parse_and_validate_options(argc, argv, builtin_commit_options,
diff --git a/commit.c b/commit.c
index 51a9bbc..11509ff 100644
--- a/commit.c
+++ b/commit.c
@@ -79,7 +79,7 @@ struct commit *lookup_commit_reference_by_name(const char *name)
 	if (get_sha1_committish(name, sha1))
 		return NULL;
 	commit = lookup_commit_reference(sha1);
-	if (!commit || parse_commit(commit))
+	if (parse_commit(commit))
 		return NULL;
 	return commit;
 }
diff --git a/notes-utils.c b/notes-utils.c
index 9107c37..7bb3473 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -18,7 +18,7 @@ void create_notes_commit(struct notes_tree *t, struct commit_list *parents,
 		unsigned char parent_sha1[20];
 		if (!read_ref(t->ref, parent_sha1)) {
 			struct commit *parent = lookup_commit(parent_sha1);
-			if (!parent || parse_commit(parent))
+			if (parse_commit(parent))
 				die("Failed to find/parse commit %s", t->ref);
 			commit_list_insert(parent, &parents);
 		}
diff --git a/sha1_name.c b/sha1_name.c
index 0e5fe7f..1dfc401 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -582,8 +582,6 @@ static int get_parent(const char *name, int len,
 	if (ret)
 		return ret;
 	commit = lookup_commit_reference(sha1);
-	if (!commit)
-		return -1;
 	if (parse_commit(commit))
 		return -1;
 	if (!idx) {
-- 
1.8.4.1.4.gf327177
