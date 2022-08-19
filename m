Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C26C28B2B
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 17:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354603AbiHSRc4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 13:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354507AbiHSRcm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 13:32:42 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFB6D0238
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 09:51:24 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id A57363F4148;
        Fri, 19 Aug 2022 12:50:26 -0400 (EDT)
Received: from jeffhost-mbp.local (unknown [IPv6:2600:1014:b1a9:35ad:581:b5cb:d568:560a])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 1C6603F4155;
        Fri, 19 Aug 2022 12:50:24 -0400 (EDT)
Subject: Re: [PATCH] fsmonitor: option to allow fsmonitor to run against
 network-mounted repos
To:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Eric DeCosta <edecosta@mathworks.com>
References: <pull.1326.git.1660855703816.gitgitgadget@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <a63bda82-3dfc-44e0-8ecf-ca340d0a95b4@jeffhostetler.com>
Date:   Fri, 19 Aug 2022 12:50:19 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <pull.1326.git.1660855703816.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.09 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/18/22 4:48 PM, Eric DeCosta via GitGitGadget wrote:
> From: Eric DeCosta <edecosta@mathworks.com>
> 
> Though perhaps not common, there are uses cases where users have large,
> network-mounted repos. Having the ability to run fsmonitor against
> network paths would benefit those users.
> 
> As a first step towards enabling fsmonitor to work against
> network-mounted repos, a configuration option, 'fsmonitor.allowRemote'
> was introduced for Windows. Setting this option to true will override
> the default behavior (erroring-out) when a network-mounted repo is
> detected by fsmonitor. In order for macOS to have parity with Windows,
> the same option is now introduced for macOS.

We might also say that this config option only allows FSMonitor
to TRY to consider using a network-mounted repo.  And that this
ability is considered experimental until sufficient testing can
be completed and we can determine the combinations of
{ client os } x { server os } x { remote access } x { file system type }
that are known to work or not work and we can update the defaults
and the documentation accordingly.

For example, on a MacOS client, we expect the local "fseventsd" service
to send us recursive events on all files and sub directories under the
repo root.  If the server is a Linux machine (which doesn't really do
recursive events), does exporting the FS from the server over NFS or SMB
(or whatever) cause the Linux host to send enough information to the
client machine for fseventsd to synthesize the recursive event stream
locally that FSMonitor expects.  It might.  It might not.  That
combination should be tested (along with a lot of other combinations).

But again, this patch is just about allowing the (informed?) user to
try it and begin testing various combinations.


> 
> The the added wrinkle being that the Unix domain socket (UDS) file
> used for IPC cannot be created in a network location; instead the
> temporary directory is used.

This scares me a bit.  I put the socket in the .git directory
so that we are guaranteed that only one daemon will run on the
repository and that all clients will know where to find that socket
(if it exists).

It looks like you're creating the UDS using a tmp pathname and
writing the pathname to the actual .git/fsmonitor--daemon.ipc FILE.
This adds a layer of indirection and is prone to races.


The act of creating the actual socket is protected by code in
unix-socket.c and unix-stream-server.c to try to safely create
the socket and avoid stepping on another active daemon (who
currently has the server-side of the socket open).

My code also detects dead sockets (where a previous daemon died
and failed to delete the socket).


Additionally, allowing remote access means that the repo could
be used by multiple client machines and/or by the server machine
itself.  Consider the example of two MacOS clients mounting the
remote repo and both wanting to start FSMonitor.  They would
constantly fight to recreate a new local-tmp-based socket and
update your pathname FILE and end up invalidating each other on
each command.


Also, if someone overwrites your new pathname FILE, but doesn't tell
the daemon, the daemon will be orphaned -- still running, but no one
will ever connect to it because the FILE no longer points to it.


There was a suggestion later in this thread about using a SHA-1
or SHA-256 hash of the pathname to avoid the tmp XXXXXX pattern
and just put the socket in $HOME (and omit the need for the new
fsmonitor-daemon.ipc FILE completely).  This might work, but we
need to be careful because a user might have hardlinks or symlinks
locally so there may be more than one unique path to the repo
on the local system.  (It is OK to have more than one daemon
listening to a repo, just less efficient.)


As an interim step, you might try using my original socket code
plus just the config.allowRemote=true change.  And test it on a
mounted repo where you've converted the .git directory to a .git
file and moved contents of the .git directory to somewhere local.
Then the UDS would be created in the local GITDIR instead of on
the remote system.  This won't help any of the sharing cases I
described above, but will let you experiment with getting remote
events.

Jeff



> base-commit: 9bf691b78cf906751e65d65ba0c6ffdcd9a5a12c
> 
