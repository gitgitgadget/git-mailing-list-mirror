From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 16/16] t5503: GIT_DEBUG_SEND_PACK is not supported on MinGW
Date: Sat, 21 Mar 2009 22:26:39 +0100
Message-ID: <4e60515a24ab4197d24c62408a277e76c65cde62.1237667830.git.j6t@kdbg.org>
References: <cover.1237667830.git.j6t@kdbg.org>
Cc: Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 21 22:30:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ll8lj-0004Ii-SH
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 22:30:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754034AbZCUV1j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 17:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755517AbZCUV1h
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 17:27:37 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:27971 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754034AbZCUV1A (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 17:27:00 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 45D0C10021;
	Sat, 21 Mar 2009 22:26:57 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 2269C5BC08;
	Sat, 21 Mar 2009 22:26:56 +0100 (CET)
X-Mailer: git-send-email 1.6.2.1.224.g2225f
In-Reply-To: <cover.1237667830.git.j6t@kdbg.org>
In-Reply-To: <cover.1237667830.git.j6t@kdbg.org>
References: <cover.1237667830.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114072>

The test opens fd 3 and instructs git-upload-pack (via GIT_DEBUG_SEND_PACK)
to log information to that channel.

The way in which new processes are spawned by git on MinGW does not inherit
all file descriptors to the child processes, but only 0, 1, and 2.
The tests in t5503 require that file descriptor 3 is inherited from
git-fetch to git-upload-pack.

A complete implementation is non-trivial and not warranted just to satisfy
this test.  Note that the incompleteness applies only to the executables
that use compat/mingw.c; bash and perl (the other important executables
used by git) are complete, of course.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t5503-tagfollow.sh |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/t/t5503-tagfollow.sh b/t/t5503-tagfollow.sh
index 4074e23..e75ccbc 100755
--- a/t/t5503-tagfollow.sh
+++ b/t/t5503-tagfollow.sh
@@ -4,6 +4,13 @@ test_description='test automatic tag following'
 
 . ./test-lib.sh
 
+case $(uname -s) in
+*MINGW*)
+	say "GIT_DEBUG_SEND_PACK not supported - skipping tests"
+	test_done
+	exit
+esac
+
 # End state of the repository:
 #
 #         T - tag1          S - tag2
-- 
1.6.2.1.224.g2225f
