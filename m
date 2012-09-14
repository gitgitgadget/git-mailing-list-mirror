From: Miklos Vajna <vmiklos@suse.cz>
Subject: [PATCH v4] cherry-pick: don't forget -s on failure
Date: Fri, 14 Sep 2012 08:52:03 +0200
Message-ID: <20120914065203.GB878@suse.cz>
References: <20120912195732.GB4722@suse.cz>
 <7vd31qc1p3.fsf@alter.siamese.dyndns.org>
 <7v8vcec13d.fsf@alter.siamese.dyndns.org>
 <20120913073324.GA14383@suse.cz>
 <7v8vcdalby.fsf@alter.siamese.dyndns.org>
 <20120913202714.GD14383@suse.cz>
 <7v1ui57hit.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Robin Stocker <robin@nibor.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 14 08:50:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCPjR-0007ve-QC
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 08:50:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755545Ab2INGuU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 02:50:20 -0400
Received: from cantor2.suse.de ([195.135.220.15]:45152 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753607Ab2INGuS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2012 02:50:18 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id E3857A0FED;
	Fri, 14 Sep 2012 08:50:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v1ui57hit.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205459>

In case 'git cherry-pick -s <commit>' failed, the user had to use 'git
commit -s' (i.e. state the -s option again), which is easy to forget
about.  Instead, write the signed-off-by line early, so plain 'git
commit' will have the same result.

Also update 'git commit -s', so that in case there is already a relevant
Signed-off-by line before the Conflicts: line, it won't add one more at
the end of the message. If there is no such line, then add it before the
the Conflicts: line.

Signed-off-by: Miklos Vajna <vmiklos@suse.cz>
---

On Thu, Sep 13, 2012 at 02:13:46PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> That's decl-after-stmt.

Sorry, added -Wdeclaration-after-statement to CFLAGS now.

> I would have expected that you can just do strbuf_splice() to add
> the &sob into &msgbuf with the original code structure, without a
> substantial rewrite of the function like this.  Perhaps I am missing
> something?

I forgot about strbuf_splice(). ;-) Here is a version with it -- it's 
indeed shorter, even if ends_rfc2822_footer() now has to be aware of a 
possible footer.

 builtin/commit.c                |   79 +++++++++++---------------------------
 sequencer.c                     |   65 ++++++++++++++++++++++++++++++++
 sequencer.h                     |    4 ++
 t/t3507-cherry-pick-conflict.sh |   32 ++++++++++++++++
 t/t3510-cherry-pick-sequence.sh |    6 +-
 t/test-lib-functions.sh         |   20 +++++++--
 6 files changed, 142 insertions(+), 64 deletions(-)

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
index f86f116..dbef5ce 100644
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
+static int ends_rfc2822_footer(struct strbuf *sb, int ignore_footer)
+{
+	int ch;
+	int hit = 0;
+	int i, j, k;
+	int len = sb->len - ignore_footer;
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
+		if (!i || !ends_rfc2822_footer(msgbuf, ignore_footer))
+			strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0, "\n", 1);
+		strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0, sob.buf, sob.len);
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
index 0c81b3c..c82f721 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -30,6 +30,7 @@ test_expect_success setup '
 	test_commit initial foo a &&
 	test_commit base foo b &&
 	test_commit picked foo c &&
+	test_commit --signoff picked-signed foo d &&
 	git config advice.detachedhead false
 
 '
@@ -340,4 +341,35 @@ test_expect_success 'revert conflict, diff3 -m style' '
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
+test_expect_success 'commit after failed cherry-pick adds -s at the right place' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick picked &&
+	git commit -a -s &&
+	pwd &&
+	cat <<EOF > expected &&
+picked
+
+Signed-off-by: C O Mitter <committer@example.com>
+
+Conflicts:
+	foo
+EOF
+
+	git show -s --pretty=format:%B > actual &&
+	test_cmp expected actual
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
index 9bc57d2..0802da5 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -144,11 +144,21 @@ test_pause () {
 
 test_commit () {
 	notick= &&
-	if test "z$1" = "z--notick"
-	then
-		notick=yes
+	signoff= &&
+	while test $# != 0; do
+		case "$1" in
+		--notick)
+			notick=yes
+			;;
+		--signoff)
+			signoff="$1"
+			;;
+		*)
+			break
+			;;
+		esac
 		shift
-	fi &&
+	done &&
 	file=${2:-"$1.t"} &&
 	echo "${3-$1}" > "$file" &&
 	git add "$file" &&
@@ -156,7 +166,7 @@ test_commit () {
 	then
 		test_tick
 	fi &&
-	git commit -m "$1" &&
+	git commit $signoff -m "$1" &&
 	git tag "$1"
 }
 
-- 
1.7.7
