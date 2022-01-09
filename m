Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBCCC433F5
	for <git@archiver.kernel.org>; Sun,  9 Jan 2022 00:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235050AbiAIAzr convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 8 Jan 2022 19:55:47 -0500
Received: from elephants.elehost.com ([216.66.27.132]:44363 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbiAIAzq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jan 2022 19:55:46 -0500
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 2090tjLB067004
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 8 Jan 2022 19:55:45 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Neeraj Singh'" <nksingh85@gmail.com>,
        "'Neeraj K. Singh via GitGitGadget'" <gitgitgadget@gmail.com>
Cc:     "'Git List'" <git@vger.kernel.org>,
        "'Bagas Sanjaya'" <bagasdotme@gmail.com>,
        "'Elijah Newren'" <newren@gmail.com>,
        "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>, "'Patrick Steinhardt'" <ps@pks.im>,
        "'Neeraj K. Singh'" <neerajsi@microsoft.com>
References: <pull.1093.v2.git.1638845211.gitgitgadget@gmail.com> <pull.1093.v3.git.1639011433.gitgitgadget@gmail.com> <CANQDOddJzgyfQHi8hVMPU5iLwyt4GmpGt5qob0ZrjqTax6K0tw@mail.gmail.com>
In-Reply-To: <CANQDOddJzgyfQHi8hVMPU5iLwyt4GmpGt5qob0ZrjqTax6K0tw@mail.gmail.com>
Subject: RE: [PATCH v3 0/4] A design for future-proofing fsync() configuration
Date:   Sat, 8 Jan 2022 19:55:40 -0500
Organization: Nexbridge Inc.
Message-ID: <007001d804f3$a2e573a0$e8b05ae0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQJO8hqKI5TyE0qDZs3QqtbaJDO56QEMlBRvAO2IlrarWrHs4A==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 7, 2022 8:14 PM, Neeraj Singh wrote:
> Hello Everyone,
> I wanted to revive this thread in the new year.
> 
> To summarize the current state of affairs:
> * The current fsync patch series implements two new configuration options:
>        core.fsync = <comma-separate list> -- select which repo components will
> be fsynced
>        core.fsyncMethod = fsync|writeout-only  -- select what form of fsyncing
> will be done
> 
> * This patch series now ignores core.fsyncObjectFiles with a deprecation
> warning pointing the user at core.fsync.
> 
> * There is a follow-on series that will extend the core.fsyncMethod to also
> include a `batch` mode that speeds up bulk operations by avoiding repeated
> disk cache flushes.
> 
> * I developed the current mechanism after Ævar pointed out that the original
> `core.fsyncObjectFiles=batch` change would cause older versions of Git to
> die() when exposed to a new configuration. There were also several fsync
> changes floating around, including Patrick Steinhardts `core.fsyncRefFiles`
> change [1] and Eric Wong's `core.fsync = false` change [2].
> 
> * The biggest sticking points are in [3].  The fundamental disagreement is
> about whether core.fsync should look like:
>       A) core.fsync = objects,commit-graph   [current patch implementation]
>       or
>       B) core.fsync = objects
>           core.fsync = commit-graph    [Ævar's multivalued proposal].
> I prefer sticking with (A) for reasons spelled out in the thread. I'm happy to re-
> litigate this discussion though.
> 
> * There's also a sticking point about whether we should fsync when invoking
> pack-objects against stdout.  I think that mostly reflects a missing comment in
> the code rather than a real disagreement.
> 
> * Now that ew/test-wo-fsync has been integrated, there's some redundancy
> between core.fsync=none and Eric's patch.
> 
> Open questions:
> 1) What format should we use for the core.fsync configuration to select
> individual repo components to sync?
> 2) Are we okay with deprecating core.fsyncObjectFiles in a single release with
> a warning?
> 3) Is it reasonable to expect people adding new persistent files to add and
> document new values of the core.fsync settings?
> 
> Thanks,
> Neeraj
> 
> [1]  https://lore.kernel.org/git/20211030103950.M489266@dcvr/
> [2] https://lore.kernel.org/git/20211028002102.19384-1-e@80x24.org/
> [3]
> https://lore.kernel.org/git/211207.86wnkgo9fv.gmgdl@evledraar.gmail.com/

Neeraj,

Please remember that fsync() is operating system and version specific. You cannot make any assumptions about what is supported and what is not. I have recently had issues with git built on a recent operating system not running on a version from 2020. The proposed patches do not work, as I recall, in a portable manner, so caution is required making this change. You can expect this not to work on some platforms and some versions. Please account for that. Requiring users who are not aware of OS details to configure git to function at all is a bad move, in my view - which has not changed since last time.

Thanks,
Randall

