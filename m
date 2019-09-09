Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86F511F463
	for <e@80x24.org>; Mon,  9 Sep 2019 22:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391932AbfIIWPD (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Sep 2019 18:15:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:44722 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2391863AbfIIWPD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Sep 2019 18:15:03 -0400
Received: (qmail 23798 invoked by uid 109); 9 Sep 2019 22:15:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 09 Sep 2019 22:15:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14187 invoked by uid 111); 9 Sep 2019 22:16:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Sep 2019 18:16:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Sep 2019 18:15:02 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Sebastian Gniazdowski <sgniazdowski@gmail.com>, git@vger.kernel.org
Subject: Re: [BUG] Password cannot contain hash
Message-ID: <20190909221501.GA31319@sigill.intra.peff.net>
References: <CAKc7PVDT0JXCAW=aON2jXidCgib=SjoUXU6Yh4t+xWB8QW4NPQ@mail.gmail.com>
 <xmqq5zm1i0xv.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5zm1i0xv.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 09, 2019 at 03:01:32PM -0700, Junio C Hamano wrote:

> Sebastian Gniazdowski <sgniazdowski@gmail.com> writes:
> 
> > Hello,
> > if the password contains a hash, then it's impossible to clone a
> > repository, either with https or ssh protocols. I've had to use a
> > `gitg' GUI to clone such a repo.
> 
> Hmph, do you mean that
> 
> 	git clone https://user:password@hosting.site/repository/
> 	git clone ssh://user:password@hosting.site/repository/
> 
> if the "password" has '#' in it?  Do passwords with colon, slash or
> at-sign have the same issue?  Would it help to URI escape the
> problematic characters?
> 
> It is a separate issue to use passwords embedded in the URLs, but
> still, escaping ought to work.

It does need escaped in a URL, or we complain. I wondered if we might be
screwing it up elsewhere in the code, too, but t5550 seems to pass with
the modification below.

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 0d985758c6..a1bc0019c9 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -154,7 +154,7 @@ prepare_httpd() {
 	HTTPD_DEST=127.0.0.1:$LIB_HTTPD_PORT
 	HTTPD_URL=$HTTPD_PROTO://$HTTPD_DEST
 	HTTPD_URL_USER=$HTTPD_PROTO://user%40host@$HTTPD_DEST
-	HTTPD_URL_USER_PASS=$HTTPD_PROTO://user%40host:pass%40host@$HTTPD_DEST
+	HTTPD_URL_USER_PASS=$HTTPD_PROTO://user%40host:a%23hash@$HTTPD_DEST
 
 	if test -n "$LIB_HTTPD_DAV" || test -n "$LIB_HTTPD_SVN"
 	then
diff --git a/t/lib-httpd/passwd b/t/lib-httpd/passwd
index 99a34d6487..636ba5b9eb 100644
--- a/t/lib-httpd/passwd
+++ b/t/lib-httpd/passwd
@@ -1 +1 @@
-user@host:xb4E8pqD81KQs
+user@host:xgK/KkMxjf9xU
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index b811d89cfd..d1b64068e6 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -65,13 +65,13 @@ test_expect_success 'http auth can use user/pass in URL' '
 '
 
 test_expect_success 'http auth can use just user in URL' '
-	set_askpass wrong pass@host &&
+	set_askpass wrong "a#hash" &&
 	git clone "$HTTPD_URL_USER/auth/dumb/repo.git" clone-auth-pass &&
 	expect_askpass pass user@host
 '
 
 test_expect_success 'http auth can request both user and pass' '
-	set_askpass user@host pass@host &&
+	set_askpass user@host "a#hash" &&
 	git clone "$HTTPD_URL/auth/dumb/repo.git" clone-auth-both &&
 	expect_askpass both user@host
 '
@@ -80,7 +80,7 @@ test_expect_success 'http auth respects credential helper config' '
 	test_config_global credential.helper "!f() {
 		cat >/dev/null
 		echo username=user@host
-		echo password=pass@host
+		echo password="a#hash"
 	}; f" &&
 	set_askpass wrong &&
 	git clone "$HTTPD_URL/auth/dumb/repo.git" clone-auth-helper &&
@@ -89,21 +89,21 @@ test_expect_success 'http auth respects credential helper config' '
 
 test_expect_success 'http auth can get username from config' '
 	test_config_global "credential.$HTTPD_URL.username" user@host &&
-	set_askpass wrong pass@host &&
+	set_askpass wrong "a#hash" &&
 	git clone "$HTTPD_URL/auth/dumb/repo.git" clone-auth-user &&
 	expect_askpass pass user@host
 '
 
 test_expect_success 'configured username does not override URL' '
 	test_config_global "credential.$HTTPD_URL.username" wrong &&
-	set_askpass wrong pass@host &&
+	set_askpass wrong "a#hash" &&
 	git clone "$HTTPD_URL_USER/auth/dumb/repo.git" clone-auth-user2 &&
 	expect_askpass pass user@host
 '
 
 test_expect_success 'set up repo with http submodules' '
 	git init super &&
-	set_askpass user@host pass@host &&
+	set_askpass user@host "a#hash" &&
 	(
 		cd super &&
 		git submodule add "$HTTPD_URL/auth/dumb/repo.git" sub &&
@@ -112,21 +112,21 @@ test_expect_success 'set up repo with http submodules' '
 '
 
 test_expect_success 'cmdline credential config passes to submodule via clone' '
-	set_askpass wrong pass@host &&
+	set_askpass wrong "a#hash" &&
 	test_must_fail git clone --recursive super super-clone &&
 	rm -rf super-clone &&
 
-	set_askpass wrong pass@host &&
+	set_askpass wrong "a#hash" &&
 	git -c "credential.$HTTPD_URL.username=user@host" \
 		clone --recursive super super-clone &&
 	expect_askpass pass user@host
 '
 
 test_expect_success 'cmdline credential config passes submodule via fetch' '
-	set_askpass wrong pass@host &&
+	set_askpass wrong "a#hash" &&
 	test_must_fail git -C super-clone fetch --recurse-submodules &&
 
-	set_askpass wrong pass@host &&
+	set_askpass wrong "a#hash" &&
 	git -C super-clone \
 	    -c "credential.$HTTPD_URL.username=user@host" \
 	    fetch --recurse-submodules &&
@@ -140,10 +140,10 @@ test_expect_success 'cmdline credential config passes submodule update' '
 	sha1=$(git rev-parse HEAD) &&
 	git -C super-clone update-index --cacheinfo 160000,$sha1,sub &&
 
-	set_askpass wrong pass@host &&
+	set_askpass wrong "a#hash" &&
 	test_must_fail git -C super-clone submodule update &&
 
-	set_askpass wrong pass@host &&
+	set_askpass wrong "a#hash" &&
 	git -C super-clone \
 	    -c "credential.$HTTPD_URL.username=user@host" \
 	    submodule update &&
