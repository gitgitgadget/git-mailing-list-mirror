From: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
Subject: [PATCH 8/9] Export rerere() and launch_editor().
Date: Wed,  5 Sep 2007 20:23:37 -0400
Message-ID: <11890382264046-git-send-email-krh@redhat.com>
References: <11890382183913-git-send-email-krh@redhat.com>
 <11890382242333-git-send-email-krh@redhat.com>
 <11890382243290-git-send-email-krh@redhat.com>
 <11890382253220-git-send-email-krh@redhat.com>
 <11890382252522-git-send-email-krh@redhat.com>
 <1189038225525-git-send-email-krh@redhat.com>
 <11890382262161-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 06 02:36:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT5Ma-0001tF-Co
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 02:36:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbXIFAf4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 5 Sep 2007 20:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbXIFAfz
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 20:35:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43782 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757184AbXIFAfr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 20:35:47 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l860ZlRP005462
	for <git@vger.kernel.org>; Wed, 5 Sep 2007 20:35:47 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l860ZkYO032623;
	Wed, 5 Sep 2007 20:35:46 -0400
Received: from localhost.localdomain (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l860Zhbc016503;
	Wed, 5 Sep 2007 20:35:46 -0400
X-Mailer: git-send-email 1.5.3.rc5.852.gc119
In-Reply-To: <11890382262161-git-send-email-krh@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57789>

Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
---
 builtin-rerere.c |   16 ++++++++++++++++
 builtin-tag.c    |    3 +--
 commit.h         |    1 +
 strbuf.h         |    1 +
 4 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/builtin-rerere.c b/builtin-rerere.c
index 29d057c..eb22a28 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -415,6 +415,22 @@ static int is_rerere_enabled(void)
 	return 1;
 }
=20
+/* Export for builtin-commit. */
+int rerere(void)
+{
+	struct path_list merge_rr =3D { NULL, 0, 0, 1 };
+	int fd;
+
+	git_config(git_rerere_config);
+	if (!is_rerere_enabled())
+		return 0;
+
+	merge_rr_path =3D xstrdup(git_path("rr-cache/MERGE_RR"));
+	fd =3D hold_lock_file_for_update(&write_lock, merge_rr_path, 1);
+	read_rr(&merge_rr);
+	return do_plain_rerere(&merge_rr, fd);
+}
+
 int cmd_rerere(int argc, const char **argv, const char *prefix)
 {
 	struct path_list merge_rr =3D { NULL, 0, 0, 1 };
diff --git a/builtin-tag.c b/builtin-tag.c
index 8724d49..3b181f5 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -18,12 +18,11 @@ static const char builtin_tag_usage[] =3D
=20
 static char signingkey[1000];
=20
-static void launch_editor(const char *path, struct strbuf *sb)
+void launch_editor(const char *path, struct strbuf *sb)
 {
 	const char *editor, *terminal;
 	struct child_process child;
 	const char *args[3];
-	int fd;
=20
 	editor =3D getenv("GIT_EDITOR");
 	if (!editor && editor_program)
diff --git a/commit.h b/commit.h
index 64e1d4b..39934cc 100644
--- a/commit.h
+++ b/commit.h
@@ -130,5 +130,6 @@ create_commit(const unsigned char *tree_sha1,
 	      const char *message, int length);
=20
 extern int interactive_add(void);
+extern int rerere(void);
=20
 #endif /* COMMIT_H */
diff --git a/strbuf.h b/strbuf.h
index e852070..b009b4b 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -16,5 +16,6 @@ extern void strbuf_printf(struct strbuf *sb, const ch=
ar *fmt, ...);
 extern int strbuf_read_fd(struct strbuf *sb, int fd);
 extern int strbuf_read_path(struct strbuf *sb, const char *path);
 extern size_t stripspace(struct strbuf *sb, int skip_comments);
+extern void launch_editor(const char *path, struct strbuf *sb);
=20
 #endif /* STRBUF_H */
--=20
1.5.2.GIT
