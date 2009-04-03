From: Finn Arne Gangstad <finnag@pvv.org>
Subject: [PATCHv2 2/2] git remote update: New option --prune
Date: Fri, 3 Apr 2009 11:03:44 +0200
Message-ID: <20090403090344.GB5199@pvv.org>
References: <20090402123823.GA1756@pvv.org> <9b18b3110904020634i17633645ue4ba91701ea243a1@mail.gmail.com> <20090402134414.GB26699@coredump.intra.peff.net> <7vab6zexq7.fsf@gitster.siamese.dyndns.org> <20090402201803.GA5397@pvv.org> <7vljqieq1r.fsf@gitster.siamese.dyndns.org> <20090403090036.GA23955@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, demerphq <demerphq@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 03 11:07:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpfKy-0003bT-MQ
	for gcvg-git-2@gmane.org; Fri, 03 Apr 2009 11:05:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754821AbZDCJDv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2009 05:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754021AbZDCJDu
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Apr 2009 05:03:50 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:52878 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751964AbZDCJDt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2009 05:03:49 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1LpfJQ-0001ow-4k; Fri, 03 Apr 2009 11:03:44 +0200
Content-Disposition: inline
In-Reply-To: <20090403090036.GA23955@pvv.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115522>

With the --prune (or -p) option, git remote update will also prune
all the remotes that it fetches.  Previously, you had to do a manual
git remote prune <remote> for each of the remotes you wanted to
prune, and this could be tedious with many remotes.

A single command will now update a set of remotes, and remove all
stale branches: git remote update -p [group]

Signed-off-by: Finn Arne Gangstad <finnag@pvv.org>
---
 Documentation/git-remote.txt |    4 +++-
 builtin-remote.c             |   20 ++++++++++++++++----
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index c9c0e6f..0b6e67d 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -16,7 +16,7 @@ SYNOPSIS
 'git remote set-head' <name> [-a | -d | <branch>]
 'git remote show' [-n] <name>
 'git remote prune' [-n | --dry-run] <name>
-'git remote update' [group]
+'git remote update' [-p | --prune] [group]
 
 DESCRIPTION
 -----------
@@ -125,6 +125,8 @@ the configuration parameter remotes.default will get used; if
 remotes.default is not defined, all remotes which do not have the
 configuration parameter remote.<name>.skipDefaultUpdate set to true will
 be updated.  (See linkgit:git-config[1]).
++
+With `--prune` option, prune all the remotes that are updated.
 
 
 DISCUSSION
diff --git a/builtin-remote.c b/builtin-remote.c
index 9804d6c..c8e5b17 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -15,7 +15,7 @@ static const char * const builtin_remote_usage[] = {
 	"git remote set-head <name> [-a | -d | <branch>]",
 	"git remote show [-n] <name>",
 	"git remote prune [-n | --dry-run] <name>",
-	"git remote [-v | --verbose] update [group]",
+	"git remote [-v | --verbose] update [-p | --prune] [group]",
 	NULL
 };
 
@@ -1210,10 +1210,18 @@ static int get_remote_group(const char *key, const char *value, void *cb)
 
 static int update(int argc, const char **argv)
 {
-	int i, result = 0;
+	int i, result = 0, prune = 0;
 	struct string_list list = { NULL, 0, 0, 0 };
 	static const char *default_argv[] = { NULL, "default", NULL };
+	struct option options[] = {
+		OPT_GROUP("update specific options"),
+		OPT_BOOLEAN('p', "prune", &prune,
+			    "prune remotes after fecthing"),
+		OPT_END()
+	};
 
+	argc = parse_options(argc, argv, options, builtin_remote_usage,
+			     PARSE_OPT_KEEP_ARGV0);
 	if (argc < 2) {
 		argc = 2;
 		argv = default_argv;
@@ -1228,8 +1236,12 @@ static int update(int argc, const char **argv)
 	if (!result && !list.nr  && argc == 2 && !strcmp(argv[1], "default"))
 		result = for_each_remote(get_one_remote_for_update, &list);
 
-	for (i = 0; i < list.nr; i++)
-		result |= fetch_remote(list.items[i].string);
+	for (i = 0; i < list.nr; i++) {
+		int err = fetch_remote(list.items[i].string);
+		result |= err;
+		if (!err && prune)
+			result |= prune_remote(list.items[i].string, 0);
+	}
 
 	/* all names were strdup()ed or strndup()ed */
 	list.strdup_strings = 1;
-- 
1.6.2.1.471.gdeb91.dirty
