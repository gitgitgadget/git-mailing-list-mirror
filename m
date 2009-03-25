From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 2/2] t7502-commit: Skip SIGTERM test on Windows
Date: Wed, 25 Mar 2009 21:33:46 +0100
Message-ID: <200903252133.46594.j6t@kdbg.org>
References: <200903252131.26561.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 21:35:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmZol-0006z4-Rp
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 21:35:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753716AbZCYUdu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 16:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753649AbZCYUdt
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 16:33:49 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:14099 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750862AbZCYUdt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 16:33:49 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id E1FD51001A;
	Wed, 25 Mar 2009 21:33:46 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id ADED41D1D5;
	Wed, 25 Mar 2009 21:33:46 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <200903252131.26561.j6t@kdbg.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114659>

The implementation of exec on Windows is just a rough approximation of the
POSIX behavior. In particular, no real process "overlay" happens (a new
process is spawned instead and the parent process waits until the child
terminates). In particular, the process ID cannot be taken by the exec'd
process. But there is one test in t7502-commit.sh that depends on this.
We have to skip it on Windows.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t7502-commit.sh |    2 +-
 t/test-lib.sh     |    2 ++
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index ad42c78..56cd866 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -234,7 +234,7 @@ cat >.git/FAKE_EDITOR <<EOF
 # kill -TERM command added below.
 EOF
 
-test_expect_success 'a SIGTERM should break locks' '
+test_expect_success EXECKEEPSPID 'a SIGTERM should break locks' '
 	echo >>negative &&
 	! "$SHELL_PATH" -c '\''
 	  echo kill -TERM $$ >> .git/FAKE_EDITOR
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 8de5ee1..2979e8e 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -697,10 +697,12 @@ case $(uname -s) in
 	}
 	# no POSIX permissions
 	# backslashes in pathspec are converted to '/'
+	# exec does not inherit the PID
 	;;
 *)
 	test_set_prereq POSIXPERM
 	test_set_prereq BSLASHPSPEC
+	test_set_prereq EXECKEEPSPID
 	;;
 esac
 
-- 
1.6.2.1.224.g2225f
