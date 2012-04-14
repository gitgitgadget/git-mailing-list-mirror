From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] t5570: use explicit push refspec
Date: Sat, 14 Apr 2012 20:32:25 +0200
Message-ID: <20120414183225.GB3915@ecki>
References: <20120414182907.GA3915@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 14 20:33:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJ7n8-0007DY-2H
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 20:33:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755045Ab2DNSdl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 14:33:41 -0400
Received: from smtpout16.highway.telekom.at ([195.3.96.93]:41003 "EHLO
	email.aon.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754755Ab2DNSdl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 14:33:41 -0400
Received: (qmail 8208 invoked from network); 14 Apr 2012 18:33:39 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.0 (2007-05-01) on
	WARSBL606.highway.telekom.at
X-Spam-Level: ****
Received: from p5b22d2b0.dip.t-dialin.net (HELO [127.0.0.1]) (aon.912301525.1@aon.at@[91.34.210.176])
          (envelope-sender <drizzd@aon.at>)
          by smarthub81.res.a1.net (qmail-ldap-1.03) with AES128-SHA encrypted SMTP
          for <gitster@pobox.com>; 14 Apr 2012 18:33:38 -0000
Content-Disposition: inline
In-Reply-To: <20120414182907.GA3915@ecki>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195502>

The default mode for push without arguments will change. Some warnings
are about to be enabled for such use, which causes some t5570 tests to
fail because they do not expect this output. Fix this by passing an
explicit refspec to git push.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

On Sat, Apr 14, 2012 at 08:29:07PM +0200, Clemens Buchacher wrote:
> 
> Note that t5570 fails on current pu, because of the push.default
> warnings. I am sending an independent patch for that.

Here we go.

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
1.7.9.6
