Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39560C4741F
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 15:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E58BD2067D
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 15:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgJ3Pyo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 11:54:44 -0400
Received: from siwi.pair.com ([209.68.5.199]:16829 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgJ3Pyn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 11:54:43 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 53D513F4096;
        Fri, 30 Oct 2020 11:54:42 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 2A9D23F4090;
        Fri, 30 Oct 2020 11:54:42 -0400 (EDT)
Subject: Re: [PATCH 00/10] Advertise trace2 SID in protocol capabilities
To:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
References: <cover.1604006121.git.steadmon@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
Message-ID: <4f1a1bab-7ac7-b8dd-acb2-6aeb04be3171@jeffhostetler.com>
Date:   Fri, 30 Oct 2020 11:54:41 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <cover.1604006121.git.steadmon@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/29/20 5:32 PM, Josh Steadmon wrote:
> In order to more easily debug remote operations, it is useful to be able
> to inspect both client-side and server-side traces. This series allows
> clients to record the server's trace2 session ID, and vice versa, by
> advertising the SID in a new "trace2-sid" protocol capability.
> 

Very nice!  This should be very helpful when matching up client and
server commands.


> Two questions in particular for reviewers:
> 
> 1) Is trace2/tr2_sid.h intended to be visible to the rest of the code,
>    or is the trace2/ directory supposed to be opaque implementation
>    detail? If the latter, would it be acceptable to move tr2_sid_get()
>    into trace2.h?

I put all the trace2-private stuff in that sub-directory and gave
everything tr2_ prefixes to hide the details as much as I could
(and as an alternative to the usual tendency of having everything
be static within a massive .c file).

So, yeah, my intent was to make all of it opaque.
So that just trace2.h contains the official API.

Perhaps in trace2.c you could create:

const char *trace2_session_id(void)
{
     return tr2_sid_get();
}


> 
> 2) upload-pack generally takes configuration via flags rather than
>    gitconfig. From offline discussions, it sounds like this is an
>    intentional choice to limit potential vulnerability from malicious
>    configs in local repositories accessed via the file:// URL scheme. Is
>    it reasonable to load the trace2.announceSID option from config files
>    in upload-pack, or should this be changed to a flag?

I don't have the history to comment on this.

One thing to consider is that the SID for a Git process is built up
from the SID of the parent and the unique data for the current process.
So for example, if `git fetch` has SID `<sid1>` and it spawns
`git upload-pack`, the child will have SID `<sid1>/<sid2>` and if that
spawns `git index-pack`, that child will have `<sid1>/<sid2>/<sid3>`.
This is very helpful when tracking down parent/child relationships
and perf hunting.

This SID inheritance is passed via an environment variable to
the child, which extends it and passes the longer version to its
children.

So the value being passed between client and server over the
protocol may look like `<sid1>/<sid2>/<sid3>` rather than just a
single `<sid_x>` term.  For your purposes, do you want or care if
you get the single term or the full SID ?

Also, there's nothing to stop someone from seeding that environment
variable in their shell with some mischief before launching the
top-level Git command.  So the above example might see the SID as
`<mischief>/<sid1>/<sid2>/<sid3>`.  I'm not sure if this could be
abused when inserted into the V0/V1/V2 protocol or your logging
facility.

     $ GIT_TRACE2_EVENT=1 GIT_TRACE2_PARENT_SID=hello git version
     {"event":"version","sid":"hello/20201030T154143.660608Z-H86606a97- 
  P00001d30",...}
     ...

So maybe we want to have a public API to return a pointer to just
the final `<sid_x>` term ?  (Then again, maybe I worry too much.)


Thanks,
Jeff


> 
> 
> 
> Josh Steadmon (10):
>    docs: new capability to advertise trace2 SIDs
>    docs: new trace2.advertiseSID option
>    upload-pack: advertise trace2 SID in v0 capabilities
>    receive-pack: advertise trace2 SID in v0 capabilities
>    serve: advertise trace2 SID in v2 capabilities
>    transport: log received server trace2 SID
>    fetch-pack: advertise trace2 SID in capabilities
>    upload-pack, serve: log received client trace2 SID
>    send-pack: advertise trace2 SID in capabilities
>    receive-pack: log received client trace2 SID
> 
>   Documentation/config/trace2.txt               |  4 +
>   .../technical/protocol-capabilities.txt       | 13 ++-
>   Documentation/technical/protocol-v2.txt       |  9 +++
>   builtin/receive-pack.c                        | 16 ++++
>   fetch-pack.c                                  | 11 +++
>   send-pack.c                                   |  9 +++
>   serve.c                                       | 19 +++++
>   t/t5705-trace2-sid-in-capabilities.sh         | 79 +++++++++++++++++++
>   transport.c                                   | 10 +++
>   upload-pack.c                                 | 23 +++++-
>   10 files changed, 190 insertions(+), 3 deletions(-)
>   create mode 100755 t/t5705-trace2-sid-in-capabilities.sh
> 
