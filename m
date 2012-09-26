From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] revision: add --reflog-message=<pattern> to grep reflog messages
Date: Wed, 26 Sep 2012 19:12:45 +0700
Message-ID: <1348661565-30484-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 26 14:19:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGqae-0001B5-NU
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 14:19:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754588Ab2IZMTe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Sep 2012 08:19:34 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:63394 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753549Ab2IZMTd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2012 08:19:33 -0400
Received: by dady13 with SMTP id y13so121474dad.19
        for <git@vger.kernel.org>; Wed, 26 Sep 2012 05:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=InionRIhxVa7ISYe0pfHW4QE4CQCQHbS29sBZohhx9U=;
        b=MtWnv9hS+rSLhoTYeyPC3CgmROL3v3qNb5Y6ZBWj/CukZoctcDu5O5Jjsl/jtXQNn4
         a28kkZoq7g0ulqw0RGGOQ5G281a+n66oHtNGNTTXK0coJdBLpMONyodMGucutTJhfYt6
         cNM+8Xi5X9gOmgriw0qehQax+S/yMYDbatYrDsxNFyeDjFZL5Gt1wXBtHjHpXAGFKv84
         G8FuX28Cr3toaxUuQtKt7d5hHQEGq6mlFTL1NG9cX1UcJdFQr4N6PGb8MSn6oYZMTU4X
         tiSX2wuC2ieBtm20oHOVEnIYBQTwFGVp2YzFQcs4NLPMmEqDaD/b5P4CUPlaJBl5dRfw
         IW1w==
Received: by 10.66.85.8 with SMTP id d8mr789103paz.30.1348661973316;
        Wed, 26 Sep 2012 05:19:33 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.51.2])
        by mx.google.com with ESMTPS id iv7sm1984006pbc.68.2012.09.26.05.19.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 26 Sep 2012 05:19:32 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 26 Sep 2012 19:12:46 +0700
X-Mailer: git-send-email 1.7.12.1.406.g6ab07c4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206413>

Both "git log" and "git reflog show" recognize this option.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Itch: how to show reflogs for checkout operation only?

 Instead of ignoring when -g is not given, we might want to imply -g.

 Still itch: grep highlight! For all applicable areas: commit headers
 including reflog messages, commit body, diff.

 Documentation/rev-list-options.txt |  5 +++++
 revision.c                         | 30 ++++++++++++++++++++++++++++++
 revision.h                         |  1 +
 3 files changed, 36 insertions(+)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-lis=
t-options.txt
index 1fc2a18..aeaa58c 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -51,6 +51,11 @@ endif::git-rev-list[]
 	commits whose author matches any of the given patterns are
 	chosen (similarly for multiple `--committer=3D<pattern>`).
=20
+--reflog-message=3D<pattern>::
+	Limit the commits output to ones with reflog messages that
+	match the specified pattern (regular expression). Ignored unless
+	--walk-reflogs is given.
+
 --grep=3D<pattern>::
=20
 	Limit the commits output to ones with log message that
diff --git a/revision.c b/revision.c
index ae12e11..ee55bb2 100644
--- a/revision.c
+++ b/revision.c
@@ -1053,6 +1053,11 @@ void init_revisions(struct rev_info *revs, const=
 char *prefix)
 	revs->grep_filter.header_tail =3D &(revs->grep_filter.header_list);
 	revs->grep_filter.regflags =3D REG_NEWLINE;
=20
+	revs->reflog_filter.status_only =3D 1;
+	revs->reflog_filter.pattern_tail =3D &(revs->reflog_filter.pattern_li=
st);
+	revs->reflog_filter.header_tail =3D &(revs->reflog_filter.header_list=
);
+	revs->reflog_filter.regflags =3D REG_NEWLINE;
+
 	diff_setup(&revs->diffopt);
 	if (prefix && !revs->diffopt.prefix) {
 		revs->diffopt.prefix =3D prefix;
@@ -1298,6 +1303,12 @@ static void add_message_grep(struct rev_info *re=
vs, const char *pattern)
 	add_grep(revs, pattern, GREP_PATTERN_BODY);
 }
