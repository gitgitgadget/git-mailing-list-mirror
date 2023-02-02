Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2E3C64EC4
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 04:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjBBE3s (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 23:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjBBE3p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 23:29:45 -0500
X-Greylist: delayed 114 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Feb 2023 20:29:43 PST
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91FF2332D
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 20:29:43 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 66E1916A71A;
        Wed,  1 Feb 2023 23:27:46 -0500 (EST)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=/rnl6fZEzDdAQThE6ZhqOJAYQeYG13Vk02BLVyT
        sT8E=; b=rIIQoMF59UaZ2IPjrvE1g/GI9yPPg84GTel/YTnaPgtYVCAVtyoA/Jf
        9ETs3C6r9TqLV1kpjBp8XGObnKhiqG2Af+jwAkv1Il2TQELtou3UOAHJ/xnXzJBT
        5OsRbeCObLrkwP3PwdVCLzhncNUDCEmyhDNRyPCiymxxPznnxVNE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5E66C16A719;
        Wed,  1 Feb 2023 23:27:46 -0500 (EST)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [108.15.224.39])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CFB8616A718;
        Wed,  1 Feb 2023 23:27:45 -0500 (EST)
        (envelope-from tmz@pobox.com)
Date:   Wed, 1 Feb 2023 23:27:43 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/4] t/lib-httpd ssl fixes
Message-ID: <Y9s7vyHKXP+TQPRm@pobox.com>
References: <Y9pOmR5fOfCHwYpF@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9pOmR5fOfCHwYpF@coredump.intra.peff.net>
X-Pobox-Relay-ID: F1414A44-A2B1-11ED-AEE6-2AEEC5D8090B-09356542!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> While chasing down a possible HTTP/2 problem in our test suite (which
> turns out not to be a Git bug, I think), I tried running the tests with
> LIB_HTTPD_SSL=1, as TLS affects HTTP/2 upgrade.
> 
> Sadly, apache would not start at all with our ssl config. It looks like
> this has probably been broken for many years, depending on your apache
> and openssl versions.
> 
> The final two patches here fix ssl problems I found. The first two
> patches drop support for older apache. This yields some minor cleanups,
> and makes the ssl fixes slightly easier. I've cc'd Todd as the last
> person to express support for Apache 2.2, in 2017. I'm hoping even
> CentOS has moved on by now, but we'll see. :)

Heh.  Fortunately, CentOS 6 has been EOL for a few years.
CentOS 7 has httpd-2.4.6.

I applied these patches and ran builds for CentOS/RHEL 7-9
and Fedora 36-38.  I had not previously run the test suite
with LIB_HTTPD_SSL=1 and I ran into many, many failures.
(154 failures across 12 tests, to be precise.)

None of the failures were due to the httpd config, so the
changes here seem fine. :)

The below diff is what I applied to resolve all but 21
git-svn failures:

Test Summary Report
-------------------
t9118-git-svn-funky-branch-names.sh              (Wstat: 256 (exited 1) Tests: 5 Failed: 4)
  Failed tests:  2-5
  Non-zero exit status: 1
t9115-git-svn-dcommit-funky-renames.sh           (Wstat: 256 (exited 1) Tests: 12 Failed: 11)
  Failed tests:  2-12
  Non-zero exit status: 1
t9120-git-svn-clone-with-percent-escapes.sh      (Wstat: 256 (exited 1) Tests: 8 Failed: 5)
  Failed tests:  2, 5-8
  Non-zero exit status: 1
t9142-git-svn-shallow-clone.sh                   (Wstat: 256 (exited 1) Tests: 2 Failed: 1)
  Failed test:  2
  Non-zero exit status: 1
Files=983, Tests=27522, 353 wallclock secs (11.78 usr  2.61 sys + 935.44 cusr 1358.38 csys = 2308.21 CPU)

I didn't feel like digging into the git-svn code and the
subversion bindings to try and fix those tests.  It's likely
a relatively simple matter to someone who knows them better
than I do, hopefully.

I can clean up this diff if you think it's worthwhile.  It
sounds like it may be quite useful for the http/2 tests, but
maybe LIB_HTTPD_SSL=1 in t5559-http-fetch-smart-http2 is
simpler for now?

