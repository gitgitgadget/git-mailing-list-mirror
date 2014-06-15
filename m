From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH 07/14] bisect: add t6041 for submodule updates
Date: Sun, 15 Jun 2014 19:01:00 +0200
Message-ID: <539DD14C.4090609@web.de>
References: <539DD029.4030506@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 15 19:01:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwDnv-0002yE-Qd
	for gcvg-git-2@plane.gmane.org; Sun, 15 Jun 2014 19:01:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936AbaFORBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2014 13:01:12 -0400
Received: from mout.web.de ([212.227.15.14]:62659 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751870AbaFORBL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2014 13:01:11 -0400
Received: from [192.168.178.41] ([84.132.144.103]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MddFQ-1X63170giC-00PKuW; Sun, 15 Jun 2014 19:01:01
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <539DD029.4030506@web.de>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:J8k900xi90Z+AFkcSSClska+Zy6E0FugZiou1urbrJqzvM8w+Ol
 CT+it7Fzcq7sTdIjPC68Xxj6wVuEGafzwb9aWpNmGIe9AtSrI/jKoDe3mOXyluPDzuuVIKX
 fY7LpAPeUm/Kc6SnfSw/Tyq5e0JWITe7t10jhJAD04UKAsp7WGdiowc3AsrUp7uAoX3P9fk
 jQ2+UC4+xRlSKDn9MXO/Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251689>

Test that the bisect command updates the work tree as expected. To make
that work with the new submodule test framework a git_bisect helper
function is added. This adds a commit after the one given to be switched
to and makes that one the bad commit. The starting point is then given to
bisect as the good commit which makes bisect change the work tree to the
commit in between, which is the commit given.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 t/t6041-bisect-submodule.sh | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100755 t/t6041-bisect-submodule.sh

diff --git a/t/t6041-bisect-submodule.sh b/t/t6041-bisect-submodule.sh
new file mode 100755
index 0000000..4f37d24
--- /dev/null
+++ b/t/t6041-bisect-submodule.sh
@@ -0,0 +1,32 @@
+#!/bin/sh
+
+test_description='bisect can handle submodules'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-submodule-update.sh
+
+git_bisect () {
+	git status -su >expected &&
+	ls -1pR * >>expected &&
+	tar czf "$TRASH_DIRECTORY/tmp.tgz" * &&
+	GOOD=$(git rev-parse --verify HEAD) &&
+	git checkout "$1" &&
+	echo "foo" >bar &&
+	git add bar &&
+	git commit -m "bisect bad" &&
+	BAD=$(git rev-parse --verify HEAD) &&
+	git reset --hard HEAD^^ &&
+	git submodule update &&
+	git bisect start &&
+	git bisect good $GOOD &&
+	rm -rf * &&
+	tar xzf "$TRASH_DIRECTORY/tmp.tgz" &&
+	git status -su >actual &&
+	ls -1pR * >>actual &&
+	test_cmp expected actual &&
+	git bisect bad $BAD
+}
+
+test_submodule_switch "git_bisect"
+
+test_done
-- 
2.0.0.275.gc479268
