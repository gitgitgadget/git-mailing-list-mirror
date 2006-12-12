X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Get rid of the dependency on RCS' merge program
Date: Wed, 13 Dec 2006 00:01:41 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612130000450.2807@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 12 Dec 2006 23:01:50 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34163>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuGdA-0001PL-Id for gcvg-git@gmane.org; Wed, 13 Dec
 2006 00:01:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964776AbWLLXBp (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 18:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964777AbWLLXBp
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 18:01:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:37532 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S964776AbWLLXBo
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006 18:01:44 -0500
Received: (qmail invoked by alias); 12 Dec 2006 23:01:43 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp033) with SMTP; 13 Dec 2006 00:01:43 +0100
To: git@vger.kernel.org, junkio@cox.net
Sender: git-owner@vger.kernel.org


Now that we have git-merge-file, an RCS merge lookalike, we no longer
need it. So long, merge, and thanks for all the fish!

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

	I only ran the test suite, which passed fine...

 .gitignore                        |    1 +
 Documentation/git-merge-index.txt |    4 +-
 INSTALL                           |    9 ----
 git-cvsserver.perl                |    2 +-
 git-rerere.perl                   |    2 +-
 git.spec.in                       |    2 +-
 merge-file.c                      |   75 ++++++------------------------------
 t/t0000-basic.sh                  |   14 +------
 8 files changed, 20 insertions(+), 89 deletions(-)

diff --git a/.gitignore b/.gitignore
index 6b8caa0..2e8f17e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -61,6 +61,7 @@ git-mailsplit
 git-merge
 git-merge-base
 git-merge-index
+git-merge-file
 git-merge-tree
 git-merge-octopus
 git-merge-one-file
diff --git a/Documentation/git-merge-index.txt b/Documentation/git-merge-index.txt
index 6cd0601..0cf505e 100644
--- a/Documentation/git-merge-index.txt
+++ b/Documentation/git-merge-index.txt
@@ -40,8 +40,8 @@ If "git-merge-index" is called with multiple <file>s (or -a) then it
 processes them in turn only stopping if merge returns a non-zero exit
 code.
 
-Typically this is run with the a script calling the merge command from
-the RCS package.
+Typically this is run with the a script calling git's imitation of
+the merge command from the RCS package.
 
 A sample script called "git-merge-one-file" is included in the
 distribution.
diff --git a/INSTALL b/INSTALL
index 8f69039..b5dd9f0 100644
--- a/INSTALL
+++ b/INSTALL
@@ -82,15 +82,6 @@ Issues of note:
 	  do that even if it wasn't for git.  There's no point in living
 	  in the dark ages any more. 
 
-	- "merge", the standard UNIX three-way merge program.  It usually
-	  comes with the "rcs" package on most Linux distributions, so if
-	  you have a developer install you probably have it already, but a
-	  "graphical user desktop" install might have left it out.
-
-	  You'll only need the merge program if you do development using
-	  git, and if you only use git to track other peoples work you'll
-	  never notice the lack of it. 
-
         - "wish", the Tcl/Tk windowing shell is used in gitk to show the
           history graphically
 
diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index bf4e228..740f2fa 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -948,7 +948,7 @@ sub req_update
 
             $log->debug("Temporary directory for merge is $dir");
 
-            my $return = system("merge", $file_local, $file_old, $file_new);
+            my $return = system("git merge-file", $file_local, $file_old, $file_new);
             $return >>= 8;
 
             if ( $return == 0 )
