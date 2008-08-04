From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] update-index: refuse to add working tree items beyond
 symlinks
Date: Mon, 04 Aug 2008 00:51:42 -0700
Message-ID: <7v7iax43qp.fsf_-_@gitster.siamese.dyndns.org>
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
X-From: git-owner@vger.kernel.org Mon Aug 04 09:53:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPusA-000217-AO
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 09:52:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558AbYHDHvw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 03:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751525AbYHDHvw
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 03:51:52 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33167 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505AbYHDHvw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 03:51:52 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B55CE46E64;
	Mon,  4 Aug 2008 03:51:50 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id ED43B46E62; Mon,  4 Aug 2008 03:51:44 -0400 (EDT)
In-Reply-To: <7vej5543v5.fsf_-_@gitster.siamese.dyndns.org> (Junio C.
 Hamano's message of "Mon, 04 Aug 2008 00:49:02 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3276298E-61FA-11DD-95EB-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91321>

When "sym" is a symbolic link that is inside the working tree, and it
points at a directory "dir" that has "path" in it, "update-index --add
sym/path" used to mistakenly add "sym/path" as if "sym" were a normal
directory.

"git apply", "git diff" and "git merge" have been taught about this issue
some time ago, but "update-index" and "add" have been left ignorant for
too long.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-update-index.c     |    5 ++++-
 t/t0055-beyond-symlinks.sh |   20 ++++++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletions(-)
 create mode 100755 t/t0055-beyond-symlinks.sh

diff --git a/builtin-update-index.c b/builtin-update-index.c
index 38eb53c..434cb8e 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -194,6 +194,10 @@ static int process_path(const char *path)
 	int len;
 	struct stat st;
 
+	len = strlen(path);
+	if (has_symlink_leading_path(len, path))
+		return error("'%s' is beyond a symbolic link", path);
+
 	/*
 	 * First things first: get the stat information, to decide
 	 * what to do about the pathname!
@@ -201,7 +205,6 @@ static int process_path(const char *path)
 	if (lstat(path, &st) < 0)
 		return process_lstat_error(path, errno);
 
-	len = strlen(path);
 	if (S_ISDIR(st.st_mode))
 		return process_directory(path, len, &st);
 
diff --git a/t/t0055-beyond-symlinks.sh b/t/t0055-beyond-symlinks.sh
new file mode 100755
index 0000000..eb11dd7
--- /dev/null
+++ b/t/t0055-beyond-symlinks.sh
@@ -0,0 +1,20 @@
+#!/bin/sh
+
+test_description='update-index refuses to add beyond symlinks'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	>a &&
+	mkdir b &&
+	ln -s b c &&
+	>c/d &&
+	git update-index --add a b/d
+'
+
+test_expect_success 'update-index --add beyond symlinks' '
+	test_must_fail git update-index --add c/d &&
+	! ( git ls-files | grep c/d )
+'
+
+test_done
-- 
1.6.0.rc1.64.g61192
