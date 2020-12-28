Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E460C433E0
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 19:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E564722B2A
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 19:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbgL1T3s (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 14:29:48 -0500
Received: from mailscanner.iro.umontreal.ca ([132.204.25.50]:25589 "EHLO
        mailscanner.iro.umontreal.ca" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728025AbgL1T3r (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 28 Dec 2020 14:29:47 -0500
Received: from pmg3.iro.umontreal.ca (localhost [127.0.0.1])
        by pmg3.iro.umontreal.ca (Proxmox) with ESMTP id 800384407B9;
        Mon, 28 Dec 2020 14:29:06 -0500 (EST)
Received: from mail01.iro.umontreal.ca (unknown [172.31.2.1])
        by pmg3.iro.umontreal.ca (Proxmox) with ESMTP id 22153440791;
        Mon, 28 Dec 2020 14:29:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iro.umontreal.ca;
        s=mail; t=1609183745;
        bh=Wp8jErex3VSz/Bk86FsJstVR1cDxRd/NFDc5bo3puQ0=;
        h=From:To:Subject:References:Date:In-Reply-To:From;
        b=ovY6R/tMRsPXvfDVqQ8qsKUfw6F16sS2wBm9Gl4VQNyaji3Wa1fQnbUdykkIpk8qx
         jwNeLuJAkd3bsgJIC97on7mp42SlA55FWSNc6Hh9pH4Wqq42QP4umgrShBeBvCFA/u
         Q2QeoHkd97oDU0U6NnTzW+UIPIhVDQVgVjjCI518XQPzRzm77pFhYYaoYp/fkWqIVB
         pxQA0m5yci+vEqxSOfFY3wVwknHWyMK87sFD7XAAiM3hU/cK4InlJ9BvcJHA44HAK8
         K1i/cX37AEdbQjdCeKqCZmjGNh49kXkF56ZEnxmHGvi6WSAE4NUMyrxMLzwvhqIo+g
         4VA2FrcLGW5Qw==
Received: from alfajor (unknown [104.247.243.191])
        by mail01.iro.umontreal.ca (Postfix) with ESMTPSA id E30BE1201FA;
        Mon, 28 Dec 2020 14:29:04 -0500 (EST)
From:   Stefan Monnier <monnier@iro.umontreal.ca>
To:     git@vger.kernel.org
Subject: Re: [BUG] Destructive access to an "objects/info/alternates"
 repository
Message-ID: <jwv8s9hd9cg.fsf-monnier+Inbox@gnu.org>
References: <jwvpn2tdb0r.fsf-monnier+gmane.comp.version-control.git@gnu.org>
        <20201228190036.vnkgeu6puxmvgt5s@chatter.i7.local>
Date:   Mon, 28 Dec 2020 14:29:03 -0500
In-Reply-To: <20201228190036.vnkgeu6puxmvgt5s@chatter.i7.local> (Konstantin
        Ryabitsev's message of "Mon, 28 Dec 2020 14:00:36 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>     git clone --reference ~otheruser/nongnu
>
> This doesn't appear to be a proper command, because it's missing actual
> repository to clone, only the repository to use as reference. This is the
> proper usage of --reference:
>
> git clone --reference ~/some/repo https://some/remote/repo.git

Indeed, thanks:

git clone --reference ~otheruser/nongnu https://git.savannah.gnu.org/r/emacs/nongnu.git

> Without knowing exactly what you did, it's hard to tell what went wrong. You
> can try running "find nongnu" to see if what you think is your own checkout is
> actually a symlink or some combination thereof.

Not sure what you mean by that.

In any case, I just reproduced the problem:

    % git clone --reference ~otheruser/nongnu https://git.savannah.gnu.org/r/emacs/nongnu.git
    Cloning into 'nongnu'...
    Fetching objects: 36974, done.
    % cd nongnu 
    % git gc
    Enumerating objects: 36974, done.
    Nothing new to pack.
    warning: unable to unlink '/home/otheruser/nongnu/.git/objects/pack/pack-0d85e74ac2f7e51ce26f281e64eb738e8182fa95.idx': Permission denied
    warning: unable to unlink '/home/otheruser/nongnu/.git/objects/pack/pack-5fe14feff49ccdee5469af9dc94f6784e8464a6b.idx': Permission denied
    % ls -l /home/otheruser/nongnu/.git/objects/pack/pack-0d85e74ac2f7e51ce26f281e64eb738e8182fa95.idx
    -rw-r--r-- 1 otheruser otheruser 975612 Dec 11 16:08 /home/otheruser/nongnu/.git/objects/pack/pack-0d85e74ac2f7e51ce26f281e64eb738e8182fa95.idx
    % ls -ld /home/otheruser/nongnu/.git/objects/pack
    drwxr-xr-x 2 otheruser otheruser 4096 Dec 27 17:57 /home/otheruser/nongnu/.git/objects/pack/
    %


-- Stefan

