From: Jeff King <peff@peff.net>
Subject: [PATCH 10/9] clone: leave repo in place after checkout errors
Date: Tue, 26 Mar 2013 18:22:09 -0400
Message-ID: <20130326222209.GA16457@sigill.intra.peff.net>
References: <20130325201427.GA15798@sigill.intra.peff.net>
 <20130325202359.GH16019@sigill.intra.peff.net>
 <7vtxnxsuty.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 26 23:22:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKcGQ-0008HM-Ir
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 23:22:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752267Ab3CZWWO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 18:22:14 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40789 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751625Ab3CZWWO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 18:22:14 -0400
Received: (qmail 9036 invoked by uid 107); 26 Mar 2013 22:24:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Mar 2013 18:24:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Mar 2013 18:22:09 -0400
Content-Disposition: inline
In-Reply-To: <7vtxnxsuty.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219223>

On Tue, Mar 26, 2013 at 02:40:57PM -0700, Junio C Hamano wrote:

> > I think the "leave the data behind" fix may be to just set "junk_pid =
> > 0" a little sooner in cmd_clone (i.e., before checkout()). Then we
> > would still die, but at least leave the fetched objects intact.
> 
> Yeah, perhaps, but I agree that is a much lower priority change.

As it turns out, the checkout() error path sometimes _already_ leaves
the repository intact, but it's due to a bug. And it ends up deleting
something random instead. :)

I agree it's not a high priority, but I think it makes sense while we're
in the area. And while it's very unlikely that the deletion would be
disastrous (see below), it makes me nervous. Patch is below.

-- >8 --
Subject: [PATCH] clone: leave repo in place after checkout errors

If we manage to clone a remote repository but run into an
error in the checkout, it is probably sane to leave the repo
directory in place. That lets the user examine the situation
without spending time to re-clone from the remote (which may
be a lengthy process).

Rather than try to convert each die() from the checkout code
path into an error(), we simply set a flag that tells the
"remove_junk" atexit function to print a helpful message and
leave the repo in place.

Note that the test added in this patch actually passes
without the code change. The reason is that the cleanup code
is buggy; we chdir into the working tree for the checkout,
but still may use relative paths to remove the directories
(which means if you cloned into "foo", we would accidentally
remove "foo" from the working tree!).  There's no point in
fixing it now, since this patch means we will never try to
remove anything after the chdir, anyway.

Signed-off-by: Jeff King <peff@peff.net>
---
I think the accidental deletion could also escape the repository if you
did something like:

  git clone $remote ../../foo

which would delete ../../foo/../../foo, or ../../../foo, which is not
related to what you just cloned. But I didn't test, and we don't have to
care anymore after this patch.

 builtin/clone.c              | 33 ++++++++++++++++++++++++++++++++-
 t/t1060-object-corruption.sh |  4 ++++
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index eceaa74..e145dfc 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -377,10 +377,40 @@ static void remove_junk(void)
 static const char *junk_work_tree;
 static const char *junk_git_dir;
 static pid_t junk_pid;
+enum {
+	JUNK_LEAVE_NONE,
+	JUNK_LEAVE_REPO,
+	JUNK_LEAVE_ALL
+} junk_mode = JUNK_LEAVE_NONE;
+
+static const char junk_leave_repo_msg[] =
+N_("The remote repository was cloned successfully, but there was\n"
+   "an error checking out the HEAD branch. The repository has been left in\n"
+   "place but the working tree may be in an inconsistent state. You can\n"
+   "can inspect the contents with:\n"
+   "\n"
+   "    git status\n"
+   "\n"
+   "and retry the checkout with\n"
+   "\n"
+   "    git checkout -f HEAD\n"
+   "\n");
 
 static void remove_junk(void)
 {
 	struct strbuf sb = STRBUF_INIT;
+
+	switch (junk_mode) {
+	case JUNK_LEAVE_REPO:
+		warning("%s", _(junk_leave_repo_msg));
+		/* fall-through */
+	case JUNK_LEAVE_ALL:
+		return;
+	default:
+		/* proceed to removal */
+		break;
+	}
+
 	if (getpid() != junk_pid)
 		return;
 	if (junk_git_dir) {
@@ -925,12 +955,13 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	transport_unlock_pack(transport);
 	transport_disconnect(transport);
 
+	junk_mode = JUNK_LEAVE_REPO;
 	err = checkout();
 
 	strbuf_release(&reflog_msg);
 	strbuf_release(&branch_top);
 	strbuf_release(&key);
 	strbuf_release(&value);
-	junk_pid = 0;
+	junk_mode = JUNK_LEAVE_ALL;
 	return err;
 }
diff --git a/t/t1060-object-corruption.sh b/t/t1060-object-corruption.sh
index a405b70..a84deb1 100755
--- a/t/t1060-object-corruption.sh
+++ b/t/t1060-object-corruption.sh
@@ -89,6 +89,10 @@ test_expect_success 'clone --local detects corruption' '
 	test_must_fail git clone --local bit-error corrupt-checkout
 '
 
+test_expect_success 'error detected during checkout leaves repo intact' '
+	test_path_is_dir corrupt-checkout/.git
+'
+
 test_expect_success 'clone --local detects missing objects' '
 	test_must_fail git clone --local missing missing-checkout
 '
-- 
1.8.2.13.g0f18d3c
