From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] teach "git branch" a --quiet option
Date: Mon, 26 Mar 2012 19:51:06 -0400
Message-ID: <20120326235106.GB23290@sigill.intra.peff.net>
References: <20120326234944.GA1901@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 01:51:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCJh1-0001i8-Ma
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 01:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176Ab2CZXvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 19:51:12 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60285
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932161Ab2CZXvK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 19:51:10 -0400
Received: (qmail 20112 invoked by uid 107); 26 Mar 2012 23:51:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 26 Mar 2012 19:51:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Mar 2012 19:51:06 -0400
Content-Disposition: inline
In-Reply-To: <20120326234944.GA1901@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193991>

There's currently no way to suppress the informational
"deleted branch..." or "set up tracking..." messages.  This
patch provides a "-q" option to do so.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-branch.txt |    5 +++++
 builtin/branch.c             |   16 ++++++++++------
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 6410c3d..e71370d 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -126,6 +126,11 @@ OPTIONS
 	relationship to upstream branch (if any). If given twice, print
 	the name of the upstream branch, as well.
 
+-q::
+--quiet::
+	Be more quiet when creating or deleting a branch, suppressing
+	non-error messages.
+
 --abbrev=<length>::
 	Alter the sha1's minimum display length in the output listing.
 	The default value is 7 and can be overridden by the `core.abbrev`
diff --git a/builtin/branch.c b/builtin/branch.c
index f1eaf1e..5f150b4 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -146,7 +146,8 @@ static int branch_merged(int kind, const char *name,
 	return merged;
 }
 
-static int delete_branches(int argc, const char **argv, int force, int kinds)
+static int delete_branches(int argc, const char **argv, int force, int kinds,
+			   int quiet)
 {
 	struct commit *rev, *head_rev = NULL;
 	unsigned char sha1[20];
@@ -216,9 +217,10 @@ static int delete_branches(int argc, const char **argv, int force, int kinds)
 			ret = 1;
 		} else {
 			struct strbuf buf = STRBUF_INIT;
-			printf(_("Deleted %sbranch %s (was %s).\n"), remote,
-			       bname.buf,
-			       find_unique_abbrev(sha1, DEFAULT_ABBREV));
+			if (!quiet)
+				printf(_("Deleted %sbranch %s (was %s).\n"),
+				       remote, bname.buf,
+				       find_unique_abbrev(sha1, DEFAULT_ABBREV));
 			strbuf_addf(&buf, "branch.%s", bname.buf);
 			if (git_config_rename_section(buf.buf, NULL) < 0)
 				warning(_("Update of config-file failed"));
@@ -678,6 +680,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	int delete = 0, rename = 0, force_create = 0, list = 0;
 	int verbose = 0, abbrev = -1, detached = 0;
 	int reflog = 0, edit_description = 0;
+	int quiet = 0;
 	enum branch_track track;
 	int kinds = REF_LOCAL_BRANCH;
 	struct commit_list *with_commit = NULL;
@@ -686,6 +689,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_GROUP("Generic options"),
 		OPT__VERBOSE(&verbose,
 			"show hash and subject, give twice for upstream branch"),
+		OPT__QUIET(&quiet, "suppress informational messages"),
 		OPT_SET_INT('t', "track",  &track, "set up tracking mode (see git-pull(1))",
 			BRANCH_TRACK_EXPLICIT),
 		OPT_SET_INT( 0, "set-upstream",  &track, "change upstream info",
@@ -766,7 +770,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		abbrev = DEFAULT_ABBREV;
 
 	if (delete)
-		return delete_branches(argc, argv, delete > 1, kinds);
+		return delete_branches(argc, argv, delete > 1, kinds, quiet);
 	else if (list)
 		return print_ref_list(kinds, detached, verbose, abbrev,
 				      with_commit, argv);
@@ -808,7 +812,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		if (kinds != REF_LOCAL_BRANCH)
 			die(_("-a and -r options to 'git branch' do not make sense with a branch name"));
 		create_branch(head, argv[0], (argc == 2) ? argv[1] : head,
-			      force_create, reflog, 0, 0, track);
+			      force_create, reflog, 0, quiet, track);
 	} else
 		usage_with_options(builtin_branch_usage, options);
 
-- 
1.7.10.rc2.3.g0850
