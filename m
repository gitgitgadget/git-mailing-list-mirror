From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] teach format-patch to place other authors into in-body
 "From"
Date: Wed, 3 Jul 2013 03:08:22 -0400
Message-ID: <20130703070822.GB17730@sigill.intra.peff.net>
References: <20130703070719.GA17638@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 03 09:08:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuHAz-0007P0-EM
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 09:08:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754423Ab3GCHIZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Jul 2013 03:08:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:36058 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754089Ab3GCHIY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 03:08:24 -0400
Received: (qmail 28787 invoked by uid 102); 3 Jul 2013 07:09:35 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 03 Jul 2013 02:09:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Jul 2013 03:08:22 -0400
Content-Disposition: inline
In-Reply-To: <20130703070719.GA17638@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229458>

=46ormat-patch generates emails with the "From" address set to
the author of each patch. If you are going to send the
emails, however, you would want to replace the author
identity with yours (if they are not the same), and bump the
author identity to an in-body header.

Normally this is handled by git-send-email, which does the
transformation before sending out the emails. However, some
workflows may not use send-email (e.g., imap-send, or a
custom script which feeds the mbox to a non-git MUA). They
could each implement this feature themselves, but getting it
right is non-trivial (one most canonicalize the identities
by reversing any RFC2047 encoding or RFC822 quoting of the
headers, which has caused many bugs in send-email over the
years).

This patch takes a different approach: it teaches
format-patch a "--from" option which handles the ident
check and in-body header while it is writing out the email.
It's much simpler to do at this level (because we haven't
done any quoting yet), and any workflow based on
format-patch can easily turn it on.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-format-patch.txt | 15 +++++++++++++
 builtin/log.c                      | 24 +++++++++++++++++++++
 commit.h                           |  5 +++++
 log-tree.c                         |  2 ++
 pretty.c                           | 38 ++++++++++++++++++++++++++++++=
+++
 revision.h                         |  1 +
 t/t4014-format-patch.sh            | 43 ++++++++++++++++++++++++++++++=
++++++++
 7 files changed, 128 insertions(+)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-for=
mat-patch.txt
index 3911877..e394276 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -187,6 +187,21 @@ will want to ensure that threading is disabled for=
 `git send-email`.
 	The negated form `--no-cc` discards all `Cc:` headers added so
 	far (from config or command line).
=20
+--from::
+--from=3D<ident>::
+	Use `ident` in the `From:` header of each commit email. If the
+	author ident of the commit is not textually identical to the
+	provided `ident`, place a `From:` header in the body of the
+	message with the original author. If no `ident` is given, use
+	the committer ident.
++
+Note that this option is only useful if you are actually sending the
+emails and want to identify yourself as the sender, but retain the
+original author (and `git am` will correctly pick up the in-body
+header). Note also that `git send-email` already handles this
+transformation for you, and this option should not be used if you are
+feeding the result to `git send-email`.
+
 --add-header=3D<header>::
 	Add an arbitrary header to the email headers.  This is in addition
 	to any configured headers, and may be used multiple times.
diff --git a/builtin/log.c b/builtin/log.c
index 9e21232..14e60ae 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1112,6 +1112,21 @@ static int cc_callback(const struct option *opt,=
 const char *arg, int unset)
 	return 0;
 }
