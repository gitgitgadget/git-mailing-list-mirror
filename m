From: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
Subject: [PATCH 5/5] Split out the actual commit creation from the option parsing etc.
Date: Mon, 30 Jul 2007 17:28:46 -0400
Message-ID: <11858309332705-git-send-email-krh@redhat.com>
References: <11858309261111-git-send-email-krh@redhat.com>
 <11858309311728-git-send-email-krh@redhat.com>
 <11858309322006-git-send-email-krh@redhat.com>
 <11858309322915-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 30 23:34:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFcst-0003em-G0
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 23:34:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968494AbXG3VeM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 30 Jul 2007 17:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968388AbXG3VeJ
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 17:34:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51452 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765765AbXG3Vd5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 17:33:57 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l6ULXv6n015598
	for <git@vger.kernel.org>; Mon, 30 Jul 2007 17:33:57 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l6ULXuSK026646;
	Mon, 30 Jul 2007 17:33:56 -0400
Received: from localhost.localdomain (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l6ULXsA1018718;
	Mon, 30 Jul 2007 17:33:56 -0400
X-Mailer: git-send-email 1.5.3.rc3.848.g198b7-dirty
In-Reply-To: <11858309322915-git-send-email-krh@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54274>

=46rom: Kristian H=C3=B8gsberg <krh@redhat.com>

The functionality is available inside git through the function
create_commit().

Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
---
 builtin-commit-tree.c |   96 ++++++++++++++++++++++++++++++-----------=
-------
 commit.h              |    7 ++++
 2 files changed, 67 insertions(+), 36 deletions(-)

diff --git a/builtin-commit-tree.c b/builtin-commit-tree.c
index 72884eb..e20f0b4 100644
--- a/builtin-commit-tree.c
+++ b/builtin-commit-tree.c
@@ -52,15 +52,59 @@ static const char commit_utf8_warn[] =3D
 "You may want to amend it after fixing the message, or set the config\=
n"
 "variable i18n.commitencoding to the encoding your project uses.\n";
=20
+const unsigned char *
+create_commit(const unsigned char *tree_sha1,
+	      unsigned char parent_sha1[][20], int parents,
+	      const char *author_info, const char *committer_info,
+	      const char *message, int length)
+{
+	static unsigned char commit_sha1[20];
+	int encoding_is_utf8, i;
+	struct strbuf sb;
+
+	/* Not having i18n.commitencoding is the same as having utf-8 */
+	encoding_is_utf8 =3D is_encoding_utf8(git_commit_encoding);
+
+	strbuf_init(&sb);
+	strbuf_printf(&sb, "tree %s\n", sha1_to_hex(tree_sha1));
+
+	/*
+	 * NOTE! This ordering means that the same exact tree merged with a
+	 * different order of parents will be a _different_ changeset even
+	 * if everything else stays the same.
+	 */
+	for (i =3D 0; i < parents; i++)
+		strbuf_printf(&sb, "parent %s\n", sha1_to_hex(parent_sha1[i]));
+
+	/* Person/date information */
+	strbuf_printf(&sb, "author %s\n", author_info);
+	strbuf_printf(&sb, "committer %s\n", committer_info);
+	if (!encoding_is_utf8)
+		strbuf_printf(&sb, "encoding %s\n", git_commit_encoding);
+	strbuf_printf(&sb, "\n");
+
+	/* And add the comment */
+	strbuf_add(&sb, message, length);
+
+	/* And check the encoding */
+	strbuf_add_char(&sb, '\0');
+	if (encoding_is_utf8 && !is_utf8(sb.buf))
+		fprintf(stderr, commit_utf8_warn);
+
+	if (!write_sha1_file(sb.buf, sb.len - 1, commit_type, commit_sha1))
+		return commit_sha1;
+
+	return NULL;
+}
+
 int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 {
 	int i;
 	int parents =3D 0;
 	unsigned char tree_sha1[20];
-	unsigned char commit_sha1[20];
-	char comment[1000];
-	struct strbuf sb;
-	int encoding_is_utf8;
+	char *buffer;
+	unsigned long len;
+	const unsigned char *commit_sha1;
=20
 	git_config(git_default_config);
=20
@@ -85,40 +129,20 @@ int cmd_commit_tree(int argc, const char **argv, c=
onst char *prefix)
 			parents++;
 	}
=20
-	/* Not having i18n.commitencoding is the same as having utf-8 */
-	encoding_is_utf8 =3D is_encoding_utf8(git_commit_encoding);
+	buffer =3D NULL;
+	if (read_fd(0, &buffer, &len))
+		die("Could not read commit message from standard input");
=20
-	strbuf_init(&sb);
-	strbuf_printf(&sb, "tree %s\n", sha1_to_hex(tree_sha1));
+	commit_sha1 =3D create_commit(tree_sha1,
+				    parent_sha1, parents,
+				    xstrdup(git_author_info(1)),
+				    xstrdup(git_committer_info(1)),
+				    buffer, len);
=20
-	/*
-	 * NOTE! This ordering means that the same exact tree merged with a
-	 * different order of parents will be a _different_ changeset even
-	 * if everything else stays the same.
-	 */
-	for (i =3D 0; i < parents; i++)
-		strbuf_printf(&sb, "parent %s\n", sha1_to_hex(parent_sha1[i]));
-
-	/* Person/date information */
-	strbuf_printf(&sb, "author %s\n", git_author_info(1));
-	strbuf_printf(&sb, "committer %s\n", git_committer_info(1));
-	if (!encoding_is_utf8)
-		strbuf_printf(&sb, "encoding %s\n", git_commit_encoding);
-	strbuf_printf(&sb, "\n");
-
-	/* And add the comment */
-	while (fgets(comment, sizeof(comment), stdin) !=3D NULL)
-		strbuf_printf(&sb, "%s", comment);
+	if (!commit_sha1)
+		return 1;
=20
-	/* And check the encoding */
-	strbuf_add_char(&sb, '\0');
-	if (encoding_is_utf8 && !is_utf8(sb.buf))
-		fprintf(stderr, commit_utf8_warn);
+	printf("%s\n", sha1_to_hex(commit_sha1));
=20
-	if (!write_sha1_file(sb.buf, sb.len - 1, commit_type, commit_sha1)) {
-		printf("%s\n", sha1_to_hex(commit_sha1));
-		return 0;
-	}
-	else
-		return 1;
+	return 0;
 }
diff --git a/commit.h b/commit.h
index 467872e..9f640ba 100644
--- a/commit.h
+++ b/commit.h
@@ -122,4 +122,11 @@ extern struct commit_list *get_shallow_commits(str=
uct object_array *heads,
 		int depth, int shallow_flag, int not_shallow_flag);
=20
 int in_merge_bases(struct commit *, struct commit **, int);
+
+extern const unsigned char *
+create_commit(const unsigned char *tree_sha1,
+	      unsigned char parent_sha1[][20], int parents,
+	      const char *author_info, const char *committer_info,
+	      const char *message, int length);
+
 #endif /* COMMIT_H */
--=20
1.5.2.GIT
