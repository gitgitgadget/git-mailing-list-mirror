Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0B4C433EF
	for <git@archiver.kernel.org>; Mon, 16 May 2022 14:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244410AbiEPOiq convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 16 May 2022 10:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbiEPOio (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 10:38:44 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D800A2C120
        for <git@vger.kernel.org>; Mon, 16 May 2022 07:38:42 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.96.21] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 24GEcfhG017321
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 16 May 2022 10:38:41 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Derrick Stolee'" <derrickstolee@github.com>,
        "'Git Mailing List'" <git@vger.kernel.org>,
        "'Junio C Hamano'" <gitster@pobox.com>,
        "'Taylor Blau'" <me@ttaylorr.com>,
        "'Emily Shaffer'" <emilyshaffer@google.com>,
        "'Glen Choo'" <chooglen@google.com>,
        "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>,
        "'Christian Couder'" <christian.couder@gmail.com>
References: <6af83767-576b-75c4-c778-0284344a8fe7@github.com> <daadac3e-d4c2-431f-a0bd-d8734d4424d8@github.com>
In-Reply-To: <daadac3e-d4c2-431f-a0bd-d8734d4424d8@github.com>
Subject: RE: [Discussion] What is Git's Security Boundary?
Date:   Mon, 16 May 2022 10:38:36 -0400
Organization: Nexbridge Inc.
Message-ID: <004d01d86932$a36f95f0$ea4ec1d0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQFUTNuklZy2dEvLMMbYj4IxjUlnXAFs0y7orh5gAVA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On May 16, 2022 10:14 AM, Derrick Stolee wrote:
>On 4/26/2022 1:00 PM, Derrick Stolee wrote:
>> I've been having a few discussions internally and externally with
>> folks about the 2.35.2 release and the safe.directory config value.
>> After stumbling a little with a too-technical proposal, I (along with
>> Taylor) figured out that I was jumping into "solutions" mode without
>> first talking about the problem and agreeing on common language there.
>
>> I'm hoping to start a conversation in this thread about "What is Git's
>> security boundary?" so we can have an established base to work from
>> for future security incidents or protections.
>
>I'm back from a vacation, and haven't seen any response to this message.
>
>I thought this would be an interesting topic that would create a lot of valuable
>discussion, but that has not happened. I have a few ideas of why that could be:
>
>1. It's long, so readers put if off until it fell off the end of their
>   inboxes.
>
>2. The fixes for 2.36.1 have been taking priority.
>
>3. There are no patches, so I should submit code if I want concrete
>   feedback.
>
>4. I'm so off base that it's not even worth replying.
>
>Of course, it could be a combination of these or any number of other things.
>
>I'm sending this email as a hopeful ping that this topic could use some feedback.
>I'm looking forward to your ideas.

Some ramblings, since you asked, and I hope I am not missing the point:

I guess some (me) were waiting for more ideas on what you meant by "Security boundary". In network security, the definition is fairly clear - the line where security needs change, so a firewall, DMZ, etc. When talking about applications, a security boundary would be an area where the concept of a user diverges from the system, so your GitHub logon vs. user ids on the servers where GitHub runs - or perhaps Amazon is a better example.

The line blurs for git because we depend on the underlying user authentication mechanisms of the platform. To do anything in git, you either have to have a legitimate logon to the server where git runs or are coming in anonymously in a read-only (hopefully) fashion. In one view, your boundary expands beyond one system, making the boundary non-traditional.

The "security boundary" line is different for git than what a network security admin would consider as a similar domain. In gits terms (my view anyway), the boundary is functional. Do we want git doing something intended vs. unintended given the structure of the repository. In strict technical terms, the boundary is at fopen() and exec(). Can git access something or do something on a system and if so, should it. Conversely, is git blocked from doing something it should be able to do. This seems like well structured problem except for the introduction of incoming changes that could trigger undesired behaviour either at clone, fetch/merge time, switch or other situations where there is a side impact.

So putting the fopen() boundary into a box, that seems pretty much up to the operating system. I am not 100% sure that the safe.directory situation is required for that - although I have had customers asking for something like that for about 3 years.

There are three areas of ancillary impacts that give me continual concern: clean/smudge, hooks, workflows. Each hits the exec() boundary. Clean/smudge has a well-defined control that is up to the user or system admin to manage. Similarly hooks, although hook import has become a topic lately. The GitHub (and other app) Workflow Actions concept opens up a new area that allows the exec() boundary to be traversed, potentially with undesired side effects. Actions depends on GitHub to provide safety controls, which is outside git's responsibility although git is the transport vector through which potential problems can be introduced. We then get into "trust" and who is trusted across that boundary and is the trust justified. If it were up to me, I would want all of the incoming changes to be signed at least for accountability, but more having some kind of authentication to ensure the trust.

I'm not sure whether this is what you are looking for.

Sincerely,
Randall

