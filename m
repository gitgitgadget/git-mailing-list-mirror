Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,WEIRD_PORT shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9B281F404
	for <e@80x24.org>; Fri,  7 Sep 2018 23:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725734AbeIHEFZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Sep 2018 00:05:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58384 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725731AbeIHEFZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Sep 2018 00:05:25 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 505EC116517;
        Fri,  7 Sep 2018 19:22:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=l9J5QFvMDPrPCrsORXz7HgDcU
        pQ=; b=Us1zG2efd68plr0wnm6hx4zbiAkot2H0TdYycUhrwTN0OHS5MS4hHsYxx
        Sqw2KqDqRLeTly4zeR9nbwljAYYdlm9COO6icFJ5cddA93iIFo/aipG1DapRBn/T
        CZvEGUYNUg/11kbYmzKV8AFv7nA5eg9J9sapYZdw1KuwGn5AYc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=PKeu0jtg9qgVQnI8UKB
        KJksHEf1t1Wz30oxNhBbb4kTR6XqiwADEAG9EccqcWVXFNOpZ2iaH5Ie+KSCqtd+
        fvyTGDHVUJvV3Pqq5APR+AoKUqLQGBg42L+0enbn1uU6HBDU4/TNrLTtcbgokaFJ
        KQdkDt4Zu/OonP23huOYMKkU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 49B0B116516;
        Fri,  7 Sep 2018 19:22:06 -0400 (EDT)
Received: from morphine.teonanacatl.net (unknown [96.240.145.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CDA5B116515;
        Fri,  7 Sep 2018 19:22:05 -0400 (EDT)
From:   Todd Zullinger <tmz@pobox.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: [PATCH] t5551-http-fetch-smart.sh: sort cookies before comparing
Date:   Fri,  7 Sep 2018 19:22:05 -0400
Message-Id: <20180907232205.31328-1-tmz@pobox.com>
X-Mailer: git-send-email 2.19.0.rc2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Pobox-Relay-ID: D5862506-B2F4-11E8-84A7-BFB3E64BB12D-09356542!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With curl-7.61.1 cookies are sorted by creation-time=C2=B9.  Sort the out=
put
used in the 'cookies stored in http.cookiefile when http.savecookies
set' test before comparing it to the expected cookies.

=C2=B9 https://github.com/curl/curl/commit/e2ef8d6fa ("cookies: support
  creation-time attribute for cookies", 2018-08-28)

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
[Resending with the list in Cc; sorry for spamming you,
Junio, Jeff, and G=C3=A1bor.]

The in-development version of Fedora updated to the recently
released curl-7.61.1 in the past few days.  This isn't
breakage from the 2.19.0 cycle, but if the fix looks good to
everyone it would be nice to include it.  That way other
distributions and users who update git and curl to the most
recent releases won't run into this test failure.

I tested this against Fedora 30 (curl-7.61.1) as well as
previous releases from RHEL/CentOS 6/7 (7.19.7/7.29.0) and
Fedora 27/28/29 (7.55.1/7.59.0/7.61.0).

The verbose output is:

expecting success:
	git config http.cookiefile cookies.txt &&
	git config http.savecookies true &&
	git ls-remote $HTTPD_URL/smart_cookies/repo.git master &&
	tail -3 cookies.txt >cookies_tail.txt &&
	test_cmp expect_cookies.txt cookies_tail.txt
++ git config http.cookiefile cookies.txt
++ git config http.savecookies true
++ git ls-remote http://127.0.0.1:5551/smart_cookies/repo.git master
7ae89caac6c721f16555e981eaeed64abc165c5d	refs/heads/master
263207bb5fbfbefbdf1c9c3fa4ae5d9663323217	refs/namespaces/ns/refs/heads/ma=
ster
++ tail -3 cookies.txt
++ test_cmp expect_cookies.txt cookies_tail.txt
++ diff -u expect_cookies.txt cookies_tail.txt
--- expect_cookies.txt	2018-09-07 07:29:05.231532462 +0000
+++ cookies_tail.txt	2018-09-07 07:29:05.306532366 +0000
@@ -1,3 +1,3 @@

-127.0.0.1	FALSE	/smart_cookies/	FALSE	0	othername	othervalue
 127.0.0.1	FALSE	/smart_cookies/repo.git/info/	FALSE	0	name	value
+127.0.0.1	FALSE	/smart_cookies/	FALSE	0	othername	othervalue
error: last command exited with $?=3D1
not ok 22 - cookies stored in http.cookiefile when http.savecookies set

 t/t5551-http-fetch-smart.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 771f36f9ff..538656bfef 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -215,7 +215,7 @@ test_expect_success 'cookies stored in http.cookiefil=
e when http.savecookies set
 	git config http.cookiefile cookies.txt &&
 	git config http.savecookies true &&
 	git ls-remote $HTTPD_URL/smart_cookies/repo.git master &&
-	tail -3 cookies.txt >cookies_tail.txt &&
+	tail -3 cookies.txt | sort >cookies_tail.txt &&
 	test_cmp expect_cookies.txt cookies_tail.txt
 '
=20
--=20
2.19.0.rc2