-- 8< --
diff --git i/t/lib-git-svn.sh w/t/lib-git-svn.sh
index ea28971e8e..f636bcafe4 100644
--- i/t/lib-git-svn.sh
+++ w/t/lib-git-svn.sh
@@ -67,7 +67,7 @@ svn_cmd () {
 		svn
 		return
 	fi
-	svn "$orig_svncmd" --config-dir "$svnconf" "$@"
+	svn --non-interactive --trust-server-cert "$orig_svncmd" --config-dir "$svnconf" "$@"
 }
 
 maybe_start_httpd () {
diff --git i/t/lib-httpd.sh w/t/lib-httpd.sh
index 608949ea80..a4f787f580 100644
--- i/t/lib-httpd.sh
+++ w/t/lib-httpd.sh
@@ -168,7 +168,7 @@ prepare_httpd() {
 		then
 			HTTPD_PARA="$HTTPD_PARA -DSVN"
 			LIB_HTTPD_SVNPATH="$rawsvnrepo"
-			svnrepo="http://127.0.0.1:$LIB_HTTPD_PORT/"
+			svnrepo="$HTTPD_PROTO://127.0.0.1:$LIB_HTTPD_PORT/"
 			svnrepo="$svnrepo$LIB_HTTPD_SVN"
 			export LIB_HTTPD_SVN LIB_HTTPD_SVNPATH
 		fi
@@ -280,11 +280,11 @@ expect_askpass() {
 		none)
 			;;
 		pass)
-			echo "askpass: Password for 'http://$2@$dest': "
+			echo "askpass: Password for '$HTTPD_PROTO://$2@$dest': "
 			;;
 		both)
-			echo "askpass: Username for 'http://$dest': "
-			echo "askpass: Password for 'http://$2@$dest': "
+			echo "askpass: Username for '$HTTPD_PROTO://$dest': "
+			echo "askpass: Password for '$HTTPD_PROTO://$2@$dest': "
 			;;
 		*)
 			false
diff --git i/t/t5411-proc-receive-hook.sh w/t/t5411-proc-receive-hook.sh
index 92cf52c6d4..c85f4668c4 100755
--- i/t/t5411-proc-receive-hook.sh
+++ w/t/t5411-proc-receive-hook.sh
@@ -63,7 +63,7 @@ run_proc_receive_hook_test() {
 	case $1 in
 	http)
 		PROTOCOL="HTTP protocol"
-		URL_PREFIX="http://.*"
+		URL_PREFIX="$HTTPD_PROTO://.*"
 		;;
 	local)
 		PROTOCOL="builtin protocol"
diff --git i/t/t5541-http-push-smart.sh w/t/t5541-http-push-smart.sh
index fbad2d5ff5..b1f414dfe0 100755
--- i/t/t5541-http-push-smart.sh
+++ w/t/t5541-http-push-smart.sh
@@ -122,9 +122,9 @@ test_expect_success 'setup rejected update hook' '
 
 	cat >exp <<-EOF
 	remote: error: hook declined to update refs/heads/dev2
-	To http://127.0.0.1:$LIB_HTTPD_PORT/smart/test_repo.git
+	To '$HTTPD_PROTO'://127.0.0.1:$LIB_HTTPD_PORT/smart/test_repo.git
 	 ! [remote rejected] dev2 -> dev2 (hook declined)
-	error: failed to push some refs to '\''http://127.0.0.1:$LIB_HTTPD_PORT/smart/test_repo.git'\''
+	error: failed to push some refs to '\'$HTTPD_PROTO'://127.0.0.1:$LIB_HTTPD_PORT/smart/test_repo.git'\''
 	EOF
 '
 
diff --git i/t/t5548-push-porcelain.sh w/t/t5548-push-porcelain.sh
index 6282728eaf..18e47c8a30 100755
--- i/t/t5548-push-porcelain.sh
+++ w/t/t5548-push-porcelain.sh
@@ -84,7 +84,7 @@ run_git_push_porcelain_output_test() {
 	case $1 in
 	http)
 		PROTOCOL="HTTP protocol"
-		URL_PREFIX="http://.*"
+		URL_PREFIX="$HTTPD_PROTO://.*"
 		;;
 	file)
 		PROTOCOL="builtin protocol"
diff --git i/t/t5550-http-fetch-dumb.sh w/t/t5550-http-fetch-dumb.sh
index 8f182a3cbf..070d04cdce 100755
--- i/t/t5550-http-fetch-dumb.sh
+++ w/t/t5550-http-fetch-dumb.sh
@@ -384,7 +384,7 @@ test_expect_success 'remote-http complains cleanly about malformed urls' '
 # learned to handle early remote helper failures more cleanly.
 test_expect_success 'remote-http complains cleanly about empty scheme' '
 	test_must_fail ok=sigpipe git ls-remote \
