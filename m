From: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
Subject: [PATCH] Introduce entry point for launching add--interactive.
Date: Mon, 30 Jul 2007 18:21:23 -0400
Message-ID: <11858340832222-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 31 00:26:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFdhH-0003cB-FG
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 00:26:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968705AbXG3W0g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 30 Jul 2007 18:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S939545AbXG3W0g
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 18:26:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40813 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937563AbXG3W0f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 18:26:35 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l6UMQYLf017445
	for <git@vger.kernel.org>; Mon, 30 Jul 2007 18:26:34 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l6UMQXJ7012171;
	Mon, 30 Jul 2007 18:26:33 -0400
Received: from localhost.localdomain (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l6UMQWeM031888;
	Mon, 30 Jul 2007 18:26:32 -0400
X-Mailer: git-send-email 1.5.3.rc3.848.g5ef3b-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54287>

This refactors builtin-add.c a little to provide a unique entry point
for launching git add --interactive, which will be used by
builtin-commit too.  If we later want to make add --interactive a
builtin or change how it is launched, we just start from this function.

Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
---

Oh, oops, just one more change outside builtin-commit.c.  This is mostl=
y
stylistic, but it seems reasonable to reasonable to have a well-defined
entry point for launcing git add --interactive.

 builtin-add.c |   14 +++++++++-----
 commit.h      |    2 ++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 7345479..7044d43 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -135,6 +135,13 @@ static int git_add_config(const char *var, const c=
har *value)
 	return git_default_config(var, value);
 }
=20
+int interactive_add(void)
+{
+	const char *argv[2] =3D { "add--interactive", NULL };
+
+	return run_command_v_opt(argv, RUN_GIT_CMD);
+}
+
 static struct lock_file lock_file;
=20
 static const char ignore_warning[] =3D
@@ -154,12 +161,9 @@ int cmd_add(int argc, const char **argv, const cha=
r *prefix)
 			add_interactive++;
 	}
 	if (add_interactive) {
-		const char *args[] =3D { "add--interactive", NULL };
-
-		if (add_interactive !=3D 1 || argc !=3D 2)
+		if (argc !=3D 2)
 			die("add --interactive does not take any parameters");
-		execv_git_cmd(args);
-		exit(1);
+		exit(interactive_add());
 	}
=20
 	git_config(git_add_config);
diff --git a/commit.h b/commit.h
index 9f640ba..64e1d4b 100644
--- a/commit.h
+++ b/commit.h
@@ -129,4 +129,6 @@ create_commit(const unsigned char *tree_sha1,
 	      const char *author_info, const char *committer_info,
 	      const char *message, int length);
=20
+extern int interactive_add(void);
+
 #endif /* COMMIT_H */
--=20
1.5.2.GIT
