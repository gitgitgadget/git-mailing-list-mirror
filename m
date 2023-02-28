Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6673C64EC7
	for <git@archiver.kernel.org>; Tue, 28 Feb 2023 13:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjB1NSb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Feb 2023 08:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjB1NSa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2023 08:18:30 -0500
X-Greylist: delayed 1382 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 28 Feb 2023 05:18:27 PST
Received: from dd36226.kasserver.com (dd36226.kasserver.com [85.13.153.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E92B46C
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 05:18:26 -0800 (PST)
Received: from [192.168.42.163] (2-97-142-46.pool.kielnet.net [46.142.97.2])
        by dd36226.kasserver.com (Postfix) with ESMTPSA id 4274D3C0761
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 13:55:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haller-berlin.de;
        s=kas202302241129; t=1677588921;
        bh=DXLyWF0jmGdXabnU8jwq+gqIs+THR+w1axCN73z/3uw=;
        h=Date:To:From:Subject:From;
        b=Q+kaLjyiGPOu6N/hB4ERQ3nn5aZyoZ9HrNZ/vPNFFwXY5RLLGeDLikQ3LggUhtaCb
         1Fl+FSxK/kHY772wGJ/Z028xL6OmmLjFqrI+c5snbClH/A0wA/ujvhGZpBCpqYdYFC
         ego6VRo4/XuHJWzcjut00wNssqnS4CQ7M6PUMmzHKIvzLPlEHVGGEEDhZd34+92O7c
         7sMaj3jXNM6f2B6fHyycgsDr5Uzd+AO8koPGEkpzjzAfzYMjLfRNlM4wRTG0r1MVrz
         3+NDlw0K+pKRj+f3SxIoEbAJgkFVetD4k4IvRah+7eDW1XnxI6FFYwDqg99vwAU9ss
         FanDVoIkPPTqA==
Message-ID: <961e68d7-5f43-c385-10fa-455b8e2f32d0@haller-berlin.de>
Date:   Tue, 28 Feb 2023 13:55:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Content-Language: de-DE, en-US
To:     git@vger.kernel.org
From:   Stefan Haller <lists@haller-berlin.de>
Subject: When exactly should REBASE_HEAD exist?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: /
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As far as I can tell, REBASE_HEAD always points to the last commit that
was attempted to be applied in a rebase, not matter whether that attempt
was successful or not. In other words, when you break in a rebase with
"edit" or "break", REBASE_HEAD is the same as HEAD (except when you
break before the first commit, in that case REBASE_HEAD is unset).

I wonder whether it would make sense to set REBASE_HEAD only when
applying a patch failed. That seems to be the main use case of it.

The reason why I am asking this is: I'm using lazygit, which, during
interactive rebases, shows a combined view of the real commits that were
already applied, and the remaining commits that are yet to be applied
(it gets these by parsing rebase-merge/git-rebase-todo); something like
this, when I set the 2nd commit to "edit":

  pick   4th commit
  pick   3rd commit
         2nd commit  <-- YOU ARE HERE
         1st commit

This is great, but assuming that the 2nd commit conflicted, currently
the display looks like this:

  pick   4th commit
  pick   3rd commit
         1st commit  <-- YOU ARE HERE

I would like to extend this to also show a "fake entry" for the commit
that conflicted, if there is one. REBASE_HEAD is perfect for this,
except that I need a way to distinguish whether it was applied already
or not.

I currently do that by comparing it against HEAD, and only showing it
when they are different. That doesn't always work though, e.g. when I
amend the current "edit" commit.

Any better suggestions how to work around this?

-Stefan

