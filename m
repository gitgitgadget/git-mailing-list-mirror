From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 7/8] longest_ancestor_length(): resolve symlinks before comparing paths
Date: Wed, 26 Sep 2012 21:34:49 +0200
Message-ID: <1348688090-13648-8-git-send-email-mhagger@alum.mit.edu>
References: <1348688090-13648-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 26 21:35:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGxOj-0004jo-Fa
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 21:35:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758357Ab2IZTfq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2012 15:35:46 -0400
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:47842 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758343Ab2IZTfk (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Sep 2012 15:35:40 -0400
X-AuditID: 1207440e-b7f036d0000008b5-7d-5063590c6233
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 08.E5.02229.C0953605; Wed, 26 Sep 2012 15:35:40 -0400 (EDT)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8QJZFfl010704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 26 Sep 2012 15:35:39 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1348688090-13648-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsUixO6iqMsTmRxgcGCVtEXXlW4mi4beK8wW
	R09ZWNxeMZ/ZYv27q8wOrB5/339g8tg56y67x8VLyh6fN8kFsERx2yQllpQFZ6bn6dslcGc8
	W9nFUjBdvWLdnUtMDYwdCl2MnBwSAiYSR5r62CFsMYkL99azdTFycQgJXGaUePN+NZRzhkni
	3pKrjCBVbAK6Eot6mplAbBEBNYmJbYdYQIqYBSYxSvRseAA2SlggXOL21flgDSwCqhJLtt1k
	A7F5BVwkeq+0Qq1TlPjxfQ0ziM0p4CrxZcMFsBohoJrDr24xT2DkXcDIsIpRLjGnNFc3NzEz
	pzg1Wbc4OTEvL7VI11gvN7NELzWldBMjJJT4djC2r5c5xCjAwajEw+vhkBwgxJpYVlyZe4hR
	koNJSZTXOgwoxJeUn1KZkVicEV9UmpNafIhRgoNZSYT3WVZSgBBvSmJlVWpRPkxKmoNFSZxX
	bYm6n5BAemJJanZqakFqEUxWhoNDSYJ3eTjQUMGi1PTUirTMnBKENBMHJ4jgAtnAA7RBOAKo
	kLe4IDG3ODMdougUo6KUOO8/kAkCIImM0jy4AbCof8UoDvSPMO8ckCoeYMKA634FNJgJaPDS
	TSCnF5ckIqSkGhiri5be9TPtPS6xlvPhVtEDe+I1p74P1P3Vdmnezrm9vAxc++ZdUNv9pCGJ
	Pfnzga1iXc9WbGlal3PIJzhty/KVvyXPO2xPi0lfMNHKdJeStXlg89fF8zc8XDijKEVyquWW
	lDM32qRPn3T8dfhlRlD09hPpm9cxTHrAceFa89z8dadi6sUmsn+4qMRSnJFoqMVc 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206438>

longest_ancestor_length() relies on a textual comparison of directory
parts to find the part of path that overlaps with one of the paths in
prefix_list.  But this doesn't work if any of the prefixes involves a
symbolic link, because the directories will look different even though
they might logically refer to the same directory.  So canonicalize the
paths listed in prefix_list using real_path_if_valid() before trying
to find matches.

path is already in canonical form, so doesn't need to be canonicalized
again.

This fixes some problems with using GIT_CEILING_DIRECTORIES that
contains paths involving symlinks, including t4035 if run with --root
set to a path involving symlinks.

Remove a number of tests of longest_ancestor_length().  It is awkward
to test longest_ancestor_length() now, because its new path
normalization behavior depends on the contents of the whole
filesystem.  But we can live without the tests, because
longest_ancestor_length() is now built of reusable components that are
themselves tested separately: string_list_split(),
string_list_longest_prefix(), and real_path_if_valid().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 path.c                | 17 ++++++++------
 t/t0060-path-utils.sh | 64 ---------------------------------------------------
 2 files changed, 10 insertions(+), 71 deletions(-)

diff --git a/path.c b/path.c
index 5cace83..981bb06 100644
--- a/path.c
+++ b/path.c
@@ -570,22 +570,25 @@ int normalize_path_copy(char *dst, const char *src)
 
 static int normalize_path_callback(struct string_list_item *item, void *cb_data)
 {
-	char buf[PATH_MAX+2];
+	char *buf;
 	const char *ceil = item->string;
-	int len = strlen(ceil);
+	const char *realpath;
+	int len;
 
-	if (len == 0 || len > PATH_MAX || !is_absolute_path(ceil))
+	if (!*ceil || !is_absolute_path(ceil))
 		return 0;
-	memcpy(buf, ceil, len+1);
-	if (normalize_path_copy(buf, buf) < 0)
+	realpath = real_path_if_valid(ceil);
+	if (!realpath)
 		return 0;
-	len = strlen(buf);
+	len = strlen(realpath);
+	buf = xmalloc(len + 2); /* Leave space for possible trailing slash */
+	strcpy(buf, realpath);
 	if (len == 0 || buf[len-1] != '/') {
 		buf[len++] = '/';
 		buf[len++] = '\0';
 	}
 	free(item->string);
-	item->string = xstrdup(buf);
+	item->string = buf;
 	return 1;
 }
 
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 4ef2345..c97bbf2 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -12,28 +12,6 @@ norm_path() {
 	"test \"\$(test-path-utils normalize_path_copy '$1')\" = '$2'"
 }
 
-# On Windows, we are using MSYS's bash, which mangles the paths.
-# Absolute paths are anchored at the MSYS installation directory,
-# which means that the path / accounts for this many characters:
-rootoff=$(test-path-utils normalize_path_copy / | wc -c)
-# Account for the trailing LF:
-if test $rootoff = 2; then
-	rootoff=	# we are on Unix
-else
-	rootoff=$(($rootoff-1))
-fi
-
-ancestor() {
-	# We do some math with the expected ancestor length.
-	expected=$3
-	if test -n "$rootoff" && test "x$expected" != x-1; then
-		expected=$(($expected+$rootoff))
-	fi
-	test_expect_success "longest ancestor: $1 $2 => $expected" \
-	"actual=\$(test-path-utils longest_ancestor_length '$1' '$2') &&
-	 test \"\$actual\" = '$expected'"
-}
-
 # Absolute path tests must be skipped on Windows because due to path mangling
 # the test program never sees a POSIX-style absolute path
 case $(uname -s) in
@@ -93,48 +71,6 @@ norm_path /d1/s1//../s2/../../d2 /d2 POSIX
 norm_path /d1/.../d2 /d1/.../d2 POSIX
 norm_path /d1/..././../d2 /d1/d2 POSIX
 
-ancestor / "" -1
-ancestor / / -1
-ancestor /foo "" -1
-ancestor /foo : -1
-ancestor /foo ::. -1
-ancestor /foo ::..:: -1
-ancestor /foo / 0
-ancestor /foo /fo -1
-ancestor /foo /foo -1
-ancestor /foo /foo/ -1
-ancestor /foo /bar -1
-ancestor /foo /bar/ -1
-ancestor /foo /foo/bar -1
-ancestor /foo /foo:/bar/ -1
-ancestor /foo /foo/:/bar/ -1
-ancestor /foo /foo::/bar/ -1
-ancestor /foo /:/foo:/bar/ 0
-ancestor /foo /foo:/:/bar/ 0
-ancestor /foo /:/bar/:/foo 0
-ancestor /foo/bar "" -1
-ancestor /foo/bar / 0
-ancestor /foo/bar /fo -1
-ancestor /foo/bar foo -1
-ancestor /foo/bar /foo 4
-ancestor /foo/bar /foo/ 4
-ancestor /foo/bar /foo/ba -1
-ancestor /foo/bar /:/fo 0
-ancestor /foo/bar /foo:/foo/ba 4
-ancestor /foo/bar /bar -1
-ancestor /foo/bar /bar/ -1
-ancestor /foo/bar /fo: -1
-ancestor /foo/bar :/fo -1
-ancestor /foo/bar /foo:/bar/ 4
-ancestor /foo/bar /:/foo:/bar/ 4
-ancestor /foo/bar /foo:/:/bar/ 4
-ancestor /foo/bar /:/bar/:/fo 0
-ancestor /foo/bar /:/bar/ 0
-ancestor /foo/bar .:/foo/. 4
-ancestor /foo/bar .:/foo/.:.: 4
-ancestor /foo/bar /foo/./:.:/bar 4
-ancestor /foo/bar .:/bar -1
-
 test_expect_success 'strip_path_suffix' '
 	test c:/msysgit = $(test-path-utils strip_path_suffix \
 		c:/msysgit/libexec//git-core libexec/git-core)
-- 
1.7.11.3
