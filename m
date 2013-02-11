From: Jeff King <peff@peff.net>
Subject: [PATCH] log: re-encode commit messages before grepping
Date: Mon, 11 Feb 2013 15:59:58 -0500
Message-ID: <20130211205958.GA32740@sigill.intra.peff.net>
References: <201302090052.22053.thom311@gmail.com>
 <7vsj56xsg5.fsf@alter.siamese.dyndns.org>
 <7vobfuxrns.fsf@alter.siamese.dyndns.org>
 <20130209002710.GA5570@sigill.intra.peff.net>
 <7vfw16xqvj.fsf@alter.siamese.dyndns.org>
 <7va9rexqii.fsf@alter.siamese.dyndns.org>
 <20130211191607.GA21269@sigill.intra.peff.net>
 <7v621ymxfv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Haller <thom311@gmail.com>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 22:00:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U50UG-0005y9-9m
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 22:00:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244Ab3BKVAB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Feb 2013 16:00:01 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44587 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932078Ab3BKVAB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 16:00:01 -0500
Received: (qmail 26861 invoked by uid 107); 11 Feb 2013 21:01:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 11 Feb 2013 16:01:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Feb 2013 15:59:58 -0500
Content-Disposition: inline
In-Reply-To: <7v621ymxfv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216086>

If you run "git log --grep=3Dfoo", we will run your regex on
the literal bytes of the commit message. This can provide
confusing results if the commit message is not in the same
encoding as your grep expression (or worse, you have commits
in multiple encodings, in which case your regex would need
to be written to match either encoding). On top of this, we
might also be grepping in the commit's notes, which are
already re-encoded, potentially leading to grepping in a
buffer with mixed encodings concatenated. This is insanity,
but most people never noticed, because their terminal and
their commit encodings all match.

Instead, let's massage the to-be-grepped commit into a
standardized encoding. There is not much point in adding a
flag for "this is the encoding I expect my grep pattern to
match"; the only sane choice is for it to use the log output
encoding. That is presumably what the user's terminal is
using, and it means that the patterns found by the grep will
match the output produced by git.

As a bonus, this fixes a potential segfault in commit_match
when commit->buffer is NULL, as we now build on logmsg_reencode,
which handles reading the commit buffer from disk if
necessary. The segfault can be triggered with:

        git commit -m 'text1' --allow-empty
        git commit -m 'text2' --allow-empty
        git log --graph --no-walk --grep 'text2'

which arguably does not make any sense (--graph inherently
wants a connected history, and by --no-walk the command line
is telling us to show discrete points in history without
connectivity), and we probably should forbid the
combination, but that is a separate issue.

Signed-off-by: Jeff King <peff@peff.net>
---
A few notes:

  1. I suppose we could also use $LANG or one of the $LC_* variables to
     guess at the encoding of the user's pattern. But I think using the
     output encoding makes the most sense, since then the pattern you
     searched for will actually be in the output.

  2. There are still problems with utf8 normalization. E.g., my tests
     represent utf-8 =C3=A9 with \xc3\xa9 (the code point for that glyp=
h),
     but it could also be represented by \x65\xcc\x81 (e + combining
     acute). But that is not a new problem; it is an inherent issue wit=
h
     grepping utf8. We might in the future want to offer an option to
     normalize utf8 (or possibly the regex library can be taught to
     handle this).

  3. If the commit does need to be re-encoded, we end up doing so here,
     and then potentially again if we actually show the commit. So
     there may be some room to optimize that by stashing the re-encoded
     version somewhere (or it may not make a big difference, I haven't
     measured).

  4. I'm still not clear on why "--graph --no-walk" wants to look at
     commit_match after we have already cleared the commit buffer. I
     agree it's nonsensical, but I wonder if it might be a symptom of a=
n
     underlying bug or inefficiency.

 revision.c          | 27 ++++++++++++++++++-------
 t/t4210-log-i18n.sh | 58 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 78 insertions(+), 7 deletions(-)
 create mode 100755 t/t4210-log-i18n.sh

