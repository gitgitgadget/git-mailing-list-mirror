Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4557DC433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 21:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2755D60FF0
	for <git@archiver.kernel.org>; Thu, 20 May 2021 21:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhETVh7 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 20 May 2021 17:37:59 -0400
Received: from elephants.elehost.com ([216.66.27.132]:46361 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbhETVh7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 17:37:59 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 14KLaU1k001795
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 20 May 2021 17:36:31 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Emily Shaffer'" <emilyshaffer@google.com>, <git@vger.kernel.org>
Cc:     "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>, "'Junio C Hamano'" <gitster@pobox.com>,
        "'Jeff Hostetler'" <git@jeffhostetler.com>,
        "'Bagas Sanjaya'" <bagasdotme@gmail.com>
References: <20210507002908.1495061-1-emilyshaffer@google.com> <20210520210546.4129620-1-emilyshaffer@google.com>
In-Reply-To: <20210520210546.4129620-1-emilyshaffer@google.com>
Subject: RE: [PATCH v2] tr2: log parent process name
Date:   Thu, 20 May 2021 17:36:25 -0400
Message-ID: <021601d74dc0$326f6620$974e3260$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQG/TiO1DChZ2CQV98iURtxeNF+BXKsc4fLQ
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On May 20, 2021 5:06 PM, Emily Shaffer wrote:
>To: git@vger.kernel.org
>Cc: Emily Shaffer <emilyshaffer@google.com>; Ævar Arnfjörð Bjarmason <avarab@gmail.com>; Junio C Hamano <gitster@pobox.com>;
>Jeff Hostetler <git@jeffhostetler.com>; Bagas Sanjaya <bagasdotme@gmail.com>
>Subject: [PATCH v2] tr2: log parent process name
>
>It can be useful to tell who invoked Git - was it invoked manually by a user via CLI or script? By an IDE?  In some cases - like 'repo' tool -
>we can influence the source code and set the GIT_TRACE2_PARENT_SID environment variable from the caller process. In 'repo''s case,
>that parent SID is manipulated to include the string "repo", which means we can positively identify when Git was invoked by 'repo' tool.
>However, identifying parents that way requires both that we know which tools invoke Git and that we have the ability to modify the source
>code of those tools. It cannot scale to keep up with the various IDEs and wrappers which use Git, most of which we don't know about.
>Learning which tools and wrappers invoke Git, and how, would give us insight to decide where to improve Git's usability and performance.
>
>Unfortunately, there's no cross-platform reliable way to gather the name of the parent process. If procfs is present, we can use that;
>otherwise we will need to discover the name another way. However, the process ID should be sufficient regardless of platform.

I like this idea, but there are some platforms where this is unlikely to work. NonStop, in particular, can initiate git - and I frequently do - from a non-POSIX environment where process name is entirely different. In fact, it is something like $ABC (always beginning with a $, which makes life very difficult for shell scripts and screws up GIT_SSH_COMMAND, but I digress). I'm going to need to plug in something very platform-specific to make this work. getppid() always returns 1 in this situation, which is extraordinarily meaningless on the platform and does not represent the actual parent.

I will try to put the appropriate compat hooks in once this moves into master but I can't promise it will be particularly efficient at this stage.

Regards,
Randall

