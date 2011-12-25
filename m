From: =?iso-8859-1?Q?Sidney_San_Mart=EDn?= <s@sidneysm.com>
Subject: [PATCH] Support wrapping commit messages when you read them
Date: Sat, 24 Dec 2011 21:05:32 -0800
Message-ID: <8DE6E894-B50D-4F7E-AE18-C10E7E40A550@sidneysm.com>
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 25 06:06:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RegHb-0005en-1U
	for gcvg-git-2@lo.gmane.org; Sun, 25 Dec 2011 06:06:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800Ab1LYFFl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Dec 2011 00:05:41 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42427 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730Ab1LYFFk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Dec 2011 00:05:40 -0500
Received: by iaeh11 with SMTP id h11so17285010iae.19
        for <git@vger.kernel.org>; Sat, 24 Dec 2011 21:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sidneysm.com; s=google;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :to:mime-version:x-mailer;
        bh=9cNHwBOie5Ygv7KVoQGR12vc6U6ktefSQqNPPpa/Ijc=;
        b=LNgmSpqb+syPL0zpGq3cFNyVqReIlxr87zSCCXjnRes1wHhRxt4KFbl6rNNWus0WEX
         WgYY7CBdmf3v8a18ne42YUMst++WoVZbquMLaZd6n06Fz2S+V7r/Id6JxrgeiZq16kkP
         /4P+MgU2757NtobNzi7uifQF0PqO1q93tMGSo=
Received: by 10.50.168.2 with SMTP id zs2mr20653172igb.9.1324789539471;
        Sat, 24 Dec 2011 21:05:39 -0800 (PST)
Received: from [172.20.10.2] (mobile-166-205-136-221.mycingular.net. [166.205.136.221])
        by mx.google.com with ESMTPS id l28sm61153233ibc.3.2011.12.24.21.05.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 24 Dec 2011 21:05:39 -0800 (PST)
