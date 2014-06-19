From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v2 07/14] bisect: add t6041 for submodule updates
Date: Thu, 19 Jun 2014 22:12:48 +0200
Message-ID: <53A34440.604@web.de>
References: <539DD029.4030506@web.de> <539DD14C.4090609@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 19 22:13:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxihm-0006Wo-44
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 22:13:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757344AbaFSUNA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 16:13:00 -0400
Received: from mout.web.de ([212.227.15.14]:58226 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757325AbaFSUM7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 16:12:59 -0400
Received: from [192.168.178.41] ([79.193.64.138]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0Lb1nV-1WHpW42Skb-00kff7; Thu, 19 Jun 2014 22:12:49
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <539DD14C.4090609@web.de>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:/+2z7ppCh2pCvZnP5h1KnNS0TAhNNlB+/P0VW2uRPR/KvzqOBbS
 KOVwj7TjkJuKvfopo9oJB5om2Sxcrje0ILT9/8tCtYG0AkJr/8G2Lw8nbC40CSJ5UTDSZSP
 6FpJbgslmvsKEyRdimnlspgPlKSpNW33Zz5PpTqocOvEy7Cf6Vd6bJ/iTdkfBs73Pg39d0V
 nGc2Kv81cWKO/AcEFqGhg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252177>

Test that the bisect command updates the work tree as expected. To make
that work with the new submodule test framework a git_bisect helper
function is added. This adds a commit after the one given to be switched
to and makes that one the bad commit. The starting point is then given to
bisect as the good commit which makes bisect change the work tree to the
commit in between, which is the commit given.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---


Changes to v1:

*) use "expect" instead of "expected"


 t/t6041-bisect-submodule.sh | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100755 t/t6041-bisect-submodule.sh

diff --git a/t/t6041-bisect-submodule.sh b/t/t6041-bisect-submodule.sh
new file mode 100755
index 0000000..c6b7aa6
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
+	git status -su >expect &&
+	ls -1pR * >>expect &&
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
+	test_cmp expect actual &&
+	git bisect bad $BAD
+}
+
+test_submodule_switch "git_bisect"
+
+test_done
-- 
2.0.0.406.gf4dce28
