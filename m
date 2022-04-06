Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90110C433EF
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 17:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239252AbiDFRaO convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 6 Apr 2022 13:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239167AbiDFR35 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 13:29:57 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD941CA13F
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 08:32:53 -0700 (PDT)
Received: from Mazikeen (cpe788df74d2cc1-cm788df74d2cc0.cpe.net.cable.rogers.com [72.138.27.250] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 236FWptl040363
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 6 Apr 2022 11:32:52 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "=?UTF-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>
Cc:     <git@vger.kernel.org>
References: <041601d849a8$1441ce60$3cc56b20$@nexbridge.com> <220406.867d82e2sr.gmgdl@evledraar.gmail.com>
In-Reply-To: <220406.867d82e2sr.gmgdl@evledraar.gmail.com>
Subject: RE: [BUG] git-2.36.0-rc0 - t6200 fails due to library/path issues
Date:   Wed, 6 Apr 2022 11:32:46 -0400
Organization: Nexbridge Inc.
Message-ID: <044f01d849cb$93d3a720$bb7af560$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQMHCFdoVunvJVf59GBqXQja4LK14QHJ4iShqnc2/YA=
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On April 6, 2022 9:52 AM, Ævar Arnfjörð Bjarmason wrote:
>On Wed, Apr 06 2022, rsbecker@nexbridge.com wrote:
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
>Is it:
>
>	SANE_TOOL_PATH = /usr/coreutils/bin:/usr/local/bin
>
>In the nonstop section in config.mak.uname along with:
>
>	Makefile:ifdef SANE_TOOL_PATH
>	Makefile:SANE_TOOL_PATH_SQ = $(subst ','\'',$(SANE_TOOL_PATH))
>	Makefile:BROKEN_PATH_FIX = 's|^\#
>@@BROKEN_PATH_FIX@@$$|git_broken_path_fix "$(SANE_TOOL_PATH_SQ)"|'
>	Makefile:PATH := $(SANE_TOOL_PATH):${PATH}
>	Makefile-else
>	Makefile-BROKEN_PATH_FIX = '/^\# @@BROKEN_PATH_FIX@@$$/d'
>	Makefile-endif
>
>?

OIC. Can I change the PATH value when running the tests without changing config.mak.uname?

