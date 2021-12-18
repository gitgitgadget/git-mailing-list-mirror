Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240D5C433EF
	for <git@archiver.kernel.org>; Sat, 18 Dec 2021 00:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbhLRAtv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 19:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhLRAtu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 19:49:50 -0500
X-Greylist: delayed 2605 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 17 Dec 2021 16:49:48 PST
Received: from mx.mickler.org (mx.mickler.org [IPv6:2a01:4f8:c2c:3e1e::1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5094EC061574
        for <git@vger.kernel.org>; Fri, 17 Dec 2021 16:49:48 -0800 (PST)
Received: from dynamic-2a01-0c22-77df-cffc-366e-72cb-3172-7055.c22.pool.telefonica.de ([2a01:c22:77df:cffc:366e:72cb:3172:7055] helo=monster.mickler.org)
        by mx.mickler.org with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <florian@mickler.org>)
        id 1myNEz-0006aB-Er; Sat, 18 Dec 2021 01:06:21 +0100
Date:   Sat, 18 Dec 2021 01:06:21 +0100
From:   Florian Mickler <florian@mickler.org>
To:     git@vger.kernel.org
Cc:     jqassar@gmail.com
Subject: passing CURLOPT_CERTTYPE to libcurl
Message-ID: <20211218010621.2fdc2b3c@monster.mickler.org>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I recently needed to use a tls client certificate from my companies pki
card (smartcard)  in order to get access to a git repository via https.
The client system I used was set up such that there was a pkcs11 openssl
module that would asks for a pin whenever the certificate was needed. 

While I was able to connect to the git repo via curl with 

	curl -E 'pkcs\:[REDACTED_PART_OF_PKCS_URL]' --key\
	'pkcs:[REDACTED_PART_OF_PKCS_URL]' --cert-type ENG\
	--key-type ENG $URL

I was not able to connect to the host with current git. I could pass
the pkcs urls for key and cert, but openssl expected them to be in "PEM"
encoding. While the certificates on the card where apparently of form
"ENG". 

After a bit of searching, I found a patch[1] for git to pass
the cert-type to libcurl (CURLOPT_SSLKEYTYPE and CURLOPT_SSLCERTTYPE)
from 2013. And sure enough, forward-porting it to current HEAD meant
that I could successfully connect to that host and clone the repo. 

Only the CURLOPT_SSLKEYTYPE and CURLOPT_SSLCERTTYPE are needed in my
case, because the openssl config sets up the pkcs11 module. My
understanding is that the pkcs11 module get's triggered by the
pkcs11:urls for key and cert. It might be this openssl module: 
https://github.com/OpenSC/libp11 

Is there a specific reason, that patch wasn't merged? It would allow
for non-pem ssl certificates to be loaded also (without pkcs11 at all). 

I realize, that the underlying systems could and should set up
everything automagically as soon as i point them to the certificate that
i want to use. But not opening up these CURL Settings from git seems
kind of silly given that today's systems still seem kinda borked and do
not do that.  What harm comes from these two tuning knobs being exposed?

Best regards,
Flo


[1] https://marc.info/?l=git&m=136675822032549&w=2


