From: Miklos Vajna <vmiklos@suse.cz>
Subject: [PATCH v2] cherry-pick: don't forget -s on failure
Date: Thu, 13 Sep 2012 09:33:25 +0200
Message-ID: <20120913073324.GA14383@suse.cz>
References: <20120912195732.GB4722@suse.cz>
 <7vd31qc1p3.fsf@alter.siamese.dyndns.org>
 <7v8vcec13d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Robin Stocker <robin@nibor.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 13 09:31:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TC3tw-00046D-VU
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 09:31:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756367Ab2IMHbp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 03:31:45 -0400
Received: from cantor2.suse.de ([195.135.220.15]:46519 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756211Ab2IMHbl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 03:31:41 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 513B2A3421;
	Thu, 13 Sep 2012 09:31:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v8vcec13d.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205361>

In case 'git cherry-pick -s <commit>' failed, the user had to use 'git
commit -s' (i.e. state the -s option again), which is easy to forget
about.  Instead, write the signed-off-by line early, so plain 'git
commit' will have the same result.

Also update 'git commit -s', so that in case there is already a relevant
Signed-off-by line before the Conflicts: line, it won't add one more at
the end of the message.

Signed-off-by: Miklos Vajna <vmiklos@suse.cz>
---

On Wed, Sep 12, 2012 at 03:45:10PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
>  - The additional S-o-b should come immediately after the existing
>    block of footers.

This was trivial to fix.

>  - And the last entry in the existing footer block is already mine,
>    so there shouldn't have been a new and duplicated one added.
> 
> 
> I am not sure how reusable the moved function is without
> enhancements for your purpose.  The logic to identify the footer
> needs to be enhanced so that an "end" pointer to point at the byte
> before the caller added "Conflicts: " can be given, and pretend as
> if it is the end of the buffer, unlike in the fresh commit case
> where it can consider the real end of the buffer as such.

Below is what I came up with. It simply ignores anything after the 
Conclicts: line, when checking for the last Signed-off-by line.

An other thing: I forgot to run 'make test' for the initial patch, it 
seems t3510-cherry-pick-sequence.sh has 3 tests that basically ensures 
the opposite of what my patch does. Given that there are already 
testcases for the new behaviour, can they be just removed? For now, I 
just disabled them.

 builtin/commit.c                |   79 +++++++++++---------------------------
 sequencer.c                     |   65 ++++++++++++++++++++++++++++++++
 sequencer.h                     |    4 ++
 t/t3507-cherry-pick-conflict.sh |   14 +++++++
 t/t3510-cherry-pick-sequence.sh |    6 +-
 t/test-lib-functions.sh         |    8 +++-
 6 files changed, 116 insertions(+), 60 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 778cf16..4d50484 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -28,6 +28,7 @@
 #include "submodule.h"
 #include "gpg-interface.h"
 #include "column.h"
+#include "sequencer.h"
 
 static const char * const builtin_commit_usage[] = {
 	N_("git commit [options] [--] <filepattern>..."),
@@ -466,8 +467,6 @@ static int is_a_merge(const struct commit *current_head)
 	return !!(current_head->parents && current_head->parents->next);
 }
 
-static const char sign_off_header[] = "Signed-off-by: ";
-
 static void export_one(const char *var, const char *s, const char *e, int hack)
 {
 	struct strbuf buf = STRBUF_INIT;
@@ -552,47 +551,6 @@ static void determine_author_info(struct strbuf *author_ident)
 	}
 }
 
