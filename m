From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] add: refuse to add working tree items beyond symlinks
Date: Mon, 04 Aug 2008 00:52:37 -0700
Message-ID: <7v1w1543p6.fsf_-_@gitster.siamese.dyndns.org>
References: <20080721002354.GK10151@machine.or.cz>
 <20080721002508.26773.92277.stgit@localhost>
 <7v8wvpm9cl.fsf@gitster.siamese.dyndns.org>
 <7vej5543v5.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 04 09:54:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPut2-0002Li-IN
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 09:53:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552AbYHDHwr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 03:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751580AbYHDHwr
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 03:52:47 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41687 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552AbYHDHwq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 03:52:46 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 07AF549627;
	Mon,  4 Aug 2008 03:52:46 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2827549625; Mon,  4 Aug 2008 03:52:38 -0400 (EDT)
In-Reply-To: <7vej5543v5.fsf_-_@gitster.siamese.dyndns.org> (Junio C.
 Hamano's message of "Mon, 04 Aug 2008 00:49:02 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5368339E-61FA-11DD-81C2-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91322>

This is the same fix for the issue of adding "sym/path" when "sym" is a
symblic link that points at a directory "dir" with "path" in it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-add.c              |   12 +++++++++++-
 dir.c                      |    6 +++++-
 t/t0055-beyond-symlinks.sh |    7 ++++++-
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index fc3f96e..81b64d7 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -153,6 +153,16 @@ static const char **validate_pathspec(int argc, const char **argv, const char *p
 {
 	const char **pathspec = get_pathspec(prefix, argv);
 
+	if (pathspec) {
+		const char **p;
+		for (p = pathspec; *p; p++) {
+			if (has_symlink_leading_path(strlen(*p), *p)) {
+				int len = prefix ? strlen(prefix) : 0;
+				die("'%s' is beyond a symbolic link", *p + len);
+			}
+		}
+	}
+
 	return pathspec;
 }
 
@@ -278,7 +288,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		fprintf(stderr, "Maybe you wanted to say 'git add .'?\n");
 		return 0;
 	}
-	pathspec = get_pathspec(prefix, argv);
+	pathspec = validate_pathspec(argc, argv, prefix);
 
 	/*
 	 * If we are adding new files, we need to scan the working
diff --git a/dir.c b/dir.c
index 29d1d5b..ae7046f 100644
--- a/dir.c
+++ b/dir.c
@@ -727,8 +727,12 @@ static void free_simplify(struct path_simplify *simplify)
 
 int read_directory(struct dir_struct *dir, const char *path, const char *base, int baselen, const char **pathspec)
 {
-	struct path_simplify *simplify = create_simplify(pathspec);
+	struct path_simplify *simplify;
 
+	if (has_symlink_leading_path(strlen(path), path))
+		return dir->nr;
+
+	simplify = create_simplify(pathspec);
 	read_directory_recursive(dir, path, base, baselen, 0, simplify);
 	free_simplify(simplify);
 	qsort(dir->entries, dir->nr, sizeof(struct dir_entry *), cmp_name);
diff --git a/t/t0055-beyond-symlinks.sh b/t/t0055-beyond-symlinks.sh
index eb11dd7..b29c37a 100755
--- a/t/t0055-beyond-symlinks.sh
+++ b/t/t0055-beyond-symlinks.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='update-index refuses to add beyond symlinks'
+test_description='update-index and add refuse to add beyond symlinks'
 
 . ./test-lib.sh
 
@@ -17,4 +17,9 @@ test_expect_success 'update-index --add beyond symlinks' '
 	! ( git ls-files | grep c/d )
 '
 
+test_expect_success 'add beyond symlinks' '
+	test_must_fail git add c/d &&
+	! ( git ls-files | grep c/d )
+'
+
 test_done
-- 
1.6.0.rc1.64.g61192
