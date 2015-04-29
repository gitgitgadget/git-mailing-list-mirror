From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 14/15] merge: handle FETCH_HEAD internally
Date: Wed, 29 Apr 2015 14:29:32 -0700
Message-ID: <1430342973-30344-15-git-send-email-gitster@pobox.com>
References: <1430025967-24479-1-git-send-email-gitster@pobox.com>
 <1430342973-30344-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 29 23:30:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnZYj-0006lY-Px
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 23:30:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbbD2VaR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 17:30:17 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64525 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751086AbbD2V36 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 17:29:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 742A24DAE1;
	Wed, 29 Apr 2015 17:29:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=K74P
	hO1HTs1rm8faWbUiz5vp9cY=; b=Gqo4k/7WZYaNSqkO25tTx4eqXSRWQENwB7Y9
	M7SdWzpbfVhbPrQhQI9vMTI4O27Gjph16/13EZk5+AISOoLl1c/Yog4z3xP+z/W1
	8fnR/xDeoEmG1J1ZLnZBDWyIyMjIUZcalM5dRZn1ZTRKoI0biGUU0v/BigJoAedP
	Y5AGwpw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=tJO6HI
	2xHDpcclOYo/rux8wStpaa5lZpjOvrGrrM0UF9v/ZWXzabMpZ+7QancqV0Wzvy8m
	EtxtrskfF2/ugJfLM17qSmxns2GJ3ItZpMYSH+/eebCwjJhJnkZRYiIN8t4REejV
	6fuUwTCvjVSgAGBiyJp91APCVYSl4NK/sH3bI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6D3A14DAE0;
	Wed, 29 Apr 2015 17:29:57 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D33154DADD;
	Wed, 29 Apr 2015 17:29:56 -0400 (EDT)
X-Mailer: git-send-email 2.4.0-rc3-300-g052d062
In-Reply-To: <1430342973-30344-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: E1DCCE82-EEB6-11E4-ADD4-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268024>

The collect_parents() function now is responsible for

 1. parsing the commits given on the command line into a list of
    commits to be merged;

 2. filtering these parents into independent ones; and

 3. optionally calling fmt_merge_msg() via prepare_merge_message()
    to prepare an auto-generated merge log message, using fake
    contents that FETCH_HEAD would have had if these commits were
    fetched from the current repository with "git pull . $args..."

Make "git merge FETCH_HEAD" to be the same as the traditional

    git merge "$(git fmt-merge-msg <.git/FETCH_HEAD)" $commits

invocation of the command in "git pull", where $commits are the ones
that appear in FETCH_HEAD that are not marked as not-for-merge, by
making it do a bit more, specifically:

 - noticing "FETCH_HEAD" is the only "commit" on the command line
   and picking the commits that are not marked as not-for-merge as
   the list of commits to be merged (substitute for step #1 above);

 - letting the resulting list fed to step #2 above;

 - doing the step #3 above, using the contents of the FETCH_HEAD
   instead of fake contents crafted from the list of commits parsed
   in the step #1 above.

Note that this changes the semantics.  "git merge FETCH_HEAD" has
always behaved as if the first commit in the FETCH_HEAD file were
directly specified on the command line, creating a two-way merge
whose auto-generated merge log said "merge commit xyz".  With this
change, if the previous fetch was to grab multiple branches (e.g.
"git fetch $there topic-a topic-b"), the new world order is to
create an octopus, behaving as if "git pull $there topic-a topic-b"
were run.  This is a deliberate change to make that happen, and
can be seen in the changes to t3033 tests.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-merge.txt |   4 ++
 builtin/merge.c             | 106 ++++++++++++++++++++++++++++++--------------
 t/t3033-merge-toplevel.sh   |  10 ++---
 3 files changed, 81 insertions(+), 39 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index cf2c374..d9aa6b6 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -104,6 +104,10 @@ commit or stash your changes before running 'git merge'.
 If no commit is given from the command line, merge the remote-tracking
 branches that the current branch is configured to use as its upstream.
 See also the configuration section of this manual page.
++
+When `FETCH_HEAD` (and no other commit) is specified, the branches
+recorded in the `.git/FETCH_HEAD` file by the previous invocation
+of `git fetch` for merging are merged to the current branch.
 
 
 PRE-MERGE CHECKS
diff --git a/builtin/merge.c b/builtin/merge.c
index eb3be68..42f9fcc 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -505,28 +505,6 @@ static void merge_name(const char *remote, struct strbuf *msg)
 		strbuf_release(&truname);
 	}
 
