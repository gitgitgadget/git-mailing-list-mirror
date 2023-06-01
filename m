Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2B6C7EE23
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 10:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbjFAKAc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 06:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbjFAKAV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 06:00:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C67F95
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 03:00:20 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B9F2521980
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 10:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1685613618; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type;
        bh=dtYa3i/WofhCDHV2AMVWq14qXtTSH4QEiyftnrN+iac=;
        b=rk/MzTabbaBMYFVFRHGM718I2qze+ZLR8d2Yh0ccGkauhOEhtedNi2x9busjsWvRtm/Vot
        lyCGlKmHkQIBLZGiYBimE3Yp7/Mh0gelVzTOhgV+bEh6fxHHCc3++hwmnHgFBaDRCLxNdy
        vfKmBWhuw1xo9Bk6QACCz8Y7fmkFMEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1685613618;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type;
        bh=dtYa3i/WofhCDHV2AMVWq14qXtTSH4QEiyftnrN+iac=;
        b=8xaIq8UKcFTHOkvkmIMk6vJnvKm9k9ONhky83Fie4+ZAGVMC2ohchBT9duvv1wVDBdJuBV
        n8mjBVc6ZvmxiSBw==
Received: from hawking.suse.de (unknown [10.168.4.11])
        by relay2.suse.de (Postfix) with ESMTP id AF5C12C141
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 10:00:18 +0000 (UTC)
Received: by hawking.suse.de (Postfix, from userid 17005)
        id A396B4A04EA; Thu,  1 Jun 2023 12:00:18 +0200 (CEST)
From:   Andreas Schwab <schwab@suse.de>
To:     git@vger.kernel.org
Subject: git gc complains about "unable to read $oid" but git fsck finds no
 problems
X-Yow:  Could I have a drug overdose?
Date:   Thu, 01 Jun 2023 12:00:18 +0200
Message-ID: <mvmfs7ba4el.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

$ git count-objects -v -H
count: 2177
size: 17.75 MiB
in-pack: 878690
packs: 46
size-pack: 279.84 MiB
prune-packable: 0
garbage: 0
size-garbage: 0 bytes
$ git gc
Enumerating objects: 866036, done.
Counting objects: 100% (866036/866036), done.
Delta compression using up to 8 threads
Compressing objects: 100% (144924/144924), done.
fatal: unable to read e8524e0483c8e65746888368f77f83d7a955ea87
fatal: failed to run repack

How can I find out where the bad object is referenced to be able to get
rid of it?  It is not part of the regular history, a re-clone of the
remote repository does not fetch it.  git fsck --full --cache prints a
lot of dangling commits, but still does not complain.  The error happens
about half way through writing out the new pack.

The repository is more than 10 years old and in regular use all that
time, including a lot of rebasing.  I have looked through all of the
reflogs, but couldn't find the object there either.  git prune
--expire=now and git reflog expire --all --stale-fix
--expire-unreachable=all didn't help.

Then I used the fresh clone to copy over all heads I know about, like
recreating the branches and replace refs, fetching all reflog entries.
That did not report any problems and git gc does not complain, but it
has about 14800 objects less.

Any ideas?

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
