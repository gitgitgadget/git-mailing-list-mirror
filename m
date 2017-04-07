Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1091F1FAFB
	for <e@80x24.org>; Fri,  7 Apr 2017 06:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752449AbdDGGTT (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 02:19:19 -0400
Received: from 5.itsy.de ([188.40.84.14]:50710 "EHLO 5.itsy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752169AbdDGGTR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 02:19:17 -0400
X-Greylist: delayed 385 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Apr 2017 02:19:17 EDT
Received: from [192.168.0.13] (84-72-0-73.dclient.hispeed.ch [84.72.0.73])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by 5.itsy.de (Postfix) with ESMTPSA id 474C164E1C
        for <git@vger.kernel.org>; Fri,  7 Apr 2017 08:12:50 +0200 (CEST)
To:     git@vger.kernel.org
From:   Joachim Durchholz <jo@durchholz.org>
Subject: problem with backslash in directory name
Message-ID: <9e3af7d6-a2c1-2673-53cc-d4c5105d9051@durchholz.org>
Date:   Fri, 7 Apr 2017 08:12:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I'm having a problem with submodules that reside in directories that 
(unwisely) contain a backslash in their name.


Transcript:

### Arrange

$ git init main
Initialized empty Git repository in /tmp/test/main/.git/

$ git init sub\\with\\backslash
Initialized empty Git repository in /tmp/test/sub\with\backslash/.git/
# This looks okay: the shell interpreted \\ as \,
# so we get sub\with\backslash

# Create a log entry in sub\with\backslash
# (it can't be added as a submodule otherwise)
# ((actually I think it's a misfeature, my current use case would be
# easier if git didn't insist on having a log in submodules))
$ touch sub\\with\\backslash/empty.file
$ git -C sub\\with\\backslash add empty.file
$ git -C sub\\with\\backslash commit -m "Added empty.file"
[master (root-commit) a27a485] Added empty.file
  1 file changed, 0 insertions(+), 0 deletions(-)
  create mode 100644 empty.file

### Act/Assert

$ git -C main submodule add ../sub\\with\\backslash
fatal: repository '/tmp/test/sub\witackslash' does not exist
fatal: clone of '/tmp/test/sub\witackslash' into submodule path 
'sub\with\backslash' failed
# The first "fatal:" line talks about "witackslash"
# Um... "ackslash"? Now that's a nice nickname for a CVE :-)

# Okay, let's see what's actually in that message
$ git -C main submodule add ../sub\\with\\backslash 2>&1 | xxd
00000000: 6661 7461 6c3a 2072 6570 6f73 6974 6f72  fatal: repositor
00000010: 7920 272f 746d 702f 7465 7374 2f73 7562  y '/tmp/test/sub
00000020: 5c77 6974 6808 6163 6b73 6c61 7368 2720  \with.ackslash'
00000030: 646f 6573 206e 6f74 2065 7869 7374 0a66  does not exist.f
00000040: 6174 616c 3a20 636c 6f6e 6520 6f66 2027  atal: clone of '
00000050: 2f74 6d70 2f74 6573 742f 7375 625c 7769  /tmp/test/sub\wi
00000060: 7468 0861 636b 736c 6173 6827 2069 6e74  th.ackslash' int
00000070: 6f20 7375 626d 6f64 756c 6520 7061 7468  o submodule path
00000080: 2027 7375 625c 7769 7468 5c62 6163 6b73   'sub\with\backs
00000090: 6c61 7368 2720 6661 696c 6564 0a         lash' failed.

# Yeah, there's a 0x08 at offset 0x25.
# It's pretty strange that it is eliding the w following the \b,
# not the h preceding it.


So... something inside "git submodule add" is replacing the \b with a 
backspace control code.


Next I tried something nasty:

$ mv sub\\with\\backslash 'sub: $(bc)'
git -C main submodule add '../sub: $(bc)'
Cloning into ' $(bc)'...
done.

Whatever that "something" is, it is not doing shell expansion, otherwise 
it would have started an interactive calculator session.
Phew :-)
I'm still a bit uneasy because I don't know what other escape sequences 
might get interpreted, and what their effects are.