=20
+static int from_callback(const struct option *opt, const char *arg, in=
t unset)
+{
+	char **from =3D opt->value;
+
+	free(*from);
+
+	if (unset)
+		*from =3D NULL;
+	else if (arg)
+		*from =3D xstrdup(arg);
+	else
+		*from =3D xstrdup(git_committer_info(IDENT_NO_DATE));
+	return 0;
+}
+
 int cmd_format_patch(int argc, const char **argv, const char *prefix)
 {
 	struct commit *commit;
@@ -1134,6 +1149,7 @@ int cmd_format_patch(int argc, const char **argv,=
 const char *prefix)
 	int quiet =3D 0;
 	int reroll_count =3D -1;
 	char *branch_name =3D NULL;
+	char *from =3D NULL;
 	const struct option builtin_format_patch_options[] =3D {
 		{ OPTION_CALLBACK, 'n', "numbered", &numbered, NULL,
 			    N_("use [PATCH n/m] even with a single patch"),
@@ -1177,6 +1193,9 @@ int cmd_format_patch(int argc, const char **argv,=
 const char *prefix)
 			    0, to_callback },
 		{ OPTION_CALLBACK, 0, "cc", NULL, N_("email"), N_("add Cc: header"),
 			    0, cc_callback },
+		{ OPTION_CALLBACK, 0, "from", &from, N_("ident"),
+			    N_("set From address to <ident> (or committer ident if absent)"=
),
+			    PARSE_OPT_OPTARG, from_callback },
 		OPT_STRING(0, "in-reply-to", &in_reply_to, N_("message-id"),
 			    N_("make first mail a reply to <message-id>")),
 		{ OPTION_CALLBACK, 0, "attach", &rev, N_("boundary"),
@@ -1264,6 +1283,11 @@ int cmd_format_patch(int argc, const char **argv=
, const char *prefix)
=20
 	rev.extra_headers =3D strbuf_detach(&buf, NULL);
=20
+	if (from) {
+		if (split_ident_line(&rev.from_ident, from, strlen(from)))
+			die(_("invalid ident line: %s"), from);
+	}
+
 	if (start_number < 0)
 		start_number =3D 1;
=20
diff --git a/commit.h b/commit.h
index 2057201..92c1d23 100644
--- a/commit.h
+++ b/commit.h
@@ -6,6 +6,7 @@
 #include "strbuf.h"
 #include "decorate.h"
 #include "gpg-interface.h"
+#include "string-list.h"
=20
 struct commit_list {
 	struct commit *item;
@@ -95,11 +96,15 @@ struct pretty_print_context {
 	const char *output_encoding;
 	struct string_list *mailmap;
 	int color;
+	struct ident_split *from_ident;
=20
 	/*
 	 * Fields below here are manipulated internally by pp_* functions and
 	 * should not be counted on by callers.
 	 */
+
+	/* Manipulated by the pp_* functions internally. */
+	struct string_list in_body_headers;
 };
=20
 struct userformat_want {
diff --git a/log-tree.c b/log-tree.c
index 2eb69bc..67da27f 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -617,6 +617,8 @@ void show_log(struct rev_info *opt)
 	ctx.fmt =3D opt->commit_format;
 	ctx.mailmap =3D opt->mailmap;
 	ctx.color =3D opt->diffopt.use_color;
+	if (opt->from_ident.mail_begin && opt->from_ident.name_begin)
+		ctx.from_ident =3D &opt->from_ident;
 	pretty_print_commit(&ctx, commit, &msgbuf);
=20
 	if (opt->add_signoff)
diff --git a/pretty.c b/pretty.c
index 68cd7a0..74563c9 100644
--- a/pretty.c
+++ b/pretty.c
@@ -432,6 +432,23 @@ void pp_user_info(struct pretty_print_context *pp,
 		map_user(pp->mailmap, &mailbuf, &maillen, &namebuf, &namelen);
=20
 	if (pp->fmt =3D=3D CMIT_FMT_EMAIL) {
+		if (pp->from_ident) {
+			struct strbuf buf =3D STRBUF_INIT;
+
+			strbuf_addstr(&buf, "From: ");
+			strbuf_add(&buf, namebuf, namelen);
+			strbuf_addstr(&buf, " <");
+			strbuf_add(&buf, mailbuf, maillen);
+			strbuf_addstr(&buf, ">\n");
+			string_list_append(&pp->in_body_headers,
+					   strbuf_detach(&buf, NULL));
+
+			mailbuf =3D pp->from_ident->mail_begin;
+			maillen =3D pp->from_ident->mail_end - mailbuf;
+			namebuf =3D pp->from_ident->name_begin;
+			namelen =3D pp->from_ident->name_end - namebuf;
+		}
+
 		strbuf_addstr(sb, "From: ");
 		if (needs_rfc2047_encoding(namebuf, namelen, RFC2047_ADDRESS)) {
 			add_rfc2047(sb, namebuf, namelen,
@@ -1602,6 +1619,16 @@ void pp_title_line(struct pretty_print_context *=
pp,
 	}
 	strbuf_addch(sb, '\n');
=20
+	if (need_8bit_cte =3D=3D 0) {
+		int i;
+		for (i =3D 0; i < pp->in_body_headers.nr; i++) {
+			if (has_non_ascii(pp->in_body_headers.items[i].string)) {
+				need_8bit_cte =3D 1;
+				break;
+			}
+		}
+	}
+
 	if (need_8bit_cte > 0) {
 		const char *header_fmt =3D
 			"MIME-Version: 1.0\n"
@@ -1615,6 +1642,17 @@ void pp_title_line(struct pretty_print_context *=
pp,
 	if (pp->fmt =3D=3D CMIT_FMT_EMAIL) {
 		strbuf_addch(sb, '\n');
 	}
+
+	if (pp->in_body_headers.nr) {
+		int i;
+		for (i =3D 0; i < pp->in_body_headers.nr; i++) {
+			strbuf_addstr(sb, pp->in_body_headers.items[i].string);
+			free(pp->in_body_headers.items[i].string);
+		}
+		string_list_clear(&pp->in_body_headers, 0);
+		strbuf_addch(sb, '\n');
+	}
+
 	strbuf_release(&title);
 }
=20
diff --git a/revision.h b/revision.h
index eeea6fb..7e3a185 100644
--- a/revision.h
+++ b/revision.h
@@ -140,6 +140,7 @@ struct rev_info {
 	int		numbered_files;
 	int		reroll_count;
 	char		*message_id;
+	struct ident_split from_ident;
 	struct string_list *ref_message_ids;
 	int		add_signoff;
 	const char	*extra_headers;
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 58d4180..668933b 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -972,6 +972,49 @@ test_expect_success 'empty subject prefix does not=
 have extra space' '
 	test_cmp expect actual
 '
=20
+test_expect_success '--from=3Dident notices bogus ident' '
+	test_must_fail git format-patch -1 --stdout --from=3Dfoo >patch
+'
+
+test_expect_success '--from=3Dident replaces author' '
+	git format-patch -1 --stdout --from=3D"Me <me@example.com>" >patch &&
+	cat >expect <<-\EOF &&
+	From: Me <me@example.com>
+
+	From: A U Thor <author@example.com>
+
+	EOF
+	sed -ne "/^From:/p; /^$/p; /^---$/q" <patch >patch.head &&
+	test_cmp expect patch.head
+'
+
+test_expect_success '--from uses committer ident' '
+	git format-patch -1 --stdout --from >patch &&
+	cat >expect <<-\EOF &&
+	From: C O Mitter <committer@example.com>
+
+	From: A U Thor <author@example.com>
+
+	EOF
+	sed -ne "/^From:/p; /^$/p; /^---$/q" <patch >patch.head &&
+	test_cmp expect patch.head
+'
+
+test_expect_success 'in-body headers trigger content encoding' '
+	GIT_AUTHOR_NAME=3D"=C3=A9x=C3=B6t=C3=ACc" test_commit exotic &&
+	test_when_finished "git reset --hard HEAD^" &&
+	git format-patch -1 --stdout --from >patch &&
+	cat >expect <<-\EOF &&
+	From: C O Mitter <committer@example.com>
+	Content-Type: text/plain; charset=3DUTF-8
+
+	From: =C3=A9x=C3=B6t=C3=ACc <author@example.com>
+
+	EOF
+	sed -ne "/^From:/p; /^$/p; /^Content-Type/p; /^---$/q" <patch >patch.=
head &&
+	test_cmp expect patch.head
+'
+
 append_signoff()
 {
 	C=3D$(git commit-tree HEAD^^{tree} -p HEAD) &&
--=20
1.8.3.26.g3f85fc7
