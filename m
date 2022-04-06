Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE6BC433F5
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 19:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiDFTE1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 15:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiDFTCB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 15:02:01 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C96EB7C5D
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 11:12:23 -0700 (PDT)
Received: from Mazikeen (cpe788df74d2cc1-cm788df74d2cc0.cpe.net.cable.rogers.com [72.138.27.250] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 236ICGlp047885
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 6 Apr 2022 14:12:17 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
References: <041601d849a8$1441ce60$3cc56b20$@nexbridge.com> <xmqq35iqyuvb.fsf@gitster.g>
In-Reply-To: <xmqq35iqyuvb.fsf@gitster.g>
Subject: RE: [BUG] git-2.36.0-rc0 - t6200 fails due to library/path issues
Date:   Wed, 6 Apr 2022 14:12:11 -0400
Organization: Nexbridge Inc.
Message-ID: <047101d849e1$d965b420$8c311c60$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQMHCFdoVunvJVf59GBqXQja4LK14QLdLMwoqm7IwLA=
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On April 6, 2022 1:39 PM, Junio C Hamano wrote:
><rsbecker@nexbridge.com> writes:
>
>> t6200 makes assumptions that ssh-keygen to be used is located in
>> /usr/local/bin. This causes problems when we have multiple OpenSSL
>> installations - which we do - 3 of them. Our environment supplies
>> OpenSSL
>> 1.1 in /usr/local-ssl1.1, with a corresponding version of ssh-agent in
>> a different directory. There needs to be a mechanism to override the
>> ssh-keygen so that tests will work in this situation.
>>
>> *** RLD ERROR ***: Unresolved Text Symbol
>> OPENSSL_add_all_algorithms_noconf in file /usr/local/bin/ssh-keygen.
>>
>> *** RLD ERROR ***: Unresolved Text Symbol EVP_MD_CTX_cleanup in file
>> /usr/local/bin/ssh-keygen.
>>
>> *** RLD ERROR ***: Unresolved Text Symbol SSLeay in file
>> /usr/local/bin/ssh-keygen.
>>
>> *** RLD ERROR ***: Unresolved Text Symbol EVP_MD_block_size in file
>> /usr/local/bin/ssh-keygen.
>>
>> *** RLD ERROR ***: Unresolved Text Symbol EVP_MD_CTX_init in file
>> /usr/local/bin/ssh-keygen.
>>
>> I do not know why the test is forcing SSH in /usr/local/bin - it is
>> not something coming from our environment, which has PATH set correctly.
>
>Indeed that is curious, as the only hits to usr/local in t/ is this one:
>
>    $ git grep usr/local t/
>    t/test-lib.sh:test FreeBSD != $uname_s || GIT_UNZIP=${GIT_UNZIP:-
>/usr/local/bin/unzip}

I think it's coming from the NonStop definition in config.mak.uname, but I
need to be able to override the PATH to pick up the correct OpenSSH for the
OpenSSL build. We have 12 different OpenSSL builds at this point and 3
OpenSSH builds - which will likely go to 6 within the year. The complexity
is wacky but needed because we cannot set up a VM for NonStop with the
hardware we have.

