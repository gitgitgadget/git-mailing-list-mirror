From: Jeff King <peff@peff.net>
Subject: [PATCH 04/17] add_to_alternates_file: don't add duplicate entries
Date: Mon, 10 Aug 2015 05:34:46 -0400
Message-ID: <20150810093446.GD30981@sigill.intra.peff.net>
References: <20150810092731.GA9027@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jim Hill <gjthill@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 10 11:34:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOjTs-0003t4-B7
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 11:34:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753123AbbHJJew (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 05:34:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:42812 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752577AbbHJJev (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 05:34:51 -0400
Received: (qmail 30838 invoked by uid 102); 10 Aug 2015 09:34:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Aug 2015 04:34:51 -0500
Received: (qmail 3080 invoked by uid 107); 10 Aug 2015 09:35:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Aug 2015 05:35:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Aug 2015 05:34:46 -0400
Content-Disposition: inline
In-Reply-To: <20150810092731.GA9027@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275570>

The add_to_alternates_file function blindly uses
hold_lock_file_for_append to copy the existing contents, and
then adds the new line to it. This has two minor problems:

  1. We might add duplicate entries, which are ugly and
     inefficient.

  2. We do not check that the file ends with a newline, in
     which case we would bogusly append to the final line.
     This is quite unlikely in practice, though, as we call
     this function only from git-clone, so presumably we are
     the only writers of the file (and we always add a
     newline).

Instead of using hold_lock_file_for_append, let's copy the
file line by line, which ensures all records are properly
terminated. If we see an extra line, we can simply abort the
update (there is no point in even copying the rest, as we
know that it would be identical to the original).

As a bonus, we also get rid of some calls to the
static-buffer mkpath and git_path functions.

Signed-off-by: Jeff King <peff@peff.net>
---
This is a polishing of the thread at:

  http://thread.gmane.org/gmane.comp.version-control.git/270341

 sha1_file.c                | 47 +++++++++++++++++++++++++++++++++++++++-------
 t/t5700-clone-reference.sh |  5 +++++
 2 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 1cee438..3400b8b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -404,13 +404,46 @@ void read_info_alternates(const char * relative_base, int depth)
 void add_to_alternates_file(const char *reference)
 {
 	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
-	int fd = hold_lock_file_for_append(lock, git_path("objects/info/alternates"), LOCK_DIE_ON_ERROR);
-	const char *alt = mkpath("%s\n", reference);
-	write_or_die(fd, alt, strlen(alt));
-	if (commit_lock_file(lock))
-		die("could not close alternates file");
-	if (alt_odb_tail)
-		link_alt_odb_entries(alt, strlen(alt), '\n', NULL, 0);
+	char *alts = git_pathdup("objects/info/alternates");
+	FILE *in, *out;
+
+	hold_lock_file_for_update(lock, alts, LOCK_DIE_ON_ERROR);
+	out = fdopen_lock_file(lock, "w");
+	if (!out)
+		die_errno("unable to fdopen alternates lockfile");
+
+	in = fopen(alts, "r");
+	if (in) {
+		struct strbuf line = STRBUF_INIT;
+		int found = 0;
+
+		while (strbuf_getline(&line, in, '\n') != EOF) {
+			if (!strcmp(reference, line.buf)) {
+				found = 1;
+				break;
+			}
+			fprintf_or_die(out, "%s\n", line.buf);
+		}
+
+		strbuf_release(&line);
+		fclose(in);
+
+		if (found) {
+			rollback_lock_file(lock);
+			lock = NULL;
+		}
+	}
+	else if (errno != ENOENT)
+		die_errno("unable to read alternates file");
+
+	if (lock) {
+		fprintf_or_die(out, "%s\n", reference);
+		if (commit_lock_file(lock))
+			die_errno("unable to move new alternates file into place");
+		if (alt_odb_tail)
+			link_alt_odb_entries(reference, strlen(reference), '\n', NULL, 0);
+	}
+	free(alts);
 }
 
 int foreach_alt_odb(alt_odb_fn fn, void *cb)
diff --git a/t/t5700-clone-reference.sh b/t/t5700-clone-reference.sh
index 51d131a..ef1779f 100755
--- a/t/t5700-clone-reference.sh
+++ b/t/t5700-clone-reference.sh
@@ -120,6 +120,11 @@ test_expect_success 'cloning with reference being subset of source (-l -s)' '
 	git clone -l -s --reference A B E
 '
 
+test_expect_success 'cloning with multiple references drops duplicates' '
+	git clone -s --reference B --reference A --reference B A dups &&
+	test_line_count = 2 dups/.git/objects/info/alternates
+'
+
 test_expect_success 'clone with reference from a tagged repository' '
 	(
 		cd A && git tag -a -m tagged HEAD
-- 
2.5.0.414.g670f2a4