-		http::${HTTPD_URL#http}/dumb/repo.git 2>stderr &&
+		http::${HTTPD_URL#$HTTPD_PROTO}/dumb/repo.git 2>stderr &&
 	test_i18ngrep "url has no scheme" stderr
 '
 
@@ -454,9 +454,9 @@ test_expect_success 'http-alternates triggers not-from-user protocol check' '
 	echo "$HTTPD_URL/dumb/victim.git/objects" \
 		>"$evil/objects/info/http-alternates" &&
 	test_config_global http.followRedirects true &&
-	test_must_fail git -c protocol.http.allow=user \
+	test_must_fail git -c protocol.'$HTTPD_PROTO'.allow=user \
 		clone $HTTPD_URL/dumb/evil.git evil-user &&
-	git -c protocol.http.allow=always \
+	git -c protocol.'$HTTPD_PROTO'.allow=always \
 		clone $HTTPD_URL/dumb/evil.git evil-user
 '
 
diff --git i/t/t5561-http-backend.sh w/t/t5561-http-backend.sh
index 9c57d84315..b3f5759972 100755
--- i/t/t5561-http-backend.sh
+++ w/t/t5561-http-backend.sh
@@ -15,7 +15,7 @@ fi
 start_httpd
 
 GET() {
-	curl --include "$HTTPD_URL/$SMART/repo.git/$1" >out &&
+	curl --include --insecure "$HTTPD_URL/$SMART/repo.git/$1" >out &&
 	tr '\015' Q <out |
 	sed '
 		s/Q$//
@@ -26,7 +26,7 @@ GET() {
 }
 
 POST() {
-	curl --include --data "$2" \
+	curl --include --insecure --data "$2" \
 	--header "Content-Type: application/x-$1-request" \
 	"$HTTPD_URL/smart/repo.git/$1" >out &&
 	tr '\015' Q <out |
diff --git i/t/t5703-upload-pack-ref-in-want.sh w/t/t5703-upload-pack-ref-in-want.sh
index df74f80061..b365e30eda 100755
--- i/t/t5703-upload-pack-ref-in-want.sh
+++ w/t/t5703-upload-pack-ref-in-want.sh
@@ -450,7 +450,7 @@ test_expect_success 'setup repos for change-while-negotiating test' '
 		# Local repo with many commits (so that negotiation will take
 		# more than 1 request/response pair)
 		rm -rf "$LOCAL_PRISTINE" &&
-		git clone "http://127.0.0.1:$LIB_HTTPD_PORT/smart/repo" "$LOCAL_PRISTINE" &&
+		git clone "$HTTPD_PROTO://127.0.0.1:$LIB_HTTPD_PORT/smart/repo" "$LOCAL_PRISTINE" &&
 		cd "$LOCAL_PRISTINE" &&
 		git checkout -b side &&
 		test_commit_bulk --id=s 33 &&
@@ -462,7 +462,7 @@ test_expect_success 'setup repos for change-while-negotiating test' '
 		test_commit m3 &&
 		git tag -d m2 m3
 	) &&
-	git -C "$LOCAL_PRISTINE" remote set-url origin "http://127.0.0.1:$LIB_HTTPD_PORT/one_time_perl/repo" &&
+	git -C "$LOCAL_PRISTINE" remote set-url origin "$HTTPD_PROTO://127.0.0.1:$LIB_HTTPD_PORT/one_time_perl/repo" &&
 	git -C "$LOCAL_PRISTINE" config protocol.version 2
 '
 
diff --git i/t/t5812-proto-disable-http.sh w/t/t5812-proto-disable-http.sh
index d8da5f58d1..9ee5132276 100755
--- i/t/t5812-proto-disable-http.sh
+++ w/t/t5812-proto-disable-http.sh
@@ -14,7 +14,7 @@ test_expect_success 'create git-accessible repo' '
 	git -C "$bare" config http.receivepack true
 '
 
-test_proto "smart http" http "$HTTPD_URL/smart/repo.git"
+test_proto "smart http" $HTTPD_PROTO "$HTTPD_URL/smart/repo.git"
 
 test_expect_success 'http(s) transport respects GIT_ALLOW_PROTOCOL' '
 	test_must_fail env GIT_ALLOW_PROTOCOL=http:https \
@@ -28,9 +28,9 @@ test_expect_success 'curl limits redirects' '
 '
 
 test_expect_success 'http can be limited to from-user' '
-	git -c protocol.http.allow=user \
+	git -c protocol.'$HTTPD_PROTO'.allow=user \
 		clone "$HTTPD_URL/smart/repo.git" plain.git &&
-	test_must_fail git -c protocol.http.allow=user \
+	test_must_fail git -c protocol.'$HTTPD_PROTO'.allow=user \
 		clone "$HTTPD_URL/smart-redir-perm/repo.git" redir.git
 '
 
-- 8< --

-- 
Todd
