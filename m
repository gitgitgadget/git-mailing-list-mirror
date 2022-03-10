Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B668C4332F
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 18:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245590AbiCJStw convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 10 Mar 2022 13:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245601AbiCJStu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 13:49:50 -0500
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827F74D9C3
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 10:48:48 -0800 (PST)
Received: from Mazikeen (cpe788df74d2cc1-cm788df74d2cc0.cpe.net.cable.rogers.com [72.138.27.250] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 22AImlML032275
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 10 Mar 2022 13:48:47 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Neeraj Singh'" <nksingh85@gmail.com>
Cc:     "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>,
        "'Neeraj K. Singh via GitGitGadget'" <gitgitgadget@gmail.com>,
        "'Git List'" <git@vger.kernel.org>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
        "'Jeff King'" <peff@peff.net>,
        "'Jeff Hostetler'" <jeffhost@microsoft.com>,
        "'Christoph Hellwig'" <hch@lst.de>,
        "'Bagas Sanjaya'" <bagasdotme@gmail.com>,
        "'Elijah Newren'" <newren@gmail.com>,
        "'Neeraj K. Singh'" <neerajsi@microsoft.com>,
        "'Patrick Steinhardt'" <ps@pks.im>,
        "'Junio C Hamano'" <gitster@pobox.com>, "'Eric Wong'" <e@80x24.org>
References: <pull.1076.v8.git.git.1633366667.gitgitgadget@gmail.com> <pull.1076.v9.git.git.1637020263.gitgitgadget@gmail.com> <211116.8635nwr055.gmgdl@evledraar.gmail.com> <CANQDOdcEtOMMOLcHrnTKReRS23PvjOGp58VdpEkV_6iZuSPXaw@mail.gmail.com> <211117.86ee7f8cm4.gmgdl@evledraar.gmail.com> <CANQDOdcKzxM+M7wgxUz831SbpwGWR7gcUC8xLFM14BcCJ+60sA@mail.gmail.com> <211201.864k7sbdjt.gmgdl@evledraar.gmail.com> <220310.86lexilo3d.gmgdl@evledraar.gmail.com> <CANQDOdcJX9bYAJN4_M5-k_Ssg+kK+CVOsanXr+Xnu7B+nzfqSw@mail.gmail.com> <220310.86r179ki38.gmgdl@evledraar.gmail.com> <CANQDOdf1pE+PUv_XqLobGq8Wvan-iH28RhBJFYM-NfxHKBjU+Q@mail.gmail.com> <00ae01d834a9$d443a530$7ccaef90$@nexbridge.com> <CANQDOdeFdTzB6GKEeNPJm0-j0qyD+n8+e=+Qn98PvRg8N5wdEQ@mail.gmail.com>
In-Reply-To: <CANQDOdeFdTzB6GKEeNPJm0-j0qyD+n8+e=+Qn98PvRg8N5wdEQ@mail.gmail.com>
Subject: RE: [PATCH v9 0/9] Implement a batched fsync option for core.fsyncObjectFiles
Date:   Thu, 10 Mar 2022 13:48:41 -0500
Organization: Nexbridge Inc.
Message-ID: <00b501d834af$794cd830$6be68890$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGgIVyljHjFm8+Xd7vU2vU1n+z2ZQKRvucnAxQpxkcB5Wnx4wJZi8f1AnM48H0BjRpn+AFX0GFeAXM2sKsCoVUILQIqGAxUAWO/xr4C0AIy/axboC4A
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On March 10, 2022 1:43 PM, Neeraj Singh wrote:
>On Thu, Mar 10, 2022 at 10:08 AM <rsbecker@nexbridge.com> wrote:
>> While this might not be a surprise, on some platforms fsync is a thread-blocking
>operation. When the OS has kernel threads, fsync can potentially cause multiple
>processes (if implemented that way) to block, particularly where an fd is shared
>across threads (and thus processes), which may end up causing a deadlock. We
>might need to keep an eye out for this type of situation in the future and at least
>try to test for it. I cannot actually see a situation where this would occur in git, but
>that does not mean it is impossible. Food for thought.
>> --Randall
>
>fsync is expected to block the calling thread until the underlying data is durable.
>Unless the OS somehow depends on the git process to make progress before
>fsync can complete, there should be no deadlock, since there would be no cycle in
>the waiting graph.  This could be a problem for FUSE implementations that are
>backed by Git, but they already have to deal with that possiblity today and this
>patch series doesn't change anything.

That assumption is based on a specific threading model. In cooperative user-thread models, fsync is process-blocking. While fsync, by spec is required to block the thread, there are no limitations on blocking everything else. In some systems, an fsync can block the entire file system. Just pointing that out. 

