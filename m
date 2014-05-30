From: Nix <nix@esperi.org.uk>
Subject: [RFC PATCH] t5538: move http push tests out to t5542
Date: Fri, 30 May 2014 11:29:10 +0100
Message-ID: <87lhtj8sqx.fsf_-_@spindle.srvr.nix>
References: <87y4xk8asq.fsf@spindle.srvr.nix>
	<20140530010649.GD28683@sigill.intra.peff.net>
	<20140530013419.GE28683@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 30 12:31:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqK5j-0006tP-TR
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 12:31:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932678AbaE3KbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2014 06:31:12 -0400
Received: from icebox.esperi.org.uk ([81.187.191.129]:53139 "EHLO
	mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932342AbaE3KbL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 06:31:11 -0400
Received: from spindle.srvr.nix (nix@spindle.srvr.nix [192.168.14.15])
	by mail.esperi.org.uk (8.14.9/8.14.8) with ESMTP id s4UATAlw005118;
	Fri, 30 May 2014 11:29:10 +0100
Emacs: don't cry -- it won't help.
In-Reply-To: <20140530013419.GE28683@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 29 May 2014 21:34:19 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
X-DCC-URT-Metrics: spindle 1060; Body=3 Fuz1=3 Fuz2=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250438>

As 0232852b, but for the push tests instead: this avoids a start_httpd
in the middle of the file, which fails under GIT_TEST_HTTPD=false.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
---
On 30 May 2014, Jeff King said:
> diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
> index be951a4..a980574 100755
> --- a/t/t5537-fetch-shallow.sh
> +++ b/t/t5537-fetch-shallow.sh

btw, t5538-push-shallow.sh has the same bug but was not fixed up that I
can see. (Though I can't see the original fix in the history of master
either: was it squashed away somehow?)

This new test fails if the patch is applied as-is because I haven't done
any ref adjustment (I don't honestly know what results are expected, and
the actual results I'm seeing, with a ref named '1s0' intermittently
replacing either 1 or 10 and 1 both, are so bizarre and inconsistent
that I suspect I'm hitting another local config problem of some sort.)

But something like this is needed.

(signed off with my work email address for paranoia's sake.)

 t/t5538-push-shallow.sh      |  59 -------------------------
 t/t5542-push-http-shallow.sh | 101 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+), 59 deletions(-)
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
index 0000000..61a7281
--- /dev/null
+++ b/t/t5542-push-http-shallow.sh
@@ -0,0 +1,101 @@
+#!/bin/sh
+
+test_description='push from/to a shallow clone over http'
+
+. ./test-lib.sh
+
+if test -n "$NO_CURL" -o -z "$GIT_TEST_HTTPD"; then
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
+	commit 1s0 &&
+	git push $HTTPD_URL/smart/repo.git +master:refs/remotes/top/master &&
+	(
+	cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	git fsck &&
+	git log --format=%s top/master >actual &&
+	cat <<EOF >expect &&
+10
+1
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
1.9.2.172.gbe1f7c7
