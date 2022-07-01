Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27063C43334
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 13:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbiGANck (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 09:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGANcj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 09:32:39 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E2D13CCF
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 06:32:38 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 252AC3F4118;
        Fri,  1 Jul 2022 09:32:38 -0400 (EDT)
Received: from jeffhost-mbp.local (unknown [IPv6:2600:1008:b01c:9358:c6b:4c4:c875:79c4])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id D87B03F40F3;
        Fri,  1 Jul 2022 09:32:37 -0400 (EDT)
Subject: Re: Option to allow fsmonitor to run against repos on network file
 systems
To:     Eric D <eric.decosta@gmail.com>, git@vger.kernel.org
References: <CAMxJVdH+o+H56tJ4UmD8YcsNsLuutiUXpOP=euQbomBe1kLkMw@mail.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <16832f8a-c582-23bb-dda9-b7b2597a42eb@jeffhostetler.com>
Date:   Fri, 1 Jul 2022 09:32:37 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAMxJVdH+o+H56tJ4UmD8YcsNsLuutiUXpOP=euQbomBe1kLkMw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/30/22 1:11 PM, Eric D wrote:
> I can appreciate the concerns expressed here:
> https://github.com/git/git/commit/d989b266c1a7ef47f27cec75e90f3dfefbfa0200
> 
> However, in my environment, our file servers are very capable and have
> the requisite support. It would be great if there was an option to
> override this check and allow fsmonitor to operate against network
> filesystems.

Yeah, I was just being cautious.  I probably should have also added
concerns on the remote system being an actual Windows server or a
non-Windows host running SAMBA.  There were just too many combinations
for me to be comfortable enabling it by default (on the initial
release, at least).

Also, the ReadDirectoryChangesW() API limits the buffer size to 64k
for remote handles (because of protocol limitations), so there _may_
be more of an opportunity for dropped events on very busy remote file
systems.  (I never saw any dropped events in my testing (without
intentionally breaking things), but it is a possible concern, so again,
caution and safety...)  And I do handle dropped events and force a
resync and send the client a "trivial" response (so it must do a regular
scan), so output is still correct, but slower.


Having said all of that, I did do lots of testing and never had an
issue with remote drives actually working correctly, so I think it'd
be fine allow a config setting to optionally allow it.  I just didn't
want to clutter up things in advance if no one actually wanted to
use it on remote file systems.


I think it would be fine to have a "fsmonitor.allowRemote" or
"fsmonitor.allowWindowsRemote" config setting and default them to false
for now.  Or until we learn which combinations of remote mounts are
safe and/or problematic.

Jeff
