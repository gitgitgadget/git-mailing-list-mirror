From: Lea Wiemann <lewiemann@gmail.com>
Subject: [PATCH] t/test-lib.sh: resolve symlinks in working directory, for pathname comparisons
Date: Sat, 31 May 2008 23:11:21 +0200
Message-ID: <1212268281-16797-1-git-send-email-LeWiemann@gmail.com>
Cc: Lea Wiemann <LeWiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 31 23:12:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2YNG-0004Tx-PZ
	for gcvg-git-2@gmane.org; Sat, 31 May 2008 23:12:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752204AbYEaVLI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2008 17:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752049AbYEaVLH
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 17:11:07 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:21781 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751820AbYEaVLF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2008 17:11:05 -0400
Received: by fg-out-1718.google.com with SMTP id 19so377430fgg.17
        for <git@vger.kernel.org>; Sat, 31 May 2008 14:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:cc:subject:date:message-id:x-mailer:from;
        bh=TkY8Z/OeZNzpiCL5YNrBe+i1TsSYf39cJ06Rojhc6yc=;
        b=w0QTMuBU2x8xKRdr8VD86s3A16srDTN/mRS0KFXL3jUxfNm0OwwpwHBCGIKFpI9DnHLaL+Tbuk1AMI2AFHqy2gjxLOlwuWY31ZaTbeLYonKTo+f180nqfzBsqdw9+4QcPOhBlKmcLsOvE7/v1rO3rH/n6P/GjPCCx3OuzfaKwlQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:date:message-id:x-mailer:from;
        b=tQqLtXcIqUs8joJIv9a8+zGJlfZElIPYbGDLcyP70+fuqrI/1iqLVAsOHoxgJn9l1zIhi1v++xP8fdsmopVnfywvKwCNBNgqGEC/PPK7T+v0wSxzCUu9XihZO7P7PBZi4Pvs8nx/kV5LUuRSVnipxYHhii5Abo1vCPJxtx2qGRw=
Received: by 10.86.4.2 with SMTP id 2mr4064994fgd.16.1212268263227;
        Sat, 31 May 2008 14:11:03 -0700 (PDT)
Received: from fly ( [91.33.240.119])
        by mx.google.com with ESMTPS id e11sm1630776fga.4.2008.05.31.14.11.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 31 May 2008 14:11:03 -0700 (PDT)
Received: from lea by fly with local (Exim 4.69)
	(envelope-from <LeWiemann@gmail.com>)
	id 1K2YMD-0004NL-HP; Sat, 31 May 2008 23:11:21 +0200
X-Mailer: git-send-email 1.5.5.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83404>

Without this, some tests will fail because they compare command output
of subprocesses (such as git) with $PWD -- but subprocesses have the
physical path as their working directory, whereas $PWD contains the
symlinked path.  This fixes it.

Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
---
Here is how to reproduce it:

$ ln -s /path/to/git git-symlink
$ cd git-symlink/t
$ ./t0001-init.sh 
*   ok 1: plain
*   ok 2: plain with GIT_WORK_TREE
*   ok 3: plain bare
*   ok 4: plain bare with GIT_WORK_TREE
*   ok 5: GIT_DIR bare
*   ok 6: GIT_DIR non-bare
* FAIL 7: GIT_DIR & GIT_WORK_TREE (1)
	
	
		(
			unset GIT_CONFIG
			mkdir git-dir-wt-1.git &&
			GIT_WORK_TREE=$(pwd) GIT_DIR=git-dir-wt-1.git git init
		) &&
		check_config git-dir-wt-1.git false "$(pwd)"
	
*   ok 8: GIT_DIR & GIT_WORK_TREE (2)
*   ok 9: reinit
* failed 1 among 9 test(s)

With this patch applied, all tests work fine in symlinked working
directories.

 t/test-lib.sh |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 3bf570b..7a8bd27 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -419,7 +419,9 @@ rm -fr "$test" || {
 }
 
 test_create_repo "$test"
-cd "$test" || exit 1
+# Use -P to resolve symlinks in our working directory so that the cwd
+# in subprocesses like git equals our $PWD (for pathname comparisons).
+cd -P "$test" || exit 1
 
 this_test=$(expr "./$0" : '.*/\(t[0-9]*\)-[^/]*$')
 for skp in $GIT_SKIP_TESTS
-- 
1.5.5.GIT
