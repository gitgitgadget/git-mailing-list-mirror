From: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
Subject: [PATCH 4/9] Introduce entry point for launching add--interactive.
Date: Wed,  5 Sep 2007 20:23:33 -0400
Message-ID: <11890382253220-git-send-email-krh@redhat.com>
References: <11890382183913-git-send-email-krh@redhat.com>
 <11890382242333-git-send-email-krh@redhat.com>
 <11890382243290-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 06 02:36:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT5Lf-0001k6-PM
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 02:35:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757181AbXIFAfv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 5 Sep 2007 20:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757226AbXIFAfu
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 20:35:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43766 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757095AbXIFAfq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 20:35:46 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l860Zjni005428
	for <git@vger.kernel.org>; Wed, 5 Sep 2007 20:35:45 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l860Zi9D032606;
	Wed, 5 Sep 2007 20:35:44 -0400
Received: from localhost.localdomain (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l860ZhbY016503;
	Wed, 5 Sep 2007 20:35:44 -0400
X-Mailer: git-send-email 1.5.3.rc5.852.gc119
In-Reply-To: <11890382243290-git-send-email-krh@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57784>

This refactors builtin-add.c a little to provide a unique entry point
for launching git add --interactive, which will be used by
builtin-commit too.  If we later want to make add --interactive a
builtin or change how it is launched, we just start from this function.

Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
---
 builtin-add.c |   15 ++++++++++-----
 commit.h      |    9 +++++++++
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 3dd4ded..e79e8f7 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -12,6 +12,7 @@
 #include "diffcore.h"
 #include "commit.h"
 #include "revision.h"
+#include "run-command.h"
=20
 static const char builtin_add_usage[] =3D
 "git-add [-n] [-v] [-f] [--interactive | -i] [-u] [--] <filepattern>..=
=2E";
@@ -153,6 +154,13 @@ static int git_add_config(const char *var, const c=
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
@@ -172,12 +180,9 @@ int cmd_add(int argc, const char **argv, const cha=
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
index 467872e..64e1d4b 100644
--- a/commit.h
+++ b/commit.h
@@ -122,4 +122,13 @@ extern struct commit_list *get_shallow_commits(str=
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
+extern int interactive_add(void);
+
 #endif /* COMMIT_H */
--=20
1.5.2.GIT
