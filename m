From: Jeff King <peff@peff.net>
Subject: [PATCH 4/4] diff: turn on rename detection progress reporting
Date: Thu, 24 Mar 2011 13:51:24 -0400
Message-ID: <20110324175124.GD30685@sigill.intra.peff.net>
References: <20110324174556.GA30661@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 18:51:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2oh7-0001l6-Bu
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 18:51:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756896Ab1CXRva (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2011 13:51:30 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34976
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754352Ab1CXRv1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2011 13:51:27 -0400
Received: (qmail 4265 invoked by uid 107); 24 Mar 2011 17:52:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 Mar 2011 13:52:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Mar 2011 13:51:24 -0400
Content-Disposition: inline
In-Reply-To: <20110324174556.GA30661@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169933>

Since all of the progress happens before we generate any
output, this looks OK, even when output goes to a pager.
We do the usual --progress/--no-progress options and check
isatty(2) to enable the feature.

The argument parsing is a little ad-hoc, but we currently
have no parse-options infrastructure here at all.  However,
it should be safe to parse like this, because the prior
call to setup_revisions will have removed any options that
take an argument, and our parsing removes --progress from
argv for later parsers. The one exception is diff_no_index,
which may get called early, and needs to learn to ignore
--progress.

Signed-off-by: Jeff King <peff@peff.net>
---
New since the last iteration.

I'm not happy about the option parsing, but converting the whole of "git
diff" to a saner parsing structure is more than I want to take on for
this series. One thing that would make it easier is if the diff parser
understood --progress and stored the result for the caller to check. I
was tempted to do that because the code ends up cleaner, but it feels
wrong.

 Documentation/git-diff.txt |    7 +++++++
 builtin/diff.c             |   28 ++++++++++++++++++++++++++++
 diff-no-index.c            |    2 ++
 3 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index f8d0819..dbebc93 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -87,6 +87,13 @@ OPTIONS
 :git-diff: 1
 include::diff-options.txt[]
 
+--no-progress::
+--progress::
+	Disable or enable progress reporting during long computations;
+	the default is to enable progress reporting when stderr is a
+	terminal. Currently the only computation with progress support
+	is inexact rename detection.
+
 <path>...::
 	The <paths> parameters, when given, are used to limit
 	the diff to the named paths (you can give directory
diff --git a/builtin/diff.c b/builtin/diff.c
index 4c9deb2..82ecc1d 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -255,6 +255,8 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	struct blobinfo blob[2];
 	int nongit;
 	int result = 0;
+	int progress = -1;
+	int unknown_argc, parsed_argc;
 
 	/*
 	 * We could get N tree-ish in the rev.pending_objects list.
@@ -307,6 +309,32 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 			die("diff_setup_done failed");
 	}
 
+	parsed_argc = 0;
+	for (unknown_argc = i = 1; i < argc; i++) {
+		const char *arg = argv[i];
+		if (!strcmp(arg, "--") || arg[0] != '-') {
+			int j;
+			for (j = i; j < argc; j++)
+				argv[unknown_argc++] = argv[j];
+			break;
+		}
+		else if (!strcmp(argv[i], "--progress"))
+			progress = 1;
+		else if (!strcmp(argv[i], "--no-progress"))
+			progress = 0;
+		else {
+			argv[unknown_argc++] = argv[i];
+			continue;
+		}
+		parsed_argc++;
+	}
+	argc -= parsed_argc;
+
+	if (progress == -1)
+		progress = isatty(2);
+	if (progress)
+		rev.diffopt.show_rename_progress = 1;
+
 	DIFF_OPT_SET(&rev.diffopt, RECURSIVE);
 
 	/*
diff --git a/diff-no-index.c b/diff-no-index.c
index 3a36144..42cb413 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -212,6 +212,8 @@ void diff_no_index(struct rev_info *revs,
 			options |= DIFF_SILENT_ON_REMOVED;
 			i++;
 		}
+		else if (!strcmp(argv[i], "--progress"))
+			; /* handled elsewhere */
 		else if (!strcmp(argv[i], "--"))
 			i++;
 		else {
-- 
1.7.4.41.g423da
