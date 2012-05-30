From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Cherry-pick dangles and forgets helpful advice in next
Date: Tue, 29 May 2012 19:59:55 -0700
Message-ID: <7vipfe1ihg.fsf@alter.siamese.dyndns.org>
References: <4FBD4904.9090000@cisco.com>
 <7vipfmzfel.fsf@alter.siamese.dyndns.org>
 <7vehqazf9d.fsf@alter.siamese.dyndns.org> <4FBD6EC2.3000804@cisco.com>
 <7v62bmzdmy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Phil Hord <hordp@cisco.com>
To: Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Wed May 30 05:00:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZZ8m-0000ui-Es
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 05:00:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177Ab2E3C77 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 May 2012 22:59:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54940 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932166Ab2E3C76 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2012 22:59:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9360D97F2;
	Tue, 29 May 2012 22:59:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1I186u4Hw/rdvjqh8W1iV1qlZMU=; b=h0c6Ik
	VAVXWnhJ3cZTNvZuNUAe/w9QpcqW7tDCA+ewokIUGgYF1gUYotDPss5amPsokght
	c4YlXaq24ekfE8WDVrK+Bk3yk5qpvQK6Wcyn5QJIU1H0XWNsWUGJ0nFezFsg+PM3
	D4W2b4ExKEs9+GcLLqQWYscYj0JI+GLCBZTRI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iUkrzW1xfE2MgKXyAIB+thzKMwiTZcFm
	riJ4FjNXzYLTERa+UFEzYOR53moDAjTNunoaCcvhWL+tg/1o2IdMZzYMmV5z26+z
	0SwoThUJx/8YJt6327xLtSvgCTFJXyjK2BevVECpo25IDpDBIZO6DJ2yoZvFHWR1
	d11KBF59aZw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8AC3C97F1;
	Tue, 29 May 2012 22:59:57 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B737B97F0; Tue, 29 May 2012
 22:59:56 -0400 (EDT)
In-Reply-To: <7v62bmzdmy.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 23 May 2012 16:22:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8993B308-AA03-11E1-9A9B-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198778>

Instead of reverting the entire thing, perhaps we can fix the
regression like this.

With this, we no longer unconditionally give "--allow-empty" when we
run "git commit", when --allow-empty (which is only about commits
that are originally empty) is given to cherry-pick; specifically,
when the user did not ask for --keep-redundant-commit, we do not
give "--allow-empty" if the original commit is not.

Thinking about it again, I _think_ we do not even have to check if
the result is an empty commit ourselves ("git commit" will do that
for us anyway), so we might want to rip "is_empty_commit()" out of
the problematic patch and keep only "is_index_unmodified()" bit, but
for now I think this may be good enough.

Phil, does it fix your issue?

Neil?

-- >8 --

Subject: [PATCH] cherry-pick: regression fix for empty commits

The earlier "--keep-redundant-commit" series broke "cherry-pick"
that is given a commit whose change is already in the current
history. Such a cherry-pick would result in an empty change, and
should stop with an error, telling the user that conflict resolution
may have made the result empty (which is exactly what is happening),
but we silently dropped the change on the floor without any message
nor non-zero exit code.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sequencer.c                  | 73 +++++++++++++++++++++++++++-----------------
 t/t3505-cherry-pick-empty.sh | 30 ++++++++++++++++++
 2 files changed, 75 insertions(+), 28 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 72cb4ff..1b2168c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -291,7 +291,8 @@ static int is_index_unchanged(void)
  * If we are revert, or if our cherry-pick results in a hand merge,
  * we had better say that the current user is responsible for that.
  */
-static int run_git_commit(const char *defmsg, struct replay_opts *opts)
+static int run_git_commit(const char *defmsg, struct replay_opts *opts,
+			  int allow_empty)
 {
 	struct argv_array array;
 	int rc;
@@ -307,7 +308,7 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts)
 		argv_array_push(&array, defmsg);
 	}
 
-	if (opts->allow_empty)
+	if (allow_empty)
 		argv_array_push(&array, "--allow-empty");
 
 	rc = run_command_v_opt(array.argv, RUN_GIT_CMD);
@@ -335,6 +336,44 @@ static int is_original_commit_empty(struct commit *commit)
 	return !hashcmp(ptree_sha1, commit->tree->object.sha1);
 }
 
