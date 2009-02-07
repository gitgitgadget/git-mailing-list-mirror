From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] give exclude mechanism a debug option
Date: Sat, 7 Feb 2009 01:44:55 -0500
Message-ID: <20090207064454.GB14906@coredump.intra.peff.net>
References: <20090207064221.GA14856@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 07 07:46:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVgxO-00038W-LS
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 07:46:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753016AbZBGGo6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 01:44:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752965AbZBGGo5
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 01:44:57 -0500
Received: from peff.net ([208.65.91.99]:45504 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752917AbZBGGo5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 01:44:57 -0500
Received: (qmail 19003 invoked by uid 107); 7 Feb 2009 06:45:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 07 Feb 2009 01:45:11 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 07 Feb 2009 01:44:55 -0500
Content-Disposition: inline
In-Reply-To: <20090207064221.GA14856@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108817>

Users can set GIT_DEBUG_IGNORE in the environment to get the
exclusion mechanism to dump to stderr files mentioned in
.gitignore along with the pattern that matched. The output
looks something like:

  foo.c: exclude: *.c

This implementation has several shortcomings that make it
unsuitable for inclusion:

  1. Doing it as a debug environment variable is hack-ish.
     A nicer interface would be a .gitignore equivalent of
     "git check-attr".

  2. If you ask for "foo/bar", and "foo/" is ignored, the
     output will show only "foo: exclude: foo". This is an
     artifact of the calling interface: you don't ask "is
     foo/bar excluded", but rather while recursing through
     "foo/" you ask "should I bother even recursing into
     foo?". So the exclusion code never even knows that you
     might have cared about foo/bar in the first place.

  3. There is no indication of where patterns came from. We
     could specify whether it came from the command-line,
     from per-directory files, or from another file. But what
     is most interesting is the actual _filename_ that it
     came from. I.e., something like:

       sub/foo.c: exclude: sub/.gitignore: *.c

     But that information seems to have been forgotten by
     the time we are actually doing excludes.

Signed-off-by: Jeff King <peff@peff.net>
---
In addition to the problems above, this is hardly tested. ;)

 dir.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/dir.c b/dir.c
index 0ea81b7..1052496 100644
--- a/dir.c
+++ b/dir.c
@@ -8,6 +8,7 @@
 #include "cache.h"
 #include "dir.h"
 #include "refs.h"
+#include "quote.h"
 
 struct path_simplify {
 	int len;
@@ -354,6 +355,24 @@ static struct exclude *excluded_1(const char *pathname,
 	return NULL;
 }
 
+static int debug_ignore(void)
+{
+	static int ignore = -1;
+	if (ignore == -1) {
+		const char *env = getenv("GIT_DEBUG_IGNORE");
+		ignore = env ? git_config_bool("GIT_DEBUG_IGNORE", env) : 0;
+	}
+	return ignore;
+}
+
+static void show_ignore(const char *path, struct exclude *x)
+{
+	quote_c_style(path, NULL, stderr, 0);
+	fprintf(stderr, ": %s: %.*s\n",
+		(x->to_exclude ? "exclude" : "include"),
+		x->patternlen, x->pattern);
+}
+
 int excluded(struct dir_struct *dir, const char *pathname, int *dtype_p)
 {
 	int pathlen = strlen(pathname);
@@ -367,6 +386,8 @@ int excluded(struct dir_struct *dir, const char *pathname, int *dtype_p)
 					dtype_p, &dir->exclude_list[st]);
 		if (!x)
 			continue;
+		if (debug_ignore())
+			show_ignore(pathname, x);
 		switch (x->to_exclude) {
 		case 0:
 			return 0;
-- 
1.6.1.2.552.g1682c.dirty
