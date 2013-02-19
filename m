From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH 2/2] check-ignore.c: fix segfault with '.' argument from repo root
Date: Tue, 19 Feb 2013 14:06:23 +0000
Message-ID: <1361282783-1413-2-git-send-email-git@adamspiers.org>
References: <CAOkDyE_96Ef5CjoxNk3mbsNi+ZAuv6XeHcO7r8RQ-Of5ELsuKw@mail.gmail.com>
 <1361282783-1413-1-git-send-email-git@adamspiers.org>
Cc: Zoltan Klinger <zoltan.klinger@gmail.com>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 19 15:06:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7nqM-0005yj-Rv
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 15:06:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932890Ab3BSOG0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 09:06:26 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:32867 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932872Ab3BSOGZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 09:06:25 -0500
Received: from localhost (b.e.0.d.8.7.e.f.e.2.f.0.b.1.1.d.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:d11b:f2e:fe78:d0eb])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 6930955B2B;
	Tue, 19 Feb 2013 14:06:24 +0000 (GMT)
X-Mailer: git-send-email 1.8.2.rc0.18.g6ba1fe2.dirty
In-Reply-To: <1361282783-1413-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216619>

Fix a corner case where check-ignore would segfault when run with the
'.' argument from the top level of a repository, due to prefix_path()
converting '.' into the empty string.  It doesn't make much sense to
call check-ignore from the top level with '.' as a parameter, since
the top-level directory would never typically be ignored, but of
course it should not segfault in this case.

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 builtin/check-ignore.c | 2 +-
 t/t0008-ignores.sh     | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 709535c..b0dd7c2 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -89,7 +89,7 @@ static int check_ignore(const char *prefix, const char **pathspec)
 					? strlen(prefix) : 0, path);
 		full_path = check_path_for_gitlink(full_path);
 		die_if_path_beyond_symlink(full_path, prefix);
-		if (!seen[i] && path[0]) {
+		if (!seen[i] && full_path[0]) {
 			exclude = last_exclude_matching_path(&check, full_path,
 							     -1, &dtype);
 			if (exclude) {
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
1.8.1.291.g0730ed6
