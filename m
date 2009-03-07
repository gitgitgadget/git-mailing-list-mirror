From: Chris Johnsen <chris_johnsen@pobox.com>
Subject: [PATCH/RFD] builtin-revert.c: release index lock when cherry-picking
 an empty commit
Date: Sat,  7 Mar 2009 03:30:51 -0600
Message-ID: <1236418251-16947-1-git-send-email-chris_johnsen@pobox.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Chris Johnsen <chris_johnsen@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 07 10:31:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lfsst-0004zW-CZ
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 10:31:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753172AbZCGJa1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 04:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753160AbZCGJa1
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 04:30:27 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48549 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752072AbZCGJaZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 04:30:25 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E7B329FDEC;
	Sat,  7 Mar 2009 04:30:22 -0500 (EST)
Received: from localhost.localdomain (unknown [76.205.202.213]) (using TLSv1
 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate
 requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id
 5BC0F9FDEB; Sat,  7 Mar 2009 04:30:15 -0500 (EST)
X-Mailer: git-send-email 1.6.2
X-Pobox-Relay-ID: 95379B08-0AFA-11DE-9218-CFA5EBB1AA3C-07245699!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112519>

When a cherry-pick of an empty commit is done, release the lock
held on the index.

The fix is the same as was applied to similar code in 4271666046.

Signed-off-by: Chris Johnsen <chris_johnsen@pobox.com>
---

RELEVANT HISTORY

The previous code was introduced in 6eb1b43793.

It seems to have been copied from builtin-merge.c, where it was
introduced in 18668f5319 (6eb1's parent).

The code introduced in 1866 was fixed with the addition of
rollback_lock_file (the same fix as applied here) in 4271666046.

CONTEXT

I ran into the code path that this patch modifies while using
'git rebase -i' on a branch that had empty commits. When rebase
tried to cherry-pick an empty commit, the cherry-pick returned an
error and failed to unlocking the index. While this patch does
not allow 'git rebase -i' to "correctly" process empty commits,
it does prevent 'git cherry-pick' from exiting without unlocking
the index.

	T="$(mktemp -d -t empty-cherry)"
	cd "$T"
	git init
	echo a > a
	git add a
	git commit -m 'add a'
	git checkout -b empty
	git commit --allow-empty -m 'empty'
	git checkout master
	git cherry-pick empty

> Finished one cherry-pick.
> fatal: Unable to create '.git/index.lock': File exists.
> 
> If no other git process is currently running, this probably means a
> git process crashed in this repository earlier. Make sure no other git
> process is running and remove the file manually to continue.

I was originally appending empty commits with descriptive
messages to mark "interesting" points in a stream of otherwise
automatic commits (made by an Xcode build script). My idea was to
use these commits as markers that would flow with the rest of the
commits through a subsequent series of cleanups done with 'git
rebase -i'.  After encountering this problem, however, I moved
away from using empty commits (I have since been using 'git
commit --amend' to rewrite the last (generic, automatic) commit
message), but the bug left me wondering about the the status of
emtpy commits.

UNEVEN TREATMENT OF EMPTY CHANGES

It seems that empty commits suffer uneven treatment under various
patch-transport/history-rewriting mechanisms. They seem to be
handled okay in the most of the core (fetch, push, bundle all
seem to preserve empty commits, though I have not done rigorous
testing). But there are various problems in other areas:
'format-patch', 'send-email', 'apply', 'am', 'rebase' (automatic,
non-fast-forward; and --interactive).

DISCUSSION

36863af16e (git-commit --allow-empty) says "This is primarily for
use by foreign scm interface scripts.". Is this the only case
where empty commits _should_ be used? Or is the uneven treatment
just a matter nobody having an itch to use empty commits in
situations where the above commands would interact with them?

I played with having builtin-revert.c always use 'git commit
--allow-empty ...', but I was not confident that such behavior
would match "official policy for empty commits" (if such policy
even exists). Should empty commits be preserved (by default) once
they are in the commit stream? Should commands that do "patch
manipulation" only preserve empty commits if they are explicitly
instructed to do so (with their own --allow-emtpy option)? Should
something completely different happen?

I realize that rebasing and cherry-picking need to have special
consideration for "effectively empty" patches (those that
introduce changes already present; usually because one side
already picked some changes from the other), but maybe "actually
empty, yet informational" commits also deserve some
consideration.

If such "actually empty, yet informational" commits (no content
changes, but a useful commit messages) are a valid use of empty
commits, then maybe "actually empty" commits in general deserve
treatment equal to that of normal commits.

---
 builtin-revert.c             |    1 +
 t/t3505-cherry-pick-empty.sh |   33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 0 deletions(-)
 create mode 100755 t/t3505-cherry-pick-empty.sh

diff --git a/builtin-revert.c b/builtin-revert.c
index d210150..3f2614e 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -376,6 +376,7 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	    (write_cache(index_fd, active_cache, active_nr) ||
 	     commit_locked_index(&index_lock)))
 		die("%s: Unable to write new index file", me);
+	rollback_lock_file(&index_lock);
 
 	if (!clean) {
 		add_to_msg("\nConflicts:\n\n");
diff --git a/t/t3505-cherry-pick-empty.sh b/t/t3505-cherry-pick-empty.sh
new file mode 100755
index 0000000..9aaeabd
--- /dev/null
+++ b/t/t3505-cherry-pick-empty.sh
@@ -0,0 +1,33 @@
+#!/bin/sh
+
+test_description='test cherry-picking an empty commit'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+
+	echo first > file1 &&
+	git add file1 &&
+	test_tick &&
+	git commit -m "first" &&
+
+	git checkout -b empty-branch &&
+	test_tick &&
+	git commit --allow-empty -m "empty"
+
+'
+
+test_expect_code 1 'cherry-pick an empty commit' '
+
+	git checkout master &&
+	git cherry-pick empty-branch
+
+'
+
+test_expect_success 'index lockfile was removed' '
+
+	test ! -f .git/index.lock
+
+'
+
+test_done
-- 
1.6.2
