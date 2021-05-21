Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB0EC47076
	for <git@archiver.kernel.org>; Fri, 21 May 2021 16:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E31F613AF
	for <git@archiver.kernel.org>; Fri, 21 May 2021 16:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234461AbhEUQ0d convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 21 May 2021 12:26:33 -0400
Received: from elephants.elehost.com ([216.66.27.132]:21302 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbhEUQ0c (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 12:26:32 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 14LGP22m081928
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 21 May 2021 12:25:02 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Emily Shaffer'" <emilyshaffer@google.com>
Cc:     <git@vger.kernel.org>,
        "=?iso-8859-1?Q?'=C6var_Arnfj=F6r=F0_Bjarmason'?=" <avarab@gmail.com>,
        "'Junio C Hamano'" <gitster@pobox.com>,
        "'Jeff Hostetler'" <git@jeffhostetler.com>,
        "'Bagas Sanjaya'" <bagasdotme@gmail.com>
References: <20210507002908.1495061-1-emilyshaffer@google.com> <20210520210546.4129620-1-emilyshaffer@google.com> <021601d74dc0$326f6620$974e3260$@nexbridge.com> <YKbvgWpMngx76I5R@google.com> <025401d74e44$25db7140$719253c0$@nexbridge.com>
In-Reply-To: <025401d74e44$25db7140$719253c0$@nexbridge.com>
Subject: RE: [PATCH v2] tr2: log parent process name
Date:   Fri, 21 May 2021 12:24:55 -0400
Message-ID: <027f01d74e5d$d9866e70$8c934b50$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQI1+egxG3zSQittuftsBVx6FuUl5gG/TiO1Aoy/7tAC+0kMaQKZ+2cXqeG8RrA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On May 21, 2021 9:21 AM, I wrote:
>To: 'Emily Shaffer' <emilyshaffer@google.com>
>Cc: git@vger.kernel.org; 'Ævar Arnfjörð Bjarmason' <avarab@gmail.com>; 'Junio C Hamano' <gitster@pobox.com>; 'Jeff Hostetler'
><git@jeffhostetler.com>; 'Bagas Sanjaya' <bagasdotme@gmail.com>
>Subject: RE: [PATCH v2] tr2: log parent process name
>
>On May 20, 2021 7:24 PM, Emily Shaffer wrote:
>>
>>On Thu, May 20, 2021 at 05:36:25PM -0400, Randall S. Becker wrote:
>>>
>>> On May 20, 2021 5:06 PM, Emily Shaffer wrote:
>>> >To: git@vger.kernel.org
>>> >Cc: Emily Shaffer <emilyshaffer@google.com>; Ævar Arnfjörð Bjarmason
>>> ><avarab@gmail.com>; Junio C Hamano <gitster@pobox.com>; Jeff
>>> >Hostetler <git@jeffhostetler.com>; Bagas Sanjaya
>>> ><bagasdotme@gmail.com>
>>> >Subject: [PATCH v2] tr2: log parent process name
>>> >
>>> >It can be useful to tell who invoked Git - was it invoked manually
>>> >by a user via CLI or script? By an IDE?  In some cases - like 'repo'
>>> >tool - we can influence the source code and set the
>>> >GIT_TRACE2_PARENT_SID environment variable from the caller process.
>>> >In
>'repo''s
>>case, that parent SID is manipulated to include the string "repo",
>>which means we can positively identify when Git was invoked by
>'repo'
>>tool.
>>> >However, identifying parents that way requires both that we know
>>> >which tools invoke Git and that we have the ability to modify the
>>> >source code of those tools. It cannot scale to keep up with
>the various
>>IDEs and wrappers which use Git, most of which we don't know about.
>>> >Learning which tools and wrappers invoke Git, and how, would give us
>>> >insight to decide where to improve Git's usability and
>>performance.
>>> >
>>> >Unfortunately, there's no cross-platform reliable way to gather the
>>> >name of the parent process. If procfs is present, we can use that; otherwise we will need to discover the name another way.
>However,
>>the process ID should be sufficient regardless of platform.
>>>
>>> I like this idea, but there are some platforms where this is unlikely
>>> to work. NonStop, in particular, can initiate git - and I
>frequently do -
>>from a non-POSIX environment where process name is entirely different.
>>In fact, it is something like $ABC (always beginning with a
>$,
>>which makes life very difficult for shell scripts and screws up
>>GIT_SSH_COMMAND, but I digress). I'm going to need to plug in
>something
>>very platform-specific to make this work. getppid() always returns 1 in
>>this situation, which is extraordinarily meaningless on the
>platform
>>and does not represent the actual parent.
>>
>>Ok. It sounds like you're saying I should be more conservative in the
>>commit message as well as in the #ifdef scope? Do you think
>this
>>needs a reroll to made the #ifdef more aggressive, or would you rather get to it when you get to it?
>
>I'll get to it pretty quickly once it's rolled in.
>
>>It looks like the change in config.mak.uname won't affect NonStop; I
>>think also the compat/procinfo.c is probably indicative enough
>of "this
>>stuff is for procfs" that it won't look like it *should* work for
>>NonStop, which means that you should still get the stub for 'trace2_collect_process_info()'. But if you think the guards aren't
readable
>enough I can try to move them around a little more.
>
>Guards are fine. There's just a lot more work to do for me. We need to make sure that the rendering of ancestor processes are
generic
>enough not to be just pid_t through any interfaces where this is queried. In NonStop's case, char[25], should be sufficient for the
short
>term, but I would prefer something longer, say char[128] to be safe for the future in which to stick the ancestor. To be completely
unique,
>the ancestor is going to look like \node.$proc:sequence (where node is a 7 character name, proc is a 5 character name, and sequence
is
>currently a long.

Just so we know what's coming, the code snippet to get a parent on NonStop is as follows (roughly):
        pid_t ossParent = getppid();
        if (ossParent == 1) {
                short pHandle[10];
                short pAncestor[10];
                short ancestorLength;
                short error;
                short attributes[] = { 40 }; /* MOM Process */
                short processNameLength;
                char processName[64];

                PROCESSHANDLE_NULLIT_(pHandle);
                PROCESS_GETINFO_(pHandle);
                error = PROCESS_GETINFOLIST_(,,,, pHandle,
                        attributes, (short) sizeof(attributes)/sizeof(attributes[0]),
                        pAncestor, (short) sizeof(pAncestor), &ancestorLength);
                if (error) {
                        printf("Cannot process parent. Error %d\n", error);
                        return;
                }
                PROCESSHANDLE_TO_FILENAME_(pAncestor, processName, (short) sizeof(processName),
                        &processNameLength);
                processName[processNameLength] = '\0';
                printf("GUARDIAN Parent %s\n", processName);
        } else {
                printf("OSS Parent %d\n", ossParent);
        }

Which in the test program generates
GUARDIAN Parent \HPITUG.$:3:1100:583555076

Regards,
Randall

