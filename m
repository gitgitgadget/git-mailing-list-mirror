From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 2/9] git p4 test: use real_path to resolve p4 client symlinks
Date: Mon, 25 Jun 2012 21:18:18 -0400
Message-ID: <1340673505-10551-3-git-send-email-pw@padd.com>
References: <1340673505-10551-1-git-send-email-pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 26 03:23:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjKVF-0004Kg-S5
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 03:23:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757914Ab2FZBTJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jun 2012 21:19:09 -0400
Received: from honk.padd.com ([74.3.171.149]:45528 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757814Ab2FZBTI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2012 21:19:08 -0400
Received: from arf.padd.com (unknown [50.55.159.91])
	by honk.padd.com (Postfix) with ESMTPSA id 328532E87;
	Mon, 25 Jun 2012 18:19:08 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id D1EB231383; Mon, 25 Jun 2012 21:19:05 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.rc2.72.gebb7ee5
In-Reply-To: <1340673505-10551-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200609>

The p4 program is finicky about making sure the recorded client Root
matches the current working directory.  The way it discovers the latter
seems to be to inspect shell variable $PWD.  This could involve symlinks,
that while leading to the same place as the client Root, look different,
and cause p4 to fail.

Resolve all client paths using "test-path-utils real_path $path".  This
removes ".." and resolves all symlinks.

Discovered while running with --root=/dev/shm, which is a link to
/run/shm.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/lib-git-p4.sh           | 2 +-
 t/t9806-git-p4-options.sh | 2 +-
 t/t9810-git-p4-rcs.sh     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index 0080eae..2693105 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -27,7 +27,7 @@ export P4CLIENT=client
 export P4EDITOR=:
 
 db="$TRASH_DIRECTORY/db"
-cli="$TRASH_DIRECTORY/cli"
+cli=$(test-path-utils real_path "$TRASH_DIRECTORY/cli")
 git="$TRASH_DIRECTORY/git"
 pidfile="$TRASH_DIRECTORY/p4d.pid"
 
diff --git a/t/t9806-git-p4-options.sh b/t/t9806-git-p4-options.sh
index 2892367..83738fa 100755
--- a/t/t9806-git-p4-options.sh
+++ b/t/t9806-git-p4-options.sh
@@ -128,7 +128,7 @@ test_expect_success 'clone --use-client-spec' '
 		exec >/dev/null &&
 		test_must_fail git p4 clone --dest="$git" --use-client-spec
 	) &&
-	cli2="$TRASH_DIRECTORY/cli2" &&
+	cli2=$(test-path-utils real_path "$TRASH_DIRECTORY/cli2") &&
 	mkdir -p "$cli2" &&
 	test_when_finished "rmdir \"$cli2\"" &&
 	(
diff --git a/t/t9810-git-p4-rcs.sh b/t/t9810-git-p4-rcs.sh
index d8d9ca4..c7313b0 100755
--- a/t/t9810-git-p4-rcs.sh
+++ b/t/t9810-git-p4-rcs.sh
@@ -244,7 +244,7 @@ test_expect_success 'cope with rcs keyword expansion damage' '
 		cd "$git" &&
 		git config git-p4.skipSubmitEdit true &&
 		git config git-p4.attemptRCSCleanup true &&
-		(cd ../cli && p4_append_to_file kwfile1.c) &&
+		(cd "$cli" && p4_append_to_file kwfile1.c) &&
 		old_lines=$(wc -l <kwfile1.c) &&
 		perl -n -i -e "print unless m/Revision:/" kwfile1.c &&
 		new_lines=$(wc -l <kwfile1.c) &&
-- 
1.7.11.rc2.72.gebb7ee5
