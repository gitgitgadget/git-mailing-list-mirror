From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] Re-fix get_pathspec()
Date: Sat, 08 Mar 2008 01:37:46 -0800
Message-ID: <7vve3xv9n9.fsf@gitster.siamese.dyndns.org>
References: <1204879119-7528-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Potapov <dpotapov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 08 10:39:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXvWH-0001TO-5V
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 10:39:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbYCHJiD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 04:38:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbYCHJiC
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 04:38:02 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:65453 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751421AbYCHJiA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 04:38:00 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 176D92220;
	Sat,  8 Mar 2008 04:37:58 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 188C421DF; Sat,  8 Mar 2008 04:37:54 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76553>

Junio C Hamano <gitster@pobox.com> writes:

> ...
> This miniseries cleans up the interface by making get_pathspec() to die
> again.

By the way, this is meant to also fix the breakage of "git clean" run with
a path outside the work tree.  With two patches from Dmitry:

 Make private quote_path() in wt-status.c available as quote_path_relative())
 git-clean: correct printing relative path)

on top of the series, the following tests now pass.

-- >8 --
git-clean: add tests for relative path

This adds tests for recent change by Dmitry to fix the report "git
clean" gives on removed paths, and also makes sure the command detects
paths that is outside working tree.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7300-clean.sh |   52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 4037142..afccfc9 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -89,6 +89,58 @@ test_expect_success 'git-clean with prefix' '
 	test -f build/lib.so
 
 '
+
+test_expect_success 'git-clean with relative prefix' '
+
+	mkdir -p build docs &&
+	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
+	would_clean=$(
+		cd docs &&
+		git clean -n ../src |
+		sed -n -e "s|^Would remove ||p"
+	) &&
+	test "$would_clean" = ../src/part3.c || {
+		echo "OOps <$would_clean>"
+		false
+	}
+'
+
+test_expect_success 'git-clean with absolute path' '
+
+	mkdir -p build docs &&
+	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
+	would_clean=$(
+		cd docs &&
+		git clean -n $(pwd)/../src |
+		sed -n -e "s|^Would remove ||p"
+	) &&
+	test "$would_clean" = ../src/part3.c || {
+		echo "OOps <$would_clean>"
+		false
+	}
+'
+
+test_expect_success 'git-clean with out of work tree relative path' '
+
+	mkdir -p build docs &&
+	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
+	(
+		cd docs &&
+		test_must_fail git clean -n ../..
+	)
+'
+
+test_expect_success 'git-clean with out of work tree absolute path' '
+
+	mkdir -p build docs &&
+	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
+	dd=$(cd .. && pwd) &&
+	(
+		cd docs &&
+		test_must_fail git clean -n $dd
+	)
+'
+
 test_expect_success 'git-clean -d with prefix and path' '
 
 	mkdir -p build docs src/feature &&
-- 
1.5.4.3.587.g0bdd73





