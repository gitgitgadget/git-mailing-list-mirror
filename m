From: Ian Ward Comfort <icomfort@stanford.edu>
Subject: [PATCH] rebase -i: Abort cleanly if new base cannot be checked out
Date: Tue,  8 Jun 2010 01:16:11 -0700
Message-ID: <1275984971-20444-1-git-send-email-icomfort@stanford.edu>
References: <AANLkTinaUiHz8gRi5JF3n45aNCoPqiNxwExIga-cyYnw@mail.gmail.com>
Cc: git@vger.kernel.org
To: Matthieu Tourne <matthieu.tourne@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 08 10:16:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLtyz-0005XI-6d
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 10:16:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752121Ab0FHIQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 04:16:17 -0400
Received: from smtp3.Stanford.EDU ([171.67.219.83]:34703 "EHLO
	smtp.stanford.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751227Ab0FHIQP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 04:16:15 -0400
Received: from smtp.stanford.edu (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with SMTP id 2B8151A0C73;
	Tue,  8 Jun 2010 01:16:15 -0700 (PDT)
Received: from ashbury.stanford.edu (ashbury.Stanford.EDU [171.67.43.200])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.stanford.edu (Postfix) with ESMTPS id 8E02E1A0C5D;
	Tue,  8 Jun 2010 01:16:11 -0700 (PDT)
Received: by ashbury.stanford.edu (Postfix, from userid 26037)
	id 6BD0C1D0056; Tue,  8 Jun 2010 01:16:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <AANLkTinaUiHz8gRi5JF3n45aNCoPqiNxwExIga-cyYnw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148653>

On 7 Jun 2010, at 5:06 PM, Matthieu Tourne wrote:
> I tried to perform an interactive rebase of several commits in my tree.
> In one of my commits I had performed a git rm --cached, on several files.
> The resulting message was :
>
> error: Untracked working tree file 'foo' would be overwritten by merge.
> shift: 1: can't shift that many
>
> I eventually removed the file from the fs, and the rebase worked.
> The fact that the rebase is not working is probably not a bug, but the
> last line looks like an sh bug.

The last line is a side effect of dash, which apparently complains when asked
to shift from an empty array, and it shouldn't be there. The best fix, though,
isn't to silence shift but to eliminate that code path by fixing another bug
in rebase--interactive. In the scenario you describe, git currently leaves the
repository in the middle of an impossible rebase, with questionably-consistent
state in .git/rebase-merge. The behavior is more compactly (if more
nonsensically) exhibited with:

  $ git init test && cd test
  $ touch A
  $ git add A
  $ git commit -m 'add' A
  $ git rm --cached A
  $ git commit -m 'remove'
  $ GIT_EDITOR=: git rebase -i --no-ff HEAD^

Let's abort cleanly instead, since that's what non-interactive rebase does
already.

---- 8< ----

Untracked content in the working tree may prevent rebase -i from checking out
the new base onto which it wants to replay commits, if the new base commit
includes files at those (now untracked) paths. Currently, rebase -i dies
uncleanly in this situation, updating ORIG_HEAD and leaving a useless
.git/rebase-merge directory, with which the user can do nothing useful except
rebase --abort. Make rebase -i abort the procedure itself instead, as
non-interactive rebase already does, and add a test for this behavior.

Signed-off-by: Ian Ward Comfort <icomfort@stanford.edu>
---
 git-rebase--interactive.sh    |    3 ++-
 t/t3404-rebase-interactive.sh |   10 ++++++++++
 2 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 436b7f5..6b86abc 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -974,8 +974,9 @@ EOF
 
 		test -d "$REWRITTEN" || test -n "$NEVER_FF" || skip_unnecessary_picks
 
+		output git checkout $ONTO || die_abort "could not detach HEAD"
 		git update-ref ORIG_HEAD $HEAD
-		output git checkout $ONTO && do_rest
+		do_rest
 		;;
 	esac
 	shift
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index f20ea38..8d40915 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -146,6 +146,16 @@ test_expect_success 'abort' '
 	! test -d .git/rebase-merge
 '
 
+test_expect_success 'abort with error when new base cannot be checked out' '
+	git rm --cached file1 &&
+	git commit -m "remove file in base" &&
+	test_must_fail git rebase -i master > output 2>&1 &&
+	grep "Untracked working tree file .file1. would be overwritten" \
+		output &&
+	! test -d .git/rebase-merge &&
+	git reset --hard HEAD^
+'
+
 test_expect_success 'retain authorship' '
 	echo A > file7 &&
 	git add file7 &&
-- 
1.7.1
