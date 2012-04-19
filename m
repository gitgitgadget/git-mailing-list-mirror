From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 2/3] t5570: use explicit push refspec
Date: Fri, 20 Apr 2012 00:57:13 +0200
Message-ID: <1334876234-20077-3-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqaa27bgon.fsf@bauges.imag.fr>
 <1334876234-20077-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Clemens Buchacher <drizzd@aon.at>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Apr 20 01:30:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SL0oL-0004YL-2E
	for gcvg-git-2@plane.gmane.org; Fri, 20 Apr 2012 01:30:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756744Ab2DSXap (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Apr 2012 19:30:45 -0400
Received: from mx2.imag.fr ([129.88.30.17]:34201 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756344Ab2DSXao (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2012 19:30:44 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q3JMpGxa032027
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 20 Apr 2012 00:51:16 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SL0Hz-0001mU-74; Fri, 20 Apr 2012 00:57:23 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SL0Hz-0005F2-5C; Fri, 20 Apr 2012 00:57:23 +0200
X-Mailer: git-send-email 1.7.10.140.g8c333
In-Reply-To: <1334876234-20077-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 20 Apr 2012 00:51:16 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q3JMpGxa032027
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1335480680.80584@bmP6bT3gs5FqdSEkd8Sfeg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195976>

From: Clemens Buchacher <drizzd@aon.at>

The default mode for push without arguments will change. Some warnings
are about to be enabled for such use, which causes some t5570 tests to
fail because they do not expect this output.

Fix this by passing an explicit refspec to git push. To that end, change
the calling conventions of test_remote_error in order to accomodate
extra command arguments.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
1.7.10.140.g8c333
