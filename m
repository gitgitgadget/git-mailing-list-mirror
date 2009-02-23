From: Heiko Voigt <git-list@hvoigt.net>
Subject: [PATCH] cvsimport: add test illustrating a bug in cvsps
Date: Mon, 23 Feb 2009 19:49:42 +0100
Message-ID: <49A2EFC6.5000104@hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 23 19:51:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbftb-0006sV-CL
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 19:51:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754172AbZBWSts (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 13:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754094AbZBWStq
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 13:49:46 -0500
Received: from darksea.de ([83.133.111.250]:57253 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753996AbZBWStq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 13:49:46 -0500
Received: (qmail 9706 invoked from network); 23 Feb 2009 19:49:31 +0100
Received: from unknown (HELO macbook.lan) (127.0.0.1)
  by localhost with SMTP; 23 Feb 2009 19:49:31 +0100
User-Agent: Thunderbird 2.0.0.19 (Macintosh/20081209)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some cvs repositories may have time deviations in their recorded commits. This
is a test for one of such cases. These kind of repositories can happen if the
system time of cvs clients is not fully synchronised.

Consider the following sequence of events:

 * client A commits file a r1.1
 * client A commits file a r1.2, b r1.1
 * client B commits file b r1.2 using the same timestamp as a r1.1

This can be resolved but due to cvsps grouping its patchsets solely based
on the timestamp and never breaking these groups it outputs the wrong
order which then leads to a broken import.

I hit this bug when importing from a real repository which was originally
converted from another rcs based scm. Other import tools can handle this
correctly, e.g. parsecvs.
---

As this is my first real patch, please let me know if I added anything
to the wrong place. There is actually another bug depending on timings
which I haven't written a testcase for yet. It is not such a showstopper
but cvsps skips revisions from a file if they have the same commit
message and fit into the same time window.

cheers Heiko

 t/t9603-cvsimport-time.sh      |   60 ++++++++++++++++++++++++++++++++++++++++
 t/t9603/cvsroot/time/a,v       |   41 +++++++++++++++++++++++++++
 t/t9603/cvsroot/time/b,v       |   41 +++++++++++++++++++++++++++
 3 files changed, 142 insertions(+), 0 deletions(-)
 create mode 100755 t/t9603-cvsimport-time.sh
 create mode 100644 t/t9603/cvsroot/CVSROOT/.empty
 create mode 100644 t/t9603/cvsroot/time/a,v
 create mode 100644 t/t9603/cvsroot/time/b,v

diff --git a/t/t9603-cvsimport-time.sh b/t/t9603-cvsimport-time.sh
new file mode 100755
index 0000000..d6de242
--- /dev/null
+++ b/t/t9603-cvsimport-time.sh
@@ -0,0 +1,60 @@
+#!/bin/sh
+
+test_description='git cvsimport basic tests'
+. ./test-lib.sh
+
+CVSROOT="$TEST_DIRECTORY"/t9603/cvsroot
+export CVSROOT
+unset CVS_SERVER
+# for clean cvsps cache
+HOME=$(pwd)
+export HOME
+
+if ! type cvs >/dev/null 2>&1
+then
+	say 'skipping cvsimport tests, cvs not found'
+	test_done
+	exit
+fi
+
+cvsps_version=`cvsps -h 2>&1 | sed -ne 's/cvsps version //p'`
+case "$cvsps_version" in
+2.1 | 2.2*)
+	;;
+'')
+	say 'skipping cvsimport tests, cvsps not found'
+	test_done
+	exit
+	;;
+*)
+	say 'skipping cvsimport tests, unsupported cvsps version'
+	test_done
+	exit
+	;;
+esac
+
+# Structure of the test cvs repository
+#
+# Message   File:Content         Commit Time
+# Rev 1     a: 1.1               2009-02-21 19:11:43 +0100
+# Rev 2     a: 1.2    b: 1.1     2009-02-21 19:11:14 +0100
+# Rev 3               b: 1.2     2009-02-21 19:11:43 +0100
+#
+# As you can see the commit of Rev 3 has the same time as
+# Rev 1 this leads to a broken import because of a cvsps
+# bug.
+
+test_expect_success 'import with criss cross times on revisions' '
+
+    git cvsimport -p"-x" -C import time && 
+    cd import &&
+        git log --pretty=format:%s > ../actual &&
+        echo "" >> ../actual &&
+    cd .. &&
+    echo "Rev 3
+Rev 2
+Rev 1" > expect &&
+    test_cmp actual expect 
+'
+
+test_done
diff --git a/t/t9603/cvsroot/CVSROOT/.empty b/t/t9603/cvsroot/CVSROOT/.empty
new file mode 100644
index 0000000..e69de29
diff --git a/t/t9603/cvsroot/time/a,v b/t/t9603/cvsroot/time/a,v
new file mode 100644
index 0000000..66a96aa
--- /dev/null
+++ b/t/t9603/cvsroot/time/a,v
@@ -0,0 +1,41 @@
+head	1.2;
+access;
+symbols;
+locks; strict;
+comment	@# @;
+
+
+1.2
+date	2009.02.21.18.11.14;	author hvoigt;	state Exp;
+branches;
+next	1.1;
+
+1.1
+date	2009.02.21.18.11.43;	author hvoigt;	state Exp;
+branches;
+next	;
+
+
+desc
+@@
+
+
+1.2
+log
+@Rev 2
+@
+text
+@1.2
+@
+
+
+1.1
+log
+@Rev 1
+@
+text
+@d1 1
+a1 1
+1.1
+@
+
diff --git a/t/t9603/cvsroot/time/b,v b/t/t9603/cvsroot/time/b,v
new file mode 100644
index 0000000..b5da856
--- /dev/null
+++ b/t/t9603/cvsroot/time/b,v
@@ -0,0 +1,41 @@
+head	1.2;
+access;
+symbols;
+locks; strict;
+comment	@# @;
+
+
+1.2
+date	2009.02.21.18.11.43;	author hvoigt;	state Exp;
+branches;
+next	1.1;
+
+1.1
+date	2009.02.21.18.11.14;	author hvoigt;	state Exp;
+branches;
+next	;
+
+
+desc
+@@
+
+
+1.2
+log
+@Rev 3
+@
+text
+@1.2
+@
+
+
+1.1
+log
+@Rev 2
+@
+text
+@d1 1
+a1 1
+1.1
+@
+
-- 
1.6.1.2.390.gba743
