From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/4] merge & sequencer: turn "Conflicts:" hint into a comment
Date: Tue, 28 Oct 2014 14:36:52 -0700
Message-ID: <1414532212-9016-5-git-send-email-gitster@pobox.com>
References: <1414532212-9016-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 28 22:57:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjElU-0007g0-Px
	for gcvg-git-2@plane.gmane.org; Tue, 28 Oct 2014 22:57:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755323AbaJ1V5P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2014 17:57:15 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61438 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753305AbaJ1V5N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2014 17:57:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 622311AFD8;
	Tue, 28 Oct 2014 17:57:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=B8QW
	rVUEHth9tdTExx1S3GihCQY=; b=JJ3siYEABpgHPO9+c8a6+Y6ddoloeb3fiuCD
	4uBzXeRQRiuP3aVDhkuSJL1s+pg7WZ5OIfMLhwgrF4A8qEuJTAZKBjJ2dnL8bfll
	jt+I/CP++N837K9qi2WaGXcs08VxXZunqtEtRCnKxbBY+uDrE12zvjeVmw1pbfxa
	cviUWks=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=DEshGE
	r1Qx5UncNcW4AO1PTvLVGOuvqvJ/Z22oNvfIhlpRf0rXehhU1Eo0DNpxgMCx56fF
	3OaQNXw8qqveBeyAEOS4z0wKKJbRwyM9qw56jGETl8PUIr3qvI84cSFLM6QtxAe6
	A6L0TqmWAiKnvZKvEDwkXsvOSCJVNp3ClyM88=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 585931AFD7;
	Tue, 28 Oct 2014 17:57:13 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 98BAB1AAB3;
	Tue, 28 Oct 2014 17:37:04 -0400 (EDT)
X-Mailer: git-send-email 2.1.2-620-g33c52cb
In-Reply-To: <1414532212-9016-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 8F3B669A-5EEA-11E4-910A-527C6E758C04-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just like other hints such as "Changes to be committed" we show in
the editor to remind the committer what paths were involved in the
resulting commit to help improving their log message, this section
is merely a reminder.

Traditionally, it was not made into comments primarily because it
has to be generated outside the wt-status infrastructure, and also
because it was meant as a bit stronger reminder than the others
(i.e. explaining how you resolved conflicts is much more important
than mentioning what you did to every paths involved in the commit).

But that still does not make this hint a part of the log message
proper, and not showing it as a comment is inviting mistakes.

