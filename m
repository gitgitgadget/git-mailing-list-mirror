Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A68DC433B4
	for <git@archiver.kernel.org>; Sun,  2 May 2021 22:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D10E060FEB
	for <git@archiver.kernel.org>; Sun,  2 May 2021 22:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbhEBWWB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 May 2021 18:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbhEBWWB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 May 2021 18:22:01 -0400
X-Greylist: delayed 1662 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 02 May 2021 15:21:09 PDT
Received: from vuizook.err.no (vuizook.err.no [IPv6:2a02:20c8:2640::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271EFC06174A
        for <git@vger.kernel.org>; Sun,  2 May 2021 15:21:09 -0700 (PDT)
Received: from [2400:4160:1877:2b00:fc5f:fa70:7483:1006] (helo=glandium.org)
        by vuizook.err.no with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1ldK1i-0005DT-6p
        for git@vger.kernel.org; Sun, 02 May 2021 21:53:22 +0000
Received: from glandium by goemon.lan with local (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1ldK1c-0007TQ-Qo
        for git@vger.kernel.org; Mon, 03 May 2021 06:53:16 +0900
Date:   Mon, 3 May 2021 06:53:16 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Subject: A couple issues with check-connectivity on fetch
Message-ID: <20210502215316.2y4vaedxn2j5gouc@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

In the context of a remote helper using the `import` capability, or one
using the `fetch` capability but the without `check-connectivity`
capability, a large amount of time may be spent in check_connected() on
fetch, on large repos with a large number of fetched refs that also
happen not to actually add commits.

[A little bit of background: in git-cinnabar, which allows to talk to
Mercurial repositories, tags are fetched from a different remote, so
when one wants to fetch tags, the transport system never calls `import`
because the `list` ended up giving a large list of refs with resolved
sha1s, all of which are already locally available]

The first thing I noticed is that check_connected() is called twice
during the fetch: once from check_exist_and_connected(), and once from
store_updated_refs(). When each call is slow, it makes things doubly so.
I'm not sure why check_connected() is called twice like this.  It seems
it could be an oversight, but I could be missing something.

The second thing is that git-cinnabar uses the `import` capability,
and in that case, the transport layer never tried to use the
`check-connectivity` capability. I'm not sure whether the capability
should be exposed there, or if the checks should be skipped altogether
assuming `import` helpers use `fast-import` (although, technically,
git-cinnabar doesn't use the one provided by git).

But in any case, the `check-connectivity` capability doesn't actually
matter because no `fetch` or `import` even happens: fetch only does a
`list` and uses that result. In this case, it would seem
`check_connected` should be skipped entirely.

Here is a testcase that takes >20s to fetch on my machine (see
instructions at the beginning of the file)
http://glandium.org/files/git-check-connectivity-testcase
(the equivalent takes > 1 minute with git-cinnabar because of the
extra refs for git-cinnabar's metadata ; note the testcase is using
the `fetch` capability)

A workaround is to create temporary refs for those tags. That makes
check_connected()'s git-rev-list work quickly, and the fetch takes < 1s.

I'm ready to send patches to improve the situation, but I wanted some
feedback first about the right things that would need to change.

Thoughts?

Mike
