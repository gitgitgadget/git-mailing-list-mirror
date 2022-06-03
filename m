Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D336C433EF
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 23:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349549AbiFCXGm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 19:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbiFCXGl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 19:06:41 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B584D59BB2
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 16:06:39 -0700 (PDT)
Received: from host-89-242-71-63.as13285.net ([89.242.71.63] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nxGNJ-0005OS-7j;
        Sat, 04 Jun 2022 00:06:38 +0100
Message-ID: <547b245d-bdb2-5833-fe4d-15222ae32b57@iee.email>
Date:   Sat, 4 Jun 2022 00:06:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [FR] supporting submodules with alternate version control systems
 (new contributor)
Content-Language: en-GB
To:     Addison Klinke <addison@baller.tv>
Cc:     Jason Pyeron <jpyeron@pdinc.us>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Addison Klinke <agk38@case.edu>
References: <CAE9CXuhvqfhARrqz2=oS1=9BF=iNhGbJv7y3HmYs1tddn8ndiQ@mail.gmail.com>
 <xmqq4k1x8gqj.fsf@gitster.g> <01e601d86492$43bb70b0$cb325210$@pdinc.us>
 <271b6a9a-a5f4-0336-51b8-860ad07f2609@iee.email>
 <CAE9CXuiTDjbncEzWJpHN5N0CukcmXbhxQJtzDDhuy0er4Se2DA@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <CAE9CXuiTDjbncEzWJpHN5N0CukcmXbhxQJtzDDhuy0er4Se2DA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/06/2022 13:44, Addison Klinke wrote:
>> rsbecker: move code into a submodule from your own VCS system
> into a git repository and the work with the submodule without the git
> code-base knowing about this
>
>> Philip: uses a proper sub-module that within it then has
> the single 'large' file git-lfs style that hosts the hash reference for
> the data VCS
>
> The downside I see with both of these approaches is that translating
> the native data VCS to git (or LFS) negates all the benefits of having
> a VCS purpose-built for data. That's why the majority of data
> versioning tools exist - because git (or LFS) are not ideal for
> handling machine learning datasets

The key aspect is deciding which of the two storage systems (the Data &
the Code) will be the overall lead system that contains the linked
reference to the other storage system to ensure the needed integrity.
That is not really a technical question. Rather its somewhat of a social
discussion (workflows, trust, style of integration, etc).

It maybe that one of the systems does have less long-term integrity, as
has been seen in many versioning systems over the last century (both
manual and computer), but the UI is also important.

IIRC Junio did note that having a suitable API to access the other
storage system (to know its status, etc.) is likely to be core to the
ability to combine the two. It may  be that a top level 'gui' is used
control both systems and ensure synchronisation to hide the complexities
of both systems.

I'm still thinking that the "git-lfs like" style could be the one to
use, but that is very dependant on the API that is available for
capturing the Data state into the git entry that records that state,
whether that is a file (git-lfs like) or a 'sub-module' (directory as
state ) style.  Either way it still need reifying (i.e. coded to make
the abstract concept into a concrete implementation).

Which ever route is chosen, it still sounds to me like a worthwhile
enterprise. It's all still very abstract.
>
> On Tue, May 10, 2022 at 2:54 PM Philip Oakley <philipoakley@iee.email> wrote:
>> On 10/05/2022 18:20, Jason Pyeron wrote:
>>>> -----Original Message-----
>>>> From: Junio C Hamano
>>>> Sent: Tuesday, May 10, 2022 1:01 PM
>>>> To: Addison Klinke <addison@baller.tv>
>>>>
>>>> Addison Klinke <addison@baller.tv> writes:
>>>>
>>>>> Is something along these lines feasible?
>>>> Offhand, I only think of one thing that could make it fundamentally
>>>> infeasible.
>>>>
>>>> When you bind an external repository (be it stored in Git or
>>>> somebody else's system) as a submodule, each commit in the
>>>> superproject records which exact commit in the submodule is used
>>>> with the rest of the superproject tree.  And that is done by
>>>> recording the object name of the commit in the submodule.
>>>>
>>>> What it means for the foreign system that wants to "plug into" a
>>>> superproject in Git as a submodule?  It is required to do two
>>>> things:
>>>>
>>>>   * At the time "git commit" is run at the superproject level, the
>>>>     foreign system has to be able to say "the version I have to be
>>>>     used in the context of this superproject commit is X", with X
>>>>     that somehow can be stored in the superproject's tree object
>>>>     (which is sized 20-byte for SHA-1 repositories; in SHA-256
>>>>     repositories, it is a bit wider).
>>>>
>>>>   * At the time "git chekcout" is run at the superproject level, the
>>>>     superproject will learn the above X (i.e. the version of the
>>>>     submodule that goes with the version of the superproject being
>>>>     checked out).  The foreign system has to be able to perform a
>>>>     "checkout" given that X.
>>>>
>>>> If a foreign system cannot do the above two, then it fundamentally
>>>> would be incapable of participating in such a "superproject and
>>>> submodule" relationship.
>> The sub-modules already have that problem if the user forgets publish
>> their sub-module (see notes in the docs ;-).
>>> The submodule "type" could create an object (hashed and stored) that contains the needed "translation" details. The object would be hashed using SHA1 or SHA256 depending on the git config. The format of the object's contents would be defined by the submodule's "code".
>>>
>> Another way of looking at the issue is via a variant of Git-LFS with a
>> smudge/clean style filter. I.e. the DataVCS would be treated as a 'file'.
>>
>> The LFS already uses the .gitattributes to define a 'type', while the
>> submodules don't yet have that capability. There is just a single
>> special type within a tree object of "sub-module"  being a mode 16000
>> commit (see https://longair.net/blog/2010/06/02/git-submodules-explained/).
>>
>> One thought is that one uses a proper sub-module that within it then has
>> the single 'large' file git-lfs style that hosts the hash reference for
>> the data VCS
>> (https://github.com/git-lfs/git-lfs/blob/main/docs/spec.md). It would be
>> the regular sub-modules .gitattributes file that handles the data
>> conversion.
>>
>> It may be converting an X-Y problem into an X-Y-Z solution, or just
>> extending the problem.
>>
>> --
>> Philip
>>
>>

