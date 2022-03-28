Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D541BC433EF
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 16:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238970AbiC1Q3q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 12:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238544AbiC1Q3h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 12:29:37 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F13160071
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 09:27:56 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 393103F4118;
        Mon, 28 Mar 2022 12:27:56 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id B64833F4104;
        Mon, 28 Mar 2022 12:27:55 -0400 (EDT)
Subject: Re: [PATCH v9 00/30] Builtin FSMonitor Part 2
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     rsbecker@nexbridge.com,
        'Jeff Hostetler via GitGitGadget' <gitgitgadget@gmail.com>,
        git@vger.kernel.org, 'Bagas Sanjaya' <bagasdotme@gmail.com>,
        'Eric Sunshine' <sunshine@sunshineco.com>,
        'Johannes Schindelin' <Johannes.Schindelin@gmx.de>,
        'Tao Klerks' <tao@klerks.biz>,
        'Jeff Hostetler' <jeffhost@microsoft.com>
References: <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com>
 <pull.1041.v9.git.1648231393.gitgitgadget@gmail.com>
 <001701d8407a$d2a29dd0$77e7d970$@nexbridge.com>
 <acfa4815-dd4a-3f35-2586-fa1ec55bca3c@jeffhostetler.com>
 <220326.86a6ddleos.gmgdl@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <a5db97af-b678-4c32-257f-68117f7d08b3@jeffhostetler.com>
Date:   Mon, 28 Mar 2022 12:27:54 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <220326.86a6ddleos.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/25/22 8:48 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Mar 25 2022, Jeff Hostetler wrote:
> 
>> On 3/25/22 3:02 PM, rsbecker@nexbridge.com wrote:
>>> On March 25, 2022 2:03 PM, Jeff Hostetler wrote:
>> [...]
[...]
> 
> Wouldn't it be much simpler POC in this case to write "watchman
> backend"?  Then we'd both get a Linux backend, and an alternate backend
> for the other platforms to validate their implementation.
> 
> Some past references to that:
> https://lore.kernel.org/git/871r8c73ej.fsf@evledraar.gmail.com/ &
> https://lore.kernel.org/git/87h7lgfchm.fsf@evledraar.gmail.com/
> 

Yes, there are several ways for a client command, such as anyone
who calls read_index/refresh_index, to get FS change data from a
monitoring service.

Let's go thru the options here for the sake of conversation:

(option 1): Use the hook-like mechanism that Ben built in 2017
             to talk to an interlude program, shell script, perl
             script, etc.  That "script" itself then talks to a
             long-running service/daemon, such as Watchman, to get
             the list of changes and relays them back to the client.

     * This "proxy" has to handle protocol format conversions.
     * It may also have to start the service on new repos.
     * And depends upon a third-party service being installed.
     * We are limited to supporting platforms where the third-party
       tool is supported.

(option 2): Replace the hook with builtin client code to talk
             directly to the service and bypass the need for
             the proxy script/executable.

     * Git client code would need client-side IPC to talk to
       an established and running service.  (Similar to the client
       side of Simple-IPC but probably not pkt-line based.)
     * Git client code would now need to handle any protocol
       format conversions.
     * Git client code might also have to start the service.
     * And we'd still be dependent on a third-party service being
       installed.
     * And we are still limited to supporting platforms where
       the third-party tool is supported.
     * So far we've been assuming that that third-party tool is
       "Watchman", but technically, you could have other such
       services available.
       * So you may need multiple implementations of option 2,
         one for each third-party tool.
       * I'm not saying that this is hard, but just yet another
         detail that would have to be encoded in the Git source
         to get this "free" feature.

(option 3): Git implements a daemon to monitor the file system
             directly.

     * Git owns the protocol between client and service.
     * Git owns the backend, so no third-party tools required.
     * Git owns service startup.
     * Unfortunately, we are also responsible for building the
       backends on each platform we want to support.

     * In the future, we could augment the service to be more
       "Git-aware", such as discarding data for ignored files,
       but that is just speculation at this point.


Now, with that context in place:

[1] Nothing prohibits us from having all three options be available
     on a platform.  They should all be able to coexist.

[2] One of my stated goals was to reduce the dependency on
     third-party tools -- especially on platforms that don't have
     a simple package management system.  The point here was to
     make it easier for enterprises to deploy Git to 1k's or 10k's
     of users (and possibly unattended build machines) and make use
     of the feature without *also* having to deploy and track updates
     to yet-another third-party tool or otherwise complicate their ES
     deployment setups.  Only option 3 gets rid of the third-party
     tool requirement.

[3] Option 2 is a valuable suggestion, don't get me wrong.  It can/
     will/should improve performance over option 1 by eliminating an
     extra process creation and the overhead of pumping all of that
     data thru another socket-pair/process and all of the context
     switches that that requires.

[4] Option 2 and option 3 could/should perform relatively equally.
     And if we wanted to deprecate the hook-like interface, doing
     an option 2 implementation would allow us to transition the
     platforms for which I don't currently have a backend.

[5] However, option 2 does not eliminate the need for a third-party
     tool, so it is of limited interest to me at this time.  Yes, it
     would be nice to have it for testing and perf testing purposes
     and comparisons with option 3, but if I have to budget my time,
     I would rather spend my efforts on additional backends.

     I consider the question of doing option 2 and a Linux backend
     as two completely independent topics -- topics that we can
     discuss and/or pursue in parallel if there is interest.

[6] Randall's question was about doing option 3 and I hope that I
     provided helpful information should he or anyone else want to
     pick up that effort before I can.

[7] If you want to start a parallel conversation on option 2, let's
     do that in a new top-level email thread.

Cheers,
Jeff

