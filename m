Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70ECC47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 22:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9405A61351
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 22:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235397AbhFHWld convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 8 Jun 2021 18:41:33 -0400
Received: from elephants.elehost.com ([216.66.27.132]:64264 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235389AbhFHWlX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 18:41:23 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 158MdLaX018617
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 8 Jun 2021 18:39:21 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Emily Shaffer'" <emilyshaffer@google.com>
Cc:     <git@vger.kernel.org>,
        "=?iso-8859-1?Q?'=C6var_Arnfj=F6r=F0_Bjarmason'?=" <avarab@gmail.com>,
        "'Junio C Hamano'" <gitster@pobox.com>,
        "'Jeff Hostetler'" <git@jeffhostetler.com>,
        "'Bagas Sanjaya'" <bagasdotme@gmail.com>
References: <20210608185855.668050-1-emilyshaffer@google.com> <20210608221059.1935021-1-emilyshaffer@google.com> <023201d75cb4$02006d10$06014730$@nexbridge.com> <YL/uNYuADscBJUu2@google.com>
In-Reply-To: <YL/uNYuADscBJUu2@google.com>
Subject: RE: [PATCH v5] tr2: log parent process name
Date:   Tue, 8 Jun 2021 18:39:15 -0400
Message-ID: <023701d75cb7$1ff995a0$5fecc0e0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQMn2S/45U4OltXk+VGGxS3e+IULawGAGyFWAfrn0aQBAcgZ76hF0k6A
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On June 8, 2021 6:25 PM, Emily Shaffer wrote"
>To: Randall S. Becker <rsbecker@nexbridge.com>
>Cc: git@vger.kernel.org; 'Ævar Arnfjörð Bjarmason' <avarab@gmail.com>; 'Junio C Hamano' <gitster@pobox.com>; 'Jeff Hostetler'
><git@jeffhostetler.com>; 'Bagas Sanjaya' <bagasdotme@gmail.com>
>Subject: Re: [PATCH v5] tr2: log parent process name
>
>On Tue, Jun 08, 2021 at 06:16:57PM -0400, Randall S. Becker wrote:
>>
>> On June 8, 2021 6:11 PM, Emily Shaffer wrote:
>> >It can be useful to tell who invoked Git - was it invoked manually by
>> >a user via CLI or script? By an IDE?  In some cases - like 'repo'
>> >tool - we can influence the source code and set the GIT_TRACE2_PARENT_SID environment variable from the caller process. In
'repo''s
>case, that parent SID is manipulated to include the string "repo", which means we can positively identify when Git was invoked by
'repo'
>tool.
>> >However, identifying parents that way requires both that we know
>> >which tools invoke Git and that we have the ability to modify the source code of those tools. It cannot scale to keep up with
the various
>IDEs and wrappers which use Git, most of which we don't know about.
>> >Learning which tools and wrappers invoke Git, and how, would give us insight to decide where to improve Git's usability and
>performance.
>> >
>> >Unfortunately, there's no cross-platform reliable way to gather the
>> >name of the parent process. If procfs is present, we can use that;
>> >otherwise we will need to discover the name another way. However, the process ID should be sufficient to look up the process
name on
>most platforms, so that code may be shareable.
>> >
>> >Git for Windows gathers similar information and logs it as a "data_json"
>> >event. However, since "data_json" has a variable format, it is
>> >difficult to parse effectively in some languages; instead, let's pursue a dedicated "cmd_ancestry" event to record information
about the
>ancestry of the current process and a consistent, parseable way.
>> >
>> >Git for Windows also gathers information about more than one
>> >generation of parent. In Linux further ancestry info can be gathered
>> >with procfs, but it's unwieldy to do so. In the interest of later
>> >moving Git for Windows ancestry logging to the 'cmd_ancestry' event, and in the interest of later adding more ancestry to the
Linux
>implementation - or of adding this functionality to other platforms which have an easier time walking the process tree - let's make
>'cmd_ancestry' accept an array of parentage.
>>
>> We are probably going to have to discuss this one at more length. On
>> NonStop, in some cases, I have access to the program arguments of the
>> parent (rather like ps -ef) in POSIX-land, but not from the other
>> personality. I do have access to the program object name, in both
>> sides, although if someone replaces the object - which is not actually
>> possible for a running program, but a rename is - the object may end
>> up being somewhat meaningless or mangled. My suspicion is that I'm
>> going to have to supply different things for the two personalities,
>> but I'm not sure what as of yet.
>
>I guess I'm having trouble understanding - it sounds like you're describing one process with a graph of ancestry instead of a line.
Does that
>mean we shouldn't be tracing the ancestry the way we are?

It's more like this (g = Guardian, p=Posix, for illustration), for a typical interactive situation coming from the non-POSIX side):

gMonitor -> gAncestor1 -> gAncestor2 -> pAncestor3 (/bin/sh) -> git

And when started from an SSH window:

gMonitor -> gAncestor1 (SSH) -> pAncestor2 (/bin/sh) -> git

I can get the program object name from any of the above, and the pid from a POSIX process, or the name (or cpu and process number)
of a Guardian process. In the case of POSIX, obtaining program arguments may be possible. An ancestor, as with Linux, can have
multiple children in a tree but a child can only have one parent - well, technically one at a time anyway because there are some
funky exceptions where a child can adopt a different parent in Guardian-land. In both cases, I can get the program object file of
the process (like /usr/local/bin/git), but if someone renames git because an install happened during a long-running operation, like
git gc --aggressive, the object may be named something else, like /usr/local/bin/ZZLDAG01, for argument sake).

I'm not sure any of this is really relevant, but describes some of what is possible. It also might be useful to pull out the tty
that the process was running on. That is easy to get if the terminal is still connected. I think that particular bit of information
might be very useful, as well as user information.

-Randall

