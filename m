Return-Path: <SRS0=ovBw=4T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D774C3F2D1
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 10:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 678162187F
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 10:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbgCBKm2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Mar 2020 05:42:28 -0500
Received: from mail.ledoian.cz ([80.211.161.108]:56730 "EHLO mail.ledoian.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726654AbgCBKm1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Mar 2020 05:42:27 -0500
X-Greylist: delayed 329 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Mar 2020 05:42:27 EST
Received: from [10.10.10.98] (guests.kam.mff.cuni.cz [195.113.17.144])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ledoian.cz (Postfix) with ESMTPSA id 18A7E7FF66
        for <git@vger.kernel.org>; Mon,  2 Mar 2020 10:36:56 +0000 (GMT)
To:     git@vger.kernel.org
From:   Pavel Turinsky <pavel.turinsky@matfyz.cz>
Subject: Updating linked working trees when receiving packs
Message-ID: <d3524560-97cb-e36a-49f1-0c17e5be545c@matfyz.cz>
Date:   Mon, 2 Mar 2020 11:36:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a question about interaction between
receive.denyCurrentBranch=updateInstead and worktrees: in regular
non-bare repository, using the configuration option mentioned above one
can directly deploy code to the folder with the repository, and the
manual for git-config seems to encourage that:

	Another option is "updateInstead" which will update the working
	tree if pushing into the current branch. This option is intended
	for synchronizing working directories when one side is not
	easily accessible via interactive ssh (e.g. a live web site,
	hence the requirement that the working directory be clean). This
	mode also comes in handy when developing inside a VM to test and
	fix code on different Operating Systems.

This seems to work with regular checked-out repositories (or "main
working tree", as I understand it). I tried using this with "linked"
worktrees (created with "git worktree add /some/where some-branch"), it
seems to misbehave: the history (git log) in the linked worktree is
complete, but files are not changed, an "inverse" change gets staged
instead. I am not sure this is not intentional, but it doesn't feel that
way.

The use case for this would be having a testing and production version
on the same server and deploying both by a single 'git push', saving
disk space on the way (since the changes are not duplicated in two
repositories). Of course, this problem is solvable by using receive
hooks and updating the linked worktrees in them.

I understand that I have possibly tried to use a combination of features
that is uncommon and maybe not tested well enough. I am considering
helping with implementing that, but I don't orient well enough in the
source code, nor have I read the contribution guidelines yet.

Just for the record: The problem I wanted to solve is a bit different.
I need to have the .git directory separate from a web deployment in
order to be able to simultaneously run the web and have the source code
available via a frontend (like Gitea). Since I do not need to have
multiple branches deployed, I will try using the updateInstead option
with a repository initialized with --separate-git-directory on a server
(and if that won't work too, I will probably write another e-mail).

Of course, all of the mentioned problems can be solved by having
multiple remotes, but I was hoping to make workflows as simple as
possible (from the user point of view) -- i.e. not having to remember to
publish the source code.

Regards,
Pavel Turinský
