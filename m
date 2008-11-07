From: Jeff King <peff@peff.net>
Subject: [PATCH 4/4] receive-pack: deny push to current branch of non-bare
	repo
Date: Fri, 7 Nov 2008 17:28:30 -0500
Message-ID: <20081107222830.GD16058@coredump.intra.peff.net>
References: <20081107220730.GA15942@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Sam Vilain <sam@vilain.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 07 23:29:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyZpx-0006An-1Z
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 23:29:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752171AbYKGW2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 17:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752127AbYKGW2d
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 17:28:33 -0500
Received: from peff.net ([208.65.91.99]:1767 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751832AbYKGW2c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 17:28:32 -0500
Received: (qmail 2977 invoked by uid 111); 7 Nov 2008 22:28:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 07 Nov 2008 17:28:31 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Nov 2008 17:28:30 -0500
Content-Disposition: inline
In-Reply-To: <20081107220730.GA15942@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100354>

Pushing into the currently checked out branch of a non-bare
repository can be dangerous; the HEAD then loses sync with
the index and working tree, and it looks in the receiving
repo as if the pushed changes have been reverted in the
index (since they were never there in the first place).

This patch adds a safety valve that checks for this
condition and denies the push. We trigger the check only on
a non-bare repository, since a bare does not have a working
tree (and in fact, pushing to the HEAD branch is a common
workflow for publishing repositories).

This behavior is still configurable, though, since some very
specific setups may want to allow such a push if they know
they will take action to reconcile the working tree and HEAD
afterwards (e.g., a post-receive hook that does "git reset
--hard").

Signed-off-by: Jeff King <peff@peff.net>
---
My feeling is that this is dangerous behavior that we see new users
confused by, so it is worth addressing. The other obvious route is to
at least _try_ the merge, and if it comes out cleanly, to allow it.

But it looks like Sam is promoting that as a hook, which makes a lot
more sense to me. And we can still support that, but the user of the
hook must now not only install the hook, but also set the config value.

I am open to comments on the name of the config value. Somebody at the
GitTogether suggested (possibly under the influence of beer) that it be
receive.PEBKAC (since you should only turn it off if you really know
what you're doing, you would set PEBKAC to "false"), but I didn't want
to give the impression that git wasn't user-friendly. ;)

One final issue: do we need to make a special exception for "branch yet
to be born"? I believe we do so for the analagous "fetch" situation.

 Documentation/config.txt |    8 ++++++++
 builtin-receive-pack.c   |   16 ++++++++++++++++
 t/t5516-fetch-push.sh    |   21 +++++++++++++++++++++
 3 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 965ed74..971f01e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1198,6 +1198,14 @@ receive.denyNonFastForwards::
 	even if that push is forced. This configuration variable is
 	set when initializing a shared repository.
 
+receive.denyCurrentBranch::
+	If set to true, receive-pack will deny a ref update to the
+	currently checked out branch of a non-bare repository. Such a
+	push is potentially dangerous because it brings the HEAD out of
+	sync with the index and working tree; only set this to "false"
+	if you know what you are doing (e.g., you have a post-receive
+	hook which resets the working tree). Defaults to "true".
+
 transfer.unpackLimit::
 	When `fetch.unpackLimit` or `receive.unpackLimit` are
 	not set, the value of this variable is used instead.
diff --git a/builtin-receive-pack.c b/builtin-receive-pack.c
index 7f9f134..06ad545 100644
--- a/builtin-receive-pack.c
+++ b/builtin-receive-pack.c
@@ -13,6 +13,7 @@ static const char receive_pack_usage[] = "git-receive-pack <git-dir>";
 
 static int deny_deletes = 0;
 static int deny_non_fast_forwards = 0;
+static int deny_current_branch = 1;
 static int receive_fsck_objects;
 static int receive_unpack_limit = -1;
 static int transfer_unpack_limit = -1;
@@ -49,6 +50,11 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, "receive.denycurrentbranch")) {
+		deny_current_branch = git_config_bool(var, value);
+		return 0;
+	}
+
 	return git_default_config(var, value, cb);
 }
 
@@ -186,6 +192,16 @@ static const char *update(struct command *cmd)
 		return "funny refname";
 	}
 
+	if (deny_current_branch && !is_bare_repository()) {
+		unsigned char sha1[20];
+		const char *head = resolve_ref("HEAD", sha1, 0, NULL);
+		if (!strcmp(head, name)) {
+			error("refusing to update checked out branch: %s",
+				name);
+			return "branch is currently checked out";
+		}
+	}
+
 	if (!is_null_sha1(new_sha1) && !has_sha1_file(new_sha1)) {
 		error("unpack should have generated %s, "
 		      "but I can't find it!", sha1_to_hex(new_sha1));
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 7070171..579c3d8 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -487,4 +487,25 @@ test_expect_success 'allow deleting an invalid remote ref' '
 
 '
 
+test_expect_success 'deny push to HEAD to non-bare repository' '
+	mk_test heads/master
+	(cd testrepo && git checkout master) &&
+	test_must_fail git push testrepo master
+'
+
+test_expect_success 'allow push to HEAD of bare repository' '
+	mk_test heads/master
+	(cd testrepo && git checkout master && git config core.bare true) &&
+	git push testrepo master
+'
+
+test_expect_success 'allow push to HEAD of non-bare repository w/ config' '
+	mk_test heads/master
+	(cd testrepo &&
+		git checkout master &&
+		git config receive.denyCurrentBranch false
+	) &&
+	git push testrepo master
+'
+
 test_done
-- 
1.6.0.3.866.gc189b
