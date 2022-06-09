Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E600C433EF
	for <git@archiver.kernel.org>; Thu,  9 Jun 2022 06:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238817AbiFIGQS convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 9 Jun 2022 02:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbiFIGQQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 02:16:16 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2102F13FBDC
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 23:16:12 -0700 (PDT)
Received: from Mazikeen ([217.33.110.218])
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 2596G9O4078802
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 9 Jun 2022 02:16:10 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Jeff King'" <peff@peff.net>, "'R. Diez'" <rdiez1999@gmail.com>
Cc:     <git@vger.kernel.org>
References: <68627d29-8ffd-2e22-46ca-c28c9e980177@gmail.com> <YqE27RU45kjNRwxf@coredump.intra.peff.net>
In-Reply-To: <YqE27RU45kjNRwxf@coredump.intra.peff.net>
Subject: RE: How to watch files in a Git repository
Date:   Thu, 9 Jun 2022 02:16:03 -0400
Organization: Nexbridge Inc.
Message-ID: <007301d87bc8$69608b00$3c21a100$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHeRrRAP4NLFeTEiFnn8P7KgJNqSwEsOTVArTGg0SA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On June 8, 2022 7:55 PM, Jeff King wrote:
>On Mon, Jun 06, 2022 at 06:04:11PM +0200, R. Diez wrote:
>
>> If there is nothing of the sort, I could write my own script in Bash
>> or Perl. I can handle cron and sending e-mails, but I do not know much
>> about Git's internals. Could someone provide a few pointers about how
>> to code this? I would expect there is some command to list commits,
>> and all files touched by a particular commit. And there would be some
>> way to interface with Bash or Perl, which does not need parsing
>> complicated text output from Git.
>
>This sounds kind of like git-multimail:
>
>  https://github.com/git-multimail/git-multimail
>
>That's usually triggered from a hook, I think, but it would not be hard to trigger it
>with arbitrary segments of history.
>
>You'd probably want to keep a "seen" ref of processed commits, and move from
>that, like:
>
>  # assuming you just care about one branch on the remote, but this
>  # concept can be extended to several
>  branch=refs/remotes/origin/main
>  seen=refs/heads/seen
>
>  git fetch
>
>  # I don't know what git-multimail expects, but this is similar to what
>  # a server-side receive hook would show
>  echo "$(git rev-parse $seen) $(git rev-parse $branch) $branch" |
>  some-git-multimail-command
>
>  # now move your pointer forward for next time
>  git update-ref $seen $branch
>
>If multimail doesn't do what you want, then you can probably just script
>around:
>
>  git rev-list $seen..$branch -- $paths_you_care_about |
>  git diff-tree --stdin -r --name-only --format="Commit %h touched: " --
>$paths_you_care_about
>
>depending how you want to format things.

I am unsure this solves the question. Is the OP looking for anyone who modifies any set or subset of files in any clone or in the upstream repo? This is generally considered a "watch" function and is sometimes available on the upstream repo manager, like GitHub/GitLab/BitBucket rather than in core git, so take into account changes made anywhere. If that is the case and the watch functions are not sufficient, you might have to put the hooks on your upstream rather than in your clone.

Just my thoughts,
Randall

