Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31CEE1FA14
	for <e@80x24.org>; Mon, 17 Apr 2017 11:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752832AbdDQLpo (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 07:45:44 -0400
Received: from oker.escape.de ([194.120.234.254]:39616 "EHLO oker.escape.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752092AbdDQLpn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 07:45:43 -0400
X-Greylist: delayed 337 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Apr 2017 07:45:43 EDT
Received: from oker.escape.de (localhost [127.0.0.1])
        (envelope-sender: urs@isnogud.escape.de)
        by oker.escape.de (8.14.4/8.14.4/$Revision: 1.86 $) with ESMTP id v3HBe3Dk025680
        for <git@vger.kernel.org>; Mon, 17 Apr 2017 13:40:03 +0200
Received: (from uucp@localhost)
        by oker.escape.de (8.14.4/8.14.4/Submit) with UUCP id v3HBe3sl025625
        for git@vger.kernel.org; Mon, 17 Apr 2017 13:40:03 +0200
Received: from tehran.isnogud.escape.de (localhost [127.0.0.1])
        by tehran.isnogud.escape.de (8.14.9/8.14.9) with ESMTP id v3HBaALj001469
        for <git@vger.kernel.org>; Mon, 17 Apr 2017 13:36:10 +0200
Received: (from urs@localhost)
        by tehran.isnogud.escape.de (8.14.9/8.14.9/Submit) id v3HBaAWW001466;
        Mon, 17 Apr 2017 13:36:10 +0200
X-Authentication-Warning: tehran.isnogud.escape.de: urs set sender to urs@isnogud.escape.de using -f
To:     git@vger.kernel.org
Subject: How to keep log history when renaming and changing simultaneously
From:   Urs Thuermann <urs@isnogud.escape.de>
Date:   17 Apr 2017 13:36:10 +0200
Message-ID: <ygfpogbb711.fsf@tehran.isnogud.escape.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sometimes I need to rename and change a file in one commit.  One
example would be a file foo.h that begins with

    #ifndef FOO_H
    #define FOO_H

which should be renamed bar.h and have the FOO_H changed to BAR_H.
In subversion I would

    svn mv foo.h bar.h; vi bar.h; svn ci

and then a

    svn log bar.h

also shows the history of that file when it was named foo.h.

This does not work in git.  After committing,

    git mv foo.h bar.h; vi bar.h; git commit -a

the command

    git log --follow bar.h

shows only the history of the file when it was named bar.h, but not
its life as foo.h.

The only workaround I found was to do the rename and the change in two
separate commits, so that git sees the same name and the same SHA hash
which allows it to follow the files' history.  This can be a problem
when the intermediate version with either only the change or only the
rename doesn't compile correctly.

Is there a better way to do this in git?

A similar problem is splitting a file into two files.  With subversion
I'd do

    printf "void foo() {}\nint main() { foo(); }\n" > prog.c
    svn add prog.c; svn ci -m "Add prog.c"

Then I would split

    svn cp prog.c foo.c; svn cp prog.c main.c; svn rm prog.c
    printf "2d\nwq\n" | ed foo.c; printf "1d\nwq\n" | ed main.c
    svn ci -m "Split prog.c"; svn up

and I get

    $ svn log -v
    ------------------------------------------------------------------------
    r2 | urs | 2017-04-17 10:03:06 +0200 (Mon, 17 Apr 2017) | 1 line
    Changed paths:
       A /foo.c (from /prog.c:1)
       A /main.c (from /prog.c:1)
       D /prog.c
    
    Split prog.c
    ------------------------------------------------------------------------
    r1 | urs | 2017-04-17 10:02:51 +0200 (Mon, 17 Apr 2017) | 1 line
    Changed paths:
       A /prog.c
    
    Add prog.c
    ------------------------------------------------------------------------

And I can also see this when I run svn log on one of both files.	
How could I do this in git?

urs
