Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80EBC433F5
	for <git@archiver.kernel.org>; Tue, 10 May 2022 20:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbiEJUyS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 16:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbiEJUyR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 16:54:17 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB5C24E000
        for <git@vger.kernel.org>; Tue, 10 May 2022 13:54:16 -0700 (PDT)
Received: from host217-43-165-125.range217-43.btcentralplus.com ([217.43.165.125] helo=[192.168.1.168])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1noWs1-0003wA-F3;
        Tue, 10 May 2022 21:54:14 +0100
Message-ID: <271b6a9a-a5f4-0336-51b8-860ad07f2609@iee.email>
Date:   Tue, 10 May 2022 21:54:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [FR] supporting submodules with alternate version control systems
 (new contributor)
Content-Language: en-US
To:     Jason Pyeron <jpyeron@pdinc.us>,
        'Junio C Hamano' <gitster@pobox.com>,
        'Addison Klinke' <addison@baller.tv>
Cc:     git@vger.kernel.org, 'Addison Klinke' <agk38@case.edu>
References: <CAE9CXuhvqfhARrqz2=oS1=9BF=iNhGbJv7y3HmYs1tddn8ndiQ@mail.gmail.com>
 <xmqq4k1x8gqj.fsf@gitster.g> <01e601d86492$43bb70b0$cb325210$@pdinc.us>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <01e601d86492$43bb70b0$cb325210$@pdinc.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/05/2022 18:20, Jason Pyeron wrote:
>> -----Original Message-----
>> From: Junio C Hamano
>> Sent: Tuesday, May 10, 2022 1:01 PM
>> To: Addison Klinke <addison@baller.tv>
>>
>> Addison Klinke <addison@baller.tv> writes:
>>
>>> Is something along these lines feasible?
>> Offhand, I only think of one thing that could make it fundamentally
>> infeasible.
>>
>> When you bind an external repository (be it stored in Git or
>> somebody else's system) as a submodule, each commit in the
>> superproject records which exact commit in the submodule is used
>> with the rest of the superproject tree.  And that is done by
>> recording the object name of the commit in the submodule.
>>
>> What it means for the foreign system that wants to "plug into" a
>> superproject in Git as a submodule?  It is required to do two
>> things:
>>
>>   * At the time "git commit" is run at the superproject level, the
>>     foreign system has to be able to say "the version I have to be
>>     used in the context of this superproject commit is X", with X
>>     that somehow can be stored in the superproject's tree object
>>     (which is sized 20-byte for SHA-1 repositories; in SHA-256
>>     repositories, it is a bit wider).
>>
>>   * At the time "git chekcout" is run at the superproject level, the
>>     superproject will learn the above X (i.e. the version of the
>>     submodule that goes with the version of the superproject being
>>     checked out).  The foreign system has to be able to perform a
>>     "checkout" given that X.
>>
>> If a foreign system cannot do the above two, then it fundamentally
>> would be incapable of participating in such a "superproject and
>> submodule" relationship.

The sub-modules already have that problem if the user forgets publish 
their sub-module (see notes in the docs ;-).
> The submodule "type" could create an object (hashed and stored) that contains the needed "translation" details. The object would be hashed using SHA1 or SHA256 depending on the git config. The format of the object's contents would be defined by the submodule's "code".
>
Another way of looking at the issue is via a variant of Git-LFS with a 
smudge/clean style filter. I.e. the DataVCS would be treated as a 'file'.

The LFS already uses the .gitattributes to define a 'type', while the 
submodules don't yet have that capability. There is just a single 
special type within a tree object of "sub-module"  being a mode 16000 
commit (see https://longair.net/blog/2010/06/02/git-submodules-explained/).

One thought is that one uses a proper sub-module that within it then has 
the single 'large' file git-lfs style that hosts the hash reference for 
the data VCS 
(https://github.com/git-lfs/git-lfs/blob/main/docs/spec.md). It would be 
the regular sub-modules .gitattributes file that handles the data 
conversion.

It may be converting an X-Y problem into an X-Y-Z solution, or just 
extending the problem.

--
Philip


