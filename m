From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH v2] t9605: test for cvsps commit ordering bug
Date: Fri, 11 Jan 2013 22:39:16 -0600
Message-ID: <1357965556-25761-1-git-send-email-chris@rorvick.com>
Cc: "Eric S. Raymond" <esr@thyrsus.com>,
	Chris Rorvick <chris@rorvick.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 12 05:40:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ttstm-0001cB-4p
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jan 2013 05:40:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755388Ab3ALEk3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2013 23:40:29 -0500
Received: from mail-ie0-f182.google.com ([209.85.223.182]:33551 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754991Ab3ALEk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 23:40:27 -0500
Received: by mail-ie0-f182.google.com with SMTP id s9so3204970iec.27
        for <git@vger.kernel.org>; Fri, 11 Jan 2013 20:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=kKIrJsMwNAD5rRfWTZLhKvbE1pwT1rPwHcHYozyle3k=;
        b=a+vt6M319sbU0Of8iGahXvQDUF6aRgJAYns8THsgXyX6nLYsQzsobdIsEeXPZqguuA
         FsEALXwduHNxgyObpulhsHDm31zrkT6WC0JdAH3m11CuSmK+UkFoZgPWjcKQW1CTfz16
         QfDzkyC9jjQbjHzZpd/hKDY1e93x0245cdv+9n2V3iDHXIysYUTdTMM2NXvTQxySaku8
         HniToPBq/L8NoPfN27Xx2G2BTeCYHfK/GQrmLFanFA8QJMBcyHToge0DvsgHp1AGZ9hv
         cTA5OL/ksg0cQw4fyl4WFhD/el5F082/WwN2qIdFKwlE4Tei+5RFTq4pC5g1JI7yHSng
         ZlaA==
X-Received: by 10.50.150.144 with SMTP id ui16mr1148401igb.68.1357965626836;
        Fri, 11 Jan 2013 20:40:26 -0800 (PST)
Received: from marlin.localdomain (adsl-70-131-98-170.dsl.emhril.sbcglobal.net. [70.131.98.170])
        by mx.google.com with ESMTPS id eu3sm1270459igc.7.2013.01.11.20.40.25
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 11 Jan 2013 20:40:26 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc3.335.g88a67d6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213259>

Import of a trivial CVS repository fails due to a cvsps bug.  Given the
following series of commits:

    timestamp             a    b    c   message
    -------------------  ---  ---  ---  -------
    2012/12/12 21:09:39  1.1            changes are done
    2012/12/12 21:09:44            1.1  changes
    2012/12/12 21:09:46            1.2  changes
    2012/12/12 21:09:50       1.1  1.3  changes are done

cvsps mangles the commit ordering (edited for brevity):

    ---------------------
    PatchSet 1
    Date: 2012/12/12 15:09:39
    Log:
    changes are done

    Members:
    	a:INITIAL->1.1
    	b:INITIAL->1.1
    	c:1.2->1.3

    ---------------------
    PatchSet 2
    Date: 2012/12/12 15:09:44
    Log:
    changes

    Members:
    	c:INITIAL->1.1

    ---------------------
    PatchSet 3
    Date: 2012/12/12 15:09:46
    Log:
    changes

    Members:
    	c:1.1->1.2

This is seen in cvsps versions 2.x and up through at least 3.7.

Signed-off-by: Chris Rorvick <chris@rorvick.com>
---

It actually does fail without the "&& false" at the end.  :-P  Sorry for
the noise.

 t/t9605-cvsimport-commit-order.sh  | 24 +++++++++++++++
 t/t9605/cvsroot/.gitattributes     |  1 +
 t/t9605/cvsroot/CVSROOT/.gitignore |  2 ++
 t/t9605/cvsroot/module/a,v         | 24 +++++++++++++++
 t/t9605/cvsroot/module/b,v         | 24 +++++++++++++++
 t/t9605/cvsroot/module/c,v         | 62 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 137 insertions(+)
 create mode 100755 t/t9605-cvsimport-commit-order.sh
 create mode 100644 t/t9605/cvsroot/.gitattributes
 create mode 100644 t/t9605/cvsroot/CVSROOT/.gitignore
 create mode 100644 t/t9605/cvsroot/module/a,v
 create mode 100644 t/t9605/cvsroot/module/b,v
 create mode 100644 t/t9605/cvsroot/module/c,v

diff --git a/t/t9605-cvsimport-commit-order.sh b/t/t9605-cvsimport-commit-order.sh
new file mode 100755
index 0000000..86aafd1
--- /dev/null
+++ b/t/t9605-cvsimport-commit-order.sh
@@ -0,0 +1,24 @@
+#!/bin/sh
+
+test_description='git cvsimport commit order'
+. ./lib-cvs.sh
+
+setup_cvs_test_repository t9605
+
+test_expect_success 'checkout with CVS' '
+
+	echo CVSROOT=$CVSROOT &&
+	cvs checkout -d module-cvs module
+'
+
+test_expect_failure 'import into git (commit order mangled)' '
+
+	git cvsimport -R -a -p"-x" -C module-git module &&
+	(
+		cd module-git &&
+		git merge origin
+	) &&
+	test_cmp module-cvs/c module-git/c
+'
+
+test_done
diff --git a/t/t9605/cvsroot/.gitattributes b/t/t9605/cvsroot/.gitattributes
new file mode 100644
index 0000000..562b12e
--- /dev/null
+++ b/t/t9605/cvsroot/.gitattributes
@@ -0,0 +1 @@
+* -whitespace
diff --git a/t/t9605/cvsroot/CVSROOT/.gitignore b/t/t9605/cvsroot/CVSROOT/.gitignore
new file mode 100644
index 0000000..3bb9b34
--- /dev/null
+++ b/t/t9605/cvsroot/CVSROOT/.gitignore
@@ -0,0 +1,2 @@
+history
+val-tags
diff --git a/t/t9605/cvsroot/module/a,v b/t/t9605/cvsroot/module/a,v
new file mode 100644
index 0000000..6455911
--- /dev/null
+++ b/t/t9605/cvsroot/module/a,v
@@ -0,0 +1,24 @@
+head	1.1;
+access;
+symbols;
+locks; strict;
+comment	@# @;
+
+
+1.1
+date	2012.12.12.21.09.39;	author tester;	state Exp;
+branches;
+next	;
+
+
+desc
+@@
+
+
+1.1
+log
+@changes are done
+@
+text
+@file a
+@
diff --git a/t/t9605/cvsroot/module/b,v b/t/t9605/cvsroot/module/b,v
new file mode 100644
index 0000000..55545c8
--- /dev/null
+++ b/t/t9605/cvsroot/module/b,v
@@ -0,0 +1,24 @@
+head	1.1;
+access;
+symbols;
+locks; strict;
+comment	@# @;
+
+
+1.1
+date	2012.12.12.21.09.50;	author tester;	state Exp;
+branches;
+next	;
+
+
+desc
+@@
+
+
+1.1
+log
+@changes are done
+@
+text
+@file b
+@
diff --git a/t/t9605/cvsroot/module/c,v b/t/t9605/cvsroot/module/c,v
new file mode 100644
index 0000000..d3eac77
--- /dev/null
+++ b/t/t9605/cvsroot/module/c,v
@@ -0,0 +1,62 @@
+head	1.3;
+access;
+symbols;
+locks; strict;
+comment	@# @;
+
+
+1.3
+date	2012.12.12.21.09.50;	author tester;	state Exp;
+branches;
+next	1.2;
+
+1.2
+date	2012.12.12.21.09.46;	author tester;	state Exp;
+branches;
+next	1.1;
+
+1.1
+date	2012.12.12.21.09.44;	author tester;	state Exp;
+branches;
+next	;
+
+
+desc
+@@
+
+
+1.3
+log
+@changes are done
+@
+text
+@file c
+line two
+line three
+line four
+line five
+@
+
+
+1.2
+log
+@changes
+@
+text
+@d2 4
+a5 4
+line 2
+line 3
+line 4
+line 5
+@
+
+
+1.1
+log
+@changes
+@
+text
+@d2 4
+@
+
-- 
1.8.1.rc3.335.g88a67d6
