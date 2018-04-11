Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D6771F424
	for <e@80x24.org>; Wed, 11 Apr 2018 07:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752279AbeDKHTe (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 03:19:34 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:45920 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752181AbeDKHTe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 03:19:34 -0400
Received: by mail-wr0-f173.google.com with SMTP id u11so664410wri.12
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 00:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=7uPC5v45Mi87CHz40r9dyZBlfCYRqcAgfe5sa2JqWH8=;
        b=tjDMGDnIZGFvARZfROhHYtEipB/5KsMPZB9ew8pBXUeJgaT6vlOtlSyX77+xa9UoMU
         UnCcCf56gOjGUQSPs+rGMmOl6ak8SWwpZUvPgIMGnksX77hbH+JNxyCiz6d6jaK0wvYb
         n2wZ3nX8cZrWrJVnSTJ2m2m+AHaGlX3X2nRU0XDnvLfDaS1EwixhdeMNM1YHMsqCNPAR
         BpahBeUZ5p9fpt9QXqEgzf37D42nhTmt1rhXGfavV3VKaBNuxFVowwXycCbaPGeH4/s6
         2vmpQ6r686+iy/xS+ugdgtRhXzehPAS0Rmy82vpnWrjkzWBqpcyNp+7F0a3xXq1XPDOY
         lIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=7uPC5v45Mi87CHz40r9dyZBlfCYRqcAgfe5sa2JqWH8=;
        b=CHa4NLXDvNRwUxHYX3GxZCTT3tCMA1nZxLhL4v0BZ2pOetjg2GPOuQCVxKWGQ4beD/
         qY2rNEl9PdiQunRdb24hLprqRM3eqRgHTmiyVT9o7smfvcfcXp0nDzD7l7ZH5KBRHOSZ
         S8XmqKWfTu2w1trKBkZ5XGRTOmcCTyyp7hknp1MUnLZharfw5QI0AKXLgcun4fBedgty
         ApB5GgAkYj3S9LaKxjKD1qS3xcR3PEcjUkVDVk/4AgkXt0M3FW6vX1zjgqxHJRLFqOA3
         V9xcjTW3icktn+X6mfV5LYnNYZrijTbH5NV5+bBpjHgfx1GupGNMDLvEKxHZgiqNM621
         zLow==
X-Gm-Message-State: ALQs6tBc/XYLzqiZsJ6FieXoAsiI15WUk/ZC/A1YfPXnqogtSygRWQYL
        FK7RDiRR1JazH46ij1pkRv/29hOC
X-Google-Smtp-Source: AIpwx49mV5rvUCUvhoahmQ8l2KlYw6TsytzSipMLdXaW/Jmf8lFG+991gLodxGfm7n8o/UziVKXbZg==
X-Received: by 10.223.160.4 with SMTP id k4mr2615096wrk.259.1523431172319;
        Wed, 11 Apr 2018 00:19:32 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l73sm2518585wma.10.2018.04.11.00.19.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Apr 2018 00:19:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: [Git] recursive merge on 'master' severely broken?
Date:   Wed, 11 Apr 2018 16:19:31 +0900
Message-ID: <xmqqmuya43cs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It appears that a topic recently graduated to 'master' introduces a
severe regression to "git merge" when it merges a side branch that
renames paths while the trunk has further updates.

The symptom can easily be seen by trying to recreate the merge I
made at the tip of 'pu' 29dea678 ("Merge branch
'sb/filenames-with-dashes' into pu", 2018-04-11) that I'll be.
pushing out shortly.  The side branch renames a file exec_cmd.h to
exec-cmd.h (an underscore changed to a dash) without changing any
contents, while the branch being merged to has made some changes to
the contents while keeping the original pathname.

A clean automerged result should leave the identical contents from
HEAD:exec_cmd.h in :exec-cmd.h in the index, which is what happens
when using Git v2.17.0 proper, but with today's master', there are
content changes that cannot be explained--the merge is simply broken
and worse yet, the command pretends that everything went well and
merged cleanly in that path.  Overly clever tool that behaves in a
buggy and unexplainable way is bad enough, doing so silently is
unexcusable.

I suspect that the culprit is the merge e4bb62fa ("Merge branch
'en/rename-directory-detection'", 2018-04-10), and I am planning to
revert it out of 'master' as soon as possible, but it is already
buried deep in other topics, so I may not be able to get to it until
later this week.  Sorry about that.

