Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D24C433ED
	for <git@archiver.kernel.org>; Mon,  3 May 2021 12:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B81BE61185
	for <git@archiver.kernel.org>; Mon,  3 May 2021 12:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbhECMMb convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 3 May 2021 08:12:31 -0400
Received: from mail.ammonit.com ([213.172.126.10]:35414 "EHLO mail.ammonit.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229594AbhECMMa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 08:12:30 -0400
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 May 2021 08:12:30 EDT
Received: from Ex16.Ammonoidea.Ammonit.de (192.168.12.213) by
 Ex16.Ammonoidea.Ammonit.de (192.168.12.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P521) id
 15.1.2176.2; Mon, 3 May 2021 13:56:32 +0200
Received: from Ex16.Ammonoidea.Ammonit.de ([fe80::c134:fd63:d13b:8207]) by
 Ex16.Ammonoidea.Ammonit.de ([fe80::c134:fd63:d13b:8207%12]) with mapi id
 15.01.2176.012; Mon, 3 May 2021 13:56:32 +0200
From:   Daniel Carpenter <dc@ammonit.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: http.sslVersion only specifies minimum TLS version, later versions
 are allowed
Thread-Topic: http.sslVersion only specifies minimum TLS version, later
 versions are allowed
Thread-Index: AQHXQBNc19Bi3sI+yUWZmtIg+syeHw==
Date:   Mon, 3 May 2021 11:56:32 +0000
Message-ID: <8f664b07d1df45bcb6b3f787f42bd046@ammonit.com>
Accept-Language: en-GB, de-DE, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.12.4]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When I run: "GIT_SSL_VERSION=tlsv1.2 GIT_CURL_VERBOSE=T git clone https://github.com/git/git.git"

I see: "SSL connection using TLS1.3 / ECDHE_RSA_AES_128_GCM_SHA256", but I was expecting to see "TLS1.2".

This happens because the "sslversions" array ( https://github.com/git/git/blob/7e391989789db82983665667013a46eabc6fc570/http.c#L58 ) uses "CURL_SSLVERSION_TLSv1_2" which only specifies TLS 1.2 or later ( https://curl.se/libcurl/c/CURLOPT_SSLVERSION.html ).

I think configuring "tlsv1.2" should imply "CURL_SSLVERSION_TLSv1_2 | CURL_SSLVERSION_MAX_TLSv1_2", to force that specific version (and the same for "tlsv1.0", "tlsv1.1", "tlsv1.3").

For background: I noticed this because of this issue with debian buster https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=987188 . The new libcurl backport enables TLS 1.3 support with gnutls, but it doesn't work for certain operations, so buster applications using a backported libcurl need to explicitly disable TLS 1.3 .
