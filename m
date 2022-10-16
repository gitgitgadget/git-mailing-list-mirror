Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8934C433FE
	for <git@archiver.kernel.org>; Sun, 16 Oct 2022 22:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiJPWHT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Oct 2022 18:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiJPWHS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Oct 2022 18:07:18 -0400
X-Greylist: delayed 572 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 16 Oct 2022 15:07:17 PDT
Received: from mail.archlinux.org (mail.archlinux.org [IPv6:2a01:4f9:c010:3052::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B4E356D2
        for <git@vger.kernel.org>; Sun, 16 Oct 2022 15:07:17 -0700 (PDT)
Message-ID: <20b14207-a6f2-033f-3419-271662bffba9@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-rsa; t=1665957461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/IDPgRBcMtxZQ3D8VKA9jdHZu6alTs9JROu67gyYj7U=;
        b=PjkInvMi9oWtVBfNjLq6iokzF2vvMSLTInLl2zPhZtYXPxBUOHIWoXTXH5y4P1gxcVImre
        Jaw925UTspwAM0nPBI2MeDLNmyM+vPSES4vmoiXh+VGeoULMjdkk4/hBi4nZQFFl26tCTL
        KEIKCLYPgtp7aeTXaDryQfXUNo6f32+N2acK4DhoH8Vd8M1P+W8uDq2YX6+23Pxgacvo4Z
        MnpLLJPnSTIYM0g3afl5cPDGnxYQbGFGpUfWi91EqCVwvnyVnkYcAW5NKXrix6Bqe3RY/a
        XhgocsvYgzxMZpGuTHJgyGwDimaiH1be4ZQdJ8WAf5eZz9/HbjQWkun5LBbUCW6SuThUdL
        N8HgVSUZJVdv0XWH6RglMa2JU97+s3Ru2ZEDsoQUG366KqJnFtEl5Bsf9rmjTj/RF7en3m
        XuVHQLf0DsHbaHfq9PCPgvMtrZKBbJlGAieL/s/mdE8Mmygb1eHsQmATPuolBZDTJrrgsI
        Ev6dnLQ/bQcasQ7DMpbrv2I5es2Zdq0WO1dx7pHMAiGXnJkR3609TwAbXp7ZOlvhfk22XX
        9LYz1DoZ0B2XEysT8acl9qGDZWPABQ3bKX26UDchggbItT5oYgSHjH8NZwT8NDLBqCH3XV
        6Rg4JzyCfSGZTcO0CDvH3NCWGGwJCcfu3dMYsz8BHOymqI6JVjqgQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-ed25519; t=1665957461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/IDPgRBcMtxZQ3D8VKA9jdHZu6alTs9JROu67gyYj7U=;
        b=ceDI5mfk47iTeh8j4/P/ko32NtY3C4liLTdqDBwuubjy5U7++NKdeRWvniM0SLV1epphBh
        1rsdwFdRzIBN8/Ag==
Authentication-Results: mail.archlinux.org;
        auth=pass smtp.auth=kpcyrd smtp.mailfrom=kpcyrd@archlinux.org
Date:   Sun, 16 Oct 2022 23:57:40 +0200
MIME-Version: 1.0
Content-Language: de-DE
To:     rb-general@lists.reproducible-builds.org,
        arch-dev-public@lists.archlinux.org, git@vger.kernel.org
From:   kpcyrd <kpcyrd@archlinux.org>
Subject: git 2.38.0: Change in `git archive` output
Cc:     gitster@pobox.com, l.s.r@web.de
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

hello,

multiple people in Arch Linux noticed the output of our `git archive` 
command doesn't match the tarball served by github anymore.

First I suspected an update in our gzip package until I found this line 
in the git 2.38.0 release notes:

 > * Teach "git archive" to (optionally and then by default) avoid
 >   spawning an external "gzip" process when creating ".tar.gz" (and
 >   ".tgz") archives.

I've then found this commit that could be considered a breaking change 
in `git archive`:

https://github.com/git/git/commit/4f4be00d302bc52d0d9d5a3d4738bb525066c710

I don't know if there's some kind of gzip standard that could be used to 
align the git internal gzip implementation with gnu gzip.

I'm not saying this is necessarily a bug or regression but it makes it 
harder to reproduce github tar balls from a git repository. Just sharing 
what I've debugged. :)

cheers,
kpcyrd
