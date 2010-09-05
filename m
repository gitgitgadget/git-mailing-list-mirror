From: Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 06/15] Automatically reuse sparse limiting arguments in revision walking
Date: Sat,  4 Sep 2010 18:13:58 -0600
Message-ID: <1283645647-1891-7-git-send-email-newren@gmail.com>
References: <1283645647-1891-1-git-send-email-newren@gmail.com>
Cc: pclouds@gmail.com, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 05 02:13:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os2rl-0008IQ-4F
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 02:13:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754629Ab0IEANq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 20:13:46 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:60884 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754466Ab0IEANH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 20:13:07 -0400
Received: by pxi10 with SMTP id 10so579626pxi.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 17:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=yZ6nKzgj0iMJ9LPfgQ3ZijIIFa00FqhVqklL5e91dUY=;
        b=wBS9oxvutmBZmoy+Su+kVWYxNsxocVohRQYqp8x9ueelGXuWjTh4qUanNbfLeIxmkY
         KtKNjr+i2JVQ5mCyAH8D72sdcOZORFBoA7eE6UXFpIanjsiR0QoXJe+15gwHgZSkFzEA
         qfdvtr57yjju6t0XUrYXhhFf4c3dc7H/6SJ5s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tSPx86gBSeCGq0e21Aw1xCm9qmz9Q+YY0P+LnNPycKEfTW8z/dG4qY9CMHOKmm3sAf
         yhUGHgpcrFOwmBgH5HgiYGmqAW7iQQVjwo2PAMq/boapVRyUbf3QDdtwYG3SvL95lBBR
         pt86Yd93bZ7ujM7WYtPN5PjpdsH80dHGeKutA=
Received: by 10.142.135.17 with SMTP id i17mr852364wfd.13.1283645585884;
        Sat, 04 Sep 2010 17:13:05 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id 33sm7341833wad.18.2010.09.04.17.13.03
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 17:13:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.140.gd06af
In-Reply-To: <1283645647-1891-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155403>

In a sparse repository, by automatically making use of sparse limits
specified at clone time, we can avoid walking uninteresting commits and
prevent access to missing trees and blobs.  Note that this means that if
you created a sparse clone with
  git clone <repo> <dest_dir> -- PATH1 PATH2 PATH3 PATH4 PATH5
then
  git log
implicitly runs as though you had manually specified
  git log -- PATH1 PATH2 PATH3 PATH4 PATH5
Similarly, running
  git diff
implicitly runs as though you had manually specified
  git diff -- PATH1 PATH2 PATH3 PATH4 PATH5

This is necessary for proper operation of git diff in a sparse clone to
avoid accessing missing objects.  In the case of a plain git log, this
merely serves as an additional convenience, but for more complicated log
operations (e.g. when passing -p or -S options) it becomes necessary.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 revision.c                          |   16 +++++++++++++++-
 t/t5720-sparse-repository-basics.sh |    6 +++---
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/revision.c b/revision.c
index a962b77..67b1a1d 100644
--- a/revision.c
+++ b/revision.c
@@ -1492,6 +1492,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	const char *submodule = NULL;
 	const char *optarg;
 	int argcount;
+	const char *arg;
 
 	if (opt)
 		submodule = opt->submodule;
@@ -1514,7 +1515,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	flags = 0;
 	read_from_stdin = 0;
 	for (left = i = 1; i < argc; i++) {
-		const char *arg = argv[i];
+		arg = argv[i];
 		if (*arg == '-') {
 			int opts;
 
@@ -1624,6 +1625,19 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 			got_rev_arg = 1;
 	}
 
+	/*
+	 * FIXME: This disallows things like --all, --stdin, --not, although
+	 * some of those like --stdin may not make sense anyway.
+	 */
+	for (arg = git_sparse_limits ? *git_sparse_limits : NULL; arg; arg++) {
+		const int flags = 0;
+		const int cant_be_filename = 1;
+		if (handle_revision_arg(arg, revs, flags, cant_be_filename))
+			die("bad revision '%s'", arg);
+	}
+	if (git_sparse_pathspecs)
+		append_prune_data(&prune_data, git_sparse_pathspecs);
+
 	if (prune_data)
 		revs->prune_data = get_pathspec(revs->prefix, prune_data);
 
diff --git a/t/t5720-sparse-repository-basics.sh b/t/t5720-sparse-repository-basics.sh
index b11c5ab..d04e171 100755
--- a/t/t5720-sparse-repository-basics.sh
+++ b/t/t5720-sparse-repository-basics.sh
@@ -60,7 +60,7 @@ test_expect_success 'plumbing: ls-files works' '
 	test "sub/b/file" = "$(cat output)"
 '
 
-test_expect_failure 'plumbing: rev-list works' '
+test_expect_success 'plumbing: rev-list works' '
 	test "$(git rev-list HEAD)" = \
 	     "$(git $srcgit rev-list HEAD -- sub/b/)" &&
 	test "$(git rev-list --objects HEAD)" = \
@@ -87,13 +87,13 @@ for i in $(git $srcgit rev-list HEAD | xargs git name-rev | cut -b 42-); do
 	"
 done
 
-test_expect_failure 'basic: log works' '
+test_expect_success 'basic: log works' '
 	git log > /dev/null &&
 	git log -p > /dev/null &&
 	git log -Scontent > /dev/null
 '
 
-test_expect_failure 'basic: diff works' '
+test_expect_success 'basic: diff works' '
 	git diff master~3 master &&
 	git diff master~3
 '
-- 
1.7.2.2.140.gd06af
