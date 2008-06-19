From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] t7502-commit.sh: test_must_fail doesn't work with inline
 environment variables
Date: Thu, 19 Jun 2008 12:32:02 -0500
Message-ID: <JvISWq5uUteLVQOl-3QkroLV8SsQufGuWrfseMUjpYY@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 19:36:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9O3n-0008W8-Rw
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 19:36:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975AbYFSRfg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 13:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751819AbYFSRfg
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 13:35:36 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:50170 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751471AbYFSRff (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 13:35:35 -0400
Received: by mail.nrlssc.navy.mil id m5JHW2p8012222; Thu, 19 Jun 2008 12:32:02 -0500
X-OriginalArrivalTime: 19 Jun 2008 17:32:02.0455 (UTC) FILETIME=[629A8270:01C8D232]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85496>

When the arguments to test_must_fail() begin with a variable assignment,
test_must_fail() attempts to execute the variable assignment as a command.
This fails, and so test_must_fail returns with a successful status value
without running the command it was intended to test.

For example, the following script:

	#!/bin/sh
	test_must_fail () {
		"$@"
		test $? -gt 0 -a $? -le 129
	}
	foo='wo adrian'
	test_must_fail foo='yo adrian' sh -c 'echo foo: $foo'

always exits zero and prints the message:

	test.sh: line 3: foo=yo adrian: command not found

Test 16 calls test_must_fail in such a way and therefore has not been
testing whether git 'do[es] not fire editor in the presence of conflicts'.
Fix this by reverting to the traditional negation operator '!' and accept
the caveat that segfault will not be detected.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


Unless you have a better work around...

-brandon


 t/t7502-commit.sh |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index ed871a6..e3469e0 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -212,7 +212,9 @@ test_expect_success 'do not fire editor in the presence of conflicts' '
 	# Must fail due to conflict
 	test_must_fail git cherry-pick -n master &&
 	echo "editor not started" >.git/result &&
-	test_must_fail GIT_EDITOR="$(pwd)/.git/FAKE_EDITOR" git commit &&
+	# We intentionally do not use test_must_fail on the next line since the
+	# mechanism does not work when setting environment variables inline
+	! GIT_EDITOR="$(pwd)/.git/FAKE_EDITOR" git commit &&
 	test "$(cat .git/result)" = "editor not started"
 '
 
-- 
1.5.5.3
