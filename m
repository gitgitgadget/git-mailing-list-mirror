From: Junio C Hamano <gitster@pobox.com>
Subject: Fix per-directory exclude handing for "git add"
Date: Fri, 16 Nov 2007 01:15:41 -0800
Message-ID: <7vodduzh36.fsf@gitster.siamese.dyndns.org>
References: <80ir431xny.fsf@tiny.isode.net>
	<alpine.LFD.0.9999.0711151044150.2786@woody.linux-foundation.org>
	<80ir43e04o.fsf@tiny.isode.net>
	<7vir4341ok.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Bruce Stephens <bruce.stephens@isode.com>
X-From: git-owner@vger.kernel.org Fri Nov 16 10:16:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsxJ2-0005jR-1p
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 10:16:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754117AbXKPJPv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2007 04:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753814AbXKPJPu
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 04:15:50 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:38344 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753191AbXKPJPt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2007 04:15:49 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 794CC2F0;
	Fri, 16 Nov 2007 04:16:10 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id C62DB93534;
	Fri, 16 Nov 2007 04:16:06 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65207>

In "dir_struct", each exclusion element in the exclusion stack records a
base string (pointer to the beginning with length) so that we can tell
where it came from, but this pointer is just pointing at the parameter
that is given by the caller to the push_exclude_per_directory()
function.

While read_directory_recursive() runs, calls to excluded() makes use
the data in the exclusion elements, including this base string.  The
caller of read_directory_recursive() is not supposed to free the
buffer it gave to push_exclude_per_directory() earlier, until it
returns.

The test case Bruce Stephens gave in the mailing list discussion
was simplified and added to the t3700 test.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 Junio C Hamano <gitster@pobox.com> writes:

 > Here is a tentative patch.  I do not think the patch is broken
 > but I call it tentative because:
 >
 >  - It is ugly -- I never get this "walking path delimited by
 >    slashes" loop right;
 >
 >  - It leaks the path buffer given to push(), but it is inherent
 >    in the design of "push/pop exclude per-directory" API.

 It turns out that a minimally invasive fix was a lot simpler
 than I thought.

 This still does not fix the other codepaths in ls-files that does not
 use read_directory() but walks the cache.

 dir.c          |    6 ++++--
 t/t3700-add.sh |   24 ++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index fa9f902..225fdfb 100644
--- a/dir.c
+++ b/dir.c
@@ -654,6 +654,7 @@ static void free_simplify(struct path_simplify *simplify)
 int read_directory(struct dir_struct *dir, const char *path, const char *base, int baselen, const char **pathspec)
 {
 	struct path_simplify *simplify = create_simplify(pathspec);
+	char *pp = NULL;
 
 	/*
 	 * Make sure to do the per-directory exclude for all the
@@ -661,7 +662,8 @@ int read_directory(struct dir_struct *dir, const char *path, const char *base, i
 	 */
 	if (baselen) {
 		if (dir->exclude_per_dir) {
-			char *p, *pp = xmalloc(baselen+1);
+			char *p;
+			pp = xmalloc(baselen+1);
 			memcpy(pp, base, baselen+1);
 			p = pp;
 			while (1) {
@@ -677,12 +679,12 @@ int read_directory(struct dir_struct *dir, const char *path, const char *base, i
 				else
 					p = pp + baselen;
 			}
-			free(pp);
 		}
 	}
 
 	read_directory_recursive(dir, path, base, baselen, 0, simplify);
 	free_simplify(simplify);
+	free(pp);
 	qsort(dir->entries, dir->nr, sizeof(struct dir_entry *), cmp_name);
 	qsort(dir->ignored, dir->ignored_nr, sizeof(struct dir_entry *), cmp_name);
 	return dir->nr;
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index a328bf5..287e058 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -104,9 +104,33 @@ test_expect_success 'add ignored ones with -f' '
 	git ls-files --error-unmatch d.ig/d.if d.ig/d.ig
 '
 
+test_expect_success 'add ignored ones with -f' '
+	rm -f .git/index &&
+	git add -f d.?? &&
+	git ls-files --error-unmatch d.ig/d.if d.ig/d.ig
+'
+
+test_expect_success '.gitignore with subdirectory' '
+
+	rm -f .git/index &&
+	mkdir -p sub/dir &&
+	echo "!dir/a.*" >sub/.gitignore &&
+	>sub/a.ig &&
+	>sub/dir/a.ig &&
+	git add sub/dir &&
+	git ls-files --error-unmatch sub/dir/a.ig &&
+	rm -f .git/index &&
+	(
+		cd sub/dir &&
+		git add .
+	) &&
+	git ls-files --error-unmatch sub/dir/a.ig
+'
+
 mkdir 1 1/2 1/3
 touch 1/2/a 1/3/b 1/2/c
 test_expect_success 'check correct prefix detection' '
+	rm -f .git/index &&
 	git add 1/2/a 1/3/b 1/2/c
 '
 
