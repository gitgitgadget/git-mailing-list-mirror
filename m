Return-Path: <SRS0=dClv=3H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705B8C33C9E
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 00:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C48622464
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 00:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730319AbgARAEC convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 17 Jan 2020 19:04:02 -0500
Received: from mailrelay3.webfaction.com ([207.38.93.110]:59212 "EHLO
        mailrelay3.webfaction.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730232AbgARAEC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 19:04:02 -0500
X-Greylist: delayed 379 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Jan 2020 19:04:01 EST
Received: from mailrelay2.webfaction.com (mailrelay2.webfaction.com [185.20.50.247])
        by mailrelay3.webfaction.com (Postfix) with ESMTPS id 1951128FBF0
        for <git@vger.kernel.org>; Fri, 17 Jan 2020 23:57:42 +0000 (UTC)
Received: from smtp.webfaction.com (mail6.webfaction.com [31.170.123.134])
        by mailrelay2.webfaction.com (Postfix) with ESMTPS id DA60840138
        for <git@vger.kernel.org>; Fri, 17 Jan 2020 23:57:39 +0000 (UTC)
Received: from localhost (82-64-139-178.subs.proxad.net [82.64.139.178])
        by smtp.webfaction.com (Postfix) with ESMTPSA id C9856600C5D4E
        for <git@vger.kernel.org>; Fri, 17 Jan 2020 23:57:31 +0000 (UTC)
From:   Christoph Groth <christoph@grothesque.org>
To:     git@vger.kernel.org
Subject: Stat cache in .git/index hinders syncing of repositories
Date:   Sat, 18 Jan 2020 00:57:36 +0100
Message-ID: <87v9p9skjz.fsf@drac>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I am using unison to sync home directories across multiple machines.
This includes a fair number of git repositories and works very well.
Unison recently acquired a new feature that allows to treat selected
subdirectories (like .git) atomically.  This makes the syncing perfectly
safe.

Some people say that one should use git itself to sync git working
directories, but IMHO these people oversee the difference between
collaboration (using git) and being able to continue one’s own
unfinished work on a different machine, including uncommitted files,
stashes, and - if it has to be - in the middle of a merge.  Moreover, it
is simpler not to have to treat git repositories specially when syncing.
Syncing git repositories is thus clearly useful.

However, there is one problem with syncing git repositories, that has
been noticed by multiple people [1]: The file .git/index contains not
only the “git index”, but also a cache of stat-data of the files in the
working directory.  Some file synchronizers are able to sync mtimes, but
syncing ctimes would be bizarre (if it is even possible).

So, say that machines A and B are synced.  A new git repository appears
on machine A.  The synchronizer is run which results in copying all the
files of the new repo verbatim to machine B.  Note that now on machine
B the cache inside the file .git/index contains invalid stat
information.  So when "git status" is run on B .git/index gets
rewritten, and the next sync operation copies it back to A, where again
it is rewritten even by something as harmless as "git status".  And so
on, and so forth...

In my opinion the root of this ping-pong problem is that .git/index
mixes information about the status of the repository (=what has been
staged) that should be synced with a cache of machine-specific
filesystem metadata.

I am not an expert of git-internals, but perhaps it would be a good idea
to move the cache into a separate file that could be put on a "ignore"
list for synchronizers?  It seems to me that this has been already
proposed in a different context [2], and I would not be surprised if
factoring out the cache had other beneficial effects.

If it is not feasible to separate the cache, perhaps another possibility
would be to add a new possible value for core.checkStat that would
disable stat structure checking except for file sizes?

As a workaround for now, I exclude .git/index from syncing.  This seems
to work quite well, but I would be scared to sync unfinished merges like
this.

Thanks
Christoph

[1] https://stackoverflow.com/questions/12126247/why-does-git-index-change-when-i-havent-done-anything-to-my-repository
[2] https://www.mail-archive.com/git@vger.kernel.org/msg48065.html
