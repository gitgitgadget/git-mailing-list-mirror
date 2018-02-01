Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAFB91F404
	for <e@80x24.org>; Thu,  1 Feb 2018 18:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753387AbeBASt0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 13:49:26 -0500
Received: from siwi.pair.com ([209.68.5.199]:28388 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753294AbeBAStA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 13:49:00 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 15E8A84585;
        Thu,  1 Feb 2018 13:49:00 -0500 (EST)
Received: from [10.160.98.99] (unknown [167.220.148.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id A8CAC84577;
        Thu,  1 Feb 2018 13:48:59 -0500 (EST)
Subject: Re: [PATCH 11/26] serve: introduce git-serve
To:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, stolee@gmail.com, jrnieder@gmail.com
References: <20180103001828.205012-1-bmwill@google.com>
 <20180103001828.205012-12-bmwill@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <d9a15c0a-35f3-8e9c-ddf2-34420ac7555b@jeffhostetler.com>
Date:   Thu, 1 Feb 2018 13:48:59 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180103001828.205012-12-bmwill@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/2/2018 7:18 PM, Brandon Williams wrote:
> Introduce git-serve, the base server for protocol version 2.
> 
> Protocol version 2 is intended to be a replacement for Git's current
> wire protocol.  The intention is that it will be a simpler, less
> wasteful protocol which can evolve over time.
> 
> Protocol version 2 improves upon version 1 by eliminating the initial
> ref advertisement.  In its place a server will export a list of
> capabilities and commands which it supports in a capability
> advertisement.  A client can then request that a particular command be
> executed by providing a number of capabilities and command specific
> parameters.  At the completion of a command, a client can request that
> another command be executed or can terminate the connection by sending a
> flush packet.
> 
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>   .gitignore                              |   1 +
>   Documentation/technical/protocol-v2.txt |  91 ++++++++++++
>   Makefile                                |   2 +
>   builtin.h                               |   1 +
>   builtin/serve.c                         |  30 ++++
>   git.c                                   |   1 +
>   serve.c                                 | 239 ++++++++++++++++++++++++++++++++
>   serve.h                                 |  15 ++
>   8 files changed, 380 insertions(+)
>   create mode 100644 Documentation/technical/protocol-v2.txt
>   create mode 100644 builtin/serve.c
>   create mode 100644 serve.c
>   create mode 100644 serve.h
> 
> diff --git a/.gitignore b/.gitignore
> index 833ef3b0b..2d0450c26 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -140,6 +140,7 @@
>   /git-rm
>   /git-send-email
>   /git-send-pack
> +/git-serve
>   /git-sh-i18n
>   /git-sh-i18n--envsubst
>   /git-sh-setup
> diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
> new file mode 100644
> index 000000000..b87ba3816
> --- /dev/null
> +++ b/Documentation/technical/protocol-v2.txt
> @@ -0,0 +1,91 @@
> + Git Wire Protocol, Version 2
> +==============================
> +
> +This document presents a specification for a version 2 of Git's wire
> +protocol.  Protocol v2 will improve upon v1 in the following ways:
> +
> +  * Instead of multiple service names, multiple commands will be
> +    supported by a single service.
> +  * Easily extendable as capabilities are moved into their own section
> +    of the protocol, no longer being hidden behind a NUL byte and
> +    limited by the size of a pkt-line (as there will be a single
> +    capability per pkt-line).
> +  * Separate out other information hidden behind NUL bytes (e.g. agent
> +    string as a capability and symrefs can be requested using 'ls-refs')
> +  * Reference advertisement will be omitted unless explicitly requested
> +  * ls-refs command to explicitly request some refs
> +
> + Detailed Design
> +=================
> +
> +A client can request to speak protocol v2 by sending `version=2` in the
> +side-channel `GIT_PROTOCOL` in the initial request to the server.
> +
> +In protocol v2 communication is command oriented.  When first contacting a
> +server a list of capabilities will advertised.  Some of these capabilities
> +will be commands which a client can request be executed.  Once a command
> +has completed, a client can reuse the connection and request that other
> +commands be executed.
> +
> + Special Packets
> +-----------------
> +
> +In protocol v2 these special packets will have the following semantics:
> +
> +  * '0000' Flush Packet (flush-pkt) - indicates the end of a message
> +  * '0001' Delimiter Packet (delim-pkt) - separates sections of a message

Previously, a 0001 pkt-line meant that there was 1 byte of data
following, right?  Does this change that and/or prevent 1 byte
packets?  (Not sure if it is likely, but the odd-tail of a packfile
might get sent in a 0001 line, right?)  Or is it that 0001 is only
special during the V2 negotiation stuff, but not during the packfile
transmission?

(I'm not against having this delimiter -- I think it is useful, but
just curious if will cause problems elsewhere.)

Should we also consider increasing the pkt-line limit to 5 hex-digits
while we're at it ?   That would let us have 1MB buffers if that would
help with large packfiles.  Granted, we're throttled by the network,
so it might not matter.  Would it be interesting to have a 5 digit
prefix with parts of the high bits of first digit being flags ?
Or is this too radical of a change?


> +
> + Capability Advertisement
> +--------------------------
> +
> +A server which decides to communicate (based on a request from a client)
> +using protocol version 2, notifies the client by sending a version string
> +in its initial response followed by an advertisement of its capabilities.
> +Each capability is a key with an optional value.  Clients must ignore all
> +unknown keys.  Semantics of unknown values are left to the definition of
> +each key.  Some capabilities will describe commands which can be requested
> +to be executed by the client.
> +
> +    capability-advertisement = protocol-version
> +			       capability-list
> +			       flush-pkt
> +
> +    protocol-version = PKT-LINE("version 2" LF)
> +    capability-list = *capability
> +    capability = PKT-LINE(key[=value] LF)
> +
> +    key = 1*CHAR
> +    value = 1*CHAR
> +    CHAR = 1*(ALPHA / DIGIT / "-" / "_")
> +
> +A client then responds to select the command it wants with any particular
> +capabilities or arguments.  There is then an optional section where the
> +client can provide any command specific parameters or queries.
> +
> +    command-request = command
> +		      capability-list
> +		      (command-args)
> +		      flush-pkt
> +    command = PKT-LINE("command=" key LF)
> +    command-args = delim-pkt
> +		   *arg
> +    arg = 1*CHAR
> +
> +The server will then check to ensure that the client's request is
> +comprised of a valid command as well as valid capabilities which were
> +advertised.  If the request is valid the server will then execute the
> +command.
> +
> +A particular command can last for as many rounds as are required to
> +complete the service (multiple for negotiation during fetch or no
> +additional trips in the case of ls-refs).
> +
> +When finished a client should send an empty request of just a flush-pkt to
> +terminate the connection.
> +
> + Commands in v2
> +~~~~~~~~~~~~~~~~
> +
> +Commands are the core actions that a client wants to perform (fetch, push,
> +etc).  Each command will be provided with a list capabilities and
> +arguments as requested by a client.

