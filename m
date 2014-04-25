From: Jeff King <peff@peff.net>
Subject: [PATCH] commit: do not complain of empty messages from -C
Date: Fri, 25 Apr 2014 19:11:15 -0400
Message-ID: <20140425231115.GA3855@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 26 01:11:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdpHC-0007uF-43
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 01:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752792AbaDYXLT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 19:11:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:38709 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752702AbaDYXLR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 19:11:17 -0400
Received: (qmail 5292 invoked by uid 102); 25 Apr 2014 23:11:17 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 25 Apr 2014 18:11:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Apr 2014 19:11:15 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247130>

When we pick another commit's message, we die() immediately
if we find that it's empty and we are not going to run an
editor (i.e., when running "-C" instead of "-c").  However,
this check is redundant and harmful.

It's redundant because we will already notice the empty
message later, after we would have run the editor, and die
there (just as we would for a regular, not "-C" case, where
the user provided an empty message in the editor).

It's harmful for a few reasons:

  1. It does not respect --allow-empty-message. As a result,
     a "git rebase -i" cannot "pick" such a commit. So you
     cannot even go back in time to fix it with a "reword"
     or "edit" instruction.

  2. It does not take into account other ways besides the
     editor to modify the message. For example, "git commit
     -C empty-commit -m foo" could take the author
     information from empty-commit, but add a message to it.
     There's more to do to make that work correctly (and
     right now we explicitly forbid "-C with -m"), but this
     removes one roadblock.

  3. The existing check is not enough to prevent segfaults.
     We try to find the "\n\n" header/body boundary in the
     commit. If it is at the end of the string (i.e., no
     body), _or_ if we cannot find it at all (i.e., a
     truncated commit object), we consider the message
     empty. With "-C", that's OK; we die in either case. But
     with "-c", we continue on, and in the case of a
     truncated commit may end up dereferencing NULL+2.

Signed-off-by: Jeff King <peff@peff.net>
---
I care most about the "rebase -i" thing, especially because it is the
primary method for fixing old mistakes. The segfault fix is a nice
bonus.

The "git commit -C empty -m foo" thing might be nice, but I don't plan
to work on it further. The semantics would need to be figured out (does
it append or replace?), and you can always just use "-c" to fire up an
actual editor and write the new content there.

 builtin/commit.c  |  5 ++---
 t/t7500-commit.sh | 11 ++++++++++-
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 9cfef6c..65c069d 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -650,9 +650,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	} else if (use_message) {
 		char *buffer;
 		buffer = strstr(use_message_buffer, "\n\n");
-		if (!use_editor && (!buffer || buffer[2] == '\0'))
-			die(_("commit has empty message"));
-		strbuf_add(&sb, buffer + 2, strlen(buffer + 2));
+		if (buffer)
+			strbuf_add(&sb, buffer + 2, strlen(buffer + 2));
 		hook_arg1 = "commit";
 		hook_arg2 = use_message;
 	} else if (fixup_message) {
diff --git a/t/t7500-commit.sh b/t/t7500-commit.sh
index bdc1f29..116885a 100755
--- a/t/t7500-commit.sh
+++ b/t/t7500-commit.sh
@@ -223,7 +223,8 @@ test_expect_success 'Commit without message is allowed with --allow-empty-messag
 	git add foo &&
 	>empty &&
 	git commit --allow-empty-message <empty &&
-	commit_msg_is ""
+	commit_msg_is "" &&
+	git tag empty-message-commit
 '
 
 test_expect_success 'Commit without message is no-no without --allow-empty-message' '
@@ -240,6 +241,14 @@ test_expect_success 'Commit a message with --allow-empty-message' '
 	commit_msg_is "hello there"
 '
 
+test_expect_success 'commit -C empty respects --allow-empty-message' '
+	echo more >>foo &&
+	git add foo &&
+	test_must_fail git commit -C empty-message-commit &&
+	git commit -C empty-message-commit --allow-empty-message &&
+	commit_msg_is ""
+'
+
 commit_for_rebase_autosquash_setup () {
 	echo "first content line" >>foo &&
 	git add foo &&
-- 
1.9.1.656.ge8a0637
