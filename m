From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] receive-pack: support push-to-checkout hook
Date: Thu, 08 Jan 2015 15:25:47 -0800
Message-ID: <xmqqbnm8etxg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 09 00:26:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9MSh-0006Yo-CB
	for gcvg-git-2@plane.gmane.org; Fri, 09 Jan 2015 00:25:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755450AbbAHXZv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2015 18:25:51 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62761 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755151AbbAHXZu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2015 18:25:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 365F62EB79;
	Thu,  8 Jan 2015 18:25:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=l
	6D7GgnNeZArAvdoqwtIkOZmbiI=; b=Th9hRQALZWS771xIQuJ2SQnrB1pgUc4uj
	gzILMZsA9NkWBpM0qHfOQ6/n6uCpBbIGvSezxbV2RWD0abSUM+zC7UDo7G1sgfqu
	L9c4SSbiQax6eqA3ldOXl0BZqaXfX4eGVnye6HvfbQpLc0P1XADlTSrttcFzgle9
	BdlQyq6bE0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=vBFhWbZDYgEhEp+/sio8zDr4q2PTsfz1ZH/PMFhbKDTgnA27Hl2Opma5
	GiCpj0BJmGxW1GvKGipdGfDd9SRX7Z/bZt49+Snlmnfdty4OcBs1hnTli//RUIEU
	XRzT/vB15V6o+BCnOgrBt99V7Osu1OxzVSS/5KAhbfmXz7Q/dBE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2B2EF2EB78;
	Thu,  8 Jan 2015 18:25:49 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 87A212EB77;
	Thu,  8 Jan 2015 18:25:48 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AD89FA2C-978D-11E4-BA52-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262225>

When receive.denyCurrentBranch is set to updateInstead, a push that
tries to update the branch that is currently checked out is accepted
only when the index and the working tree exactly matches the
currently checked out commit, in which case the index and the
working tree are updated to match the pushed commit.  Otherwise the
push is refused.

This hook can be used to customize this "push-to-deploy" logic.  The
hook receives the commit with which the tip of the current branch is
going to be updated, and can decide what kind of local changes are
acceptable and how to update the index and the working tree to match
the updated tip of the current branch.

For example, the hook can simply run `git read-tree -u -m HEAD "$1"`
in order to emulate 'git fetch' that is run in the reverse direction
with `git push`, as the two-tree form of `read-tree -u -m` is
essentially the same as `git checkout` that switches branches while
keeping the local changes in the working tree that do not interfere
with the difference between the branches.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is an update to $gmane/260527; relative to what I have been
   keeping in 'pu', the only difference is that it comes with
   documentation updates.

 Documentation/config.txt   |  6 ++++-
 Documentation/githooks.txt | 30 ++++++++++++++++++++++
 builtin/receive-pack.c     | 19 +++++++++++++-
 t/t5516-fetch-push.sh      | 63 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 116 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6a4c19e..4e558ab 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2131,11 +2131,15 @@ receive.denyCurrentBranch::
 	message. Defaults to "refuse".
 +
 Another option is "updateInstead" which will update the working
-directory (must be clean) if pushing into the current branch. This option is
+tree if pushing into the current branch.  This option is
 intended for synchronizing working directories when one side is not easily
 accessible via interactive ssh (e.g. a live web site, hence the requirement
 that the working directory be clean). This mode also comes in handy when
 developing inside a VM to test and fix code on different Operating Systems.
++
+By default, "updateInstead" will refuse the push if the working tree or
+the index have any difference from the HEAD, but the `push-to-checkout`
+hook can be used to customize this.  See linkgit:githooks[5].
 
 receive.denyNonFastForwards::
 	If set to true, git-receive-pack will deny a ref update which is
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 9ef2469..7ba0ac9 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -341,6 +341,36 @@ Both standard output and standard error output are forwarded to
 'git send-pack' on the other end, so you can simply `echo` messages
 for the user.
 