diff --git a/revision.c b/revision.c
index d7562ee..ef60205 100644
--- a/revision.c
+++ b/revision.c
@@ -2268,7 +2268,10 @@ static int commit_match(struct commit *commit, s=
truct rev_info *opt)
 static int commit_match(struct commit *commit, struct rev_info *opt)
 {
 	int retval;
+	const char *encoding;
+	char *message;
 	struct strbuf buf =3D STRBUF_INIT;
+
 	if (!opt->grep_filter.pattern_list && !opt->grep_filter.header_list)
 		return 1;
=20
@@ -2279,13 +2282,23 @@ static int commit_match(struct commit *commit, =
struct rev_info *opt)
 		strbuf_addch(&buf, '\n');
 	}
=20
+	/*
+	 * We grep in the user's output encoding, under the assumption that i=
t
+	 * is the encoding they are most likely to write their grep pattern
+	 * for. In addition, it means we will match the "notes" encoding belo=
w,
+	 * so we will not end up with a buffer that has two different encodin=
gs
+	 * in it.
+	 */
+	encoding =3D get_log_output_encoding();
+	message =3D logmsg_reencode(commit, encoding);
+
 	/* Copy the commit to temporary if we are using "fake" headers */
 	if (buf.len)
-		strbuf_addstr(&buf, commit->buffer);
+		strbuf_addstr(&buf, message);
=20
 	if (opt->grep_filter.header_list && opt->mailmap) {
 		if (!buf.len)
-			strbuf_addstr(&buf, commit->buffer);
+			strbuf_addstr(&buf, message);
=20
 		commit_rewrite_person(&buf, "\nauthor ", opt->mailmap);
 		commit_rewrite_person(&buf, "\ncommitter ", opt->mailmap);
@@ -2294,18 +2307,18 @@ static int commit_match(struct commit *commit, =
struct rev_info *opt)
 	/* Append "fake" message parts as needed */
 	if (opt->show_notes) {
 		if (!buf.len)
-			strbuf_addstr(&buf, commit->buffer);
-		format_display_notes(commit->object.sha1, &buf,
-				     get_log_output_encoding(), 1);
+			strbuf_addstr(&buf, message);
+		format_display_notes(commit->object.sha1, &buf, encoding, 1);
 	}
=20
-	/* Find either in the commit object, or in the temporary */
+	/* Find either in the original commit message, or in the temporary */
 	if (buf.len)
 		retval =3D grep_buffer(&opt->grep_filter, buf.buf, buf.len);
 	else
 		retval =3D grep_buffer(&opt->grep_filter,
-				     commit->buffer, strlen(commit->buffer));
+				     message, strlen(message));
 	strbuf_release(&buf);
+	logmsg_free(message, commit);
 	return retval;
 }
=20
diff --git a/t/t4210-log-i18n.sh b/t/t4210-log-i18n.sh
new file mode 100755
index 0000000..52a7472
--- /dev/null
+++ b/t/t4210-log-i18n.sh
@@ -0,0 +1,58 @@
+#!/bin/sh
+
+test_description=3D'test log with i18n features'
+. ./test-lib.sh
+
+# two forms of =C3=A9
+utf8_e=3D$(printf '\303\251')
+latin1_e=3D$(printf '\351')
+
+test_expect_success 'create commits in different encodings' '
+	test_tick &&
+	cat >msg <<-EOF &&
+	utf8
+
+	t${utf8_e}st
+	EOF
+	git add msg &&
+	git -c i18n.commitencoding=3Dutf8 commit -F msg &&
+	cat >msg <<-EOF &&
+	latin1
+
+	t${latin1_e}st
+	EOF
+	git add msg &&
+	git -c i18n.commitencoding=3DISO-8859-1 commit -F msg
+'
+
+test_expect_success 'log --grep searches in log output encoding (utf8)=
' '
+	cat >expect <<-\EOF &&
+	latin1
+	utf8
+	EOF
+	git log --encoding=3Dutf8 --format=3D%s --grep=3D$utf8_e >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --grep searches in log output encoding (latin=
1)' '
+	cat >expect <<-\EOF &&
+	latin1
+	utf8
+	EOF
+	git log --encoding=3DISO-8859-1 --format=3D%s --grep=3D$latin1_e >act=
ual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --grep does not find non-reencoded values (ut=
f8)' '
+	>expect &&
+	git log --encoding=3Dutf8 --format=3D%s --grep=3D$latin1_e >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --grep does not find non-reencoded values (la=
tin1)' '
+	>expect &&
+	git log --encoding=3DISO-8859-1 --format=3D%s --grep=3D$utf8_e >actua=
l &&
+	test_cmp expect actual
+'
+
+test_done
--=20
1.8.1.2.11.g1a2f572
