Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00E2A20899
	for <e@80x24.org>; Wed,  2 Aug 2017 14:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752268AbdHBOrZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 10:47:25 -0400
Received: from oker.escape.de ([194.120.234.254]:32826 "EHLO oker.escape.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752014AbdHBOrZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 10:47:25 -0400
X-Greylist: delayed 440 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Aug 2017 10:47:24 EDT
Received: from oker.escape.de (localhost [127.0.0.1])
        (envelope-sender: urs@isnogud.escape.de)
        by oker.escape.de (8.14.4/8.14.4/$Revision: 1.86 $) with ESMTP id v72Ee3Zq030582
        for <git@vger.kernel.org>; Wed, 2 Aug 2017 16:40:03 +0200
Received: (from uucp@localhost)
        by oker.escape.de (8.14.4/8.14.4/Submit) with UUCP id v72Ee3hB030570
        for git@vger.kernel.org; Wed, 2 Aug 2017 16:40:03 +0200
Received: from tehran.isnogud.escape.de (localhost [127.0.0.1])
        by tehran.isnogud.escape.de (8.14.9/8.14.9) with ESMTP id v72EaUsq025937
        for <git@vger.kernel.org>; Wed, 2 Aug 2017 16:36:30 +0200
Received: (from urs@localhost)
        by tehran.isnogud.escape.de (8.14.9/8.14.9/Submit) id v72EaPQZ025934;
        Wed, 2 Aug 2017 16:36:25 +0200
X-Authentication-Warning: tehran.isnogud.escape.de: urs set sender to urs@isnogud.escape.de using -f
To:     git <git@vger.kernel.org>
Subject: git svn fetch --localtime produces wrong commit times
From:   Urs Thuermann <urs@isnogud.escape.de>
Date:   02 Aug 2017 16:36:25 +0200
Message-ID: <ygf8tj26npy.fsf@tehran.isnogud.escape.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In converting a SVN repository to git, the commit timestamp is
generated incorrectly.  I use "git svn fetch --localtime" and the
offset from UTC is always set to +0200 (probably because that is the
current local offset here, i.e. Europe/Berlin) even for times when it
should be +0100.

For example, in my SVN working copy I get

    $ svn log -r152
    ------------------------------------------------------------------------
    r152 | urs | 2010-08-16 11:05:52 +0200 (Mon, 16 Aug 2010) | 2 lines

    Add error checks on input file streams

    ------------------------------------------------------------------------
    $ svn log -r158
    ------------------------------------------------------------------------
    r158 | urs | 2010-11-24 00:24:13 +0100 (Wed, 24 Nov 2010) | 16 lines

    Make code portable to Linux/amd64

After converting to git using

    $ mkdir use
    $ cd use
    $ git svn init -s file://$HOME/SVN/use
    Initialized empty Git repository in /home/urs/GIT/use/.git/
    $ git svn fetch -q -A ../ADM/git.svn-authors --localtime
    r1 = 12cb83315be96e594a98b42db7ae57d19e0c7973 (refs/remotes/origin/trunk)
    ...
    r162 = 99ff393f1d64f330b14d6e06412b94fd3023d616 (refs/remotes/origin/trunk)
    Checked out HEAD:
      file:///home/urs/SVN/use/trunk r162

I see wrong commit timestamps:

    $ git log
    ...
    commit c6b4f7aaa66650a16de67d32fb83d541b1973331
    Author: Urs Thuermann <urs@isnogud.escape.de>
    Date:   Wed Nov 24 00:24:13 2010 +0200

        Make code portable to Linux/amd64


        git-svn-id: file:///home/urs/SVN/use/trunk@158 b3714422-7cff-11dd-9a33-b89007e0d947
    ...
    commit a9d95e506681ac5742d2d0927c93f22c541ff170
    Author: Urs Thuermann <urs@isnogud.escape.de>
    Date:   Mon Aug 16 11:05:52 2010 +0200

        Add error checks on input file streams


        git-svn-id: file:///home/urs/SVN/use/trunk@152 b3714422-7cff-11dd-9a33-b89007e0d947
    ...

In revision 152 the timestamp is correct, but for revision 158 the UTC
offset is +0200 instead of +0100.  Then, of course, also the POSIX
timestamp in the commit object is wrong:

    $ git cat-file -p c6b4f7aaa66650a16de67d32fb83d541b1973331
    tree ff4528220ddcf8beca9f4958fbb947d5ed85808e
    parent edcaeb292153663664d850bafe1dad12daab4165
    author Urs Thuermann <urs@isnogud.escape.de> 1290551053 +0200
    committer Urs Thuermann <urs@isnogud.escape.de> 1290551053 +0200

        Make code portable to Linux/amd64
    ...
    $ date -d@1290551053 +%F\ %T\ %z
    2010-11-23 23:24:13 +0100

The correct timestamp would be 2010-11-24 00:24:13 +0100, or, as a
POSIX time_t 1290554653.

I could find the bug grepping through /usr/lib/git-core/git-svn, maybe
it's in GIT::SVN::Fetcher or some other GIT::SVN module.

Is a fix available for this bug?

urs
