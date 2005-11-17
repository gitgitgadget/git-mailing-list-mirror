From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Add test case for git-config-set
Date: Thu, 17 Nov 2005 22:50:08 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511172249410.18285@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Nov 17 22:53:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcreN-0003cx-40
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 22:50:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503AbVKQVuL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 16:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751506AbVKQVuL
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 16:50:11 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:58298 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751503AbVKQVuJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 16:50:09 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 9EF3A13FCE7; Thu, 17 Nov 2005 22:50:08 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 79770B5232; Thu, 17 Nov 2005 22:50:08 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 48318B5230; Thu, 17 Nov 2005 22:50:08 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3B06413FCE0; Thu, 17 Nov 2005 22:50:08 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12161>


... includes the mean tests I mentioned on the list.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 t1300-config-set.sh |  180 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 180 insertions(+), 0 deletions(-)
 create mode 100644 t1300-config-set.sh

applies-to: de5d2a42ebd69e3608e0f99f615fbcf55a88c101
3fa048df0d691d3423ec81f8dba947e2c05fa996
diff --git a/t1300-config-set.sh b/t1300-config-set.sh
new file mode 100644
index 0000000..df89216
--- /dev/null
+++ b/t1300-config-set.sh
@@ -0,0 +1,180 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Johannes Schindelin
+#
+
+test_description='Test git-config-set in different settings'
+
+. ./test-lib.sh
+
+test -f .git/config && rm .git/config
+
+git-config-set core.penguin "little blue"
+
+cat > expect << EOF
+#
+# This is the config file
+#
+
+[core]
+	penguin = little blue
+EOF
+
+test_expect_success 'initial' 'cmp .git/config expect'
+
+git-config-set Core.Movie BadPhysics
+
+cat > expect << EOF
+#
+# This is the config file
+#
+
+[core]
+	penguin = little blue
+	Movie = BadPhysics
+EOF
+
+test_expect_success 'mixed case' 'cmp .git/config expect'
+
+git-config-set Cores.WhatEver Second
+
+cat > expect << EOF
+#
+# This is the config file
+#
+
+[core]
+	penguin = little blue
+	Movie = BadPhysics
+[Cores]
+	WhatEver = Second
+EOF
+
+test_expect_success 'similar section' 'cmp .git/config expect'
+
+git-config-set CORE.UPPERCASE true
+
+cat > expect << EOF
+#
+# This is the config file
+#
+
+[core]
+	penguin = little blue
+	Movie = BadPhysics
+	UPPERCASE = true
+[Cores]
+	WhatEver = Second
+EOF
+
+test_expect_success 'similar section' 'cmp .git/config expect'
+
+cat > .git/config << EOF
+[beta] ; silly comment # another comment
+noIndent= sillyValue ; 'nother silly comment
+
+# empty line
+		; comment
+		haha   ="beta" # last silly comment
+[nextSection] noNewline = ouch
+EOF
+
+git-config-set beta.haha alpha
+
+cat > expect << EOF
+[beta] ; silly comment # another comment
+noIndent= sillyValue ; 'nother silly comment
+
+# empty line
+		; comment
+	haha = alpha
+[nextSection] noNewline = ouch
+EOF
+
+test_expect_success 'really mean test' 'cmp .git/config expect'
+
+git-config-set nextsection.nonewline wow
+
+cat > expect << EOF
+[beta] ; silly comment # another comment
+noIndent= sillyValue ; 'nother silly comment
+
+# empty line
+		; comment
+	haha = alpha
+[nextSection]
+	nonewline = wow
+EOF
+
+test_expect_success 'really really mean test' 'cmp .git/config expect'
+
+git-config-set beta.haha
+
+cat > expect << EOF
+[beta] ; silly comment # another comment
+noIndent= sillyValue ; 'nother silly comment
+
+# empty line
+		; comment
+[nextSection]
+	nonewline = wow
+EOF
+
+test_expect_success 'unset' 'cmp .git/config expect'
+
+git-config-set nextsection.NoNewLine "wow2 for me" "for me$"
+
+cat > expect << EOF
+[beta] ; silly comment # another comment
+noIndent= sillyValue ; 'nother silly comment
+
+# empty line
+		; comment
+[nextSection]
+	nonewline = wow
+	NoNewLine = wow2 for me
+EOF
+
+test_expect_success 'multivar' 'cmp .git/config expect'
+
+git-config-set nextsection.nonewline "wow3" "wow$"
+
+cat > expect << EOF
+[beta] ; silly comment # another comment
+noIndent= sillyValue ; 'nother silly comment
+
+# empty line
+		; comment
+[nextSection]
+	nonewline = wow3
+	NoNewLine = wow2 for me
+EOF
+
+test_expect_success 'multivar replace' 'cmp .git/config expect'
+
+test_expect_failure 'ambiguous unset' \
+	'git-config-set --unset nextsection.nonewline'
+
+test_expect_failure 'invalid unset' \
+	'git-config-set --unset somesection.nonewline'
+
+git-config-set --unset nextsection.nonewline "wow3$"
+
+cat > expect << EOF
+[beta] ; silly comment # another comment
+noIndent= sillyValue ; 'nother silly comment
+
+# empty line
+		; comment
+[nextSection]
+	NoNewLine = wow2 for me
+EOF
+
+test_expect_success 'multivar unset' 'cmp .git/config expect'
+
+test_expect_failure 'invalid key' 'git-config-set inval.2key blabla'
+
+test_expect_success 'correct key' 'git-config-set 123456.a123 987'
+
+test_done
+
---
0.99.9.GIT
