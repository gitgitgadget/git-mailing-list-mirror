Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A224C433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 15:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04C9A64E30
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 15:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbhBCP1Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 10:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbhBCP1T (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 10:27:19 -0500
Received: from joooj.vinc17.net (joooj.vinc17.net [IPv6:2001:4b99:1:3:216:3eff:fe20:ac98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F37AC0613D6
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 07:26:38 -0800 (PST)
Received: by joooj.vinc17.net (Postfix, from userid 1000)
        id C29275F2; Wed,  3 Feb 2021 16:26:34 +0100 (CET)
Date:   Wed, 3 Feb 2021 16:26:34 +0100
From:   Vincent Lefevre <vincent@vinc17.net>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: git fails with a broken pipe when one quits the pager
Message-ID: <20210203152634.GA22673@joooj.vinc17.net>
References: <YAG/vzctP4JwSp5x@zira.vinc17.org>
 <8735yhq3lc.fsf@evledraar.gmail.com>
 <20210131033652.GK623063@zira.vinc17.org>
 <87o8h4omqa.fsf@evledraar.gmail.com>
 <20210201103429.GT623063@zira.vinc17.org>
 <87im7cng42.fsf@evledraar.gmail.com>
 <20210201144857.GB24560@zira.vinc17.org>
 <87a6snokrr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a6snokrr.fsf@evledraar.gmail.com>
X-Mailer-Info: https://www.vinc17.net/mutt/
User-Agent: Mutt/2.0.5+101 (ab6d0dc5) vl-132933 (2021-01-27)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-02-01 16:44:24 +0100, Ævar Arnfjörð Bjarmason wrote:
> And then whether it makes sense to ignore SIGPIPE for all users, or
> e.g. if it's some opt-in setting in some situations that users might
> want to turn on because they're aware of how their pager behaves and
> want to work around some zsh mode.

AFAIK, SIGPIPE exists for the following reason. Most programs that
generate output are not written to specifically handle pipes. So,
if SIGPIPE did not exist, there would be 2 kinds of behavior:
  1. The program doesn't check for errors, and still outputs data,
     wasting time and resources as output will be ignored.
  2. The program sees that the write() failed and terminates with
     an error message. However, in most cases, such a failure is
     not an error: the consumer has terminated either because it
     no longer needs any input (e.g. with the "head" utility or a
     pager), or because it has terminated abnormally, in which case
     the real error is on the side of the consumer. So, the error
     message from the LHS of the pipe would be annoying.

SIGPIPE solves this issue: the program is simply killed with SIGPIPE.
In a shell, one gets a non-zero exit code (128 + 13) due to the
signal, but as being on the left-hand side of the pipe, such a
non-zero exit code is normally not reported, so that this will not
annoy the user.

Note 1: Non-zero exit codes from right-hand side are not reported
either by most shells, but zsh can report them, and this is very
useful for developers, as programs may fail with a non-zero exit
code but without an error message. (Reports may also be done by
looking at the standard $? in some hook.)

Note 2: Failures on the left-hand side are less interesting in practice
and generally ignored, at least for commands run in interactive shells.
For scripts, there are various (non-simple) ways to handle them.

Now, I think that in the case (like Git) a program creates a pipe,
it should use its knowledge to handle SIGPIPE / EPIPE. Either this
is regarded as an error because the full output is *always expected*
to be read, in which case there should be an error message in addition
to the usual non-zero exist status (not necessarily 141), or this is
regarded as OK (if there is a real failure, this is on the side of
the consumer). In the case of Git, the consumer is documented to be
a pager, which obviously may not read the full output (e.g. for the
GCC repository, "git log" returns more than 3 million lines, back to
the year 1988, while one is generally interested in the latest changes
only). If the user wants to pipe to something else, he can always use
an explicit pipe.

-- 
Vincent Lefèvre <vincent@vinc17.net> - Web: <https://www.vinc17.net/>
100% accessible validated (X)HTML - Blog: <https://www.vinc17.net/blog/>
Work: CR INRIA - computer arithmetic / AriC project (LIP, ENS-Lyon)
