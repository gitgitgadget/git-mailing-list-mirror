Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,STOX_REPLY_TYPE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 745B11F600
	for <e@80x24.org>; Sun, 23 Jul 2017 16:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751428AbdGWQdo (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Jul 2017 12:33:44 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:41508 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751354AbdGWQdn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jul 2017 12:33:43 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id ZJp7dAq2SQ527ZJp7dY3R3; Sun, 23 Jul 2017 17:33:41 +0100
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=MI8io4Rl c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=IkcTkHD0fZMA:10 a=LtVNH8unAAAA:8
 a=uPZiAMpXAAAA:8 a=XBffrurXYvWKY6J2gJoA:9 a=QEXdDO2ut3YA:10
 a=AueyrETzaJnuU_qMmc6C:22
Message-ID: <1E42613B0CD743C6ADA24B9F1B43F0F9@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "John Szakmeister" <john@szakmeister.net>, <git@vger.kernel.org>
References: <CAEBDL5URsbMazLBy-kWLJzECTEQ=61DN07xuu5NaO2Hw6r=j+w@mail.gmail.com>
Subject: Re: Expected behavior of "git check-ignore"...
Date:   Sun, 23 Jul 2017 17:33:42 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="UTF-8";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 170723-2, 23/07/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfIjouEzPalp6CDQ7Pom/yBo9eL9L0AfQ9vvdheox6NrHE/tcVV/R+Xzff1hDdbm7/c9LJANg4kVsyFipA10rPbBP6EK4fdWzingVJ418eM2saCA5mp6o
 Lz3AePVsXsuYz1TaPeIFPLyqHoTxoo7sxSsfCVjPyevmi1jFXTE1Ay48aGJNvb821JYjGYzQgr21sumBYBC5WEGe9DrN/CvO7o0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "John Szakmeister" <john@szakmeister.net>
Sent: Thursday, July 20, 2017 11:37 AM
>A StackOverflow user posted a question about how to reliably check
> whether a file would be ignored by "git add" and expected "git
> check-ignore" to return results that matched git add's behavior.  It
> turns out that it doesn't.  If there is a negation rule, we end up
> returning that exclude and printing it and exiting with 0 (there are
> some ignored files) even though the file has been marked to not be
> ignored.
>
> Is the expected behavior of "git check-ignore" to return 0 even if the
> file is not ignore when a negation is present?

I'm testing this on..
$ git --version

git version 2.10.0.windows.1


>
>>>>>
> git init .
> echo 'foo/*' > .gitignore
> echo '!foo/bar' > .gitignore

Is this missing the >> append to get the full two line .gitignore?
adding in a `cat .gitignore` would help check.


> mkdir foo
> touch foo/bar
I don't think you need these. It's the given pathnames that are checked, not 
the file system content.

> git check-ignore foo/bar

Does this need the `-q` option to set the exit status?

echo $? # to display the status.


> <<<<
>
> I expect the last command to return 1 (no files are ignored), but it
> doesn't.  The StackOverflow user had the same expectation, and imagine
> others do as well.  OTOH, it looks like the command is really meant to
> be a debugging tool--to show me the line in a .gitignore associated
> with this file, if there is one.  In which case, the behavior is
> correct but the return code description is a bit misleading (0 means
> the file is ignored, which isn't true here).

Maybe the logic isn't that clear? Maybe it is simply detecting if any one of 
the ignore lines is active, and doesn't reset the status for a negation?

I appear to get the same response as yourself, but I haven't spent much time 
on it - I'm clearing a backlog of work at the moment.

I also tried the -v -n options, and if I swap the ignore lines around it 
still says line 2 is the one that ignores.
It gets more interesting if two paths are given `foo/bar foo/baz`, to see 
which line picks up which pathname (and with the swapped ignore lines).

Is there a test for this in the test suite?

>
> Thoughts?  It seems like this question was asked before several years
> ago but didn't get a response.
>
> Thanks!
>
> -John
>
> PS The SO question is here:
> https://stackoverflow.com/questions/45210790/how-to-reliably-check-whether-a-file-is-ignored-by-git

--
Philip 

