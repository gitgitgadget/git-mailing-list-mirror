Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEEEC433EF
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 19:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7BD460F9D
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 19:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbhJRTqB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Oct 2021 15:46:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:41146 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231787AbhJRTqA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Oct 2021 15:46:00 -0400
Received: (qmail 3203 invoked by uid 109); 18 Oct 2021 19:43:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 18 Oct 2021 19:43:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1595 invoked by uid 111); 18 Oct 2021 19:43:48 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 Oct 2021 15:43:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 18 Oct 2021 15:43:47 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/2] send-pack: complain about "expecting report" with
 --helper-status
Message-ID: <YW3OcxqcOsY9AFQ8@coredump.intra.peff.net>
References: <YW3MY6lAI5l+BOnP@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YW3MY6lAI5l+BOnP@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When pushing to a server which erroneously omits the final ref-status
report, the client side should complain about the refs for which we
didn't receive the status (because we can't just assume they were
updated). This works over most transports like ssh, but for http we'll
print a very misleading "Everything up-to-date".

It works for ssh because send-pack internally sets the status of each
ref to REF_STATUS_EXPECTING_REPORT, and then if the server doesn't tell
us about a particular ref, it will stay at that value. When we print the
final status table, we'll see that we're still on EXPECTING_REPORT and
complain then.

But for http, we go through remote-curl, which invokes send-pack with
"--stateless-rpc --helper-status". The latter option causes send-pack to
return a machine-readable list of ref statuses to the remote helper. But
ever since its inception in de1a2fdd38 (Smart push over HTTP: client
side, 2009-10-30), the send-pack code has simply omitted mention of any
ref which ended up in EXPECTING_REPORT.

In the remote helper, we then take the absence of any status report
from send-pack to mean that the ref was not even something we tried to
send, and thus it prints "Everything up-to-date". Fortunately it does
detect the eventual non-zero exit from send-pack, and propagates that in
its own non-zero exit code. So at least a careful script invoking "git
push" would notice the failure.  But sending the misleading message on
stderr is certainly confusing for humans (not to mention the
machine-readable "push --porcelain" output, though again, any careful
script should be checking the exit code from push, too).

Nobody seems to have noticed because the server in this instance has to
be misbehaving: it has promised to support the ref-status capability
(otherwise the client will not set EXPECTING_REPORT at all), but didn't
send us any. If the connection were simply cut, then send-pack would
complain about getting EOF while trying to read the status. But if the
server actually sends a flush packet (i.e., saying "now you have all of
the ref statuses" without actually sending any), then the client ends up
in this confused situation.

The fix is simple: we should return an error message from "send-pack
--helper-status", just like we would for any other error per-ref error
condition (in the test I included, the server simply omits all ref
status responses, but a more insidious version of this would skip only
some of them).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/send-pack.c            |  4 ++++
 t/lib-httpd.sh                 |  1 +
 t/lib-httpd/apache.conf        |  4 ++++
 t/lib-httpd/error-no-report.sh |  6 ++++++
 t/t5541-http-push-smart.sh     | 16 ++++++++++++++++
 5 files changed, 31 insertions(+)
 create mode 100644 t/lib-httpd/error-no-report.sh

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 8932142312..69c432ef1a 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -87,6 +87,10 @@ static void print_helper_status(struct ref *ref)
 			break;
 
 		case REF_STATUS_EXPECTING_REPORT:
+			res = "error";
+			msg = "expecting report";
+			break;
+
 		default:
 			continue;
 		}
diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index d2edfa4c50..782891908d 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -131,6 +131,7 @@ prepare_httpd() {
 	cp "$TEST_PATH"/passwd "$HTTPD_ROOT_PATH"
 	install_script incomplete-length-upload-pack-v2-http.sh
 	install_script incomplete-body-upload-pack-v2-http.sh
+	install_script error-no-report.sh
 	install_script broken-smart-http.sh
 	install_script error-smart-http.sh
 	install_script error.sh
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 180a41fe96..497b9b9d92 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -122,6 +122,7 @@ Alias /auth/dumb/ www/auth/dumb/
 </LocationMatch>
 ScriptAlias /smart/incomplete_length/git-upload-pack incomplete-length-upload-pack-v2-http.sh/
 ScriptAlias /smart/incomplete_body/git-upload-pack incomplete-body-upload-pack-v2-http.sh/
+ScriptAlias /smart/no_report/git-receive-pack error-no-report.sh/
 ScriptAliasMatch /error_git_upload_pack/(.*)/git-upload-pack error.sh/
 ScriptAliasMatch /smart_*[^/]*/(.*) ${GIT_EXEC_PATH}/git-http-backend/$1
 ScriptAlias /broken_smart/ broken-smart-http.sh/
@@ -137,6 +138,9 @@ ScriptAliasMatch /one_time_perl/(.*) apply-one-time-perl.sh/$1
 <Files incomplete-body-upload-pack-v2-http.sh>
 	Options ExecCGI
 </Files>
+<Files error-no-report.sh>
+	Options ExecCGI
+</Files>
 <Files broken-smart-http.sh>
 	Options ExecCGI
 </Files>
diff --git a/t/lib-httpd/error-no-report.sh b/t/lib-httpd/error-no-report.sh
new file mode 100644
index 0000000000..39ff75bbc4
--- /dev/null
+++ b/t/lib-httpd/error-no-report.sh
@@ -0,0 +1,6 @@
+echo "Content-Type: application/x-git-receive-pack-result"
+echo
+printf '0013\001000eunpack ok\n'
+printf '0015\002skipping report\n'
+printf '0009\0010000'
+printf '0000'
diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index c024fa2818..9c61dccc24 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -509,4 +509,20 @@ test_expect_success 'colorize errors/hints' '
 	test_i18ngrep ! "^hint: " decoded
 '
 
+test_expect_success 'report error server does not provide ref status' '
+	git init "$HTTPD_DOCUMENT_ROOT_PATH/no_report" &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/no_report" config http.receivepack true &&
+	test_must_fail git push --porcelain \
+		$HTTPD_URL_USER_PASS/smart/no_report \
+		HEAD:refs/tags/will-fail >actual &&
+	test_must_fail git -C "$HTTPD_DOCUMENT_ROOT_PATH/no_report" \
+		rev-parse --verify refs/tags/will-fail &&
+	cat >expect <<-EOF &&
+	To $HTTPD_URL/smart/no_report
+	!	HEAD:refs/tags/will-fail	[remote rejected] (expecting report)
+	Done
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
2.33.1.1223.g80c1dbe6e5