Note that we still notice "Conflicts:" followed by list of indented
pathnames as an old-style cruft and insert a new Signed-off-by:
before it.  This is so that "commit --amend -s" adds the new S-o-b
at the right place when used on an older commit.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/commit.c                | 47 +++++++++++++++++++++++++++--------------
 sequencer.c                     |  7 +++---
 t/t3507-cherry-pick-conflict.sh | 42 +++++++++++++++++++++++++++++-------
 3 files changed, 68 insertions(+), 28 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index cd455aa..0a78e76 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -596,32 +596,47 @@ static char *cut_ident_timestamp_part(char *string)
 /*
  * Inspect sb and determine the true "end" of the log message, in
  * order to find where to put a new Signed-off-by: line.  Ignored are
- * trailing "Conflict:" block.
+ * trailing comment lines and blank lines, and also the traditional
+ * "Conflicts:" block that is not commented out, so that we can use
+ * "git commit -s --amend" on an existing commit that forgot to remove
+ * it.
  *
  * Returns the number of bytes from the tail to ignore, to be fed as
  * the second parameter to append_signoff().
  */
 static int ignore_non_trailer(struct strbuf *sb)
 {
-	int ignore_footer = 0;
-	int i, eol, previous = 0;
-	const char *nl;
+	int boc = 0;
+	int bol = 0;
+	int in_old_conflicts_block = 0;
 
-	for (i = 0; i < sb->len; i++) {
-		nl = memchr(sb->buf + i, '\n', sb->len - i);
-		if (nl)
-			eol = nl - sb->buf;
+	while (bol < sb->len) {
+		char *next_line;
+
+		if (!(next_line = memchr(sb->buf + bol, '\n', sb->len - bol)))
+			next_line = sb->buf + sb->len;
 		else
-			eol = sb->len;
-		if (!prefixcmp(sb->buf + previous, "\nConflicts:\n")) {
-			ignore_footer = sb->len - previous;
-			break;
+			next_line++;
+
+		if (sb->buf[bol] == comment_line_char || sb->buf[bol] == '\n') {
+			/* is this the first of the run of comments? */
+			if (!boc)
+				boc = bol;
+			/* otherwise, it is just continuing */
+		} else if (!prefixcmp(sb->buf + bol, "Conflicts:\n")) {
+			in_old_conflicts_block = 1;
+			if (!boc)
+				boc = bol;
+		} else if (in_old_conflicts_block && sb->buf[bol] == '\t') {
+			; /* a pathname in the conflicts block */
+		} else if (boc) {
+			/* the previous was not trailing comment */
+			boc = 0;
+			in_old_conflicts_block = 0;
 		}
-		while (i < eol)
-			i++;
-		previous = eol;
+		bol = next_line - sb->buf;
 	}
-	return ignore_footer;
+	return boc ? sb->len - boc : 0;
 }
 
 static int prepare_to_commit(const char *index_file, const char *prefix,
diff --git a/sequencer.c b/sequencer.c
index 0f84bbe..1d97da3 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -291,13 +291,12 @@ void append_conflicts_hint(struct strbuf *msgbuf)
 {
 	int i;
 
-	strbuf_addstr(msgbuf, "\nConflicts:\n");
+	strbuf_addch(msgbuf, '\n');
+	strbuf_commented_addf(msgbuf, "Conflicts:\n");
 	for (i = 0; i < active_nr;) {
 		const struct cache_entry *ce = active_cache[i++];
 		if (ce_stage(ce)) {
-			strbuf_addch(msgbuf, '\t');
-			strbuf_addstr(msgbuf, ce->name);
-			strbuf_addch(msgbuf, '\n');
+			strbuf_commented_addf(msgbuf, "\t%s\n", ce->name);
 			while (i < active_nr && !strcmp(ce->name,
 							active_cache[i]->name))
 				i++;
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index 223b984..7c5ad08 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -351,19 +351,45 @@ test_expect_success 'commit after failed cherry-pick does not add duplicated -s'
 test_expect_success 'commit after failed cherry-pick adds -s at the right place' '
 	pristine_detach initial &&
 	test_must_fail git cherry-pick picked &&
+
 	git commit -a -s &&
-	pwd &&
-	cat <<EOF > expected &&
-picked
 
-Signed-off-by: C O Mitter <committer@example.com>
+	# Do S-o-b and Conflicts appear in the right order?
+	cat <<-\EOF >expect &&
+	Signed-off-by: C O Mitter <committer@example.com>
+	# Conflicts:
+	EOF
+	grep -e "^# Conflicts:" -e '^Signed-off-by' <.git/COMMIT_EDITMSG >actual &&
+	test_cmp expect actual &&
+
+	cat <<-\EOF >expected &&
+	picked
 
-Conflicts:
-	foo
-EOF
+	Signed-off-by: C O Mitter <committer@example.com>
+	EOF
 
-	git show -s --pretty=format:%B > actual &&
+	git show -s --pretty=format:%B >actual &&
 	test_cmp expected actual
 '
 
+test_expect_success 'commit --amend -s places the sign-off at the right place' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick picked &&
+
+	# emulate old-style conflicts block
+	mv .git/MERGE_MSG .git/MERGE_MSG+ &&
+	sed -e "/^# Conflicts:/,\$s/^# *//" <.git/MERGE_MSG+ >.git/MERGE_MSG &&
+
+	git commit -a &&
+	git commit --amend -s &&
+
+	# Do S-o-b and Conflicts appear in the right order?
+	cat <<-\EOF >expect &&
+	Signed-off-by: C O Mitter <committer@example.com>
+	Conflicts:
+	EOF
+	grep -e "^Conflicts:" -e '^Signed-off-by' <.git/COMMIT_EDITMSG >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.1.2-620-g33c52cb
