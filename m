Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1839C433FE
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 19:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243188AbiCGTJ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 14:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241168AbiCGTJU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 14:09:20 -0500
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0BA1A824
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 11:08:23 -0800 (PST)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 0E9AD20007;
        Mon,  7 Mar 2022 14:08:20 -0500 (EST)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1nRIiR-FUd-00; Mon, 07 Mar 2022 20:08:19 +0100
Date:   Mon, 7 Mar 2022 20:08:19 +0100
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Erik Cervin Edin <erik@cervined.in>, git@vger.kernel.org
Subject: Re: rewinding interactive rebases
Message-ID: <YiZYI8/jY37hZxxa@ugly>
References: <YhPiqlM81XCjNWpk@ugly>
 <CA+JQ7M-+kq1MTh+DG+HCmXkpsF5Esm_0V=4=2_DS2_ZYdjP2+g@mail.gmail.com>
 <nycvar.QRO.7.76.6.2203071745590.11118@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2203071745590.11118@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 07, 2022 at 05:56:22PM +0100, Johannes Schindelin wrote:
>Problem statement: in the middle of an interactive rebase, the user 
>would like to choose a different rebase target, without having to abort 
>the rebase.
>
it didn't even occur to me to actually change the base (note that my 
script has no --onto option, even though it wouldn't be that hard to 
do). that stems from that fact that i have *really* rarely 
(intentionally) made an interactive rebase without (the equivalent of) 
--keep-base.

for me, it's about noticing that i need to rewrite some earlier commits 
again before going forward.

>The idea here is to generate a todo list (just like a fresh `git rebase 
>-i --onto <commit> <base-commit>` would have done) and _prepend_ it to 
>the current todo list.
>
yeah, that's essentially what the script does.

>To support a nested `git rebase --abort`, we would probably want to insert
>some marker after the newly-generated todo list (maybe a
>specially-formatted comment such as `## END NESTED ##`).
>
in the few weeks i've been using the script so far (with a by now 80+ 
commit series), i'd have found nested abort useful about twice, while 
repeated "flat" rewinds are par for the course. i'm also slightly 
worried that i'd lose track of the stack and throw away too much (though 
strictly speaking that's actually not unique to nesting; it would just 
amplify the problem). my script already inserts a marker in the form of 
"break\n\n", and it gets really weird after several rewinds if i don't 
clean up. to make it less weird (and error-prone), one would have to 
actually start a new todo list, that is, actually throw the rest of the 
old todo list on a stack rather than prepending to it. so basically, 
choose between linear and nested, but don't mix the two.

