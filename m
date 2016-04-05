From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 1/4] pretty: expand tabs in indented logs to make things line up properly
Date: Mon,  4 Apr 2016 17:58:34 -0700
Message-ID: <1459817917-32078-2-git-send-email-gitster@pobox.com>
References: <1459293309-25195-1-git-send-email-gitster@pobox.com>
 <1459817917-32078-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 05 02:58:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anFKQ-0002NW-9q
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 02:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752689AbcDEA6n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Apr 2016 20:58:43 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:61434 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752404AbcDEA6l convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Apr 2016 20:58:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D0E6A53083;
	Mon,  4 Apr 2016 20:58:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=0/lw3BV0yJiV
	qhzEltUSXI70N+E=; b=ixRZLgoPYBjMvsogJFA6ykv+L0mhhG9gR+csBKI3He6U
	TQwCfx8zV0Nf/PAkKHiNY4KQOAqU2mr9UPAi3CVMtN19sQOPe+4ew92wk7rnwMNs
	DsIucqvmtCpQEO+k6kDfbLdqt/enIACONGG3WC4iMHCLj3aEAM2OVQN0opsMTEk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=XxZ7uw
	cyOac3X8CRPolXapysMDW7kcwiVjRE9wQjaUPghUiD/lWuZ6CquLZNn/6XEqwp3F
	oYFdStP3f0JIbJB/0MS+a/uqvterPP0oDaDnnRGsgEgcNPztAmur+T3Q2pLVCFL/
	smk9Rj1aKue1bjd7UDUbdJo3FHH135eI+PRtI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C8CFA53082;
	Mon,  4 Apr 2016 20:58:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 380C353081;
	Mon,  4 Apr 2016 20:58:40 -0400 (EDT)
X-Mailer: git-send-email 2.8.1-251-g9997610
In-Reply-To: <1459817917-32078-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 893B6C28-FAC9-11E5-8F64-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290741>

=46rom: Linus Torvalds <torvalds@linux-foundation.org>

A commit log message sometimes tries to line things up using tabs,
assuming fixed-width font with the standard 8-place tab settings.
Viewing such a commit however does not work well in "git log", as
we indent the lines by prefixing 4 spaces in front of them.

This should all line up:

  Column 1	Column 2
  --------	--------
  A		B
  ABCD		EFGH
  SPACES        Instead of Tabs

Even with multi-byte UTF8 characters:

  Column 1	Column 2
  --------	--------
  =C3=84		B
  =C3=A5=C3=A4=C3=B6		100
  A M=C3=B8=C3=B8se	once bit my sister..

Tab-expand the lines in "git log --expand-tabs" output before
prefixing 4 spaces.

This is based on the patch by Linus Torvalds, but at this step, we
require an explicit command line option to enable the behaviour.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/pretty-options.txt |  5 +++
 commit.h                         |  1 +
 log-tree.c                       |  1 +
 pretty.c                         | 71 ++++++++++++++++++++++++++++++++=
++++++--
 revision.c                       |  2 ++
 revision.h                       |  1 +
 6 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-op=
tions.txt
index 4b659ac..d820653 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -42,6 +42,11 @@ people using 80-column terminals.
 	verbatim; this means that invalid sequences in the original
 	commit may be copied to the output.
=20
+--expand-tabs::
+	Perform a tab expansion (replace each tab with enough spaces
+	to fill to the next display column that is multiple of 8)
+	in the log message before showing it in the output.
+
 ifndef::git-rev-list[]
 --notes[=3D<ref>]::
 	Show the notes (see linkgit:git-notes[1]) that annotate the