+/*
+ * Do we run "git commit" with "--allow-empty"?
+ */
+static int allow_empty(struct replay_opts *opts, struct commit *commit)
+{
+	int index_unchanged, empty_commit;
+
+	/*
+	 * Three cases:
+	 *
+	 * (1) we do not allow empty at all and error out.
+	 *
+	 * (2) we allow ones that were initially empty, but
+	 * forbid the ones that become empty;
+	 *
+	 * (3) we allow both.
+	 */
+	if (!opts->allow_empty)
+		return 0; /* let "git commit" barf as necessary */
+
+	index_unchanged = is_index_unchanged();
+	if (index_unchanged < 0)
+		return index_unchanged;
+	if (!index_unchanged)
+		return 0; /* we do not have to say --allow-empty */
+
+	if (opts->keep_redundant_commits)
+		return 1;
+
+	empty_commit = is_original_commit_empty(commit);
+	if (empty_commit < 0)
+		return empty_commit;
+	if (!empty_commit)
+		return 0;
+	else
+		return 1;
+}
+
 static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 {
 	unsigned char head[20];
@@ -344,8 +383,6 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 	char *defmsg = NULL;
 	struct strbuf msgbuf = STRBUF_INIT;
 	int res;
-	int empty_commit;
-	int index_unchanged;
 
 	if (opts->no_commit) {
 		/*
@@ -471,10 +508,6 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		free_commit_list(remotes);
 	}
 
-	empty_commit = is_original_commit_empty(commit);
-	if (empty_commit < 0)
-		return empty_commit;
-
 	/*
 	 * If the merge was clean or if it failed due to conflict, we write
 	 * CHERRY_PICK_HEAD for the subsequent invocation of commit to use.
@@ -495,27 +528,11 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		print_advice(res == 1, opts);
 		rerere(opts->allow_rerere_auto);
 	} else {
-		index_unchanged = is_index_unchanged();
-		/*
-		 * If index_unchanged is less than 0, that indicates we either
-		 * couldn't parse HEAD or the index, so error out here.
-		 */
-		if (index_unchanged < 0)
-			return index_unchanged;
-
-		if (!empty_commit && !opts->keep_redundant_commits && index_unchanged)
-			/*
-			 * The head tree and the index match
-			 * meaning the commit is empty.  Since it wasn't created
-			 * empty (based on the previous test), we can conclude
-			 * the commit has been made redundant.  Since we don't
-			 * want to keep redundant commits, we can just return
-			 * here, skipping this commit
-			 */
-			return 0;
-
+		int allow = allow_empty(opts, commit);
+		if (allow < 0)
+			return allow;
 		if (!opts->no_commit)
-			res = run_git_commit(defmsg, opts);
+			res = run_git_commit(defmsg, opts, allow);
 	}
 
 	free_message(&msg);
diff --git a/t/t3505-cherry-pick-empty.sh b/t/t3505-cherry-pick-empty.sh
index 92f00cd..5a1340c 100755
--- a/t/t3505-cherry-pick-empty.sh
+++ b/t/t3505-cherry-pick-empty.sh
@@ -71,4 +71,34 @@ test_expect_success 'cherry pick with --keep-redundant-commits' '
 	git cherry-pick --keep-redundant-commits HEAD^
 '
 
+test_expect_success 'cherry-pick a commit that becomes no-op (prep)' '
+	git checkout master &&
+	git branch fork &&
+	echo foo >file2 &&
+	git add file2 &&
+	test_tick &&
+	git commit -m "add file2 on master" &&
+
+	git checkout fork &&
+	echo foo >file2 &&
+	git add file2 &&
+	test_tick &&
+	git commit -m "add file2 on the side"
+'
+
+test_expect_success 'cherry-pick a no-op without --keep-redundant' '
+	git reset --hard &&
+	git checkout fork^0 &&
+	test_must_fail git cherry-pick master
+'
+
+test_expect_success 'cherry-pick a no-op with --keep-redundant' '
+	git reset --hard &&
+	git checkout fork^0 &&
+	git cherry-pick --keep-redundant-commits master &&
+	git show -s --format='%s' >actual &&
+	echo "add file2 on master" >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.7.11.rc0.54.g0680f74
