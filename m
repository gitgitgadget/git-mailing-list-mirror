From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH 1/6] git-p4 tests: refactor and cleanup
Date: Sun, 16 Oct 2011 10:35:33 -0400
Message-ID: <20111016143533.GA22144@arf.padd.com>
References: <20111015155358.GA29436@arf.padd.com>
 <20111015155517.GB29436@arf.padd.com>
 <201110161138.58396.stefano.lattarini@gmail.com>
 <201110161154.11898.stefano.lattarini@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Luke Diamand <luke@diamand.org>, Chris Li <git@chrisli.org>
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 16 16:35:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFRoi-0002ba-NJ
	for gcvg-git-2@lo.gmane.org; Sun, 16 Oct 2011 16:35:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754435Ab1JPOfw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Oct 2011 10:35:52 -0400
Received: from honk.padd.com ([74.3.171.149]:48053 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753705Ab1JPOfv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2011 10:35:51 -0400
Received: from arf.padd.com (unknown [50.55.131.180])
	by honk.padd.com (Postfix) with ESMTPSA id 06B8D2822;
	Sun, 16 Oct 2011 07:35:50 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id D0663313B8; Sun, 16 Oct 2011 10:35:33 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <201110161154.11898.stefano.lattarini@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183713>

stefano.lattarini@gmail.com wrote on Sun, 16 Oct 2011 11:54 +0200:
> OK, I have to partially correct myself here ...
> 
> On Sunday 16 October 2011, Stefano Lattarini wrote:
> >
> > This won't work with older versions of the Almquist shell (without
> > prepending `testid' and `git_p4_test_start' with a `$', that is):
> > 
> >   $ ash-0.5.2 -c 'a=4; b=2; echo $(( 1 + (a - b) ))'
> >   ash-0.5.2: arith: syntax error: " 1 + (a - b) "
> > 
> OTOH, this behaviour seems in contrast with the POSIX standard, which
> says that:
> 
>   ``If the shell variable x contains a value that forms a valid integer
>     constant, then the arithmetic expansions "$((x))" and "$(($x))" shall
>     return the same value.''
> 
> Reference:
>  <http://pubs.opengroup.org/onlinepubs/009695399/utilities/xcu_chap02.html#tag_02_06_04>
> 
> So, since the git testsuite explicitly requires a POSIX shell, there is
> probably nothing to fix here.
> 
> Sorry for the noise,
>   Stefano

No, this is a good catch.  The use of $x inside arithmetic
expansions is indeed called out in the CodingGuidlines.  Thanks
for the careful read.

I'm going to resend the series, since it's not in next yet.
Here's the patch for this bit, fyi.

		-- Pete


-------------------8<-------------------
From 53d5ad0761cda36da97bf1498ab1dc1a80a52772 Mon Sep 17 00:00:00 2001
From: Pete Wyckoff <pw@padd.com>
Date: Sun, 16 Oct 2011 09:59:05 -0400
Subject: [PATCH] git-p4 tests: use explicit $ for variables in $(( .. ))


Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/lib-git-p4.sh   |    2 +-
 t/t9800-git-p4.sh |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index 412adec..a870f9a 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -22,7 +22,7 @@ GITP4="$GIT_BUILD_DIR/contrib/fast-import/git-p4"
 # same tests and has chosen the same ports.
 testid=${this_test#t}
 git_p4_test_start=9800
-P4DPORT=$((10669 + (testid - git_p4_test_start)))
+P4DPORT=$((10669 + ($testid - $git_p4_test_start)))
 
 export P4PORT=localhost:$P4DPORT
 export P4CLIENT=client
diff --git a/t/t9800-git-p4.sh b/t/t9800-git-p4.sh
index 296aee9..8fbed66 100755
--- a/t/t9800-git-p4.sh
+++ b/t/t9800-git-p4.sh
@@ -293,7 +293,7 @@ test_expect_success 'detect renames' '
 		git diff-tree -r -M HEAD &&
 		level=$(git diff-tree -r -M HEAD | sed 1d | cut -f1 | cut -d" " -f5 | sed "s/R0*//") &&
 		test -n "$level" && test "$level" -gt 0 && test "$level" -lt 98 &&
-		git config git-p4.detectRenames $((level + 2)) &&
+		git config git-p4.detectRenames $(($level + 2)) &&
 		"$GITP4" submit &&
 		p4 filelog //depot/file6 &&
 		p4 filelog //depot/file6 | test_must_fail grep -q "branch from" &&
@@ -305,7 +305,7 @@ test_expect_success 'detect renames' '
 		git diff-tree -r -M HEAD &&
 		level=$(git diff-tree -r -M HEAD | sed 1d | cut -f1 | cut -d" " -f5 | sed "s/R0*//") &&
 		test -n "$level" && test "$level" -gt 2 && test "$level" -lt 100 &&
-		git config git-p4.detectRenames $((level - 2)) &&
+		git config git-p4.detectRenames $(($level - 2)) &&
 		"$GITP4" submit &&
 		p4 filelog //depot/file7 &&
 		p4 filelog //depot/file7 | grep -q "branch from //depot/file6"
@@ -376,7 +376,7 @@ test_expect_success 'detect copies' '
 		test -n "$level" && test "$level" -gt 0 && test "$level" -lt 98 &&
 		src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
 		test "$src" = file10 &&
-		git config git-p4.detectCopies $((level + 2)) &&
+		git config git-p4.detectCopies $(($level + 2)) &&
 		"$GITP4" submit &&
 		p4 filelog //depot/file12 &&
 		p4 filelog //depot/file12 | test_must_fail grep -q "branch from" &&
@@ -390,7 +390,7 @@ test_expect_success 'detect copies' '
 		test -n "$level" && test "$level" -gt 2 && test "$level" -lt 100 &&
 		src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
 		test "$src" = file10 &&
-		git config git-p4.detectCopies $((level - 2)) &&
+		git config git-p4.detectCopies $(($level - 2)) &&
 		"$GITP4" submit &&
 		p4 filelog //depot/file13 &&
 		p4 filelog //depot/file13 | grep -q "branch from //depot/file"
-- 
1.7.7
