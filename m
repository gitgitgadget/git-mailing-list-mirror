Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0213C54EAA
	for <git@archiver.kernel.org>; Thu, 26 Jan 2023 21:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbjAZVWd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Jan 2023 16:22:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbjAZVWc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2023 16:22:32 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DC1301B9
        for <git@vger.kernel.org>; Thu, 26 Jan 2023 13:22:29 -0800 (PST)
Received: (qmail 26494 invoked by uid 109); 26 Jan 2023 21:22:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 26 Jan 2023 21:22:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26984 invoked by uid 111); 26 Jan 2023 21:22:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Jan 2023 16:22:28 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 26 Jan 2023 16:22:28 -0500
From:   Jeff King <peff@peff.net>
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v7 08/12] test-http-server: add simple authentication
Message-ID: <Y9LvFMzriAWUsS58@coredump.intra.peff.net>
References: <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
 <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
 <b8d3e81b5534148359c7e92807cf1e2795480ddf.1674252531.git.gitgitgadget@gmail.com>
 <Y9JPslSoEayaCJ3n@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y9JPslSoEayaCJ3n@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 26, 2023 at 05:02:27AM -0500, Jeff King wrote:

> I suspect this could all be done as a CGI wrapping git-http-backend. You
> can influence the HTTP response code by sending:
> 
>    Status: 401 Authorization Required
>    WWW-Authenticate: whatever you want
> 
> And likewise you can see what the client sends by putting something like
> this in apache.conf:
> 
>    SetEnvIf Authorization "(.*)" HTTP_AUTHORIZATION=$1
> 
> and then reading $HTTP_AUTHORIZATION as you like. At that point, it
> feels like a simple shell or perl script could then decide whether to
> return a 401 or not (and if not, then just exec git-http-backend to do
> the rest). And the scripts would be simple enough that you could have
> individual scripts to implement various schemes, rather than
> implementing this configuration scheme. You can control which script is
> run based on the URL; see the way we match /broken_smart/, etc, in
> t/lib-httpd/apache.conf.

And here's a minimally worked-out example of that approach. It's on top
of your patches so I could use your credential-helper infrastructure in
the test, but the intent is that it would replace all of the test-tool
server patches and be rolled into t5556 as appropriate.

---
 t/lib-httpd.sh              |  1 +
 t/lib-httpd/apache.conf     |  6 ++++++
 t/lib-httpd/custom-auth.sh  | 18 ++++++++++++++++
 t/t5563-simple-http-auth.sh | 42 +++++++++++++++++++++++++++++++++++++
 4 files changed, 67 insertions(+)
 create mode 100644 t/lib-httpd/custom-auth.sh
 create mode 100755 t/t5563-simple-http-auth.sh

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 608949ea80..ab255bdbc5 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -137,6 +137,7 @@ prepare_httpd() {
 	install_script error-smart-http.sh
 	install_script error.sh
 	install_script apply-one-time-perl.sh
+	install_script custom-auth.sh
 
 	ln -s "$LIB_HTTPD_MODULE_PATH" "$HTTPD_ROOT_PATH/modules"
 
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 0294739a77..4b2256363f 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -135,6 +135,11 @@ Alias /auth/dumb/ www/auth/dumb/
 	SetEnv GIT_HTTP_EXPORT_ALL
 	SetEnv GIT_PROTOCOL
 </LocationMatch>
+<LocationMatch /custom_auth/>
+	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
+	SetEnv GIT_HTTP_EXPORT_ALL
+	CGIPassAuth on
+</LocationMatch>
 ScriptAlias /smart/incomplete_length/git-upload-pack incomplete-length-upload-pack-v2-http.sh/
 ScriptAlias /smart/incomplete_body/git-upload-pack incomplete-body-upload-pack-v2-http.sh/
 ScriptAlias /smart/no_report/git-receive-pack error-no-report.sh/
@@ -144,6 +149,7 @@ ScriptAlias /broken_smart/ broken-smart-http.sh/
 ScriptAlias /error_smart/ error-smart-http.sh/
 ScriptAlias /error/ error.sh/
 ScriptAliasMatch /one_time_perl/(.*) apply-one-time-perl.sh/$1
+ScriptAliasMatch /custom_auth/(.*) custom-auth.sh/$1
 <Directory ${GIT_EXEC_PATH}>
 	Options FollowSymlinks
 </Directory>
diff --git a/t/lib-httpd/custom-auth.sh b/t/lib-httpd/custom-auth.sh
new file mode 100644
index 0000000000..686895ee8c
--- /dev/null
+++ b/t/lib-httpd/custom-auth.sh
@@ -0,0 +1,18 @@
+#!/bin/sh
+
+# Our acceptable auth here is hard-coded, but we could
+# read it from a file provided by individual tests, etc.
+#
+# base64("alice:secret-passwd")
+USERPASS64=YWxpY2U6c2VjcmV0LXBhc3N3ZA==
+
+case "$HTTP_AUTHORIZATION" in
+"Basic $USERPASS64")
+	exec "$GIT_EXEC_PATH"/git-http-backend
+	;;
+*)
+	echo 'Status: 401 Auth Required'
+	echo 'WWW-Authenticate: Basic realm="whatever"'
+	echo
+	;;
+esac
diff --git a/t/t5563-simple-http-auth.sh b/t/t5563-simple-http-auth.sh
new file mode 100755
index 0000000000..314f9217e6
--- /dev/null
+++ b/t/t5563-simple-http-auth.sh
@@ -0,0 +1,42 @@
+#!/bin/sh
+
+test_description='test http auth header and credential helper interop'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-httpd.sh
+. "$TEST_DIRECTORY"/lib-credential-helper.sh
+
+start_httpd
+
+setup_credential_helper
+
+test_expect_success 'setup repository' '
+	test_commit foo &&
+	git init --bare "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	git push --mirror "$HTTPD_DOCUMENT_ROOT_PATH/repo.git"
+'
+
+test_expect_success 'access using custom auth' '
+	set_credential_reply get <<-EOF &&
+	username=alice
+	password=secret-passwd
+	EOF
+
+	git -c "credential.helper=!\"$CREDENTIAL_HELPER\"" ls-remote \
+		"$HTTPD_URL/custom_auth/repo.git" &&
+
+	expect_credential_query get <<-EOF &&
+	protocol=http
+	host=$HTTPD_DEST
+	wwwauth[]=Basic realm="whatever"
+	EOF
+
+	expect_credential_query store <<-EOF
+	protocol=http
+	host=$HTTPD_DEST
+	username=alice
+	password=secret-passwd
+	EOF
+'
+
+test_done
-- 
2.39.1.738.g5e5f8a2714

