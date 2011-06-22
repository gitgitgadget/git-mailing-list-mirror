From: Jeff King <peff@peff.net>
Subject: [PATCHv2 1/9] archive: reorder option parsing and config reading
Date: Tue, 21 Jun 2011 21:20:44 -0400
Message-ID: <20110622012044.GA30604@sigill.intra.peff.net>
References: <20110622011923.GA30370@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	"J.H." <warthog19@eaglescrag.net>, git@vger.kernel.org,
	git-dev@github.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 22 03:20:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZC7f-0003gE-UB
	for gcvg-git-2@lo.gmane.org; Wed, 22 Jun 2011 03:20:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757747Ab1FVBUq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 21:20:46 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56445
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757730Ab1FVBUq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 21:20:46 -0400
Received: (qmail 7312 invoked by uid 107); 22 Jun 2011 01:20:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 21 Jun 2011 21:20:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Jun 2011 21:20:44 -0400
Content-Disposition: inline
In-Reply-To: <20110622011923.GA30370@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176204>

The archive command does three things during its
initialization phase:

  1. parse command-line options

  2. setup the git directory

  3. read config

During phase (1), if we see any options that do not require
a git directory (like "--list"), we handle them immediately
and exit, making it safe to abort step (2) if we are not in
a git directory.

Step (3) must come after step (2), since the git directory
may influence configuration.  However, this leaves no
possibility of configuration from step (3) impacting the
command-line options in step (1) (which is useful, for
example, for supporting user-configurable output formats).

Instead, let's reorder this to:

  1. setup the git directory, if it exists

  2. read config

  3. parse command-line options

  4. if we are not in a git repository, die

This should have the same external behavior, but puts
configuration before command-line parsing.

Signed-off-by: Jeff King <peff@peff.net>
---
Same as v1.

 archive.c |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/archive.c b/archive.c
index 42f2d2f..2616676 100644
--- a/archive.c
+++ b/archive.c
@@ -387,17 +387,27 @@ static int parse_archive_args(int argc, const char **argv,
 int write_archive(int argc, const char **argv, const char *prefix,
 		int setup_prefix)
 {
+	int nongit = 0;
 	const struct archiver *ar = NULL;
 	struct archiver_args args;
 
-	argc = parse_archive_args(argc, argv, &ar, &args);
 	if (setup_prefix && prefix == NULL)
-		prefix = setup_git_directory();
+		prefix = setup_git_directory_gently(&nongit);
+
+	git_config(git_default_config, NULL);
+
+	argc = parse_archive_args(argc, argv, &ar, &args);
+	if (nongit) {
+		/*
+		 * We know this will die() with an error, so we could just
+		 * die ourselves; but its error message will be more specific
+		 * than what we could write here.
+		 */
+		setup_git_directory();
+	}
 
 	parse_treeish_arg(argv, &args, prefix);
 	parse_pathspec_arg(argv + 1, &args);
 
-	git_config(git_default_config, NULL);
-
 	return ar->write_archive(&args);
 }
-- 
1.7.5.4.44.g4b107
