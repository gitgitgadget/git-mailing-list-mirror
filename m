From: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
Subject: [PATCH] Port builtin-add.c to use the new option parser.
Date: Wed,  3 Oct 2007 17:45:02 -0400
Message-ID: <1191447902-27326-2-git-send-email-krh@redhat.com>
References: <1191447902-27326-1-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com,
	=?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 03 23:45:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdC2C-0007DZ-Ee
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 23:45:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754449AbXJCVp2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Oct 2007 17:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754661AbXJCVp2
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 17:45:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48601 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754449AbXJCVp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 17:45:27 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id l93Lj9u2018634;
	Wed, 3 Oct 2007 17:45:09 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l93Lj9v2025623;
	Wed, 3 Oct 2007 17:45:09 -0400
Received: from localhost.localdomain (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l93Lj7tV000495;
	Wed, 3 Oct 2007 17:45:08 -0400
X-Mailer: git-send-email 1.5.3.4.1152.geb85a-dirty
In-Reply-To: <1191447902-27326-1-git-send-email-krh@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59894>

Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
---
 builtin-add.c |   64 ++++++++++++++++++-------------------------------=
-------
 1 files changed, 21 insertions(+), 43 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 966e145..66fd99d 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -13,6 +13,7 @@
 #include "commit.h"
 #include "revision.h"
 #include "run-command.h"
+#include "parse-options.h"
=20
 static const char builtin_add_usage[] =3D
 "git-add [-n] [-v] [-f] [--interactive | -i] [-u] [--refresh] [--] <fi=
lepattern>...";
@@ -160,21 +161,30 @@ static struct lock_file lock_file;
 static const char ignore_error[] =3D
 "The following paths are ignored by one of your .gitignore files:\n";
=20
+static int verbose =3D 0, show_only =3D 0, ignored_too =3D 0, refresh_=
only =3D 0;
+static int add_interactive =3D 0;
+
+static struct option builtin_add_options[] =3D {
+	{ OPTION_BOOLEAN, "interactive", 'i', &add_interactive },
+	{ OPTION_BOOLEAN, NULL, 'n', &show_only },
+	{ OPTION_BOOLEAN, NULL, 'f', &ignored_too },
+	{ OPTION_BOOLEAN, NULL, 'v',&verbose },
+	{ OPTION_BOOLEAN, NULL, 'u',&take_worktree_changes },
+	{ OPTION_BOOLEAN, "refresh", 0, &refresh_only }
+};
+
 int cmd_add(int argc, const char **argv, const char *prefix)
 {
 	int i, newfd;
-	int verbose =3D 0, show_only =3D 0, ignored_too =3D 0, refresh_only =3D=
 0;
 	const char **pathspec;
 	struct dir_struct dir;
-	int add_interactive =3D 0;
=20
-	for (i =3D 1; i < argc; i++) {
-		if (!strcmp("--interactive", argv[i]) ||
-		    !strcmp("-i", argv[i]))
-			add_interactive++;
-	}
+	i =3D parse_options(argc, argv, builtin_add_options,
+			  ARRAY_SIZE(builtin_add_options),
+			  builtin_add_usage);
+
 	if (add_interactive) {
-		if (argc !=3D 2)
+		if (i > 0)
 			die("add --interactive does not take any parameters");
 		exit(interactive_add());
 	}
@@ -183,51 +193,19 @@ int cmd_add(int argc, const char **argv, const ch=
ar *prefix)
=20
 	newfd =3D hold_locked_index(&lock_file, 1);
=20
-	for (i =3D 1; i < argc; i++) {
-		const char *arg =3D argv[i];
-
-		if (arg[0] !=3D '-')
-			break;
-		if (!strcmp(arg, "--")) {
-			i++;
-			break;
-		}
-		if (!strcmp(arg, "-n")) {
-			show_only =3D 1;
-			continue;
-		}
-		if (!strcmp(arg, "-f")) {
-			ignored_too =3D 1;
-			continue;
-		}
-		if (!strcmp(arg, "-v")) {
-			verbose =3D 1;
-			continue;
-		}
-		if (!strcmp(arg, "-u")) {
-			take_worktree_changes =3D 1;
-			continue;
-		}
-		if (!strcmp(arg, "--refresh")) {
-			refresh_only =3D 1;
-			continue;
-		}
-		usage(builtin_add_usage);
-	}
-
 	if (take_worktree_changes) {
 		if (read_cache() < 0)
 			die("index file corrupt");
-		add_files_to_cache(verbose, prefix, argv + i);
+		add_files_to_cache(verbose, prefix, argv);
 		goto finish;
 	}
=20
-	if (argc <=3D i) {
+	if (i =3D=3D 0) {
 		fprintf(stderr, "Nothing specified, nothing added.\n");
 		fprintf(stderr, "Maybe you wanted to say 'git add .'?\n");
 		return 0;
 	}
-	pathspec =3D get_pathspec(prefix, argv + i);
+	pathspec =3D get_pathspec(prefix, argv);
=20
 	if (refresh_only) {
 		refresh(verbose, pathspec);
--=20
1.5.2.5
