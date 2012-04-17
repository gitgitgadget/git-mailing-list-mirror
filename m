From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [RFC/PATCH] git-sh-setup.sh: Add an pwd() function for MinGW
Date: Tue, 17 Apr 2012 19:48:39 +0100
Message-ID: <4F8DBB07.5060506@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Apr 17 20:51:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKDV7-0005xl-7b
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 20:51:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753146Ab2DQSvh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 14:51:37 -0400
Received: from anchor-post-1.mail.demon.net ([195.173.77.132]:37848 "EHLO
	anchor-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753130Ab2DQSvf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Apr 2012 14:51:35 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1SKDUz-0007Z2-iO; Tue, 17 Apr 2012 18:51:34 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195792>


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Johannes,

While working on fixing git-submodule.sh on cygwin, I attempted
to run tests on MinGW to ensure that my patches don't cause a
regression. (Indeed that is the *only* reason I have MinGW
installed!)

In order to test the modified git-submodule.sh I used the following
tests:

    $ git grep -l -e 'git *submodule' -- t
    t/t5526-fetch-submodules.sh
    t/t6008-rev-list-submodule.sh
    t/t7003-filter-branch.sh
    t/t7400-submodule-basic.sh
    t/t7401-submodule-summary.sh
    t/t7403-submodule-sync.sh
    t/t7405-submodule-merge.sh
    t/t7406-submodule-update.sh
    t/t7407-submodule-foreach.sh
    t/t7408-submodule-reference.sh
    t/t7506-status-submodule.sh
    t/t7610-mergetool.sh
    t/t9300-fast-import.sh
    t/t9350-fast-export.sh

On MinGW, the following tests failed:

    t5526-fetch-submodules.sh:  1, 2, 5, 8-13, 16, 18-19, 21, 23-24
    t7400-submodule-basic.sh:   7
    t7401-submodule-summary.sh: 16
    t7405-submodule-merge.sh:   7-8
    t7406-submodule-update.sh:  3, 24-25, 30-31
    t7407-submodule-foreach.sh: 2, 5-10, 12-13
    t9300-fast-import.sh:       62

I noticed that 6 of those tests were failing due to CRLF line ending
issues. For example, if you redirect the output of git-status to a
file, then you will find that the lines output by git-submodule have
CRLF line endings, while the remainder of the file has LF only.
So, in order to ignore this (ie I don't have a patch to fix it!), if
I run the tests something like this:

    $ GIT_TEST_CMP='diff -ub' ./t7400-submodule-basic.sh

then these tests pass. The tests in question being:

    t7400.7, t7401.16, t7405.{7,8}, t7406.3 and t7407.2

[Note that I wanted to use --strip-trailing-cr but the version of diff
on MinGW was too old.]

Test #62 in t9300-fast-import.sh is fixed by a separate patch (see email
[PATCH] compat/mingw.h: Set S_ISUID to prevent a fast-import test failure).

All of the remaining test failures are fixed by this patch!

This is an RFC because I have only run the above tests. In fact the original
version of this patch was confined to git-submodule.sh (along with a uname
conditional to restrict the definition to MinGW).

HTH

ATB,
Ramsay Jones

 git-sh-setup.sh |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 5d8e4e6..7b3ae75 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -248,6 +248,10 @@ case $(uname -s) in
 	find () {
 		/usr/bin/find "$@"
 	}
+	# git sees Windows-style pwd
+	pwd () {
+		builtin pwd -W
+	}
 	is_absolute_path () {
 		case "$1" in
 		[/\\]* | [A-Za-z]:*)
-- 
1.7.10
