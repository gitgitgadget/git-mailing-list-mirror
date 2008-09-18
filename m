From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH] extend meaning of "--root" option to index comparisons
Date: Thu, 18 Sep 2008 05:21:52 -0400
Message-ID: <20080918092152.GA18732@coredump.intra.peff.net>
References: <3665a1a00809151301p7d8e6387g3cacfb879b45da2f@mail.gmail.com> <48CECA42.1050209@drmicha.warpmail.net> <bd6139dc0809151411p49f5adeaq4beff452574ca980@mail.gmail.com> <20080915223442.GD20677@sigill.intra.peff.net> <bd6139dc0809152319m31a79877h5dc1b701a8210802@mail.gmail.com> <20080916062105.GA12708@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Thu Sep 18 11:23:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgFj6-0002Mc-De
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 11:23:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753736AbYIRJV4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 05:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753892AbYIRJV4
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 05:21:56 -0400
Received: from peff.net ([208.65.91.99]:1258 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753701AbYIRJVz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 05:21:55 -0400
Received: (qmail 7729 invoked by uid 111); 18 Sep 2008 09:21:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 18 Sep 2008 05:21:54 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Sep 2008 05:21:52 -0400
Content-Disposition: inline
In-Reply-To: <20080916062105.GA12708@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96187>

The "--root" option generally means "treat any commits
without parents as a big creation event". This extends the
meaning to make an index comparison against a non-existant
HEAD into a big creation event. In other words, "if this
index _were_ to become a commit, this is how we would show
it with --root."

Specifically, we cover the case of

  git diff --cached --root

to show either the diff between the index and HEAD, or if
there is no HEAD, show the diff against the empty tree.
This can simplify calling scripts which must otherwise
special-case the initial commit when showing the index
status.

We intentionally don't cover:

  - git diff --cached --root HEAD

    The user has specifically asked for HEAD, which doesn't
    exist.

  - git diff-index

    The user is required to specify a tree-ish to
    diff-index; if that tree-ish doesn't exist, we should
    report an error.

Signed-off-by: Jeff King <peff@peff.net>
---
On Tue, Sep 16, 2008 at 02:21:05AM -0400, Jeff King wrote:

> Right, that was what I meant by "incomplete". I think there are several
> other cases where giving "--root" would have expected behavior but is
> currently ignored. I'll take a closer look, but I probably won't have
> time for a few days.

Actually, I wasn't able to find any more cases. I don't think it makes
sense to override the behavior when an explicit tree-ish is given, so
that cuts out the two places mentioned above. Though I think
that scripts using this might prefer the plumbing
diff-index, so maybe there is a better way to support this
(e.g., if --root is specified without a tree-ish, assume
HEAD or empty tree).

diff-tree already handles --root itself. And there is no way to my
knowledge to provoke the same kind of "show the diff against its parent"
behavior via git-diff, since a single tree-ish there means "diff against
the working tree".

And of course for diff-files, such an option makes no sense.

Can you think of any other cases?

 builtin-diff.c       |    7 +++++--
 revision.c           |   17 ++++++++++++++---
 revision.h           |    1 +
 t/t4030-diff-root.sh |   21 +++++++++++++++++++++
 4 files changed, 41 insertions(+), 5 deletions(-)
 create mode 100755 t/t4030-diff-root.sh

diff --git a/builtin-diff.c b/builtin-diff.c
index 037c303..0a1efb5 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -315,8 +315,11 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 				break;
 			else if (!strcmp(arg, "--cached")) {
 				add_head_to_pending(&rev);
-				if (!rev.pending.nr)
-					die("No HEAD commit to compare with (yet)");
+				if (!rev.pending.nr) {
+					if (!rev.show_root_diff)
+						die("No HEAD commit to compare with (yet)");
+					add_empty_to_pending(&rev);
+				}
 				break;
 			}
 		}
diff --git a/revision.c b/revision.c
index 499f0e0..de0fd89 100644
--- a/revision.c
+++ b/revision.c
@@ -145,16 +145,27 @@ void add_pending_object(struct rev_info *revs, struct object *obj, const char *n
 	add_pending_object_with_mode(revs, obj, name, S_IFINVALID);
 }
 
-void add_head_to_pending(struct rev_info *revs)
+static void add_to_pending_by_name(struct rev_info *revs, const char *name)
 {
 	unsigned char sha1[20];
 	struct object *obj;
-	if (get_sha1("HEAD", sha1))
+	if (get_sha1(name, sha1))
 		return;
 	obj = parse_object(sha1);
 	if (!obj)
 		return;
-	add_pending_object(revs, obj, "HEAD");
+	add_pending_object(revs, obj, name);
+}
+
+void add_head_to_pending(struct rev_info *revs)
+{
+	add_to_pending_by_name(revs, "HEAD");
+}
+
+void add_empty_to_pending(struct rev_info *revs)
+{
+	add_to_pending_by_name(revs,
+			"4b825dc642cb6eb9a060e54bf8d69288fbee4904");
 }
 
 static struct object *get_reference(struct rev_info *revs, const char *name, const unsigned char *sha1, unsigned int flags)
diff --git a/revision.h b/revision.h
index fc23522..108f43d 100644
--- a/revision.h
+++ b/revision.h
@@ -151,6 +151,7 @@ extern void add_object(struct object *obj,
 extern void add_pending_object(struct rev_info *revs, struct object *obj, const char *name);
 
 extern void add_head_to_pending(struct rev_info *);
+extern void add_empty_to_pending(struct rev_info *);
 
 enum commit_action {
 	commit_ignore,
diff --git a/t/t4030-diff-root.sh b/t/t4030-diff-root.sh
new file mode 100755
index 0000000..e5174b7
--- /dev/null
+++ b/t/t4030-diff-root.sh
@@ -0,0 +1,21 @@
+#!/bin/sh
+
+test_description='diff --root allows comparison between index and root'
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo content >file &&
+	git add file
+'
+
+test_expect_success 'diff --cached (without --root)' '
+	test_must_fail git diff --cached --name-only
+'
+
+test_expect_success 'diff --cached (with --root)' '
+	echo file >expect &&
+	git diff --cached --name-only --root >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
1.6.0.2.249.g97d7f.dirty
