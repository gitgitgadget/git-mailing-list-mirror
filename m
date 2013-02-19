From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v2 2/2] check-ignore.c, dir.c: fix segfault with '.' argument from repo root
Date: Tue, 19 Feb 2013 19:21:36 +0000
Message-ID: <1361301696-11307-1-git-send-email-git@adamspiers.org>
References: <CAOkDyE9VVuFn6B=Fe4XHxGCEW0MFgndx1X0+9hO36Soxb37YQw@mail.gmail.com>
Cc: Zoltan Klinger <zoltan.klinger@gmail.com>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 19 20:22:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7slO-0003hC-WA
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 20:22:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933100Ab3BSTVj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 14:21:39 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:33376 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933020Ab3BSTVi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 14:21:38 -0500
Received: from localhost (b.e.0.d.8.7.e.f.e.2.f.0.b.1.1.d.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:d11b:f2e:fe78:d0eb])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 55BA455AFA;
	Tue, 19 Feb 2013 19:21:37 +0000 (GMT)
X-Mailer: git-send-email 1.8.2.rc0.18.g543d1e4
In-Reply-To: <CAOkDyE9VVuFn6B=Fe4XHxGCEW0MFgndx1X0+9hO36Soxb37YQw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216652>

Fix a corner case where check-ignore would segfault when run with the
'.' argument from the top level of a repository, due to prefix_path()
converting '.' into the empty string.  It doesn't make much sense to
call check-ignore from the top level with '.' as a parameter, since
the top-level directory would never typically be ignored, but of
course it should not segfault in this case.  The existing code
attempted to check for this case but failed due to using the wrong
variable.  Instead we move the check to last_exclude_matching_path(),
in case other callers present or future have a similar issue.

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 builtin/check-ignore.c | 2 +-
 dir.c                  | 8 ++++++++
 t/t0008-ignores.sh     | 5 +++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 709535c..0240f99 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -89,7 +89,7 @@ static int check_ignore(const char *prefix, const char **pathspec)
 					? strlen(prefix) : 0, path);
 		full_path = check_path_for_gitlink(full_path);
 		die_if_path_beyond_symlink(full_path, prefix);
-		if (!seen[i] && path[0]) {
+		if (!seen[i]) {
 			exclude = last_exclude_matching_path(&check, full_path,
 							     -1, &dtype);
 			if (exclude) {
diff --git a/dir.c b/dir.c
index 57394e4..1ae0b90 100644
--- a/dir.c
+++ b/dir.c
@@ -828,6 +828,14 @@ struct exclude *last_exclude_matching_path(struct path_exclude_check *check,
 	struct exclude *exclude;
 
 	/*
+	 * name could be the empty string, e.g. if check-ignore was
+	 * invoked from the top level with '.', prefix_path() will
+	 * convert it into "".
+	 */
+	if (!*name)
+		return NULL;
+
+	/*
 	 * we allow the caller to pass namelen as an optimization; it
 	 * must match the length of the name, as we eventually call
 	 * is_excluded() on the whole name string.
diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index ebe7c70..9c1bde1 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -138,6 +138,7 @@ test_expect_success 'setup' '
 	cat <<-\EOF >.gitignore &&
 		one
 		ignored-*
+		top-level-dir/
 	EOF
 	for dir in . a
 	do
@@ -177,6 +178,10 @@ test_expect_success 'setup' '
 #
 # test invalid inputs
 
+test_expect_success_multi '. corner-case' '' '
+	test_check_ignore . 1
+'
+
 test_expect_success_multi 'empty command line' '' '
 	test_check_ignore "" 128 &&
 	stderr_contains "fatal: no path specified"
-- 
1.8.2.rc0.18.g543d1e4
