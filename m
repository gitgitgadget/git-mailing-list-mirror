From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] merge & sequencer: turn "Conflicts:" hint into a comment
Date: Fri, 24 Oct 2014 14:24:37 -0700
Message-ID: <xmqqr3xxf9ey.fsf_-_@gitster.dls.corp.google.com>
References: <xmqq1tpxgw6t.fsf@gitster.dls.corp.google.com>
	<xmqqvbn9f9ig.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 24 23:24:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XhmLn-0007hj-D8
	for gcvg-git-2@plane.gmane.org; Fri, 24 Oct 2014 23:24:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756546AbaJXVYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2014 17:24:41 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55319 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752865AbaJXVYj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2014 17:24:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BCE30181BB;
	Fri, 24 Oct 2014 17:24:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7pstejfwhv/AxeEoTR/ALom2CQo=; b=BIVecd
	iywI8zfL8zoqbiKxJwcL9dsoKh40zk+N6/g7hGn5kWMAILA6ZQTWMXsaJXrhNeGl
	JKlsgQl8AWwZt9Ad3rB0ndLFm1JXvRJlasqeJmHfVIvdOedN7Y8BN10BOf6Weyki
	EqNVjTY2rcWo+g9IH55mR0s6Jmh6W+QTgDPIg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eU4nvCez+TdAwVMhN3yIcxG3fpzagGIz
	/QA1LYIFBic1L2iP5NrZ2cSENa9Y7C/TMXNthLDfXJjZZPFTzb/JjuG20Q2R2yXi
	PTphEatyOpkW7IuOmn7gV42bT6ChApTYz+jF9KPEvVwwsJFcExVWctDQnpk/oGrJ
	49z5ojZvEjs=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B45E1181BA;
	Fri, 24 Oct 2014 17:24:38 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3C44C181B9;
	Fri, 24 Oct 2014 17:24:38 -0400 (EDT)
In-Reply-To: <xmqqvbn9f9ig.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 24 Oct 2014 14:22:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 28B3FA82-5BC4-11E4-A103-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just like other hints such as "Change to be committed" we show in
the editor to remind the committer what paths were involved in the
resulting commit to improve their log message, this section is
merely a reminder.  Traditionally, it was not made into comments
primarily because it has to be generated outside wt-status
infrastructure, and secondary it was meant as a bit stronger
reminder than the rest (i.e. explaining how you resolved conflicts
is much more important than mentioning what you did to every paths
involved in the commit), but that still does not make this hint a
hint, which should be commented out by default.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/commit.c                | 42 ++++++++++++++++++++---------------------
 sequencer.c                     |  7 +++----
 t/t3507-cherry-pick-conflict.sh | 22 +++++++++++++--------
 3 files changed, 38 insertions(+), 33 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index fedb45a..3a1d1a8 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -719,30 +719,30 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		stripspace(&sb, 0);
 
 	if (signoff) {
-		/*
-		 * See if we have a Conflicts: block at the end. If yes, count
-		 * its size, so we can ignore it.
-		 */
-		int ignore_footer = 0;
-		int i, eol, previous = 0;
-		const char *nl;
-
-		for (i = 0; i < sb.len; i++) {
-			nl = memchr(sb.buf + i, '\n', sb.len - i);
-			if (nl)
-				eol = nl - sb.buf;
+		/* Ignore comments and blanks after the trailer */
+		int boc = 0;
+		int bol = 0;
+
+		while (bol < sb.len) {
+			char *next_line;
+
+			if (!(next_line = memchr(sb.buf + bol, '\n', sb.len - bol)))
+				next_line = sb.buf + sb.len;
 			else
-				eol = sb.len;
-			if (!prefixcmp(sb.buf + previous, "\nConflicts:\n")) {
-				ignore_footer = sb.len - previous;
-				break;
+				next_line++;
+
+			if (sb.buf[bol] == comment_line_char || sb.buf[bol] == '\n') {
+				/* is this the first of the run of comments? */
+				if (!boc)
+					boc = bol;
+				/* otherwise, it is just continuing */
+			} else if (boc) {
+				/* the previous was not trailing comment */
+				boc = 0;
 			}
-			while (i < eol)
-				i++;
-			previous = eol;
+			bol = next_line - sb.buf;
 		}
-
-		append_signoff(&sb, ignore_footer, 0);
+		append_signoff(&sb, boc ? sb.len - boc : 0, 0);
 	}
 
 	if (fwrite(sb.buf, 1, sb.len, s->fp) < sb.len)
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
index 223b984..fa04226 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -351,18 +351,24 @@ test_expect_success 'commit after failed cherry-pick does not add duplicated -s'
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
 
-- 
2.1.2-595-g1568c45
