Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96112C433E0
	for <git@archiver.kernel.org>; Fri, 29 May 2020 03:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 707342075F
	for <git@archiver.kernel.org>; Fri, 29 May 2020 03:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391716AbgE2DTB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 23:19:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:59618 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390172AbgE2DTA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 23:19:00 -0400
Received: (qmail 955 invoked by uid 109); 29 May 2020 03:19:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 May 2020 03:19:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20506 invoked by uid 111); 29 May 2020 03:18:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 May 2020 23:18:59 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 28 May 2020 23:18:58 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        git@vger.kernel.org, hji@dyntopia.com
Subject: digging into historical commit references
Message-ID: <20200529031858.GA1271617@coredump.intra.peff.net>
References: <20200528083745.15273-1-carenas@gmail.com>
 <xmqqo8q83x3v.fsf@gitster.c.googlers.com>
 <20200528154349.GA1215380@coredump.intra.peff.net>
 <xmqqh7w03vnq.fsf@gitster.c.googlers.com>
 <20200528165245.GA1223396@coredump.intra.peff.net>
 <xmqqsgfj3lym.fsf@gitster.c.googlers.com>
 <20200528203516.GA1245262@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200528203516.GA1245262@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 28, 2020 at 04:35:17PM -0400, Jeff King wrote:

> You could probably get interesting numbers in our project by grepping
> for [0-9a-f]{7,} in commit messages to see which commits are referenced
> a lot. Those aren't always bug-fixes exactly, but they are often "we did
> this in commit XYZ, but that missed this case". Or maybe it would just
> tell you which commits are interesting enough that we keep coming back
> to them. ;)

Just for fun, I tried this. You can get a list of plausible references
with:

  git log --format=%B |
  perl -lne 'print $& for /[0-9a-f]{7,}/' |
  git cat-file --batch-check='%(objectname)' |
  grep -v missing

The top hits (by count) in git.git are:

  16 d1c5f2a42d (Add git-am, applymbox replacement., 2005-10-07)

     Referenced a lot during the C conversion, but not particularly
     buggy.

  14 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391

     Not a commit. Experienced Gits might recognize this particular
     sha1.

  13 d95138e695 (setup: set env $GIT_WORK_TREE when work tree is set, like $GIT_DIR, 2015-06-26)

     This one _is_ interesting, as it caused a lot of fallout and was
     reverted. But really only 4 commits; it just got mentioned several
     times in each (and my line-by-line count doesn't notice that).

  12 b1ef400eec (setup_git_env: avoid blind fall-back to ".git", 2016-10-20)

     This one also caused a lot of fallout (and actually had 7
     commits mention it), which doesn't surprise me, given the topic.

  10 94da9193a6 (grep: add support for PCRE v2, 2017-06-01)

     I wouldn't have thought this could have caused a lot of bugs, but
     apparently it did. :)

So I dunno. A little fun to look through, but I didn't find it
especially enlightening.

-Peff
