From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] t5570: add tests for "git fetch -v"
Date: Sat, 13 Feb 2016 00:35:26 +0000
Message-ID: <20160213003526.GA15899@dcvr.yhbt.net>
References: <xmqqsi10xhbk.fsf@gitster.mtv.corp.google.com>
 <20160212234953.GA8691@dcvr.yhbt.net>
 <CAPc5daUd6fQ6hX6W1AzQ9rCzrsTvkXOxZgwVdibbM5S34nF7ZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 13 01:35:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUOBR-0005mu-Uv
	for gcvg-git-2@plane.gmane.org; Sat, 13 Feb 2016 01:35:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752058AbcBMAf3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2016 19:35:29 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:56907 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751965AbcBMAf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2016 19:35:29 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98EE4202F4;
	Sat, 13 Feb 2016 00:35:26 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAPc5daUd6fQ6hX6W1AzQ9rCzrsTvkXOxZgwVdibbM5S34nF7ZA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286100>

Now that git_connect is more information about connectivity
progress after: ("pass transport verbosity down to git_connect")
we should ensure it remains so for future users who need to
to diagnose networking problems.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
  Junio C Hamano <gitster@pobox.com> wrote:
  > On Fri, Feb 12, 2016 at 3:49 PM, Eric Wong <normalperson@yhbt.net> wrote:
  > > Junio C Hamano <gitster@pobox.com> wrote:
  > >> * ew/connect-verbose (2016-01-28) 1 commit
  > >>   (merged to 'next' on 2016-02-03 at ceac37e)
  > >>  + pass transport verbosity down to git_connect
  > >
  > > Btw, I posted v2 of this with tests added to t/t5570-git-daemon.sh
  > >
  > >   http://mid.gmane.org/20160130085056.GA20118@dcvr.yhbt.net
  > >
  > > Can you replace it with my v2 or would you prefer a standalone
  > > patch for just the test?  Thanks.
  > 
  > Thanks, that's water under the bridge, so let's have a follow-up patch
  > to add test.

 t/t5570-git-daemon.sh | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
index d76269a..095e862 100755
--- a/t/t5570-git-daemon.sh
+++ b/t/t5570-git-daemon.sh
@@ -6,6 +6,13 @@ test_description='test fetching over git protocol'
 . "$TEST_DIRECTORY"/lib-git-daemon.sh
 start_git_daemon
 
+check_verbose_connect () {
+	grep -qF "Looking up 127.0.0.1 ..." stderr &&
+	grep -qF "Connecting to 127.0.0.1 (port " stderr &&
+	grep -qF "done." stderr &&
+	rm stderr
+}
+
 test_expect_success 'setup repository' '
 	git config push.default matching &&
 	echo content >file &&
@@ -24,18 +31,32 @@ test_expect_success 'create git-accessible bare repository' '
 '
 
 test_expect_success 'clone git repository' '
-	git clone "$GIT_DAEMON_URL/repo.git" clone &&
+	git clone -v "$GIT_DAEMON_URL/repo.git" clone 2>stderr &&
 	test_cmp file clone/file
 '
 
+test_expect_success 'clone -v stderr is as expected' check_verbose_connect
+
 test_expect_success 'fetch changes via git protocol' '
 	echo content >>file &&
 	git commit -a -m two &&
 	git push public &&
-	(cd clone && git pull) &&
+	(cd clone && git pull -v) 2>stderr &&
 	test_cmp file clone/file
 '
 
+test_expect_success 'pull -v stderr is as expected' check_verbose_connect
+
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
