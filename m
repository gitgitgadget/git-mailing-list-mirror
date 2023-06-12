Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6310DC7EE2E
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 20:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237206AbjFLU2m convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 12 Jun 2023 16:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjFLU2k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 16:28:40 -0400
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A598F191
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 13:28:39 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 35CKQxYh076312
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 20:26:59 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Douglas R. Reno'" <renodr@linuxfromscratch.org>,
        <git@vger.kernel.org>
References: <3843d97f-0073-e2d4-b98d-5a38c33b25f3@linuxfromscratch.org>
In-Reply-To: <3843d97f-0073-e2d4-b98d-5a38c33b25f3@linuxfromscratch.org>
Subject: RE: Test failures with cURL-8.1.2 (when building git-2.41.0)
Date:   Mon, 12 Jun 2023 16:28:26 -0400
Organization: Nexbridge Inc.
Message-ID: <00b801d99d6c$74670e40$5d352ac0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFYPZ+AVUXU5jHTelGZovZtLvavGrCKXRUg
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Monday, June 12, 2023 12:59 PM, Douglas R. Reno wrote:
>While building git-2.41.0 with curl-8.1.2 installed, I've noticed three test failures.
>They appear to be coming from t5559-http-fetch-smart-http2.sh. Here are the details
>from the tests:
>
>not ok 17 - GIT_TRACE_CURL redacts auth details # #               rm -rf redact-auth
>trace && #               set_askpass user@host pass@host &&
>#               GIT_TRACE_CURL="$(pwd)/trace" git clone --bare
>"$HTTPD_URL/auth/smart/repo.git" redact-auth && #               expect_askpass both
>user@host && # #               # Ensure that there is no "Basic" followed by a base64
>string, but that #               # the auth details are redacted #               ! grep -i
>"Authorization: Basic [0-9a-zA-Z+/]" trace && #               grep -i "Authorization: Basic
><redacted>" trace # not ok 18 - GIT_CURL_VERBOSE redacts auth details #
>#               rm -rf redact-auth trace && #               set_askpass user@host pass@host
>&& #               GIT_CURL_VERBOSE=1 git clone --bare
>"$HTTPD_URL/auth/smart/repo.git" redact-auth 2>trace &&
>#               expect_askpass both user@host && # #               # Ensure that there is no
>"Basic" followed by a base64 string, but that #               # the auth details are
>redacted #               ! grep -i "Authorization: Basic [0-9a-zA-Z+/]" trace &&
>#               grep -i "Authorization: Basic <redacted>" trace #
>
>ok 19 - GIT_TRACE_CURL does not redact auth details if GIT_TRACE_REDACT=0 ok 20
>- disable dumb http on server ok 21 - GIT_SMART_HTTP can disable smart http ok 22
>- invalid Content-Type rejected ok 23 - create namespaced refs ok 24 - smart clone
>respects namespace ok 25 - dumb clone via http-backend respects namespace ok 26 -
>cookies stored in http.cookiefile when http.savecookies set ok 27 - transfer.hiderefs
>works over smart-http ok 28 - create 2,000 tags in the repo ok 29 - clone the 2,000
>tag repo to check OS command line overflow ok 30 - large fetch-pack requests can be
>sent using chunked encoding ok 31 - test allowreachablesha1inwant ok 32 - test
>allowreachablesha1inwant with unreachable ok 33 - test allowanysha1inwant with
>unreachable ok 34 # skip http can handle enormous ref negotiation (missing
>EXPENSIVE) ok 35 - custom http headers ok 36 - using fetch command in remote-curl
>updates refs ok 37 - fetch by SHA-1 without tag following not ok 38 - cookies are
>redacted by default # #               rm -rf clone && #               echo "Set-Cookie: Foo=1"
>>cookies && #               echo "Set-Cookie: Bar=2" >>cookies &&
>#               GIT_TRACE_CURL=true \ #                       git -c
>"http.cookieFile=$(pwd)/cookies" clone \ #                       $HTTPD_URL/smart/repo.git
>clone 2>err && #               grep -i "Cookie:.*Foo=<redacted>" err && #               grep
>-i "Cookie:.*Bar=<redacted>" err && #               ! grep -i "Cookie:.*Foo=1" err &&
>#               ! grep -i "Cookie:.*Bar=2" err #
>
>
>I've done a bit of investigation and found the directory where it's saving the results to,
>"trash directory.t5559-http-fetch-smart-http2".
>After changing to that directory and running 'grep -i "Authorization:
>Basic"' trace, I get:
>
>renodr [ /sources/git-2.41.0/git-2.41.0/t/trash
>directory.t5559-http-fetch-smart-http2 ]$ grep -i "Authorization: Basic"
>trace
>== Info: h2 [authorization: Basic dXNlckBob3N0OnBhc3NAaG9zdA==] => Send header:
>Authorization: Basic dXNlckBob3N0OnBhc3NAaG9zdA== == Info: h2 [authorization:
>Basic dXNlckBob3N0OnBhc3NAaG9zdA==] => Send header: Authorization: Basic
>dXNlckBob3N0OnBhc3NAaG9zdA== == Info: h2 [authorization: Basic
>dXNlckBob3N0OnBhc3NAaG9zdA==] => Send header: Authorization: Basic
>dXNlckBob3N0OnBhc3NAaG9zdA==
>
>Checking the 'err' file where the cookies test was supposed to be looking in results in:
>
>renodr [ /sources/git-2.41.0/git-2.41.0/t/trash
>directory.t5559-http-fetch-smart-http2 ]$ cat err
>fatal: URL
>'https://user%40host:<redacted>@127.0.0.1:5559/auth/smart/repo.git' uses plaintext
>credentials
>
>Please let me know if there's any way that I can help diagnose this further!

Curl, for at least a year (Curl issue #8654), does not support blanks in URLs of any kind. Have you found any of these?

-Randall

