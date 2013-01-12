From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH] t9605: test for cvsps commit ordering bug
Date: Fri, 11 Jan 2013 22:13:53 -0600
Message-ID: <1357964033-24659-1-git-send-email-chris@rorvick.com>
Cc: "Eric S. Raymond" <esr@thyrsus.com>,
	Chris Rorvick <chris@rorvick.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 12 05:15:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtsVY-0008Ty-Ap
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jan 2013 05:15:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754327Ab3ALEPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2013 23:15:22 -0500
Received: from mail-ia0-f170.google.com ([209.85.210.170]:51833 "EHLO
	mail-ia0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753744Ab3ALEPV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 23:15:21 -0500
Received: by mail-ia0-f170.google.com with SMTP id k20so2090138iak.29
        for <git@vger.kernel.org>; Fri, 11 Jan 2013 20:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=fjwUtkVru1OT/A22XZQKDuPek3xa2eXOakT0pdrAvbE=;
        b=NvrIxh7fg1417DvdYlhqXFZPt466ipGF0oBkRlwFDhoQHrKXTqEJdLPsry07kzfyxd
         R2vOn+mlVb8vCJ1pHZkf9s+9LDf2gJ5HZJpm7Hxr7ckU+JMvlQkjDmRRLsIRybBFWR4E
         x1ZSogmwOrqIscU/ggprhL3Xorn9zwXjfxlm5Km2FrAdF4cSYiF/BQDC8YGfUPQpMND0
         BpKwyx6isJK5CYxFmLZD7zeOzO53aIsilh6aVoQzds0fcdkWiXPwqtEeQm6pN8iHOBji
         qGmLNiyztuQJ8/eQpfw9LoHxelSUa6/IOx2QCeJ8sUHKuA8CKVKYLdme9ikmFnWYhLek
         bdnQ==
X-Received: by 10.50.16.210 with SMTP id i18mr1178004igd.53.1357964120503;
        Fri, 11 Jan 2013 20:15:20 -0800 (PST)
Received: from marlin.localdomain (adsl-70-131-98-170.dsl.emhril.sbcglobal.net. [70.131.98.170])
        by mx.google.com with ESMTPS id k5sm1329346igq.9.2013.01.11.20.15.17
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 11 Jan 2013 20:15:18 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc3.335.g88a67d6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213258>

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

Ran into this recently.  No branching and no "criss cross" timestamps,
just lazy commit messages.  And it magically backed out a bug fix.

This applies on top of master.  With minor modifications I've tested it
with Eric's latest code and confirmed the bug still exists.

Chris

 t/t9605-cvsimport-commit-order.sh  | 25 +++++++++++++++
 t/t9605/cvsroot/.gitattributes     |  1 +
 t/t9605/cvsroot/CVSROOT/.gitignore |  2 ++
 t/t9605/cvsroot/module/a,v         | 24 +++++++++++++++
 t/t9605/cvsroot/module/b,v         | 24 +++++++++++++++
 t/t9605/cvsroot/module/c,v         | 62 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 138 insertions(+)
 create mode 100755 t/t9605-cvsimport-commit-order.sh
 create mode 100644 t/t9605/cvsroot/.gitattributes
 create mode 100644 t/t9605/cvsroot/CVSROOT/.gitignore
 create mode 100644 t/t9605/cvsroot/module/a,v
 create mode 100644 t/t9605/cvsroot/module/b,v
 create mode 100644 t/t9605/cvsroot/module/c,v

diff --git a/t/t9605-cvsimport-commit-order.sh b/t/t9605-cvsimport-commit-order.sh
new file mode 100755
index 0000000..ab4042e
--- /dev/null
+++ b/t/t9605-cvsimport-commit-order.sh
@@ -0,0 +1,25 @@
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
+	test_cmp module-cvs/c module-git/c &&
+false
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
