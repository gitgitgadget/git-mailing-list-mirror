Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7DAA207D2
	for <e@80x24.org>; Sun, 25 Jun 2017 07:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751256AbdFYHUk (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Jun 2017 03:20:40 -0400
Received: from oker.escape.de ([194.120.234.254]:36622 "EHLO oker.escape.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751200AbdFYHUj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jun 2017 03:20:39 -0400
X-Greylist: delayed 334 seconds by postgrey-1.27 at vger.kernel.org; Sun, 25 Jun 2017 03:20:39 EDT
Received: from oker.escape.de (localhost [127.0.0.1])
        (envelope-sender: urs@isnogud.escape.de)
        by oker.escape.de (8.14.4/8.14.4/$Revision: 1.86 $) with ESMTP id v5P7F3hq017711
        for <git@vger.kernel.org>; Sun, 25 Jun 2017 09:15:03 +0200
Received: (from uucp@localhost)
        by oker.escape.de (8.14.4/8.14.4/Submit) with UUCP id v5P7F3Rc017681
        for git@vger.kernel.org; Sun, 25 Jun 2017 09:15:03 +0200
Received: from tehran.isnogud.escape.de (localhost [127.0.0.1])
        by tehran.isnogud.escape.de (8.14.9/8.14.9) with ESMTP id v5P7Crak017403
        for <git@vger.kernel.org>; Sun, 25 Jun 2017 09:12:53 +0200
Received: (from urs@localhost)
        by tehran.isnogud.escape.de (8.14.9/8.14.9/Submit) id v5P7Cqog017400;
        Sun, 25 Jun 2017 09:12:52 +0200
X-Authentication-Warning: tehran.isnogud.escape.de: urs set sender to urs@isnogud.escape.de using -f
To:     git@vger.kernel.org
Subject: Migration from CVS to Git looses merges
From:   Urs Thuermann <urs@isnogud.escape.de>
Date:   25 Jun 2017 09:12:52 +0200
Message-ID: <ygfd19stua3.fsf@tehran.isnogud.escape.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I want to convert several old CVS repositories to Git.  Some of these
CVS repositories contain branches, which have later been merged to the
main trunk.  When I try to convert using cvs2git or git cvsimport the
branches appear in the new git repository but they are not merged to
the master branch.

Here is an example of how the branches in the CVS repository were
created and merged:

    cd /tmp
    export CVSROOT=$PWD/CVS

    cvs init
    mkdir CVS/foo
    cvs co foo

    cd foo
    (date; seq 10; date) > bar
    cvs add bar
    cvs ci -m msg1                              # rev 1.1

    sleep 1
    printf "1c\n%s\n.\nwq\n" "`date`" | ed bar
    cvs ci -m msg2                              # rev 1.2

    sleep 1
    cvs tag -b a-branch

    sleep 1
    printf "1c\n%s\n.\nwq\n" "`date`" | ed bar
    cvs ci -m msg3                              # rev 1.3

    sleep 1
    cvs up -r a-branch
    printf "12c\n%s\n.\nwq\n" "`date`" | ed bar
    cvs ci -m msg-b1                            # rev 1.2.2.1

    sleep 1
    printf "12c\n%s\n.\nwq\n" "`date`" | ed bar
    cvs ci -m msg-b2                            # rev 1.2.2.2

    sleep 1
    cvs up -A
    cvs up -j a-branch
    cvs ci -m "Merge branch a-branch"           # rev 1.4

Now I have tried 2 ways to convert this to git:

1. mkdir g; cd g; git cvsimport -A <file> -m foo
2. mkdir g; cd g; git init;
   cvs2git --blobfile=foo.blob --dumpfile=foo.dump --username=urs ../CVS/foo
   cat foo.blob foo.dump | git fast-import

In both cases, the branch "a-branch" is in the git repository but is
not merged with the master branch, i.e. rev 1.4 has only parent 1.3
but not 1.2.2.2.  I also tried cvsimport with several regexes passed
using -M to match "Merge branch a-branch", but still the same result.

How should the CVS repository be converted to git, so that the commit
corresponding to rev 1.4 has two parents, 1.3 and 1.2.2.2?

urs
