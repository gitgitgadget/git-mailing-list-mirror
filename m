From: Junio C Hamano <junkio@cox.net>
Subject: Re: Test fails on ubuntu breezy
Date: Thu, 13 Apr 2006 11:56:40 -0700
Message-ID: <7vpsjl1ezb.fsf@assigned-by-dhcp.cox.net>
References: <20060413115447.11819.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Thu Apr 13 20:56:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FU6zm-0004Zg-EG
	for gcvg-git@gmane.org; Thu, 13 Apr 2006 20:56:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbWDMS4n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Apr 2006 14:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbWDMS4n
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Apr 2006 14:56:43 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:36757 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932446AbWDMS4n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Apr 2006 14:56:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060413185642.DBQP20694.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 13 Apr 2006 14:56:42 -0400
To: linux@horizon.com, "Peter Eriksen" <s022018@student.dtu.dk>,
	"Aneesh Kumar" <aneesh.kumar@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18667>

linux@horizon.com writes:

> I've recently encountered the same problem with t/t3600-rm.sh step 9,
> but I put it down to compiling as root.
>
> Basically, the chmod of the directory didn't stop the delete from
> happening, since I had umask 002 and it was g+w.
>
> Anyway, that test is fragile.

Indeed.  I am not sure about test #5, but here is my stab at
fixing test #9.

-- >8 --
[PATCH] t3600-rm: skip failed-remove test when we cannot make an unremovable file

When running t3600-rm test under fakeroot (or as root), we
cannot make a file unremovable with "chmod a-w .".  Detect this
case early and skip that test.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index d1947e1..acaa4d6 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -23,6 +23,16 @@ else
     test_tabs=n
 fi
 
+# Later we will try removing an unremovable path to make sure
+# git-rm barfs, but if the test is run as root that cannot be
+# arranged.
+: >test-file
+chmod a-w .
+rm -f test-file
+test -f test-file && test_failed_remove=y
+chmod 775 .
+rm -f test-file
+
 test_expect_success \
     'Pre-check that foo exists and is in index before git-rm foo' \
     '[ -f foo ] && git-ls-files --error-unmatch foo'
@@ -56,12 +66,14 @@ test "$test_tabs" = y && test_expect_suc
     "git-rm -f 'space embedded' 'tab	embedded' 'newline
 embedded'"
 
-if test "$test_tabs" = y; then
-chmod u-w .
+if test "$test_failed_remove" = y; then
+chmod a-w .
 test_expect_failure \
     'Test that "git-rm -f" fails if its rm fails' \
     'git-rm -f baz'
-chmod u+w .
+chmod 775 .
+else
+    test_expect_success 'skipping removal failure (perhaps running as root?)' :
 fi
 
 test_expect_success \
