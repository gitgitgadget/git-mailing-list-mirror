From: Alex Vandiver <alex@chmrr.net>
Subject: [PATCH] Allow --quiet option to git remote, particularly for `git remote update`
Date: Sat,  5 Dec 2009 19:00:23 -0500
Message-ID: <1260057623-28960-1-git-send-email-alex@chmrr.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 06 01:00:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NH4YG-0004DR-22
	for gcvg-git-2@lo.gmane.org; Sun, 06 Dec 2009 01:00:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933249AbZLFAA1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Dec 2009 19:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933242AbZLFAAZ
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Dec 2009 19:00:25 -0500
Received: from chmrr.net ([209.67.253.66]:39756 "EHLO utwig.chmrr.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933233AbZLFAAY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Dec 2009 19:00:24 -0500
Received: from c-67-186-135-139.hsd1.ma.comcast.net ([67.186.135.139] helo=localhost.localdomain)
	by utwig.chmrr.net with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <alex@chmrr.net>)
	id 1NH4Y7-00071U-Bo
	for git@vger.kernel.org; Sat, 05 Dec 2009 19:00:30 -0500
X-Mailer: git-send-email 1.6.6.rc0.360.gc408
X-Authenticated-User: chmrr
X-Authenticator: plain
X-Sender-Verify: SUCCEEDED (sender exists & accepts mail)
X-Exim-Version: 4.69 (build at 07-Feb-2009 20:08:51)
X-Date: 2009-12-05 19:00:30
X-Connected-IP: 67.186.135.139:37540
X-Message-Linecount: 90
X-Body-Linecount: 83
X-Message-Size: 2854
X-Body-Size: 2556
X-Received-Count: 1
X-Recipient-Count: 1
X-Local-Recipient-Count: 1
X-Local-Recipient-Defer-Count: 0
X-Local-Recipient-Fail-Count: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134638>


Signed-off-by: Alex Vandiver <alex@chmrr.net>
---
 builtin-remote.c |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index a501939..a34006f 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -8,14 +8,14 @@
 #include "refs.h"
 
 static const char * const builtin_remote_usage[] = {
-	"git remote [-v | --verbose]",
+	"git remote [-v | --verbose] [-q | --quiet]",
 	"git remote add [-t <branch>] [-m <master>] [-f] [--mirror] <name> <url>",
 	"git remote rename <old> <new>",
 	"git remote rm <name>",
 	"git remote set-head <name> (-a | -d | <branch>)",
 	"git remote [-v | --verbose] show [-n] <name>",
 	"git remote prune [-n | --dry-run] <name>",
-	"git remote [-v | --verbose] update [-p | --prune] [group | remote]",
+	"git remote [-v | --verbose] [-q | --quiet] update [-p | --prune] [group]",
 	NULL
 };
 
@@ -58,7 +58,7 @@ static const char * const builtin_remote_update_usage[] = {
 #define GET_HEAD_NAMES (1<<1)
 #define GET_PUSH_REF_STATES (1<<2)
 
-static int verbose;
+static int verbosity;
 
 static int show_all(void);
 static int prune_remote(const char *remote, int dry_run);
@@ -84,9 +84,12 @@ static int opt_parse_track(const struct option *opt, const char *arg, int not)
 static int fetch_remote(const char *name)
 {
 	const char *argv[] = { "fetch", name, NULL, NULL };
-	if (verbose) {
+	if (verbosity > 0) {
 		argv[1] = "-v";
 		argv[2] = name;
+	} else if (verbosity < 0) {
+		argv[1] = "-q";
+		argv[2] = name;
 	}
 	printf("Updating %s\n", name);
 	if (run_command_v_opt(argv, RUN_GIT_CMD))
@@ -1236,8 +1239,10 @@ static int update(int argc, const char **argv)
 
 	if (prune)
 		fetch_argv[fetch_argc++] = "--prune";
-	if (verbose)
+	if (verbosity > 0)
 		fetch_argv[fetch_argc++] = "-v";
+	if (verbosity < 0)
+		fetch_argv[fetch_argc++] = "-q";
 	if (argc < 2) {
 		fetch_argv[fetch_argc++] = "default";
 	} else {
@@ -1301,7 +1306,7 @@ static int show_all(void)
 		sort_string_list(&list);
 		for (i = 0; i < list.nr; i++) {
 			struct string_list_item *item = list.items + i;
-			if (verbose)
+			if (verbosity > 0)
 				printf("%s\t%s\n", item->string,
 					item->util ? (const char *)item->util : "");
 			else {
@@ -1318,7 +1323,7 @@ static int show_all(void)
 int cmd_remote(int argc, const char **argv, const char *prefix)
 {
 	struct option options[] = {
-		OPT_BOOLEAN('v', "verbose", &verbose, "be verbose; must be placed before a subcommand"),
+		OPT__VERBOSITY(&verbosity),
 		OPT_END()
 	};
 	int result;
-- 
1.6.6.rc0.360.gc408
