Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90C8EB64DC
	for <git@archiver.kernel.org>; Mon, 17 Jul 2023 11:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjGQLUU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jul 2023 07:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjGQLUT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2023 07:20:19 -0400
Received: from out-31.mta0.migadu.com (out-31.mta0.migadu.com [IPv6:2001:41d0:1004:224b::1f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C667AE48
        for <git@vger.kernel.org>; Mon, 17 Jul 2023 04:20:15 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
        t=1689592813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=o+iv1szw7Io6kUXUpYHyH5o5Uv0D9oewEAeBDI7tOv8=;
        b=SA5LkPEN+AJrg+4jV2NALIgvhzM3ctJ465HZql++IgfK9F6Fr5zq178FxkZGeEqE5z0kTP
        g89YFkEVbPI7acDnHHemW4C7KqzqJqdYW5D8FWsZjiGRmPjzFZocwXqhhjDHGPinMz5TrG
        ErHYwXXy6gfBlBHuvGaqH9awrE/aL5A=
From:   Toon Claes <toon@iotcl.com>
To:     git@vger.kernel.org
Subject: Teach git-fetch(1) to use a quarantine directory
Date:   Mon, 17 Jul 2023 12:48:17 +0200
Message-ID: <87edl6bx7o.fsf@iotcl.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I've been looking into making git-fetch(1) to use a quarantine
directory, but I'm a bit stuck on direction.

I took git-receive-pack(1) as an example how it uses a quarantine
directory. It seems it sets the environment variables
$GIT_OBJECT_DIRECTORY and $GIT_ALTERNATE_OBJECT_DIRECTORIES so the real
object db is used as an alternative, and a temporary is set as the
default. Then a sub-process is spawned to uses these. In case of
git-receive-pack(1), it calls git-unpack-objects(1).

At the moment git-fetch(1) does not spawn any similar subprocess, so if
we want to take the same approach to use the quarantine, we'll need to
split up that command.

But then we run into another problem as well. git-fetch(1) updates
references, and that is something that's not allowed when using a tmp
object directory.

As far as I can tell from the code, fetching packs and updating refs is
heavily intertwined, so I'm not sure this approach is the best way
forward. So a few questions:

1) Does it even make sense to make use git-fetch(1) use a quarantine
   directory?
2) When making git-fetch(1) use a quarantine directory, what is the
   recommended way to achieve this? Is this by calling a subprocess?
   Maybe git-fetch-pack(1)?

--
Toon
