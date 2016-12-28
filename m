Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB4FD20441
	for <e@80x24.org>; Sat, 31 Dec 2016 21:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754826AbcLaVmz (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Dec 2016 16:42:55 -0500
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:43368 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754776AbcLaVmy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Dec 2016 16:42:54 -0500
Received: from glandium by mitsuha.glandium.org with local (Exim 4.88)
        (envelope-from <mh@glandium.org>)
        id 1cM9IS-00019A-8X
        for git@vger.kernel.org; Wed, 28 Dec 2016 17:09:16 +0900
Date:   Wed, 28 Dec 2016 17:09:16 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Subject: Counter-intuitive result from diff -C --stat
Message-ID: <20161228080916.72id4hzqxfbygtth@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20161126 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

So I was checking out differences between two branches, accounting for
file moves with -C, and was surprised by the number of insertions and
deletions that it indicated, because it was telling me I had removed
more than I added, which I really don't think is true.

I took a closer look, and what happens is that I had a lot of stuff in
a __init__.py file that I moved to another file, while keeping a now
new, empty, __init__.py file.

Which means while diff counts the deletions from __init__.py, it doesn't
count the additions from the move because it is a move, leading to a
counter-intuitive result.

Here's how to reproduce in case code makes more sense than prose:

/tmp$ git init g
Initialized empty Git repository in /tmp/g/.git/
/tmp$ cd g
/tmp/g$ echo foo > foo
/tmp/g$ git add foo
/tmp/g$ git commit -m foo
[master (root-commit) 14749a7] foo
 1 file changed, 1 insertion(+)
 create mode 100644 foo
/tmp/g$ git mv foo bar
/tmp/g$ touch foo
/tmp/g$ git add foo
/tmp/g$ git commit -m bar
[master 9fbf50e] bar
 2 files changed, 1 insertion(+), 1 deletion(-)
 create mode 100644 bar
/tmp/g$ git diff HEAD~ -C --stat
 foo => bar | 0
 foo        | 1 -
 2 files changed, 1 deletion(-)

I'm actually not sure what the right thing would be. I guess this is a
case where -B should help, but it doesn't.

Any thoughts?

Mike