diff --git a/commit.h b/commit.h
index 5d58be0..a7ef682 100644
--- a/commit.h
+++ b/commit.h
@@ -147,6 +147,7 @@ struct pretty_print_context {
 	int preserve_subject;
 	struct date_mode date_mode;
 	unsigned date_mode_explicit:1;
+	unsigned expand_tabs_in_log:1;
 	int need_8bit_cte;
 	char *notes_message;
 	struct reflog_walk_info *reflog_info;
diff --git a/log-tree.c b/log-tree.c
index 60f9839..78a5381 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -683,6 +683,7 @@ void show_log(struct rev_info *opt)
 	ctx.fmt =3D opt->commit_format;
 	ctx.mailmap =3D opt->mailmap;
 	ctx.color =3D opt->diffopt.use_color;
+	ctx.expand_tabs_in_log =3D opt->expand_tabs_in_log;
 	ctx.output_encoding =3D get_log_output_encoding();
 	if (opt->from_ident.mail_begin && opt->from_ident.name_begin)
 		ctx.from_ident =3D &opt->from_ident;
diff --git a/pretty.c b/pretty.c
index 92b2870..c8b075d 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1629,6 +1629,72 @@ void pp_title_line(struct pretty_print_context *=
pp,
 	strbuf_release(&title);
 }
=20
+static int pp_utf8_width(const char *start, const char *end)
+{
+	int width =3D 0;
+	size_t remain =3D end - start;
+
+	while (remain) {
+		int n =3D utf8_width(&start, &remain);
+		if (n < 0 || !start)
+			return -1;
+		width +=3D n;
+	}
+	return width;
+}
+
+static void strbuf_add_tabexpand(struct strbuf *sb,
+				 const char *line, int linelen)
+{
+	const char *tab;
+
+	while ((tab =3D memchr(line, '\t', linelen)) !=3D NULL) {
+		int width =3D pp_utf8_width(line, tab);
+
+		/*
+		 * If it wasn't well-formed utf8, or it
+		 * had characters with badly defined
+		 * width (control characters etc), just
+		 * give up on trying to align things.
+		 */
+		if (width < 0)
+			break;
+
+		/* Output the data .. */
+		strbuf_add(sb, line, tab - line);
+
+		/* .. and the de-tabified tab */
+		strbuf_addchars(sb, ' ', 8 - (width % 8));
+
+		/* Skip over the printed part .. */
+		linelen -=3D tab + 1 - line;
+		line =3D tab + 1;
+	}
+
+	/*
+	 * Print out everything after the last tab without
+	 * worrying about width - there's nothing more to
+	 * align.
+	 */
+	strbuf_add(sb, line, linelen);
+}
+
+/*
+ * pp_handle_indent() prints out the intendation, and
+ * the whole line (without the final newline), after
+ * de-tabifying.
+ */
+static void pp_handle_indent(struct pretty_print_context *pp,
+			     struct strbuf *sb, int indent,
+			     const char *line, int linelen)
+{
+	strbuf_addchars(sb, ' ', indent);
+	if (pp->expand_tabs_in_log)
+		strbuf_add_tabexpand(sb, line, linelen);
+	else
+		strbuf_add(sb, line, linelen);
+}
+
 void pp_remainder(struct pretty_print_context *pp,
 		  const char **msg_p,
 		  struct strbuf *sb,
@@ -1653,8 +1719,9 @@ void pp_remainder(struct pretty_print_context *pp=
,
=20
 		strbuf_grow(sb, linelen + indent + 20);
 		if (indent)
-			strbuf_addchars(sb, ' ', indent);
-		strbuf_add(sb, line, linelen);
+			pp_handle_indent(pp, sb, indent, line, linelen);
+		else
+			strbuf_add(sb, line, linelen);
 		strbuf_addch(sb, '\n');
 	}
 }
diff --git a/revision.c b/revision.c
index df56fce..e662230 100644
--- a/revision.c
+++ b/revision.c
@@ -1915,6 +1915,8 @@ static int handle_revision_opt(struct rev_info *r=
evs, int argc, const char **arg
 		revs->verbose_header =3D 1;
 		revs->pretty_given =3D 1;
 		get_commit_format(arg+9, revs);
+	} else if (!strcmp(arg, "--expand-tabs")) {
+		revs->expand_tabs_in_log =3D 1;
 	} else if (!strcmp(arg, "--show-notes") || !strcmp(arg, "--notes")) {
 		revs->show_notes =3D 1;
 		revs->show_notes_given =3D 1;
diff --git a/revision.h b/revision.h
index 23857c0..4079753 100644
--- a/revision.h
+++ b/revision.h
@@ -133,6 +133,7 @@ struct rev_info {
 			show_notes_given:1,
 			show_signature:1,
 			pretty_given:1,
+			expand_tabs_in_log:1,
 			abbrev_commit:1,
 			abbrev_commit_given:1,
 			zero_commit:1,
--=20
2.8.1-251-g9997610