+push-to-checkout
+~~~~~~~~~~~~~~~~
+
+This hook is invoked by 'git-receive-pack' on the remote repository,
+which happens when a 'git push' is done on a local repository, when
+the push tries to update the branch that is currently checked out
+and the `receive.denyCurrentBranch` configuration variable is set to
+`updateInstead`.  Such a push by default is refused if the working
+tree and the index of the remote repository has any difference from
+the currently checked out commit; when both the working tree and the
+index match the current commit, they are updated to match the newly
+pushed tip of the branch.  This hook is to be used to override the
+default behaviour.
+
+The hook receives the commit with which the tip of the current
+branch is going to be updated.  It can exit with a non-zero status
+to refuse the push (when it does so, it must not modify the index or
+the working tree).  Or it can make any necessary changes to the
+working tree and to the index to bring them to the desired state
+when the tip of the current branch is updated to the new commit, and
+exit with a zero status.
+
+For example, the hook can simply run `git read-tree -u -m HEAD "$1"`
+in order to emulate 'git fetch' that is run in the reverse direction
+with `git push`, as the two-tree form of `read-tree -u -m` is
+essentially the same as `git checkout` that switches branches while
+keeping the local changes in the working tree that do not interfere
+with the difference between the branches.
+
+
 pre-auto-gc
 ~~~~~~~~~~~
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 11800cd..fc8ec9c 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -797,6 +797,20 @@ static const char *push_to_deploy(unsigned char *sha1,
 	return NULL;
 }
 
+static const char *push_to_checkout_hook = "push-to-checkout";
+
+static const char *push_to_checkout(unsigned char *sha1,
+				    struct argv_array *env,
+				    const char *work_tree)
+{
+	argv_array_pushf(env, "GIT_WORK_TREE=%s", absolute_path(work_tree));
+	if (run_hook_le(env->argv, push_to_checkout_hook,
+			sha1_to_hex(sha1), NULL))
+		return "push-to-checkout hook declined";
+	else
+		return NULL;
+}
+
 static const char *update_worktree(unsigned char *sha1)
 {
 	const char *retval;
@@ -808,7 +822,10 @@ static const char *update_worktree(unsigned char *sha1)
 
 	argv_array_pushf(&env, "GIT_DIR=%s", absolute_path(get_git_dir()));
 
-	retval = push_to_deploy(sha1, &env, work_tree);
+	if (!find_hook(push_to_checkout_hook))
+		retval = push_to_deploy(sha1, &env, work_tree);
+	else
+		retval = push_to_checkout(sha1, &env, work_tree);
 
 	argv_array_clear(&env);
 	return retval;
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 85c7fec..e4436c1 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1434,4 +1434,67 @@ test_expect_success 'receive.denyCurrentBranch = updateInstead' '
 
 '
 
+test_expect_success 'updateInstead with push-to-checkout hook' '
+	rm -fr testrepo &&
+	git init testrepo &&
+	(
+		cd testrepo &&
+		git pull .. master &&
+		git reset --hard HEAD^^ &&
+		git tag initial &&
+		git config receive.denyCurrentBranch updateInstead &&
+		write_script .git/hooks/push-to-checkout <<-\EOF
+		echo >&2 updating from $(git rev-parse HEAD)
+		echo >&2 updating to "$1"
+
+		git update-index -q --refresh &&
+		git read-tree -u -m HEAD "$1" || {
+			status=$?
+			echo >&2 read-tree failed
+			exit $status
+		}
+		EOF
+	) &&
+
+	# Try pushing into a pristine
+	git push testrepo master &&
+	(
+		cd testrepo &&
+		git diff --quiet &&
+		git diff HEAD --quiet &&
+		test $(git -C .. rev-parse HEAD) = $(git rev-parse HEAD)
+	) &&
+
+	# Try pushing into a repository with conflicting change
+	(
+		cd testrepo &&
+		git reset --hard initial &&
+		echo conflicting >path2
+	) &&
+	test_must_fail git push testrepo master &&
+	(
+		cd testrepo &&
+		test $(git rev-parse initial) = $(git rev-parse HEAD) &&
+		test conflicting = "$(cat path2)" &&
+		git diff-index --quiet --cached HEAD
+	) &&
+
+	# Try pushing into a repository with unrelated change
+	(
+		cd testrepo &&
+		git reset --hard initial &&
+		echo unrelated >path1 &&
+		echo irrelevant >path5 &&
+		git add path5
+	) &&
+	git push testrepo master &&
+	(
+		cd testrepo &&
+		test "$(cat path1)" = unrelated &&
+		test "$(cat path5)" = irrelevant &&
+		test "$(git diff --name-only --cached HEAD)" = path5 &&
+		test $(git -C .. rev-parse HEAD) = $(git rev-parse HEAD)
+	)
+'
+
 test_done
-- 
2.2.1-390-g773ecee
