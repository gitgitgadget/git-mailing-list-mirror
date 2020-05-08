Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12115C54E49
	for <git@archiver.kernel.org>; Fri,  8 May 2020 09:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E514A208CA
	for <git@archiver.kernel.org>; Fri,  8 May 2020 09:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i/Ue81zo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgEHJu7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 May 2020 05:50:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46193 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726083AbgEHJu5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 May 2020 05:50:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588931456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SlGBFtePSvOigRWa+jRg8eydrJPsjDLiI33nb9ee2x8=;
        b=i/Ue81zo9dm7+ZVKu7m0uOlMr3+5yuRnLzZ6Ul8DpGqCxSXI5yvvdjMY7xm2tgBjQdaeMb
        PuxIugtJPcxNUL+F4eWT842Ii+PxJMXC1ACUczbRPqcOxTY5J0HZOoGuaRnXGEHx4rVfrv
        aNOYEhlpxMO3UNOLEmowgzklvK65nMI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-eEupif1DO1uhPtTo3IqjMg-1; Fri, 08 May 2020 05:50:54 -0400
X-MC-Unique: eEupif1DO1uhPtTo3IqjMg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68441107ACCA;
        Fri,  8 May 2020 09:50:53 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-114-60.ams2.redhat.com [10.36.114.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B23396E71F;
        Fri,  8 May 2020 09:50:52 +0000 (UTC)
Subject: Re: "--quiet" for git-push does not suppress remote hook output
To:     Jeff King <peff@peff.net>
Cc:     public git mailing list <git@vger.kernel.org>
References: <ba70b25b-906c-0117-2594-c606595c6816@redhat.com>
 <3cb011a9-ce3d-df38-01c6-062062f1c9c2@redhat.com>
 <20200507210210.GB38308@coredump.intra.peff.net>
From:   Laszlo Ersek <lersek@redhat.com>
Message-ID: <a9593a71-e1d0-54cc-d974-7cfb60deafc6@redhat.com>
Date:   Fri, 8 May 2020 11:50:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200507210210.GB38308@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/07/20 23:02, Jeff King wrote:
> On Thu, May 07, 2020 at 02:16:36PM +0200, Laszlo Ersek wrote:
> 
>> On 05/07/20 14:05, Laszlo Ersek wrote:
>>> Hi,
>>>
>>> being a total novice in git internals, it seems like
>>> "builtin/receive-pack.c" (on the server) forwards any receive hook
>>> output with copy_to_sideband() back to git-push (on the client), even if
>>> git-push was invoked with "--quiet".
>>>
>>> And "case 2" in demultiplex_sideband() seems to print that "band" to
>>> stderr (on the client), despite "--quiet".
>>>
>>> Is this intentional? I'd prefer "git push --quiet" to suppress remote
>>> hook output (unless the remote hook fails).
> 
> I think the client has to propagate sideband 2 from the server, since it
> doesn't know whether the messages are informational or errors (and even
> with --quiet, we'd want to show errors).
> 
> There is a "quiet" protocol capability; when you run "git push --quiet"
> on the client, it tells the server to use "quiet", and then it passes
> options to index-pack, etc, to suppress progress. But that never makes
> it to hooks.
> 
>> Or else:
>>
>> would it be the job of the particular receive hooks to observe and obey
>> the "--quiet" option in the GIT_PUSH_OPTION_* environment variables?
> 
> That would work, but push options require the client to send them. We
> should probably be passing knowledge of the "quiet" capability from
> receive-pack down to the hooks, probably via an environment variable
> (but not GIT_PUSH_OPTION_*, because that already has meaning).

Thank you for explaining!
Laszlo

