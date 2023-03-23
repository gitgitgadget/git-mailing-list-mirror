Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32582C74A5B
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 20:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjCWUoi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 16:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjCWUog (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 16:44:36 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836B212CC4
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 13:44:28 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 1E6CC20076
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 16:44:27 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1pfRnO-fER-00
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 21:44:26 +0100
Date:   Thu, 23 Mar 2023 21:44:26 +0100
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Subject: Re: limiting git branch --contains
Message-ID: <ZBy6Ku+znv/wuOix@ugly>
References: <ZBygZbz5E6jVNp3y@ugly>
 <xmqqpm8z8dab.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqpm8z8dab.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 23, 2023 at 12:42:52PM -0700, Junio C Hamano wrote:
>Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:
>
>> git branch --contains can be a rather expensive operation in big
>> repositories. as my use case is actually a rather limited search for
>> commits in my local wip branches,...
>
>I can do
>
>    $ git branch --list --contains master \??/\*
>
>to show only the topic branches that forked from/after 'master', and
>replacing 'master' with v2.40.0 or any older point and the output
>starts showing more branches, but the search excludes integration
>branches like 'next' and 'seen'.  Is that what you are after?
>
not really.
the objective is finding the work branch(es) a given sha1 is coming 
from.
the problem isn't that the above doesn't work, only that it is insanely 
expensive - on my old machine it takes half a minute in the linux kernel 
tree.
that's an inevitable effect of trying the branches one after another and 
not being lucky enough to pick the right branch first. at least that's 
what appears to be happening.
this could be optimized by doing a piecewise descend on all branches 
simultaneously (which i presume is what merge-base & co. do), but if the 
commit actually isn't on any local branch at all, we'd still walk to the 
very root commit(s) - which is rather wasteful when we actually know 
that we can cut the walks short.

am i making sense?
