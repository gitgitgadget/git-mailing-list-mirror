Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59ADC433EF
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 17:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240248AbiC2RiE convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 29 Mar 2022 13:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240122AbiC2Rhw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 13:37:52 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1436F1DC9A4
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 10:36:07 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 22THa4GM017319
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 29 Mar 2022 13:36:05 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Fabian Stelzer'" <fs@gigacodes.de>
Cc:     <git@vger.kernel.org>
References: <036701d83942$e6963ca0$b3c2b5e0$@nexbridge.com> <20220316162711.wfcavqpg2w4u7fat@fs> <00b801d84383$d85b0490$89110db0$@nexbridge.com> <20220329172555.wzmhplni3w2guvo5@fs>
In-Reply-To: <20220329172555.wzmhplni3w2guvo5@fs>
Subject: RE: [RFE] Signing using SSL
Date:   Tue, 29 Mar 2022 13:35:59 -0400
Organization: Nexbridge Inc.
Message-ID: <00c901d84393$77a67200$66f35600$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEPHGOlDpxeio8Suw6+ThURSydcNAIyUfJAASdJCEwCjsUlFq45qUMQ
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On March 29, 2022 1:26 PM, Fabian Stelzer wrote:
>On 29.03.2022 11:44, rsbecker@nexbridge.com wrote:
>>On March 16, 2022 12:45 PM, I wrote:
>>>On March 16, 2022 12:27 PM, Fabian Stelzer wrote:
>>>>On 16.03.2022 10:34, rsbecker@nexbridge.com wrote:
>>>>>Following up on our IRC discussion on Monday, I have had a request
>>>>>to support signing git commits and tags with SSL certificates
>>>>>instead of SSH/GPG. The organization is heavily invested in SSL
>>>>>infrastructure, so they want to go down that path.
>>>>>
>>>>>The basic technique for doing this is, for example:
>>>>>
>>>>>openssl dgst -sha256 -sign key -out content.sha256 signature.txt
>>>>>-passin passphrase
>>>>>
>>>>>There is a pre-step to compute the sha256, in this example, into a
>>>>>file provided to openssl. We could use openssl to compute the hash also.
>>>>>
>>>>>Verification is a bit different than what SSH or GPG does:
>>>>>
>>>>>openssl dgst -sha256 -verify  <(openssl x509 -in certificate -pubkey
>>>>>-noout) -signature sign.txt.sha256 signature.txt
>>>>>
>>>>>and reports either
>>>>>
>>>>>Verified OK
>>>>>Or
>>>>>Verification Failure
>>>>>
>>>>>It does not look like completion codes are consistently involved.
>>>>>
>>>>>This also does look structurally different than both GPG and SSH and
>>>>>more work to set up. It may be possible to provide wrappers and
>>>>>pretend we are in SSH, but I'm not sure that is the right path to take.
>>>>>
>>>>>Any pointers on how this might be done in existing git
>>>>>infrastructure, or should I look into making this work in code?
>>>>>Sorry to say that the documentation is not that clear on this.
>>>>
>>>>Why not gpgsm? It can deal with x509 certs and is already supported.
>>>>I am using this to do s/mime signing/encryption with an yubikey
>>>>hardware token but static certs/keys should be even simpler. However
>>>>I'm not sure how good this works on other platforms.
>>>>
>>>>Take a look into the GPGSM prereq in t/lib-gpg.sh for a few hints on
>>>>how to set this up.
>>>
>>>Good idea but this is a non-starter. I have a limit of GPG 1.4, which
>>>only has the single legacy object. GPG added a dependency to mmap,
>>>which is not available on any of my platforms. That was one reason we were so
>happy to have SSH support.
>>
>>I have been investigating this capability in more depth. After discussing with
>OpenSSL, explicitly adding SSL signing to git would introduce CVE-2022-0778 into git
>and allow a hostile upstream repo to introduce a deliberately defective key that
>could trigger this CVE unless customers have patched OpenSSL. Given the lack of
>broad-based adoption of the fixes to this point, I am reluctant to pursue this
>capability at this time. (Actually referencing my own advice in Git Rev News 82).
>The impact on git would be looping processes when signatures are evaluated. This
>would break workflows that depend on signed content and have downloaded
>keys with the CVE attributes.
>>
>>Does anyone agree/disagree with me on delaying this?
>>--Randall
>>
>
>Do you actually need SSL Signing so you can verify commits with a single CA key?
>Or do you have all the certs public keys anyway?
>
>I know quite a few setups where every employee is issued an x509 cert (often PIV
>Certs, preferably on a smartcard/token) and a central ldap is available with all
>issued certs. This is usually used for authentication and s/mime.
>
>However this can easily be used with ssh signing as well. I do so myself.  I use my
>own s/mime cert loaded into an ssh-agent (pkcs11 smartcard) to sign commits and
>generate an allowed signers file with all the pubkeys extracted from the certs i get
>from the PKIs ldap server.

I would prefer to use SSH - mostly because I am much more comfortable in that space - but SSH has not been authorized for use at this customer. They are a pure SSL shop with each developer having their own SSL unique cert based on the internal corporate CA (as they explained it). I don't have info at this point on the type of cert they are using. Signing is desired to be done by each developer/operator with their own private cert.

The vulnerability is that if SSL certs are used for signatures and a hostile cert gets in via an SSL path. it can trigger the CVE, according to the OpenSSL team.

