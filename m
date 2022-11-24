Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB032C4332F
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 00:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiKXAmL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Nov 2022 19:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiKXAmJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2022 19:42:09 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0524A6A1E
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 16:42:08 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id mh8-20020a17090b4ac800b0021348e084a0so2239125pjb.8
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 16:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IKnmofc2dGvaYJJ18HVGWIfxw2W644JQl8q6tPttP+U=;
        b=g1lVegWRQbzBuCGhsbMPxpqzhCeY/JXSLRNYo4aF5pyh9lFRi/IuGywdSIk33ufb3C
         ZygfKJhZGQ7OV1PEl4bqowKvO3wccayYal12iVm27jejvs4P3vHpucrOED2lnuOdl8/a
         cDusJ5JqjdfjndB4tTb21dN7OrzdfuCkuZcCPVK2NFiA55sYdq5gpmdSzrOKB+If4QMZ
         eA2WDnxbqd146ZCyf/TDxviJ3lfoDVwhLkmFzP6plzmAdTnyYSx9HH8RhqNKaGxeDUtA
         lgKGYITaNgeLX8DwdNlK8gvSD0WzV9OpmTyV0FX4CLJ0kn5OYDdqx9dkgkaTtq7nQH16
         6Lyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IKnmofc2dGvaYJJ18HVGWIfxw2W644JQl8q6tPttP+U=;
        b=XnUIfEei5faJxNzjRehItO3RzIwwp+ZdLiNo2tj18/7aoJQREnER8UJYIOK+szpghn
         psgxPy2wgzA2gviElBGOP9FbUujos1tW0cahH5sD5D6KHEP4aAlNZXL2DQ1GETeziZ7g
         ENydeP5peN8whxr0d1F3ktRiO2eiyO4MmCVUHijpCf67ShArhX1yJMBJV+okL089PG1J
         vDpIHKnWAuqBgZ4Tqh/AdPtND5VGmSUsVUo1PeHQIWJwRP7ZEA5M6hhSs7yQJueFAb/3
         MoA6WdnOS3G0kLgmYXwBryobnSiNtf4vd2Fd4GU6tDs8XG7TF9mmIiIrMvHXlwxEaDbJ
         ESKA==
X-Gm-Message-State: ANoB5pmTZrZrVOHC8jyh/WWzQyBxWb5WWFsCKW2K7pjX1QuC8f4dkewO
        fsW7NwSked/vZRoZrIrrHGs7h1QEgJlDHTui/4r6N91S5XgaLPWUcIV/17YEcvnKe5NsKTrnUfA
        3TkR07xUjCw1XwU+W5+VYzSO3/EpgVnXX4+wbQYtA/F+7+EGtPQgBX7yeyK3HZFm/CwtHcEGXDm
        np
X-Google-Smtp-Source: AA0mqf4ct5+5OVaT3dQ8FVpmqGrsXGT2JALNNV+EKDSaqq9A1aP+YDtQK7e3rpOG7yMWVcXcmGpmlANBNh6VRuB5KNOT
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:bb84:b0:184:e4db:e3e with
 SMTP id m4-20020a170902bb8400b00184e4db0e3emr15227955pls.47.1669250528363;
 Wed, 23 Nov 2022 16:42:08 -0800 (PST)
Date:   Wed, 23 Nov 2022 16:42:05 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221124004205.1777255-1-jonathantanmy@google.com>
Subject: [Design RFC] Being more defensive about fetching commits in partial clone
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At $DAYJOB, we recently ran into a situation in which through a bug (not
necessarily through Git) [1], there was corruption in the object store of
a partial clone. In this particular case, the problem was exposed when "git
gc" tried to expire reflogs, which calls repo_parse_commit(), which triggers
fetches of the missing commits.

We don't want to go to great lengths to improve the user experience in a
relatively rare case caused by a bug in another program at the expense of the
regular user experience, so this constrains the solution space. But I think
there is a solution that works: if we have reason to believe that we are
parsing a commit, we shouldn't lazy-fetch if it is missing. (I'm not proposing
a hard guarantee that commits are never lazy-fetched; this just relatively
increases resilience to object store corruption, and does not guarantee
absolute defense.) I think that we can use a missing commit as a sign of
object store corruption in this case because currently, Git does not support
excluding commits in partial clones.

There are other possible solutions including passing an argument from "git gc"
to "git reflog" to inhibit all lazy fetches, but I think that this fix is at
the wrong level - fixing "git reflog" means that this particular command works
fine, or so we think (it will fail if it somehow needs to read a legitimately
missing blob, say, a .gitmodules file), but fixing repo_parse_commit() will fix
a whole class of bugs.

A question remains of whether we would need to undo all this work if we decide
to support commit filters in partial clones. Firstly, there are good arguments
against (and, of course, for) commit filters in partial clones, so commit
filters may not work out in the end anyway. Secondly, even if we do have commit
filters, we at $DAYJOB think that we still need to differentiate, in some way,
a fetch that we have accounted for in our design and a fetch that we haven't;
commit chains have much greater lengths than tree chains and users wouldn't
want to wait for Git to fetch commit by commit (or segment by segment, if we
end up batch fetching commits as we probably will). So we would be building on
the defensiveness of fetching commits in this case, not tearing it down.

My next step will be to send a patch modifying repo_parse_commit() to not
lazy-fetch, and I think that future work will lie in identifying when we know
that we are reading a commit and inhibiting lazy-fetches in those cases. If
anyone has an opinion on this, feel free to let us know (hence the "RFC" in
the subject).

[1] For the curious, we ran a script that ran "git gc" on a repo having
configured a symlink to that repo as its alternate, which resulted in many
objects being deleted.
 
