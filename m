From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH v2] t5570: add tests for "git {clone,fetch,pull} -v"
Date: Sun, 14 Feb 2016 09:26:29 +0000
Message-ID: <20160214092629.GA1909@dcvr.yhbt.net>
References: <xmqqsi10xhbk.fsf@gitster.mtv.corp.google.com>
 <20160212234953.GA8691@dcvr.yhbt.net>
 <CAPc5daUd6fQ6hX6W1AzQ9rCzrsTvkXOxZgwVdibbM5S34nF7ZA@mail.gmail.com>
 <20160213003526.GA15899@dcvr.yhbt.net>
 <xmqqtwlcs5e6.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 14 10:26:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUswx-00074a-CZ
	for gcvg-git-2@plane.gmane.org; Sun, 14 Feb 2016 10:26:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834AbcBNJ0e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2016 04:26:34 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:59227 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751742AbcBNJ0a (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2016 04:26:30 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6FB3202DA;
	Sun, 14 Feb 2016 09:26:29 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <xmqqtwlcs5e6.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286134>

Now that git_connect is more information about connectivity
progress after: ("pass transport verbosity down to git_connect")
we should ensure it remains so for future users who need to
to diagnose networking problems.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
  Thanks for the feedback, v2 changes as suggested:
  - remove -q flag from grep invocation for verbose git tests
  - do not remove stderr file after testing
  - fold verbosity check into existing tests for skip-ability

 t/t5570-git-daemon.sh | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
index d76269a..225a022 100755
--- a/t/t5570-git-daemon.sh
+++ b/t/t5570-git-daemon.sh
@@ -6,6 +6,12 @@ test_description='test fetching over git protocol'
 . "$TEST_DIRECTORY"/lib-git-daemon.sh
 start_git_daemon
 
+check_verbose_connect () {
+	grep -F "Looking up 127.0.0.1 ..." stderr &&
+	grep -F "Connecting to 127.0.0.1 (port " stderr &&
+	grep -F "done." stderr
+}
+
 test_expect_success 'setup repository' '
 	git config push.default matching &&
 	echo content >file &&
@@ -24,7 +30,8 @@ test_expect_success 'create git-accessible bare repository' '
 '
 
 test_expect_success 'clone git repository' '
-	git clone "$GIT_DAEMON_URL/repo.git" clone &&
+	git clone -v "$GIT_DAEMON_URL/repo.git" clone 2>stderr &&
+	check_verbose_connect &&
 	test_cmp file clone/file
 '
 
@@ -32,10 +39,21 @@ test_expect_success 'fetch changes via git protocol' '
 	echo content >>file &&
 	git commit -a -m two &&
 	git push public &&
-	(cd clone && git pull) &&
+	(cd clone && git pull -v) 2>stderr &&
+	check_verbose_connect &&
 	test_cmp file clone/file
 '
 
+test_expect_success 'no-op fetch -v stderr is as expected' '
+	(cd clone && git fetch -v) 2>stderr &&
+	check_verbose_connect
+'
+
+test_expect_success 'no-op fetch without "-v" is quiet' '
+	(cd clone && git fetch) 2>stderr &&
+	! test -s stderr
+'
+
 test_expect_success 'remote detects correct HEAD' '
 	git push public master:other &&
 	(cd clone &&
-- 
EW