diff --git a/git-rerere.perl b/git-rerere.perl
index 61eef57..fdd6854 100755
--- a/git-rerere.perl
+++ b/git-rerere.perl
@@ -154,7 +154,7 @@ sub find_conflict {
 sub merge {
 	my ($name, $path) = @_;
 	record_preimage($path, "$rr_dir/$name/thisimage");
-	unless (system('merge', map { "$rr_dir/$name/${_}image" }
+	unless (system('git merge-file', map { "$rr_dir/$name/${_}image" }
 		       qw(this pre post))) {
 		my $in;
 		open $in, "<$rr_dir/$name/thisimage" or
diff --git a/git.spec.in b/git.spec.in
index f2374b7..fb95e37 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -24,7 +24,7 @@ This is a dummy package which brings in all subpackages.
 %package core
 Summary:	Core git tools
 Group:		Development/Tools
-Requires:	zlib >= 1.2, rsync, rcs, curl, less, openssh-clients, expat
+Requires:	zlib >= 1.2, rsync, curl, less, openssh-clients, expat
 %description core
 This is a stupid (but extremely fast) directory content manager.  It
 doesn't do a whole lot, but what it _does_ do is track directory
diff --git a/merge-file.c b/merge-file.c
index fc9b148..69dc1eb 100644
--- a/merge-file.c
+++ b/merge-file.c
@@ -3,52 +3,6 @@
 #include "xdiff-interface.h"
 #include "blob.h"
 
-static void rm_temp_file(const char *filename)
-{
-	unlink(filename);
-	free((void *)filename);
-}
-
-static const char *write_temp_file(mmfile_t *f)
-{
-	int fd;
-	const char *tmp = getenv("TMPDIR");
-	char *filename;
-
-	if (!tmp)
-		tmp = "/tmp";
-	filename = mkpath("%s/%s", tmp, "git-tmp-XXXXXX");
-	fd = mkstemp(filename);
-	if (fd < 0)
-		return NULL;
-	filename = xstrdup(filename);
-	if (f->size != xwrite(fd, f->ptr, f->size)) {
-		rm_temp_file(filename);
-		return NULL;
-	}
-	close(fd);
-	return filename;
-}
-
-static void *read_temp_file(const char *filename, unsigned long *size)
-{
-	struct stat st;
-	char *buf = NULL;
-	int fd = open(filename, O_RDONLY);
-	if (fd < 0)
-		return NULL;
-	if (!fstat(fd, &st)) {
-		*size = st.st_size;
-		buf = xmalloc(st.st_size);
-		if (st.st_size != xread(fd, buf, st.st_size)) {
-			free(buf);
-			buf = NULL;
-		}
-	}
-	close(fd);
-	return buf;
-}
-
 static int fill_mmfile_blob(mmfile_t *f, struct blob *obj)
 {
 	void *buf;
@@ -72,22 +26,19 @@ static void free_mmfile(mmfile_t *f)
 
 static void *three_way_filemerge(mmfile_t *base, mmfile_t *our, mmfile_t *their, unsigned long *size)
 {
-	void *res;
-	const char *t1, *t2, *t3;
-
-	t1 = write_temp_file(base);
-	t2 = write_temp_file(our);
-	t3 = write_temp_file(their);
-	res = NULL;
-	if (t1 && t2 && t3) {
-		int code = run_command("merge", t2, t1, t3, NULL);
-		if (!code || code == -1)
-			res = read_temp_file(t2, size);
-	}
-	rm_temp_file(t1);
-	rm_temp_file(t2);
-	rm_temp_file(t3);
-	return res;
+	mmbuffer_t res;
+	xpparam_t xpp;
+	int merge_status;
+
+	memset(&xpp, 0, sizeof(xpp));
+	merge_status = xdl_merge(base, our, ".our", their, ".their",
+		&xpp, XDL_MERGE_ZEALOUS, &res);
+
+	if (merge_status < 0)
+		return NULL;
+
+	*size = res.size;
+	return res.ptr;
 }
 
 static int common_outf(void *priv_, mmbuffer_t *mb, int nbuf)
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 81f3bed..3260d1d 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -19,11 +19,7 @@ modification *should* take notice and update the test vectors here.
 '
 
 ################################################################
-# It appears that people are getting bitten by not installing
-# 'merge' (usually part of RCS package in binary distributions).
-# Check this and error out before running any tests.  Also catch
-# the bogosity of trying to run tests without building while we
-# are at it.
+# It appears that people try to run tests without building...
 
 ../git >/dev/null
 if test $? != 1
@@ -32,14 +28,6 @@ then
 	exit 1
 fi
 
-merge >/dev/null 2>/dev/null
-if test $? = 127
-then
-	echo >&2 'You do not seem to have "merge" installed.
-Please check INSTALL document.'
-	exit 1
-fi
-
 . ./test-lib.sh
 
 ################################################################
-- 
1.4.4.2.g473fa0-dirty
