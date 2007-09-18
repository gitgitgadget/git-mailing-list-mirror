From: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
Subject: [PATCH 3/7] Introduce entry point for launching add--interactive.
Date: Mon, 17 Sep 2007 20:06:44 -0400
Message-ID: <11900740142347-git-send-email-krh@redhat.com>
References: <1190074008617-git-send-email-krh@redhat.com>
 <1190074014548-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 18 02:07:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXQcn-0002Qo-SX
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 02:07:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756759AbXIRAHA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Sep 2007 20:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757014AbXIRAG7
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 20:06:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56218 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756892AbXIRAG4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 20:06:56 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l8I06uIk012095
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 17 Sep 2007 20:06:56 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l8I06tl9022178;
	Mon, 17 Sep 2007 20:06:55 -0400
Received: from localhost.localdomain (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l8I06scw021539;
	Mon, 17 Sep 2007 20:06:54 -0400
X-Mailer: git-send-email 1.5.3.1.993.gbf388-dirty
In-Reply-To: <1190074014548-git-send-email-krh@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58506>

This refactors builtin-add.c a little to provide a unique entry point
for launching git add --interactive, which will be used by
builtin-commit too.  If we later want to make add --interactive a
builtin or change how it is launched, we just start from this function.

Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
---
 builtin-add.c |   15 ++++++++++-----
 commit.h      |    3 +++
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 0d7d0ce..a5cb910 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -12,6 +12,7 @@
 #include "diffcore.h"
 #include "commit.h"
 #include "revision.h"
+#include "run-command.h"
=20
 static const char builtin_add_usage[] =3D
 "git-add [-n] [-v] [-f] [--interactive | -i] [-u] [--refresh] [--] <fi=
lepattern>...";
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
 static const char ignore_error[] =3D
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
index b779de8..da34c23 100644
--- a/commit.h
+++ b/commit.h
@@ -128,4 +128,7 @@ extern struct commit_list *get_shallow_commits(stru=
ct object_array *heads,
 		int depth, int shallow_flag, int not_shallow_flag);
=20
 int in_merge_bases(struct commit *, struct commit **, int);
+
+extern int interactive_add(void);
+
 #endif /* COMMIT_H */
--=20
1.5.3.1.993.gbf388-dirty
