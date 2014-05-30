From: Jeff King <peff@peff.net>
Subject: [PATCH v2] t5538: move http push tests out to t5542
Date: Fri, 30 May 2014 13:36:21 -0400
Message-ID: <20140530173621.GD25443@sigill.intra.peff.net>
References: <87y4xk8asq.fsf@spindle.srvr.nix>
 <20140530010649.GD28683@sigill.intra.peff.net>
 <20140530013419.GE28683@sigill.intra.peff.net>
 <87lhtj8sqx.fsf_-_@spindle.srvr.nix>
 <20140530172051.GB25443@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Nix <nix@esperi.org.uk>
X-From: git-owner@vger.kernel.org Fri May 30 19:36:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqQjD-0008GM-G7
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 19:36:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933195AbaE3RgX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2014 13:36:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:34288 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932564AbaE3RgX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 13:36:23 -0400
Received: (qmail 15599 invoked by uid 102); 30 May 2014 17:36:23 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 30 May 2014 12:36:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 May 2014 13:36:21 -0400
Content-Disposition: inline
In-Reply-To: <20140530172051.GB25443@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250451>

From: Nick Alcock <nick.alcock@oracle.com>

As 0232852b, but for the push tests instead: this avoids a start_httpd
in the middle of the file, which fails under GIT_TEST_HTTPD=false.

Note that we have to munge the test in a few ways while
moving it:

  1. We drop the `test -z "$GIT_TEST_HTTPD"` check; this is
     too simplistic since 83d842d, and we should let
     lib-httpd.sh handle it.

  2. We have to port over some of the old setup from t5538.

  3. In the final test, we no longer expect the extra commit
     "1" built on top of "4". This was a side effect from an
     earlier test in t5538 which was not ported over.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Signed-off-by: Jeff King <peff@peff.net>
---
Here it is with the fixups I suggested in the last email. This passes
for me, but I'd love to have a sanity check from Duy.

 t/t5538-push-shallow.sh      |  59 -------------------------
 t/t5542-push-http-shallow.sh | 100 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+), 59 deletions(-)
 create mode 100755 t/t5542-push-http-shallow.sh

diff --git a/t/t5538-push-shallow.sh b/t/t5538-push-shallow.sh
index 8e54ac5..ceee95b 100755
--- a/t/t5538-push-shallow.sh
+++ b/t/t5538-push-shallow.sh
@@ -120,63 +120,4 @@ EOF
 	git cat-file blob `echo 1|git hash-object --stdin` >/dev/null
 	)
 '
-
-if test -n "$NO_CURL" -o -z "$GIT_TEST_HTTPD"; then
-	say 'skipping remaining tests, git built without http support'
-	test_done
-fi
-
-. "$TEST_DIRECTORY"/lib-httpd.sh
-start_httpd
-
-test_expect_success 'push to shallow repo via http' '
-	git clone --bare --no-local shallow "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
-	(
-	cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
-	git config http.receivepack true
-	) &&
-	(
-	cd full &&
-	commit 9 &&
-	git push $HTTPD_URL/smart/repo.git +master:refs/remotes/top/master
-	) &&
-	(
-	cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
-	git fsck &&
-	git log --format=%s top/master >actual &&
-	cat <<EOF >expect &&
-9
-4
-3
-EOF
-	test_cmp expect actual
-	)
-'
-
-test_expect_success 'push from shallow repo via http' '
-	mv "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" shallow-upstream.git &&
-	git clone --bare --no-local full "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
-	(
-	cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
-	git config http.receivepack true
-	) &&
-	commit 10 &&
-	git push $HTTPD_URL/smart/repo.git +master:refs/remotes/top/master &&
-	(
-	cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
-	git fsck &&
-	git log --format=%s top/master >actual &&
-	cat <<EOF >expect &&
-10
-1
-4
-3
-2
-1
-EOF
-	test_cmp expect actual
-	)
-'
-
-stop_httpd
 test_done
diff --git a/t/t5542-push-http-shallow.sh b/t/t5542-push-http-shallow.sh
new file mode 100755
index 0000000..2a691e0
--- /dev/null
+++ b/t/t5542-push-http-shallow.sh
@@ -0,0 +1,100 @@
+#!/bin/sh
+
+test_description='push from/to a shallow clone over http'
+
+. ./test-lib.sh
+
+if test -n "$NO_CURL"; then
+	say 'skipping test, git built without http support'
+	test_done
+fi
+
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
+
+commit() {
+	echo "$1" >tracked &&
+	git add tracked &&
+	git commit -m "$1"
+}
+
+test_expect_success 'setup' '
+	git config --global transfer.fsckObjects true &&
+	commit 1 &&
+	commit 2 &&
+	commit 3 &&
+	commit 4 &&
+	git clone . full &&
+	(
+	git init full-abc &&
+	cd full-abc &&
+	commit a &&
+	commit b &&
+	commit c
+	) &&
+	git clone --no-local --depth=2 .git shallow &&
+	git --git-dir=shallow/.git log --format=%s >actual &&
+	cat <<EOF >expect &&
+4
+3
+EOF
+	test_cmp expect actual &&
+	git clone --no-local --depth=2 full-abc/.git shallow2 &&
+	git --git-dir=shallow2/.git log --format=%s >actual &&
+	cat <<EOF >expect &&
+c
+b
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'push to shallow repo via http' '
+	git clone --bare --no-local shallow "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	(
+	cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	git config http.receivepack true
+	) &&
+	(
+	cd full &&
+	commit 9 &&
+	git push $HTTPD_URL/smart/repo.git +master:refs/remotes/top/master
+	) &&
+	(
+	cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	git fsck &&
+	git log --format=%s top/master >actual &&
+	cat <<EOF >expect &&
+9
+4
+3
+EOF
+	test_cmp expect actual
+	)
+'
+
+test_expect_success 'push from shallow repo via http' '
+	mv "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" shallow-upstream.git &&
+	git clone --bare --no-local full "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	(
+	cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	git config http.receivepack true
+	) &&
+	commit 10 &&
+	git push $HTTPD_URL/smart/repo.git +master:refs/remotes/top/master &&
+	(
+	cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	git fsck &&
+	git log --format=%s top/master >actual &&
+	cat <<EOF >expect &&
+10
+4
+3
+2
+1
+EOF
+	test_cmp expect actual
+	)
+'
+
+stop_httpd
+test_done
-- 
2.0.0.rc1.436.g03cb729
