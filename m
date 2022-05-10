Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294B5C433F5
	for <git@archiver.kernel.org>; Tue, 10 May 2022 18:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348877AbiEJS0q convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 10 May 2022 14:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348886AbiEJS0p (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 14:26:45 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5287170F16
        for <git@vger.kernel.org>; Tue, 10 May 2022 11:26:43 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.96.21] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 24AIQcCN010781
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 10 May 2022 14:26:38 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Addison Klinke'" <addison@baller.tv>,
        "'Jason Pyeron'" <jpyeron@pdinc.us>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>,
        "'Addison Klinke'" <agk38@case.edu>
References: <CAE9CXuhvqfhARrqz2=oS1=9BF=iNhGbJv7y3HmYs1tddn8ndiQ@mail.gmail.com> <xmqq4k1x8gqj.fsf@gitster.g> <01e601d86492$43bb70b0$cb325210$@pdinc.us> <CAE9CXujPzu3_95pBDVRXKFU_z40j9Y7v5_1y3c+WnFpz1_oY4w@mail.gmail.com>
In-Reply-To: <CAE9CXujPzu3_95pBDVRXKFU_z40j9Y7v5_1y3c+WnFpz1_oY4w@mail.gmail.com>
Subject: RE: [FR] supporting submodules with alternate version control systems (new contributor)
Date:   Tue, 10 May 2022 14:26:33 -0400
Organization: Nexbridge Inc.
Message-ID: <03ca01d8649b$7d6a3310$783e9930$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQMmAUfbvsYWpozP57O9QeLcqWKlogGoVhkBAX3yDo8CHEtlFqpTHZoQ
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On May 10, 2022 1:27 PM, Addison Klinke wrote:
>Thanks for the quick replies
>
>> Junio Hamano: When you bind an external repository (be it stored in
>> Git or
>somebody else's system) as a submodule, each commit in the superproject
>records which exact commit in the submodule is used with the rest of the
>superproject tree.
>
>This should be fine then - at least the data versioning tools I'm familiar with can all
>specify their current commit and checkout by commit hash. Does it matter how
>the hashes are structured/stored internally? For example, I believe Dolt keeps
>them in a MySQL table that connects to Noms under the hood.
>
> > Junio Hamano: not judging "if it is realistic" at this point
>
>What would be the best approach for answering this portion?

Basically, answer the following: Can you implement a command like the cvs2git that can be re-executed on an idempotent (repeatedly with the same result) basis?

If yes, then you can build your own automation to move code into a submodule from your own VCS system into a git repository and the work with the submodule without the git code-base knowing about this.

If you can go the other way, from git to your other VCS system, repeatedly, then you can go back again. This is likely to be much harder as git has a much richer representation model than is typical of VCS systems.

One way may be sufficient for your purposes. Research how cvs2git works and see whether you are able to emulate its functions.

>> Jason Pyeron: The submodule "type" could create an object (hashed and
>> stored) that contains the needed "translation" details
>
>That sounds like an interesting idea. Since I'd like to offload the burden of
>maintaining these translation files to the 3rd party developers, it would be nice if
>they got copied to a standard location (i.e. ~/.gitmodules/translations/tool_x)
>during the 3rd party install.
>Then when a submodule is added with "type = tool_x", git checks that the
>appropriate translation file is available, and if so, copies it into the parent
>repository.
>
>On Tue, May 10, 2022 at 11:20 AM Jason Pyeron <jpyeron@pdinc.us> wrote:
>>
>> > -----Original Message-----
>> > From: Junio C Hamano
>> > Sent: Tuesday, May 10, 2022 1:01 PM
>> > To: Addison Klinke <addison@baller.tv>
>> >
>> > Addison Klinke <addison@baller.tv> writes:
>> >
>> > > Is something along these lines feasible?
>> >
>> > Offhand, I only think of one thing that could make it fundamentally
>> > infeasible.
>> >
>> > When you bind an external repository (be it stored in Git or
>> > somebody else's system) as a submodule, each commit in the
>> > superproject records which exact commit in the submodule is used
>> > with the rest of the superproject tree.  And that is done by
>> > recording the object name of the commit in the submodule.
>> >
>> > What it means for the foreign system that wants to "plug into" a
>> > superproject in Git as a submodule?  It is required to do two
>> > things:
>> >
>> >  * At the time "git commit" is run at the superproject level, the
>> >    foreign system has to be able to say "the version I have to be
>> >    used in the context of this superproject commit is X", with X
>> >    that somehow can be stored in the superproject's tree object
>> >    (which is sized 20-byte for SHA-1 repositories; in SHA-256
>> >    repositories, it is a bit wider).
>> >
>> >  * At the time "git chekcout" is run at the superproject level, the
>> >    superproject will learn the above X (i.e. the version of the
>> >    submodule that goes with the version of the superproject being
>> >    checked out).  The foreign system has to be able to perform a
>> >    "checkout" given that X.
>> >
>> > If a foreign system cannot do the above two, then it fundamentally
>> > would be incapable of participating in such a "superproject and
>> > submodule" relationship.
>>
>> The submodule "type" could create an object (hashed and stored) that contains
>the needed "translation" details. The object would be hashed using SHA1 or
>SHA256 depending on the git config. The format of the object's contents would be
>defined by the submodule's "code".

I would not try to do this inside the git infrastructure. What you may be able to do in my suggestion above, is to restrict how your other VCS system is used and restrict how your team uses git to make the mapping repeatable. This is typical of some environments where there is an SVN repo and a git repo that are mirrored. This does simplify matters particularly if you do not have to modify either system but are building a façade or wrapper around both.

Keep this as simple as possible to meet a minimum viable set of requirements.
--Randal 

