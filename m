From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 4/8] Implement an interoperability test for fetch-pack/upload-pack
Date: Fri, 28 Oct 2005 04:48:03 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510280447440.20516@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Oct 28 04:48:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVKHo-0000iX-OP
	for gcvg-git@gmane.org; Fri, 28 Oct 2005 04:48:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965066AbVJ1CsG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Oct 2005 22:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965067AbVJ1CsF
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Oct 2005 22:48:05 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:41423 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S965066AbVJ1CsE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2005 22:48:04 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 8869D13EFF3; Fri, 28 Oct 2005 04:48:03 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 661129EFCF; Fri, 28 Oct 2005 04:48:03 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4F5BC9EFC9; Fri, 28 Oct 2005 04:48:03 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4611513EFF3; Fri, 28 Oct 2005 04:48:03 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10743>


The next patches will extend the pack protocol. This test assures that this
extension is compatible to earlier versions of git-fetch-pack/git-upload-pack.

All you need to do to take advantage of this test, is to install older
known-to-be-working binaries in the path as "old-git-fetch-pack" and
"old-git-upload-pack".

Note that the warning when testing with old-git-fetch-pack is to be
expected (it just says that the old version was not taking advantage
of all the information which the server sent).

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 t/t5501-old-fetch-and-upload.sh |   43 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)
 create mode 100755 t/t5501-old-fetch-and-upload.sh

applies-to: 4286a14deeaa64cf1d00fc5f7cb197e91f230ab9
0bae675fd1eb4ec33834a6c8d0b6bbc88adc30da
diff --git a/t/t5501-old-fetch-and-upload.sh b/t/t5501-old-fetch-and-upload.sh
new file mode 100755
index 0000000..86df785
--- /dev/null
+++ b/t/t5501-old-fetch-and-upload.sh
@@ -0,0 +1,43 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Johannes Schindelin
+#
+
+# Test that the current fetch-pack/upload-pack plays nicely with
+# an old counterpart
+
+cd $(dirname $0) || exit 1
+
+tmp=$(mktemp tmp-XXXX)
+
+retval=0
+
+if [ -z "$1" ]; then
+	list="fetch upload"
+else
+	list="$@"
+fi
+
+for i in $list; do
+	case "$i" in
+	fetch) pgm="old-git-fetch-pack"; replace="$pgm";;
+	upload) pgm="old-git-upload-pack"; replace="git-fetch-pack --exec=$pgm";;
+	both) pgm="old-git-upload-pack"; replace="old-git-fetch-pack --exec=$pgm";;
+	esac
+
+	if which $pgm; then
+		echo "Testing with $pgm"
+		sed -e "s/git-fetch-pack/$replace/g" \
+			-e "s/# old fails/warn/" < t5500-fetch-pack.sh > $tmp
+
+		sh $tmp || retval=$?
+		rm $tmp
+
+		test $retval != 0 && exit $retval
+	else
+		echo "Skipping test for $i, since I cannot find $pgm"
+	fi
+done
+
+exit 0
+
---
0.99.8.GIT