X-Mailer: Apple Mail (2.1251.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187678>

=46airly simpleminded line wrapping that makes commit messages
readable if they weren=92t wrapped by the committer.

- Use strbuf_add_wrapped_text() to do the dirty work
- Detect simple lists which begin with "+ ", "* ", or "- " and indent
  them appropriately (like this line)
- Print lines which begin with whitespace as-is (e.g. code samples)

Add --wrap[=3D<width>] and --no-wrap to commands that pretty-print comm=
it
messages, and add log.wrap and log.wrap.width configuration options.

log.wrap defaults to never, and can be set to never/false, auto/true,
or always. If auto, hijack want_color() to decide whether it=92s
appropriate to use line wrapping. (This is a little hacky, but as far
as I can tell the conditions for auto color and auto wrapping are the
same. Maybe it would make sense to rename want_color()?)

log.wrap.width defaults to 80.

Signed-off-by: Sidney San Mart=EDn <s@sidneysm.com>
---

I hope I=92m doing this right!

Consider this a first draft of the new feature I brought up a few weeks=
 ago.


 Documentation/config.txt         |    8 ++++
 Documentation/pretty-options.txt |   14 +++++++
 commit.h                         |    6 +++
 log-tree.c                       |    1 +
 pretty.c                         |   71 ++++++++++++++++++++++++++++++=
+++++++-
 revision.c                       |   10 +++++
 revision.h                       |    3 ++
 7 files changed, 112 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6e63b59..b8c1a81 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1403,6 +1403,14 @@ log.showroot::
 	Tools like linkgit:git-log[1] or linkgit:git-whatchanged[1], which
 	normally hide the root commit will now show it. True by default.
=20
+log.wrap::
+	Commit message wrapping. May be set to always, false (or never) or
+	auto (or true), in which case commit messages are only wrapped when
+	the output is to a terminal. Defaults to false. See linkgit:git-log[1=
].
+
+log.wrap.width::
+	Line width for commit message wrapping. Defaults to 80 characters.
+
 mailmap.file::
 	The location of an augmenting mailmap file. The default
 	mailmap, located in the root of the repository, is loaded
diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-op=
tions.txt
index 2a3dc86..7601a43 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -10,6 +10,20 @@
 Note: you can specify the default pretty format in the repository
 configuration (see linkgit:git-config[1]).
=20
+--wrap[=3D<width>]::
+	Word-wrap commit messages to the specified width, 80 characters
+	by default. Lines beginning with +, *, or - and a space, or with a
+	number followed by a period and a space, are interpreted as lists
+	and wrapped with a hanging indent. Lines beginning with whitespace
+	(e.g. code samples) are left as-is.
++
+Note: you can specify the default wrapping behavior in the repository
+configuration (see linkgit:git-config[1]).
+
+--no-wrap::
+	Turn off commit message wrapping. This is the default (unless
+	otherwise specified in the repository configuration).
+
 --abbrev-commit::
 	Instead of showing the full 40-byte hexadecimal commit object
 	name, show only a partial prefix.  Non default number of
diff --git a/commit.h b/commit.h
index 4df3978..1321666 100644
--- a/commit.h
+++ b/commit.h
@@ -86,6 +86,12 @@ struct pretty_print_context {
 	int show_notes;
 	struct reflog_walk_info *reflog_info;
 	const char *output_encoding;
+	struct wrap_options {
+		unsigned int
+			width,
+			wrap:1,
+			wrap_given:1;
+	} wrap;
 };
=20
 struct userformat_want {
diff --git a/log-tree.c b/log-tree.c
index 319bd31..3dfa944 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -414,6 +414,7 @@ void show_log(struct rev_info *opt)
=20
 	opt->loginfo =3D NULL;
 	ctx.show_notes =3D opt->show_notes;
+	ctx.wrap =3D opt->wrap;
 	if (!opt->verbose_header) {
 		graph_show_commit(opt->graph);
=20
diff --git a/pretty.c b/pretty.c
index 1580299..133bc53 100644
--- a/pretty.c
+++ b/pretty.c
@@ -23,6 +23,10 @@ static size_t commit_formats_len;
 static size_t commit_formats_alloc;
 static struct cmt_fmt_map *find_commit_format(const char *sought);
=20
+static unsigned int wrap_configured =3D 0;
+static unsigned int wrap =3D 0;
+static unsigned int wrap_width =3D 80;
+
 static void save_user_format(struct rev_info *rev, const char *cp, int=
 is_tformat)
 {
 	free(user_format);
@@ -172,6 +176,63 @@ void get_commit_format(const char *arg, struct rev=
_info *rev)
 	}
 }
=20
+static int git_wrap_config(const char *name, const char *value, void *=
cb)
+{
+	wrap_configured =3D 1;
+
+	if (prefixcmp(name, "log.wrap"))
+		return 0;
+
+	if (name[8] =3D=3D '\0') {
+		if (value && !strcmp(value, "always")) {
+			wrap =3D 1;
+		} else if (value && !strcmp(value, "never")) {
+			wrap =3D 0;
+		} else if (!value || !strcmp(value, "auto") || git_config_bool(name,=
 value)) {
+			wrap =3D want_color(GIT_COLOR_AUTO);
+		}
+	} else if (name[8] =3D=3D '.') {
+		name +=3D 9;
+		if (!strcmp(name, "width")) {
+			wrap_width =3D git_config_int(name, value);
+		}
+	}
+	return 0;
+}
+
+static unsigned int want_wrap(struct wrap_options options)
+{
+	if(!wrap_configured)
+		git_config(git_wrap_config, NULL);
+	return (options.wrap_given ? options.wrap : wrap);
+}
+static unsigned int get_wrap_width(struct wrap_options options)
+{
+	if(!wrap_configured)
+		git_config(git_wrap_config, NULL);
+	return options.width ? options.width : wrap_width;
+}
+
+static int line_list_prefix(const char *line, int len)
+{
+	unsigned int numberLength =3D 0;
+	const char *pos =3D line;
+	if (len < 3) {
+		return 0;
+	} else if ((line[0] =3D=3D '*' || line[0] =3D=3D '+' || line[0] =3D=3D=
 '-') && line[1] =3D=3D ' ') {
+		return 2;
+	} else {
+		while (pos - line < len && pos[0] >=3D '0' && pos[0] <=3D '9'){
+			numberLength++;
+			pos++;
+		}
+		if (numberLength && pos - line + 1 < len && pos[0] =3D=3D '.' && pos=
[1] =3D=3D ' ') {
+			return numberLength + 2;
+		}
+	}
+	return 0;
+}
+
 /*
  * Generic support for pretty-printing the header
  */
@@ -1246,6 +1307,8 @@ void pp_remainder(const struct pretty_print_conte=
xt *pp,
 		  struct strbuf *sb,
 		  int indent)
 {
+	unsigned int wrap =3D want_wrap(pp->wrap);
+	unsigned int width =3D get_wrap_width(pp->wrap);
 	int first =3D 1;
 	for (;;) {
 		const char *line =3D *msg_p;
@@ -1268,7 +1331,13 @@ void pp_remainder(const struct pretty_print_cont=
ext *pp,
 			memset(sb->buf + sb->len, ' ', indent);
 			strbuf_setlen(sb, sb->len + indent);
 		}
-		strbuf_add(sb, line, linelen);
+		if (wrap && linelen && line[0] !=3D ' ' && line[0] !=3D '\t') {
+			struct strbuf wrapped =3D STRBUF_INIT;
+			strbuf_add(&wrapped, line, linelen);
+			strbuf_add_wrapped_text(sb, wrapped.buf, 0, indent + line_list_pref=
ix(line, linelen), width - indent);
+		} else {
+			strbuf_add(sb, line, linelen);
+		}
 		strbuf_addch(sb, '\n');
 	}
 }
diff --git a/revision.c b/revision.c
index 8764dde..ca4b386 100644
--- a/revision.c
+++ b/revision.c
@@ -1465,6 +1465,16 @@ static int handle_revision_opt(struct rev_info *=
revs, int argc, const char **arg
 		revs->verbose_header =3D 1;
 		revs->pretty_given =3D 1;
 		get_commit_format(arg+9, revs);
+	} else if (!strcmp(arg, "--wrap")) {
+		revs->wrap.wrap =3D 1;
+		revs->wrap.wrap_given =3D 1;
+	} else if (!prefixcmp(arg, "--wrap=3D")) {
+		revs->wrap.wrap =3D 1;
+		revs->wrap.wrap_given =3D 1;
+		revs->wrap.width =3D atoi(arg+7);
+	} else if (!prefixcmp(arg, "--no-wrap")) {
+		revs->wrap.wrap =3D 0;
+		revs->wrap.wrap_given =3D 1;
 	} else if (!strcmp(arg, "--show-notes") || !strcmp(arg, "--notes")) {
 		revs->show_notes =3D 1;
 		revs->show_notes_given =3D 1;
diff --git a/revision.h b/revision.h
index 6aa53d1..f812685 100644
--- a/revision.h
+++ b/revision.h
@@ -117,6 +117,9 @@ struct rev_info {
 			missing_newline:1,
 			date_mode_explicit:1,
 			preserve_subject:1;
+
+	struct wrap_options wrap;
+
 	unsigned int	disable_stdin:1;
 	unsigned int	leak_pending:1;
=20
--=20
1.7.8.1
