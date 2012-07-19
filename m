From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] teach sha1_name to look in graveyard reflogs
Date: Thu, 19 Jul 2012 17:33:26 -0400
Message-ID: <20120719213326.GB20385@sigill.intra.peff.net>
References: <20120719213225.GA20311@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alexey Muranov <alexey.muranov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 19 23:33:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SryLl-0001SA-Oo
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jul 2012 23:33:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751728Ab2GSVd3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jul 2012 17:33:29 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55601 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751499Ab2GSVd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2012 17:33:28 -0400
Received: (qmail 3201 invoked by uid 107); 19 Jul 2012 21:33:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 19 Jul 2012 17:33:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jul 2012 17:33:26 -0400
Content-Disposition: inline
In-Reply-To: <20120719213225.GA20311@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201754>

The previous commit introduced graveyard reflogs, where the
reflog for a deleted branch "foo" appears in
"logs/graveyard/refs/heads/foo~".

This patch teaches dwim_log to search for these logs if the
ref does not exist, and teaches read_ref_at to fall back to
them when the literal reflog does not exist.  This allows
"deleted@{1}" to refer to the final commit of a deleted
branch (either to view or to re-create the branch).  You can
also go further back, or refer to the deleted reflog entries
by time. Accessing deleted@{0} will yield the null sha1.

Similarly, for_each_reflog_ent learns to fallback to
graveyard refs, which allows the reflog walker to work.
However, this is slightly less friendly, as the revision
parser expects the matching ref to exist before it realizes
that we are interested in the reflog. Therefore you must use
"git log -g deleted@{1}" insted of "git log -g deleted" to
walk a deleted reflog.

In both cases, we also tighten up the mode-checking when
opening the reflogs. dwim_log checks that the entry we found
is a regular file (not a directory) to avoid D/F confusion
(e.g., you ask for "foo" but "foo/bar" exists and we find
the "foo" but it is a directory).

However, read_ref_at and for_each_reflog_ent did not do this
check, and relied on earlier parts of the code to have
verified the log they are about to open. This meant that
even before this patch, a race condition in changing refs
between dwim_log and the actual read could cause bizarre
errors (e.g., read_ref_at would open and try to mmap a
directory). This patch makes it even easier to trigger those
conditions (because the ref namespace and the fallback
graveyard namespace can have D/F ambiguity for a certain
path). To solve this, we check the mode of the file we open
and treat it as if it did not exist if it is not a regular
file (this is the same way dwim_log handles it).

Signed-off-by: Jeff King <peff@peff.net>
---
 refs.c | 46 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/refs.c b/refs.c
index 553de77..551a0f9 100644
--- a/refs.c
+++ b/refs.c
@@ -1590,9 +1590,16 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 
 		mksnpath(path, sizeof(path), *p, len, str);
 		ref = resolve_ref_unsafe(path, hash, 1, NULL);
-		if (!ref)
-			continue;
-		if (!stat(git_path("logs/%s", path), &st) &&
+		if (!ref) {
+			if (!stat(refname_to_graveyard_reflog(path), &st) &&
+			    S_ISREG(st.st_mode)) {
+				it = path;
+				hashcpy(hash, null_sha1);
+			}
+			else
+				continue;
+		}
+		else if (!stat(git_path("logs/%s", path), &st) &&
 		    S_ISREG(st.st_mode))
 			it = path;
 		else if (strcmp(ref, path) &&
@@ -2201,9 +2208,16 @@ int read_ref_at(const char *refname, unsigned long at_time, int cnt,
 
 	logfile = git_path("logs/%s", refname);
 	logfd = open(logfile, O_RDONLY, 0);
-	if (logfd < 0)
-		die_errno("Unable to read log '%s'", logfile);
-	fstat(logfd, &st);
+	if (logfd < 0 || fstat(logfd, &st) < 0 || !S_ISREG(st.st_mode)) {
+		const char *deleted_log = refname_to_graveyard_reflog(refname);
+
+		if (logfd >= 0)
+			close(logfd);
+		logfd = open(deleted_log, O_RDONLY);
+		if (logfd < 0 || fstat(logfd, &st) < 0 || !S_ISREG(st.st_mode))
+			die_errno("Unable to read log '%s'", logfile);
+		logfile = deleted_log;
+	}
 	if (!st.st_size)
 		die("Log %s is empty.", logfile);
 	mapsz = xsize_t(st.st_size);
@@ -2296,18 +2310,28 @@ int for_each_recent_reflog_ent(const char *refname, each_reflog_ent_fn fn, long
 {
 	const char *logfile;
 	FILE *logfp;
+	struct stat st;
 	struct strbuf sb = STRBUF_INIT;
 	int ret = 0;
 
 	logfile = git_path("logs/%s", refname);
 	logfp = fopen(logfile, "r");
-	if (!logfp)
-		return -1;
+	if (!logfp || fstat(fileno(logfp), &st) < 0 || !S_ISREG(st.st_mode)) {
+		logfile = refname_to_graveyard_reflog(refname);
+
+		if (logfp)
+			fclose(logfp);
+		logfp = fopen(logfile, "r");
+		if (!logfp)
+			return -1;
+		if (fstat(fileno(logfp), &st) < 0 || !S_ISREG(st.st_mode)) {
+			fclose(logfp);
+			return -1;
+		}
+	}
 
 	if (ofs) {
-		struct stat statbuf;
-		if (fstat(fileno(logfp), &statbuf) ||
-		    statbuf.st_size < ofs ||
+		if (st.st_size < ofs ||
 		    fseek(logfp, -ofs, SEEK_END) ||
 		    strbuf_getwholeline(&sb, logfp, '\n')) {
 			fclose(logfp);
-- 
1.7.10.5.40.g059818d
