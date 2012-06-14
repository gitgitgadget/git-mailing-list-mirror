From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH js/submodule-relative] t7400: avoid path mangling issues
Date: Thu, 14 Jun 2012 14:10:27 +0200
Message-ID: <4FD9D4B3.9060805@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 14 14:10:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sf8sq-0004Rc-Jq
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 14:10:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755888Ab2FNMKf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jun 2012 08:10:35 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:25315 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755742Ab2FNMKf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2012 08:10:35 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Sf8to-0006eN-30; Thu, 14 Jun 2012 14:11:40 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 203E01660F;
	Thu, 14 Jun 2012 14:10:28 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:13.0) Gecko/20120604 Thunderbird/13.0
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200001>

From: Johannes Sixt <j6t@kdbg.org>

A recently introduced test uses an absolute path. But when run on Windows
using the MSYS bash, such a path is mangled into a Windows style path when
it is passed to 'git config'. The subsequent 'test' then compares the
mangled path to the unmangled version and reports a failure.

A path beginning with two slashes denotes a network directory
(//server/share path) and is not mangled. Use that trick to side-step the
issue. Just in case that 'git submodule init' regresses in such a way that
it accesses the URL, use a path name that is unlikely to exist on POSIX
systems, and that cannot be a server name on Windows.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 Sorry, Jon, Junio, for the resend. Forgot to Cc the list.

 t/t7400-submodule-basic.sh | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index a899e6d..c73bec9 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -510,14 +510,19 @@ test_expect_success '../subrepo works with port-qualified URL - ssh://hostname:2
 	)
 '
 
-test_expect_success '../subrepo path works with local path - /foo/repo' '
+# About the choice of the path in the next test:
+# - double-slash side-steps path mangling issues on Windows
+# - it is still an absolute local path
+# - there cannot be a server with a blank in its name just in case the
+#   path is used erroneously to access a //server/share style path
+test_expect_success '../subrepo path works with local path - //somewhere else/repo' '
 	(
 		cd reltest &&
 		cp pristine-.git-config .git/config &&
 		cp pristine-.gitmodules .gitmodules &&
-		git config remote.origin.url /foo/repo &&
+		git config remote.origin.url "//somewhere else/repo" &&
 		git submodule init &&
-		test "$(git config submodule.sub.url)" = /foo/subrepo
+		test "$(git config submodule.sub.url)" = "//somewhere else/subrepo"
 	)
 '
 
-- 
1.7.11.rc3.1188.ga03e3fc
