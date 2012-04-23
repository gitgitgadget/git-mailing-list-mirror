From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 5/7] t5570: use explicit push refspec
Date: Mon, 23 Apr 2012 10:38:02 +0200
Message-ID: <1335170284-30768-6-git-send-email-Matthieu.Moy@imag.fr>
References: <1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr>
 <1335170284-30768-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Clemens Buchacher <drizzd@aon.at>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Apr 23 10:39:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMEno-0003OH-Sp
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 10:39:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754403Ab2DWIjQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Apr 2012 04:39:16 -0400
Received: from mx2.imag.fr ([129.88.30.17]:55627 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754398Ab2DWIjP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 04:39:15 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q3N8VnEd029938
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 23 Apr 2012 10:31:50 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SMEmd-0004mw-Ra; Mon, 23 Apr 2012 10:38:07 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SMEmd-00081b-PO; Mon, 23 Apr 2012 10:38:07 +0200
X-Mailer: git-send-email 1.7.10.234.ge65dd.dirty
In-Reply-To: <1335170284-30768-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 23 Apr 2012 10:31:53 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q3N8VnEd029938
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1335774714.31981@rr+dbI5ycKsG1GB+UPq8AQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196107>

From: Clemens Buchacher <drizzd@aon.at>

The default mode for push without arguments will change. Some warnings
are about to be enabled for such use, which causes some t5570 tests to
fail because they do not expect this output.

Fix this by passing an explicit refspec to git push. To that end, change
the calling conventions of test_remote_error in order to accomodate
extra command arguments.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 t/t5570-git-daemon.sh |   30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
index 7cbc999..a3a4e47 100755
--- a/t/t5570-git-daemon.sh
+++ b/t/t5570-git-daemon.sh
@@ -103,14 +103,12 @@ test_remote_error()
 		esac
 	done
 
-	if test $# -ne 3
-	then
-		error "invalid number of arguments"
-	fi
-
+	msg=$1
+	shift
 	cmd=$1
-	repo=$2
-	msg=$3
+	shift
+	repo=$1
+	shift || error "invalid number of arguments"
 
 	if test -x "$GIT_DAEMON_DOCUMENT_ROOT_PATH/$repo"
 	then
@@ -122,7 +120,7 @@ test_remote_error()
 		fi
 	fi
 
-	test_must_fail git "$cmd" "$GIT_DAEMON_URL/$repo" 2>output &&
+	test_must_fail git "$cmd" "$GIT_DAEMON_URL/$repo" "$@" 2>output &&
 	echo "fatal: remote error: $msg: /$repo" >expect &&
 	test_cmp expect output
 	ret=$?
@@ -131,18 +129,18 @@ test_remote_error()
 }
 
 msg="access denied or repository not exported"
-test_expect_success 'clone non-existent' "test_remote_error    clone nowhere.git '$msg'"
-test_expect_success 'push disabled'      "test_remote_error    push  repo.git    '$msg'"
-test_expect_success 'read access denied' "test_remote_error -x fetch repo.git    '$msg'"
-test_expect_success 'not exported'       "test_remote_error -n fetch repo.git    '$msg'"
+test_expect_success 'clone non-existent' "test_remote_error    '$msg' clone nowhere.git    "
+test_expect_success 'push disabled'      "test_remote_error    '$msg' push  repo.git master"
+test_expect_success 'read access denied' "test_remote_error -x '$msg' fetch repo.git       "
+test_expect_success 'not exported'       "test_remote_error -n '$msg' fetch repo.git       "
 
 stop_git_daemon
 start_git_daemon --informative-errors
 
-test_expect_success 'clone non-existent' "test_remote_error    clone nowhere.git 'no such repository'"
-test_expect_success 'push disabled'      "test_remote_error    push  repo.git    'service not enabled'"
-test_expect_success 'read access denied' "test_remote_error -x fetch repo.git    'no such repository'"
-test_expect_success 'not exported'       "test_remote_error -n fetch repo.git    'repository not exported'"
+test_expect_success 'clone non-existent' "test_remote_error    'no such repository'      clone nowhere.git    "
+test_expect_success 'push disabled'      "test_remote_error    'service not enabled'     push  repo.git master"
+test_expect_success 'read access denied' "test_remote_error -x 'no such repository'      fetch repo.git       "
+test_expect_success 'not exported'       "test_remote_error -n 'repository not exported' fetch repo.git       "
 
 stop_git_daemon
 test_done
-- 
1.7.10.234.ge65dd.dirty
