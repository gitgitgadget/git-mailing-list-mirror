From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] Add basic cvsimport tests
Date: Wed, 28 Nov 2007 13:55:46 -0500
Message-ID: <20071128185546.GA11320@coredump.intra.peff.net>
References: <20071128185504.GA11236@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Emanuele Giaquinta <e.giaquinta@glauco.it>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 19:56:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxS50-0005N8-BA
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 19:56:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754839AbXK1Szt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 13:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbXK1Szt
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 13:55:49 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3689 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754646AbXK1Szs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 13:55:48 -0500
Received: (qmail 13183 invoked by uid 111); 28 Nov 2007 18:55:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 28 Nov 2007 13:55:47 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Nov 2007 13:55:46 -0500
Content-Disposition: inline
In-Reply-To: <20071128185504.GA11236@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66406>

We weren't even testing basic things before, so let's at
least try importing and updating a trivial repository, which
will catch total breakage.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t9600-cvsimport.sh |   99 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 99 insertions(+), 0 deletions(-)
 create mode 100755 t/t9600-cvsimport.sh

diff --git a/t/t9600-cvsimport.sh b/t/t9600-cvsimport.sh
new file mode 100755
index 0000000..1ee06bb
--- /dev/null
+++ b/t/t9600-cvsimport.sh
@@ -0,0 +1,99 @@
+#!/bin/sh
+
+test_description='git-cvsimport basic tests'
+. ./test-lib.sh
+
+if ! ( type cvs && type cvsps ) >/dev/null 2>&1
+then
+	test_expect_success 'skipping cvsimport tests, cvs/cvsps not found' ''
+	test_done
+	exit
+fi
+
+CVSROOT=$(pwd)/cvsroot
+export CVSROOT
+# for clean cvsps cache
+HOME=$(pwd)
+export HOME
+
+test_expect_success 'setup cvsroot' 'cvs init'
+
+test_expect_success 'setup a cvs module' '
+
+	mkdir $CVSROOT/module &&
+	cvs co -d module-cvs module &&
+	cd module-cvs &&
+	cat <<EOF >o_fortuna &&
+O Fortuna
+velut luna
+statu variabilis,
+
+semper crescis
+aut decrescis;
+vita detestabilis
+
+nunc obdurat
+et tunc curat
+ludo mentis aciem,
+
+egestatem,
+potestatem
+dissolvit ut glaciem.
+EOF
+	cvs add o_fortuna &&
+	cat <<EOF >message &&
+add "O Fortuna" lyrics
+
+These public domain lyrics make an excellent sample text.
+EOF
+	cvs commit -F message &&
+	cd ..
+'
+
+test_expect_success 'import a trivial module' '
+
+	git cvsimport -a -z 0 -C module-git module &&
+	git diff module-cvs/o_fortuna module-git/o_fortuna
+
+'
+
+test_expect_success 'update cvs module' '
+
+	cd module-cvs &&
+	cat <<EOF >o_fortuna &&
+O Fortune,
+like the moon
+you are changeable,
+
+ever waxing
+and waning;
+hateful life
+
+first oppresses
+and then soothes
+as fancy takes it;
+
+poverty
+and power
+it melts them like ice.
+EOF
+	cat <<EOF >message &&
+translate to English
+
+My Latin is terrible.
+EOF
+	cvs commit -F message &&
+	cd ..
+'
+
+test_expect_success 'update git module' '
+
+	cd module-git &&
+	git cvsimport -a -z 0 module &&
+	git merge origin &&
+	cd .. &&
+	git diff module-cvs/o_fortuna module-git/o_fortuna
+
+'
+
+test_done
-- 
1.5.3.6.2039.g0495
