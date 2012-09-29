From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/3] revision: add --grep-reflog to filter commits by reflog messages
Date: Sat, 29 Sep 2012 11:41:28 +0700
Message-ID: <1348893689-20240-3-git-send-email-pclouds@gmail.com>
References: <7vr4pmm3qz.fsf@alter.siamese.dyndns.org>
 <1348893689-20240-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 29 06:49:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THozR-0007bo-UH
	for gcvg-git-2@plane.gmane.org; Sat, 29 Sep 2012 06:49:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906Ab2I2EtH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 29 Sep 2012 00:49:07 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:38637 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871Ab2I2Esc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2012 00:48:32 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so5926981pbb.19
        for <git@vger.kernel.org>; Fri, 28 Sep 2012 21:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=QM5yNJ1s7Pq1pY6Uu/R4rG/YCa83F7m1wXw6KkiYyXU=;
        b=XhpZZjGrC9oI6B777ayII0jfcYhf60NSYioXvl5uEYPGg0hbPrBhDvm6jDka6eFxcQ
         4QfSqocgQbHaktLl5SCvK7uyDhgOsP/cuNwkl+FaBAw6nGe92jlbBJ+kt+FHBtHlD9GG
         lGoZel651LJ5n+SdI8kkshNpAF9BO9FismBSYZrHc2HgvwjI2OFIKEoTOLATafmrFgZX
         hg3q+cg4fkWdFUFSMSSBmeVERkeRFDbr9UhCwzzqE49ESUUr1dQVu9RCYEdDDsm/ACKo
         WWNyOAgEghdRUhEc38egDTzFgSpXi1y6EdxRkJ22lpvwcajn7k6g6PD9T57fmf5hmLqh
         TU4g==
Received: by 10.68.225.3 with SMTP id rg3mr25575051pbc.27.1348894111800;
        Fri, 28 Sep 2012 21:48:31 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.51.2])
        by mx.google.com with ESMTPS id gt2sm6663767pbc.62.2012.09.28.21.48.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 28 Sep 2012 21:48:31 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 29 Sep 2012 11:41:43 +0700
X-Mailer: git-send-email 1.7.12.1.406.g6ab07c4
In-Reply-To: <1348893689-20240-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206622>

Similar to --author/--committer which filters commits by author and
committer header fields. --grep-reflog adds a fake "reflog" header to
commit and a grep filter to search on that line.

All rules to --author/--committer apply except no timestamp stripping.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/rev-list-options.txt |  8 ++++++++
 grep.c                             |  1 +
 grep.h                             |  1 +
 revision.c                         | 20 ++++++++++++++++++--
 t/t7810-grep.sh                    | 26 ++++++++++++++++++++++++++
 5 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-lis=
t-options.txt
index 1fc2a18..aa7cd9d 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -51,6 +51,14 @@ endif::git-rev-list[]
 	commits whose author matches any of the given patterns are
 	chosen (similarly for multiple `--committer=3D<pattern>`).
=20
+--grep-reflog=3D<pattern>::
+
+	Limit the commits output to ones with reflog entries that
+	match the specified pattern (regular expression). With
+	more than one `--grep-reflog`, commits whose reflog message
+	matches any of the given patterns are chosen. Ignored unless
+	`--walk-reflogs` is given.
+
 --grep=3D<pattern>::
=20
 	Limit the commits output to ones with log message that
diff --git a/grep.c b/grep.c
index 8d73995..d70dcdf 100644
--- a/grep.c
+++ b/grep.c
@@ -697,6 +697,7 @@ static struct {
 } header_field[] =3D {
 	{ "author ", 7 },
 	{ "committer ", 10 },
+	{ "reflog ", 7 },
 };
=20
 static int match_one_pattern(struct grep_pat *p, char *bol, char *eol,
diff --git a/grep.h b/grep.h
index d54adbe..6e78b96 100644
--- a/grep.h
+++ b/grep.h
@@ -30,6 +30,7 @@ enum grep_context {
 enum grep_header_field {
 	GREP_HEADER_AUTHOR =3D 0,
 	GREP_HEADER_COMMITTER,
+	GREP_HEADER_REFLOG,
=20
 	/* Must be at the end of the enum */
 	GREP_HEADER_FIELD_MAX
diff --git a/revision.c b/revision.c
index ae12e11..109bec1 100644
--- a/revision.c
+++ b/revision.c
@@ -1595,6 +1595,9 @@ static int handle_revision_opt(struct rev_info *r=
evs, int argc, const char **arg
 	} else if ((argcount =3D parse_long_opt("committer", argv, &optarg)))=
 {
 		add_header_grep(revs, GREP_HEADER_COMMITTER, optarg);
 		return argcount;
+	} else if ((argcount =3D parse_long_opt("grep-reflog", argv, &optarg)=
)) {
+		add_header_grep(revs, GREP_HEADER_REFLOG, optarg);
+		return argcount;
 	} else if ((argcount =3D parse_long_opt("grep", argv, &optarg))) {
 		add_message_grep(revs, optarg);
 		return argcount;
@@ -2210,10 +2213,23 @@ static int rewrite_parents(struct rev_info *rev=
s, struct commit *commit)
=20
 static int commit_match(struct commit *commit, struct rev_info *opt)
 {
+	int retval;
+	struct strbuf buf =3D STRBUF_INIT;
 	if (!opt->grep_filter.pattern_list && !opt->grep_filter.header_list)
 		return 1;
-	return grep_buffer(&opt->grep_filter,
-			   commit->buffer, strlen(commit->buffer));
+	if (opt->reflog_info) {
+		strbuf_addstr(&buf, "reflog ");
+		get_reflog_message(&buf, opt->reflog_info);
+		strbuf_addch(&buf, '\n');
+		strbuf_addstr(&buf, commit->buffer);
+	}
+	if (buf.len)
+		retval =3D grep_buffer(&opt->grep_filter, buf.buf, buf.len);
+	else
+		retval =3D grep_buffer(&opt->grep_filter,
+				     commit->buffer, strlen(commit->buffer));
+	strbuf_release(&buf);
+	return retval;
 }
=20
 static inline int want_ancestry(struct rev_info *revs)
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 30eaa9a..3a5d0fd 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -546,6 +546,32 @@ test_expect_success 'log grep (6)' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'log grep (7)' '
+	git log -g --grep-reflog=3D"commit: third" --pretty=3Dtformat:%s >act=
ual &&
+	echo third >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log grep (8)' '
+	git log -g --grep-reflog=3D"commit: third" --grep-reflog=3D"commit: s=
econd" --pretty=3Dtformat:%s >actual &&
+	{
+		echo third && echo second
+	} >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log grep (9)' '
+	git log -g --grep-reflog=3D"commit: third" --author=3D"Thor" --pretty=
=3Dtformat:%s >actual &&
+	echo third >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log grep (9)' '
+	git log -g --grep-reflog=3D"commit: third" --author=3D"non-existant" =
--pretty=3Dtformat:%s >actual &&
+	: >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'log with multiple --grep uses union' '
 	git log --grep=3Di --grep=3Dr --format=3D%s >actual &&
 	{
--=20
1.7.12.1.406.g6ab07c4
