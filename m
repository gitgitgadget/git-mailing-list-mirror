Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAADC433F5
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 20:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbiCYUOa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 16:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiCYUO2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 16:14:28 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E88047387
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 13:12:53 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 8388E3F4135;
        Fri, 25 Mar 2022 16:12:52 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 7B3E93F4117;
        Fri, 25 Mar 2022 16:12:51 -0400 (EDT)
Subject: Re: [PATCH v9 00/30] Builtin FSMonitor Part 2
To:     rsbecker@nexbridge.com,
        'Jeff Hostetler via GitGitGadget' <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     'Bagas Sanjaya' <bagasdotme@gmail.com>,
        =?UTF-8?B?J8OGdmFyIEFybmZqw7Zyw7AgQmphcm1hc29uJw==?= 
        <avarab@gmail.com>, 'Eric Sunshine' <sunshine@sunshineco.com>,
        'Johannes Schindelin' <Johannes.Schindelin@gmx.de>,
        'Tao Klerks' <tao@klerks.biz>,
        'Jeff Hostetler' <jeffhost@microsoft.com>
References: <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com>
 <pull.1041.v9.git.1648231393.gitgitgadget@gmail.com>
 <001701d8407a$d2a29dd0$77e7d970$@nexbridge.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <acfa4815-dd4a-3f35-2586-fa1ec55bca3c@jeffhostetler.com>
Date:   Fri, 25 Mar 2022 16:12:50 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <001701d8407a$d2a29dd0$77e7d970$@nexbridge.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/25/22 3:02 PM, rsbecker@nexbridge.com wrote:
> On March 25, 2022 2:03 PM, Jeff Hostetler wrote:
[...]
> 
> So that we can plan for next time, would you mind giving some thought to what would be required for Linux and whether it makes sense to extend this. No urgency, but I would not mind participating - assuming my $DAYJOB lets me. I have a backlog for git that I need to get done first anyway.
> 
> Kind Regards,
> Randall
> 

A Linux backend would need to:

(1) stub in compat/fsmonitor/fsm-listen-linux.c (see commits
     8/30 and 9/30 in this series).  That gives you enough for
     the builtin/fsmonitor--daemon.c to link with your new
     backend.

(2) populate those 4 routines.

(2a) __ctor() and __dtor() will be called from the main thread
      before and after the listener thread is created.  You can
      do anything you need there to register/deregister a watch
      on the FS.

      See inotify() and/or fanotify().  I haven't looked at those
      routines for a while, so all I can say is google it.

(2b) __stop_async() will be called by "some" thread to request
      that the listener thread stop listening.  This is an async
      request, so just notify the listener thread and return.
      (There is an example of this for Unix in
       compat/simple-ipc/ipc-unix-sockets.c)

(2c) __loop() will be called (once) by the "listener" thread-proc
      to process/service events from the FS until a shutdown event
      is received.  This runs in the body of the "listener" thread.
      It should probably use poll()/select()/whatever on fd's from
      inotify()/fsnotify() *and* whatever you set up in (2b) to
      wait for a shutdown event.

      (There are examples of this wait-loop in the Windows and Mac
      backends, but they have *very* different FS event and wait
      models, so they might not be very helpful here.)

      When you get a "batch" of one or more paths from the FS,
      use the fsmonitor_classify_*() routines to classify or
      discard them and then use fsmonitor_publish() to publish
      newly changed paths to the other threads.

      The core code will handle path de-dup and all locking so
      you don't have to.

It is important that you figure out how to get recursive data
from the FS.  We want to watch the complete worktree.  Windows
and Mac let you register the root directory of the watch and
automatically give me events for anything under it.  IIRC,
inotify() only gave you a single directory and you had to
readdir() and recurse to get fd's to the subdirs.  I haven't
looked to see if fanotify() solves that or not.  So there may
be some fd juggling and tree walking required.  That could/should
all be hidden inside the __ctor() and/or __loop() routines.

(3) stub in compat/fsmonitor/fsm-settings-linux.c (see the
     peers.  This is needed to link.

(4) fill in any platform-specific reasons why you might want
     to reject a worktree.  for example, when they are remote
     (NFS/SMB might support it, but do you trust it....)

(5) stub in compat/fsmonitor/fsm-health-linux.c (see
     fsm-health-*.c in part 3).  That will give you enough
     to link the health thread.

(6) this part is probably optional (at least for now).  we
     can use this if we want to add platform-specific things
     like auto-shutdown after idle.  The mac version is currently
     empty, but the Windows version needs to watch the worktree
     root separately (because the FS watch is limited to what
     is *within* watched directory root).

That should help get you get started.
Let me know if you have questions.

Jeff