-	if (!strcmp(remote, "FETCH_HEAD") &&
-			!access(git_path("FETCH_HEAD"), R_OK)) {
-		const char *filename;
-		FILE *fp;
-		struct strbuf line = STRBUF_INIT;
-		char *ptr;
-
-		filename = git_path("FETCH_HEAD");
-		fp = fopen(filename, "r");
-		if (!fp)
-			die_errno(_("could not open '%s' for reading"),
-				  filename);
-		strbuf_getline(&line, fp, '\n');
-		fclose(fp);
-		ptr = strstr(line.buf, "\tnot-for-merge\t");
-		if (ptr)
-			strbuf_remove(&line, ptr-line.buf+1, 13);
-		strbuf_addbuf(msg, &line);
-		strbuf_release(&line);
-		goto cleanup;
-	}
-
 	if (remote_head->util) {
 		struct merge_remote_desc *desc;
 		desc = merge_remote_util(remote_head);
@@ -1090,6 +1068,60 @@ static void prepare_merge_message(struct strbuf *merge_names, struct strbuf *mer
 		strbuf_setlen(merge_msg, merge_msg->len - 1);
 }
 
+static void handle_fetch_head(struct commit_list **remotes, struct strbuf *merge_names)
+{
+	const char *filename;
+	int fd, pos, npos;
+	struct strbuf fetch_head_file = STRBUF_INIT;
+
+	if (!merge_names)
+		merge_names = &fetch_head_file;
+
+	filename = git_path("FETCH_HEAD");
+	fd = open(filename, O_RDONLY);
+	if (fd < 0)
+		die_errno(_("could not open '%s' for reading"), filename);
+
+	if (strbuf_read(merge_names, fd, 0) < 0)
+		die_errno(_("could not read '%s'"), filename);
+	if (close(fd) < 0)
+		die_errno(_("could not close '%s'"), filename);
+
+	for (pos = 0; pos < merge_names->len; pos = npos) {
+		unsigned char sha1[20];
+		char *ptr;
+		struct commit *commit;
+
+		ptr = strchr(merge_names->buf + pos, '\n');
+		if (ptr)
+			npos = ptr - merge_names->buf + 1;
+		else
+			npos = merge_names->len;
+
+		if (npos - pos < 40 + 2 ||
+		    get_sha1_hex(merge_names->buf + pos, sha1))
+			commit = NULL; /* bad */
+		else if (memcmp(merge_names->buf + pos + 40, "\t\t", 2))
+			continue; /* not-for-merge */
+		else {
+			char saved = merge_names->buf[pos + 40];
+			merge_names->buf[pos + 40] = '\0';
+			commit = get_merge_parent(merge_names->buf + pos);
+			merge_names->buf[pos + 40] = saved;
+		}
+		if (!commit) {
+			if (ptr)
+				*ptr = '\0';
+			die("not something we can merge in %s: %s",
+			    filename, merge_names->buf + pos);
+		}
+		remotes = &commit_list_insert(commit, remotes)->next;
+	}
+
+	if (merge_names == &fetch_head_file)
+		strbuf_release(&fetch_head_file);
+}
+
 static struct commit_list *collect_parents(struct commit *head_commit,
 					   int *head_subsumed,
 					   int argc, const char **argv,
@@ -1105,21 +1137,27 @@ static struct commit_list *collect_parents(struct commit *head_commit,
 
 	if (head_commit)
 		remotes = &commit_list_insert(head_commit, remotes)->next;
-	for (i = 0; i < argc; i++) {
-		struct commit *commit = get_merge_parent(argv[i]);
-		if (!commit)
-			help_unknown_ref(argv[i], "merge",
-					 "not something we can merge");
-		remotes = &commit_list_insert(commit, remotes)->next;
-	}
 
-	remoteheads = reduce_parents(head_commit, head_subsumed, remoteheads);
+	if (argc == 1 && !strcmp(argv[0], "FETCH_HEAD")) {
+		handle_fetch_head(remotes, autogen);
+		remoteheads = reduce_parents(head_commit, head_subsumed, remoteheads);
+	} else {
+		for (i = 0; i < argc; i++) {
+			struct commit *commit = get_merge_parent(argv[i]);
+			if (!commit)
+				help_unknown_ref(argv[i], "merge",
+						 "not something we can merge");
+			remotes = &commit_list_insert(commit, remotes)->next;
+		}
+		remoteheads = reduce_parents(head_commit, head_subsumed, remoteheads);
+		if (autogen) {
+			struct commit_list *p;
+			for (p = remoteheads; p; p = p->next)
+				merge_name(merge_remote_util(p->item)->name, autogen);
+		}
+	}
 
 	if (autogen) {
-		struct commit_list *p;
-		for (p = remoteheads; p; p = p->next)
-			merge_name(merge_remote_util(p->item)->name, autogen);
-
 		prepare_merge_message(autogen, merge_msg);
 		strbuf_release(autogen);
 	}
diff --git a/t/t3033-merge-toplevel.sh b/t/t3033-merge-toplevel.sh
index 9d92d3c..46aadc4 100755
--- a/t/t3033-merge-toplevel.sh
+++ b/t/t3033-merge-toplevel.sh
@@ -77,7 +77,7 @@ test_expect_success 'merge octopus, non-fast-forward' '
 
 # The same set with FETCH_HEAD
 
-test_expect_failure 'merge FETCH_HEAD octopus into void' '
+test_expect_success 'merge FETCH_HEAD octopus into void' '
 	t3033_reset &&
 	git checkout --orphan test &&
 	git rm -fr . &&
@@ -88,7 +88,7 @@ test_expect_failure 'merge FETCH_HEAD octopus into void' '
 	test_must_fail git rev-parse HEAD
 '
 
-test_expect_failure 'merge FETCH_HEAD octopus fast-forward (ff)' '
+test_expect_success 'merge FETCH_HEAD octopus fast-forward (ff)' '
 	t3033_reset &&
 	git reset --hard one &&
 	git fetch . left right &&
@@ -100,7 +100,7 @@ test_expect_failure 'merge FETCH_HEAD octopus fast-forward (ff)' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'merge FETCH_HEAD octopus non-fast-forward (ff)' '
+test_expect_success 'merge FETCH_HEAD octopus non-fast-forward (ff)' '
 	t3033_reset &&
 	git reset --hard one &&
 	git fetch . left right &&
@@ -112,7 +112,7 @@ test_expect_failure 'merge FETCH_HEAD octopus non-fast-forward (ff)' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'merge FETCH_HEAD octopus fast-forward (does not ff)' '
+test_expect_success 'merge FETCH_HEAD octopus fast-forward (does not ff)' '
 	t3033_reset &&
 	git fetch . left right &&
 	git merge FETCH_HEAD &&
@@ -123,7 +123,7 @@ test_expect_failure 'merge FETCH_HEAD octopus fast-forward (does not ff)' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'merge FETCH_HEAD octopus non-fast-forward' '
+test_expect_success 'merge FETCH_HEAD octopus non-fast-forward' '
 	t3033_reset &&
 	git fetch . left right &&
 	git merge --no-ff FETCH_HEAD &&
-- 
2.4.0-rc3-300-g052d062
