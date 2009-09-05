From: Jeff King <peff@peff.net>
Subject: [PATCH/RFC 5/6] status: add --porcelain output format
Date: Sat, 5 Sep 2009 04:55:37 -0400
Message-ID: <20090905085537.GE13157@coredump.intra.peff.net>
References: <20090905084809.GA13073@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	bill lam <cbill.lam@gmail.com>, git <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 05 10:55:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mjr3k-0002ou-Ke
	for gcvg-git-2@lo.gmane.org; Sat, 05 Sep 2009 10:55:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757261AbZIEIzj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2009 04:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757249AbZIEIzj
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Sep 2009 04:55:39 -0400
Received: from peff.net ([208.65.91.99]:51614 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757217AbZIEIzi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2009 04:55:38 -0400
Received: (qmail 26146 invoked by uid 107); 5 Sep 2009 08:55:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 05 Sep 2009 04:55:54 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Sep 2009 04:55:37 -0400
Content-Disposition: inline
In-Reply-To: <20090905084809.GA13073@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127804>

The "short" format was added to "git status" recently to
provide a less verbose way of looking at the same
information. This has two practical uses:

  1. Users who want a more dense display of the information.

  2. Scripts which want to parse the information and need a
     stable, easy-to-parse interface.

For now, the "--short" format covers both of those uses.
However, as time goes on, users of (1) may want additional
format tweaks, or for "git status" to change its behavior
based on configuration variables. Those wishes will be at
odds with (2), which wants to stability for scripts.

This patch introduces a separate --porcelain option early to
avoid problems later on.  Right now the --short and
--porcelain outputs are identical. However, as time goes on,
we will have the freedom to customize --short for human
consumption while keeping --porcelain stable.

Signed-off-by: Jeff King <peff@peff.net>
---
No tests. Does this really need them? At this point, it would be pure
duplication of the --short tests; I am inclined to leave such tests
until later when there is actually a difference between the two formats
(and then we will know _what_ to test).

 Documentation/git-status.txt |    9 +++++++--
 builtin-commit.c             |    9 ++++++++-
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index fd71a7a..58d35fb 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -27,6 +27,11 @@ OPTIONS
 --short::
 	Give the output in the short-format.
 
+--porcelain::
+	Give the output in a stable, easy-to-parse format for scripts.
+	Currently this is identical to --short output, but is guaranteed
+	not to change in the future, making it safe for scripts.
+
 -u[<mode>]::
 --untracked-files[=<mode>]::
 	Show untracked files (Default: 'all').
@@ -45,8 +50,8 @@ used to change the default for when the option is not
 specified.
 
 -z::
-	Terminate entries with NUL, instead of LF.  This implies `-s`
-	(short status) output format.
+	Terminate entries with NUL, instead of LF.  This implies
+	the `--porcelain` output format if no other format is given.
 
 
 OUTPUT
diff --git a/builtin-commit.c b/builtin-commit.c
index aa4a358..ffdee31 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -995,12 +995,16 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	static enum {
 		STATUS_FORMAT_LONG,
 		STATUS_FORMAT_SHORT,
+		STATUS_FORMAT_PORCELAIN,
 	} status_format = STATUS_FORMAT_LONG;
 	unsigned char sha1[20];
 	static struct option builtin_status_options[] = {
 		OPT__VERBOSE(&verbose),
 		OPT_SET_INT('s', "short", &status_format,
 			    "show status concisely", STATUS_FORMAT_SHORT),
+		OPT_SET_INT(0, "porcelain", &status_format,
+			    "show porcelain output format",
+			    STATUS_FORMAT_PORCELAIN),
 		OPT_BOOLEAN('z', "null", &null_termination,
 			    "terminate entries with NUL"),
 		{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg,
@@ -1011,7 +1015,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	};
 
 	if (null_termination && status_format == STATUS_FORMAT_LONG)
-		status_format = STATUS_FORMAT_SHORT;
+		status_format = STATUS_FORMAT_PORCELAIN;
 
 	wt_status_prepare(&s);
 	git_config(git_status_config, &s);
@@ -1032,6 +1036,9 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	case STATUS_FORMAT_SHORT:
 		short_print(&s, null_termination);
 		break;
+	case STATUS_FORMAT_PORCELAIN:
+		short_print(&s, null_termination);
+		break;
 	case STATUS_FORMAT_LONG:
 		s.verbose = verbose;
 		if (s.relative_paths)
-- 
1.6.4.2.418.g1a1d3.dirty
