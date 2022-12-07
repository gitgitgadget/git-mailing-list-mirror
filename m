Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7A1C4708E
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 12:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiLGMB0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 07:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiLGMBZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 07:01:25 -0500
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE4B200
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 04:01:23 -0800 (PST)
Received: from 88-110-102-84.dynamic.dsl.as9105.com ([88.110.102.84] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1p2t73-0001uf-7D;
        Wed, 07 Dec 2022 12:01:21 +0000
Message-ID: <aa8a0d4b-961f-cdad-6e67-452ac945ed1e@iee.email>
Date:   Wed, 7 Dec 2022 12:01:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: Git credential store conflicting configuration leads to
 unexpected behavior
Content-Language: en-GB
To:     Gennady Uraltsev <gennady.uraltsev@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <CACH4KQSutGnoyFGP2RmkwQT3yhnEg1RcvedXVSMOVVDAnz_aFg@mail.gmail.com>
 <Y4+/VQly2NKnMrFY@tapette.crustytoothpaste.net>
 <CACH4KQSj64WeqAV3CDkCXc+YW6dr+S2vN_QBj5SwcSP05fM0Eg@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <CACH4KQSj64WeqAV3CDkCXc+YW6dr+S2vN_QBj5SwcSP05fM0Eg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/12/2022 23:53, Gennady Uraltsev wrote:
> Thank you!
>
> This makes sense and the solution is simple. Is this somewhere in the
> documentation (honest question, I am not being a jerk)? I tried my
> best to figure this out before bugging people on the mailinglist.

I think it's all hidden in the docs, but isn't easy to tease out.

The 'override a multi-value config with a leading empty value"
technique, I think, is covered in the general discussions about how
config values are entered and parsed.

A useful question would be to ask, where did, or would, you look to hope
to find this information? If we put the info in the right place,
sufficient folks will read it.

Philip
PS in-line posting preferred.  

>
> Best,
>
> Gennady
>
> --
> Gennady Uraltsev
> <gennady.uraltsev@gmail.com>
> (https://guraltsev.github.io)
>
>
> On Tue, Dec 6, 2022 at 5:16 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
>> On 2022-12-06 at 22:05:22, Gennady Uraltsev wrote:
>>> Hello everyone,
>>>
>>> I have an issue with git credential-store. In my global configuration
>>> dir  (.config/git/config) I had the line
>>>
>>> [credential]
>>> helper = store
>>>
>>> while ini a repository's .git/config while I have
>>>
>>> [credential]
>>> helper = "store --file=./.git/git-credentials"
>>>
>>> to store credentials "locally".
>>>
>>> I thought the latter would overrule the former However what happens is
>>> the following:
>>>
>>> 1) On first run the file repo-local file ./.git/git-credentials gets
>>> created and the credentials are saved there after the user is queried
>>> for a password
>>> 2) On subsequent runs the credentials get recovered from
>>> ./.git/git-credentials and the user is NOT asked for credentials
>>> 2b) **Here is the weird behavior** git ALSO creates the
>>> .git-credentials file in the home directory and saves a copy of
>>> credentials there.
>>>
>>> The behavior 2b leads to exfiltration of passwords to a location a
>>> user might not expect.
>>>
>>> Workaround: Remove the line
>>>
>>> [credential]
>>> helper = store
>>>
>>> in the global config.
>>>
>>> It seems that the global config somehow does not get shadowed by the local one!
>> This behaviour is by design.  The reason is that sometimes the user may
>> have two sets of credential helpers, one for one set of domains, and
>> another for another.  For example, I believe AWS has its own custom
>> credential helper.  Git calls credential helpers until it finds a
>> credential, and then it sends store commands to all of them.  A
>> credential helper which has no credentials for a domain will generally
>> respond with no credentials.
>>
>> If you want to override the credential helpers in the `.git/config`
>> file, you can do so by first writing an empty value, like so:
>>
>> [credential]
>> helper =
>> helper = "store --file=./.git/git-credentials"
>> --
>> brian m. carlson (he/him or they/them)
>> Toronto, Ontario, CA