=20
+static void add_reflog_grep(struct rev_info *revs, const char *ptn)
+{
+	append_grep_pattern(&revs->reflog_filter, ptn,
+			    "command line", 0, GREP_PATTERN);
+}
+
 static int handle_revision_opt(struct rev_info *revs, int argc, const =
char **argv,
 			       int *unkc, const char **unkv)
 {
@@ -1600,15 +1611,23 @@ static int handle_revision_opt(struct rev_info =
*revs, int argc, const char **arg
 		return argcount;
 	} else if (!strcmp(arg, "--grep-debug")) {
 		revs->grep_filter.debug =3D 1;
+	} else if ((argcount =3D parse_long_opt("reflog-message",
+					      argv, &optarg))) {
+		add_reflog_grep(revs, optarg);
+		return argcount;
 	} else if (!strcmp(arg, "--extended-regexp") || !strcmp(arg, "-E")) {
 		revs->grep_filter.regflags |=3D REG_EXTENDED;
+		revs->reflog_filter.regflags |=3D REG_EXTENDED;
 	} else if (!strcmp(arg, "--regexp-ignore-case") || !strcmp(arg, "-i")=
) {
 		revs->grep_filter.regflags |=3D REG_ICASE;
+		revs->reflog_filter.regflags |=3D REG_ICASE;
 		DIFF_OPT_SET(&revs->diffopt, PICKAXE_IGNORE_CASE);
 	} else if (!strcmp(arg, "--fixed-strings") || !strcmp(arg, "-F")) {
 		revs->grep_filter.fixed =3D 1;
+		revs->reflog_filter.fixed =3D 1;
 	} else if (!strcmp(arg, "--all-match")) {
 		revs->grep_filter.all_match =3D 1;
+		revs->reflog_filter.all_match =3D 1;
 	} else if ((argcount =3D parse_long_opt("encoding", argv, &optarg))) =
{
 		if (strcmp(optarg, "none"))
 			git_log_output_encoding =3D xstrdup(optarg);
@@ -1891,6 +1910,7 @@ int setup_revisions(int argc, const char **argv, =
struct rev_info *revs, struct s
 	diff_setup_done(&revs->diffopt);
=20
 	compile_grep_patterns(&revs->grep_filter);
+	compile_grep_patterns(&revs->reflog_filter);
=20
 	if (revs->reverse && revs->reflog_info)
 		die("cannot combine --reverse with --walk-reflogs");
@@ -2242,6 +2262,16 @@ enum commit_action get_commit_action(struct rev_=
info *revs, struct commit *commi
 		    ((revs->max_parents >=3D 0) && (n > revs->max_parents)))
 			return commit_ignore;
 	}
+	if (revs->reflog_info &&
+	    revs->reflog_filter.pattern_list) {
+		struct strbuf sb =3D STRBUF_INIT;
+		int ignore;
+		get_reflog_message(&sb, revs->reflog_info);
+		ignore =3D !grep_buffer(&revs->reflog_filter, sb.buf, sb.len);
+		strbuf_release(&sb);
+		if (ignore)
+			return commit_ignore;
+	}
 	if (!commit_match(commit, revs))
 		return commit_ignore;
 	if (revs->prune && revs->dense) {
diff --git a/revision.h b/revision.h
index a95bd0b..0ebe34b 100644
--- a/revision.h
+++ b/revision.h
@@ -145,6 +145,7 @@ struct rev_info {
=20
 	/* Filter by commit log message */
 	struct grep_opt	grep_filter;
+	struct grep_opt	reflog_filter;
=20
 	/* Display history graph */
 	struct git_graph *graph;
--=20
1.7.12.1.406.g6ab07c4