-static int ends_rfc2822_footer(struct strbuf *sb)
-{
-	int ch;
-	int hit = 0;
-	int i, j, k;
-	int len = sb->len;
-	int first = 1;
-	const char *buf = sb->buf;
-
-	for (i = len - 1; i > 0; i--) {
-		if (hit && buf[i] == '\n')
-			break;
-		hit = (buf[i] == '\n');
-	}
-
-	while (i < len - 1 && buf[i] == '\n')
-		i++;
-
-	for (; i < len; i = k) {
-		for (k = i; k < len && buf[k] != '\n'; k++)
-			; /* do nothing */
-		k++;
-
-		if ((buf[k] == ' ' || buf[k] == '\t') && !first)
-			continue;
-
-		first = 0;
-
-		for (j = 0; i + j < len; j++) {
-			ch = buf[i + j];
-			if (ch == ':')
-				break;
-			if (isalnum(ch) ||
-			    (ch == '-'))
-				continue;
-			return 0;
-		}
-	}
-	return 1;
-}
-
 static char *cut_ident_timestamp_part(char *string)
 {
 	char *ket = strrchr(string, '>');
@@ -717,21 +675,30 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		stripspace(&sb, 0);
 
 	if (signoff) {
-		struct strbuf sob = STRBUF_INIT;
-		int i;
+		/*
+		 * See if we have a Conflicts: block at the end. If yes, count
+		 * its size, so we can ignore it.
+		 */
+		int ignore_footer = 0;
+		int i, eol, previous = 0;
+		const char *nl;
 
-		strbuf_addstr(&sob, sign_off_header);
-		strbuf_addstr(&sob, fmt_name(getenv("GIT_COMMITTER_NAME"),
-					     getenv("GIT_COMMITTER_EMAIL")));
-		strbuf_addch(&sob, '\n');
-		for (i = sb.len - 1; i > 0 && sb.buf[i - 1] != '\n'; i--)
-			; /* do nothing */
-		if (prefixcmp(sb.buf + i, sob.buf)) {
-			if (!i || !ends_rfc2822_footer(&sb))
-				strbuf_addch(&sb, '\n');
-			strbuf_addbuf(&sb, &sob);
+		for (i = 0; i < sb.len; i++) {
+			nl = memchr(sb.buf + i, '\n', sb.len - i);
+			if (nl)
+				eol = nl - sb.buf;
+			else
+				eol = sb.len;
+			if (!prefixcmp(sb.buf + previous, "\nConflicts:\n")) {
+				ignore_footer = sb.len - previous;
+				break;
+			}
+			while (i < eol)
+				i++;
+			previous = eol;
 		}
-		strbuf_release(&sob);
+
+		append_signoff(&sb, ignore_footer);
 	}
 
 	if (fwrite(sb.buf, 1, sb.len, s->fp) < sb.len)
diff --git a/sequencer.c b/sequencer.c
index f86f116..e691b08 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -17,6 +17,8 @@
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
+const char sign_off_header[] = "Signed-off-by: ";
+
 void remove_sequencer_state(void)
 {
 	struct strbuf seq_dir = STRBUF_INIT;
@@ -233,6 +235,9 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 		die(_("%s: Unable to write new index file"), action_name(opts));
 	rollback_lock_file(&index_lock);
 
+	if (opts->signoff)
+		append_signoff(msgbuf, 0);
+
 	if (!clean) {
 		int i;
 		strbuf_addstr(msgbuf, "\nConflicts:\n");
@@ -1011,3 +1016,63 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 	save_opts(opts);
 	return pick_commits(todo_list, opts);
 }
+
+static int ends_rfc2822_footer(struct strbuf *sb)
+{
+	int ch;
+	int hit = 0;
+	int i, j, k;
+	int len = sb->len;
+	int first = 1;
+	const char *buf = sb->buf;
+
+	for (i = len - 1; i > 0; i--) {
+		if (hit && buf[i] == '\n')
+			break;
+		hit = (buf[i] == '\n');
+	}
+
+	while (i < len - 1 && buf[i] == '\n')
+		i++;
+
+	for (; i < len; i = k) {
+		for (k = i; k < len && buf[k] != '\n'; k++)
+			; /* do nothing */
+		k++;
+
+		if ((buf[k] == ' ' || buf[k] == '\t') && !first)
+			continue;
+
+		first = 0;
+
+		for (j = 0; i + j < len; j++) {
+			ch = buf[i + j];
+			if (ch == ':')
+				break;
+			if (isalnum(ch) ||
+			    (ch == '-'))
+				continue;
+			return 0;
+		}
+	}
+	return 1;
+}
+
+void append_signoff(struct strbuf *msgbuf, int ignore_footer)
+{
+	struct strbuf sob = STRBUF_INIT;
+	int i;
+
+	strbuf_addstr(&sob, sign_off_header);
+	strbuf_addstr(&sob, fmt_name(getenv("GIT_COMMITTER_NAME"),
+				getenv("GIT_COMMITTER_EMAIL")));
+	strbuf_addch(&sob, '\n');
+	for (i = msgbuf->len - 1 - ignore_footer; i > 0 && msgbuf->buf[i - 1] != '\n'; i--)
+		; /* do nothing */
+	if (prefixcmp(msgbuf->buf + i, sob.buf)) {
+		if (!i || !ends_rfc2822_footer(msgbuf))
+			strbuf_addch(msgbuf, '\n');
+		strbuf_addbuf(msgbuf, &sob);
+	}
+	strbuf_release(&sob);
+}
diff --git a/sequencer.h b/sequencer.h
index d849420..60287b8 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -49,4 +49,8 @@ extern void remove_sequencer_state(void);
 
 int sequencer_pick_revisions(struct replay_opts *opts);
 
+extern const char sign_off_header[];
+
+void append_signoff(struct strbuf *msgbuf, int ignore_footer);
+
 #endif
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index 0c81b3c..b67756f 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -30,6 +30,7 @@ test_expect_success setup '
 	test_commit initial foo a &&
 	test_commit base foo b &&
 	test_commit picked foo c &&
+	test_commit --signoff picked-signed foo d &&
 	git config advice.detachedhead false
 
 '
@@ -340,4 +341,17 @@ test_expect_success 'revert conflict, diff3 -m style' '
 	test_cmp expected actual
 '
 
+test_expect_success 'failed cherry-pick does not forget -s' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick -s picked &&
+	test_i18ngrep -e "Signed-off-by" .git/MERGE_MSG
+'
+
+test_expect_success 'commit after failed cherry-pick does not add duplicated -s' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick -s picked-signed &&
+	git commit -a -s &&
+	test $(git show -s |grep -c "Signed-off-by") = 1
+'
+
 test_done
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index f4e6450..b5fb527 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -410,7 +410,7 @@ test_expect_success '--continue respects -x in first commit in multi-pick' '
 	grep "cherry picked from.*$picked" msg
 '
 
-test_expect_success '--signoff is not automatically propagated to resolved conflict' '
+test_expect_failure '--signoff is automatically propagated to resolved conflict' '
 	pristine_detach initial &&
 	test_expect_code 1 git cherry-pick --signoff base..anotherpick &&
 	echo "c" >foo &&
@@ -428,7 +428,7 @@ test_expect_success '--signoff is not automatically propagated to resolved confl
 	grep "Signed-off-by:" anotherpick_msg
 '
 
-test_expect_success '--signoff dropped for implicit commit of resolution, multi-pick case' '
+test_expect_failure '--signoff dropped for implicit commit of resolution, multi-pick case' '
 	pristine_detach initial &&
 	test_must_fail git cherry-pick -s picked anotherpick &&
 	echo c >foo &&
@@ -441,7 +441,7 @@ test_expect_success '--signoff dropped for implicit commit of resolution, multi-
 	! grep Signed-off-by: msg
 '
 
-test_expect_success 'sign-off needs to be reaffirmed after conflict resolution, single-pick case' '
+test_expect_failure 'sign-off needs to be reaffirmed after conflict resolution, single-pick case' '
 	pristine_detach initial &&
 	test_must_fail git cherry-pick -s picked &&
 	echo c >foo &&
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 9bc57d2..bbb7b7d 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -149,6 +149,12 @@ test_commit () {
 		notick=yes
 		shift
 	fi &&
+	signoff= &&
+	if test "z$1" = "z--signoff"
+	then
+		signoff="$1"
+		shift
+	fi &&
 	file=${2:-"$1.t"} &&
 	echo "${3-$1}" > "$file" &&
 	git add "$file" &&
@@ -156,7 +162,7 @@ test_commit () {
 	then
 		test_tick
 	fi &&
-	git commit -m "$1" &&
+	git commit $signoff -m "$1" &&
 	git tag "$1"
 }
 
-- 
1.7.7
