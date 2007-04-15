From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Expose subprojects as special files to "git diff" machinery
Date: Sun, 15 Apr 2007 11:14:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704151100550.5473@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 15 20:14:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hd9FG-0008Ss-FQ
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 20:14:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753221AbXDOSOd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 14:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753258AbXDOSOd
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 14:14:33 -0400
Received: from smtp.osdl.org ([65.172.181.24]:60220 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753221AbXDOSOc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 14:14:32 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3FIESIs021034
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 15 Apr 2007 11:14:29 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3FIESbC017685;
	Sun, 15 Apr 2007 11:14:28 -0700
X-Spam-Status: No, hits=-0.455 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44499>


The same way we generate diffs on symlinks as the the diff of text of the 
symlink, we can generate subproject diffs (when not recursing into them!) 
as the diff of the text that describes the subproject.

Of course, since what descibes a subproject is just the SHA1, that's what 
we'll use. Add some pretty-printing to make it a bit more obvious what is 
going on, and we're done.

So with this, we can get both raw diffs and "textual" diffs of subproject 
changes:

 - git diff --raw:

	:160000 160000 2de597b5ad348b7db04bd10cdd38cd81cbc93ab5 0000000... M    sub-A


 - git diff:

	diff --git a/sub-A b/sub-A
	index 2de597b..e8f11a4 160000
	--- a/sub-A
	+++ b/sub-A
	@@ -1 +1 @@
	-Subproject commit 2de597b5ad348b7db04bd10cdd38cd81cbc93ab5
	+Subproject commit e8f11a45c5c6b9e2fec6d136d3fb5aff75393d42

NOTE! We'll also want to have the ability to recurse into the subproject 
and actually diff it recursively, but that will involve a new command line 
option (I'd suggest "--subproject" and "-S", but the latter is in use by 
pickaxe), and some very different code.

But regardless of ay future recursive behaviour, we need the non-recursive 
version too (and it should be the default, at least in the absense of 
config options, so that large superprojects don't default to something 
extremely expensive).

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 diff.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/diff.c b/diff.c
index e4efb65..137f5b4 100644
--- a/diff.c
+++ b/diff.c
@@ -1419,6 +1419,21 @@ static int populate_from_stdin(struct diff_filespec *s)
 	return 0;
 }
 
+static int diff_populate_gitlink(struct diff_filespec *s, int size_only)
+{
+	int len;
+	char *data = xmalloc(100);
+	len = snprintf(data, 100,
+		"Subproject commit %s\n", sha1_to_hex(s->sha1));
+	s->data = data;
+	s->size = len;
+	if (size_only) {
+		s->data = NULL;
+		free(data);
+	}
+	return 0;
+}
+
 /*
  * While doing rename detection and pickaxe operation, we may need to
  * grab the data for the blob (or file) for our own in-core comparison.
@@ -1437,6 +1452,10 @@ int diff_populate_filespec(struct diff_filespec *s, int size_only)
 
 	if (s->data)
 		return err;
+
+	if (S_ISDIRLNK(s->mode))
+		return diff_populate_gitlink(s, size_only);
+
 	if (!s->sha1_valid ||
 	    reuse_worktree_file(s->path, s->sha1, 0)) {
 		struct stat st;
