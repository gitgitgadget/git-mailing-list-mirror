From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/3] rev-list: Introduce --no-output to avoid /dev/null redirects
Date: Thu, 8 Nov 2007 03:00:52 -0500
Message-ID: <20071108080052.GB16690@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 09:01:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq2K7-0004OR-Tt
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 09:01:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbXKHIA4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 03:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbXKHIA4
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 03:00:56 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:60838 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889AbXKHIAz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 03:00:55 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Iq2Jo-0008AN-Lk; Thu, 08 Nov 2007 03:00:52 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B018520FBAE; Thu,  8 Nov 2007 03:00:52 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63951>

Some uses of git-rev-list are to run it with --objects to see if
a range of objects between two or more commits is fully connected
or not.  In such a case the caller doesn't care about the actual
object names or hash hints so formatting this data only for it to
be dumped to /dev/null by a redirect is a waste of CPU time.  If
all the caller needs is the exit status then --no-output can be
used to bypass the commit and object formatting.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/git-rev-list.txt |    9 +++++++++
 builtin-rev-list.c             |   26 ++++++++++++++++++++++----
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 4852804..66ddbd3 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -20,6 +20,7 @@ SYNOPSIS
 	     [ \--not ]
 	     [ \--all ]
 	     [ \--stdin ]
+	     [ \--no-output ]
 	     [ \--topo-order ]
 	     [ \--parents ]
 	     [ \--timestamp ]
@@ -270,6 +271,14 @@ limiting may be applied.
 	In addition to the '<commit>' listed on the command
 	line, read them from the standard input.
 
+--no-output::
+
+	Don't print anything to standard output.  This form of
+	git-rev-list is primarly meant to allow the caller to
+	test the exit status to see if a range of objects is fully
+	connected (or not).  It is faster than redirecting stdout
+	to /dev/null as the output does not have to be formatted.
+
 --cherry-pick::
 
 	Omit any commit that introduces the same change as
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 2dec887..634b1f4 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -26,6 +26,7 @@ static const char rev_list_usage[] =
 "    --remove-empty\n"
 "    --all\n"
 "    --stdin\n"
+"    --no-output\n"
 "  ordering output:\n"
 "    --topo-order\n"
 "    --date-order\n"
@@ -50,6 +51,7 @@ static int show_timestamp;
 static int hdr_termination;
 static const char *header_prefix;
 
+static void noshow_commit(struct commit *commit);
 static void show_commit(struct commit *commit)
 {
 	if (show_timestamp)
@@ -93,6 +95,11 @@ static void show_commit(struct commit *commit)
 		strbuf_release(&buf);
 	}
 	maybe_flush_or_die(stdout, "stdout");
+	noshow_commit(commit);
+}
+
+static void noshow_commit(struct commit *commit)
+{
 	if (commit->parents) {
 		free_commit_list(commit->parents);
 		commit->parents = NULL;
@@ -101,6 +108,12 @@ static void show_commit(struct commit *commit)
 	commit->buffer = NULL;
 }
 
+static void noshow_object(struct object_array_entry *p)
+{
+	if (p->item->type == OBJ_BLOB && !has_sha1_file(p->item->sha1))
+		die("missing blob object '%s'", sha1_to_hex(p->item->sha1));
+}
+
 static void show_object(struct object_array_entry *p)
 {
 	/* An object with name "foo\n0000000..." can be used to
@@ -108,9 +121,7 @@ static void show_object(struct object_array_entry *p)
 	 */
 	const char *ep = strchr(p->name, '\n');
 
-	if (p->item->type == OBJ_BLOB && !has_sha1_file(p->item->sha1))
-		die("missing blob object '%s'", sha1_to_hex(p->item->sha1));
-
+	noshow_object(p);
 	if (ep) {
 		printf("%s %.*s\n", sha1_to_hex(p->item->sha1),
 		       (int) (ep - p->name),
@@ -527,6 +538,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	int read_from_stdin = 0;
 	int bisect_show_vars = 0;
 	int bisect_find_all = 0;
+	int nooutput = 0;
 
 	git_config(git_default_config);
 	init_revisions(&revs, prefix);
@@ -565,6 +577,10 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			read_revisions_from_stdin(&revs);
 			continue;
 		}
+		if (!strcmp(arg, "--no-output")) {
+			nooutput = 1;
+			continue;
+		}
 		usage(rev_list_usage);
 
 	}
@@ -640,7 +656,9 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	traverse_commit_list(&revs, show_commit, show_object);
+	traverse_commit_list(&revs,
+		nooutput ? noshow_commit : show_commit,
+		nooutput ? noshow_object : show_object);
 
 	return 0;
 }
-- 
1.5.3.5.1590.gfadfad
