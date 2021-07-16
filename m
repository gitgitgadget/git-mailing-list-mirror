Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBF7C12002
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 19:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC671613FB
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 19:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbhGPTgO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 15:36:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:52286 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231266AbhGPTgN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 15:36:13 -0400
Received: (qmail 21762 invoked by uid 109); 16 Jul 2021 19:33:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 16 Jul 2021 19:33:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12201 invoked by uid 111); 16 Jul 2021 19:33:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 16 Jul 2021 15:33:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 16 Jul 2021 15:33:17 -0400
From:   Jeff King <peff@peff.net>
To:     phillip.wood@dunelm.org.uk
Cc:     Luca Weiss <luca@z3ntu.xyz>,
        Luca Weiss via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH 2/2] merge: make sure to terminate message with newline
Message-ID: <YPHe/W7+Oh63NpB0@coredump.intra.peff.net>
References: <pull.1048.git.git.1626421416.gitgitgadget@gmail.com>
 <31371c25743e1001b4fac89e80e7206ff477ac8a.1626421416.git.gitgitgadget@gmail.com>
 <8678772b-dd5d-9188-8b63-98d05cedb323@gmail.com>
 <AB048897-F70A-4388-B2A6-56BFEA40B303@z3ntu.xyz>
 <16229b1d-e4a6-7a8d-8ea0-ae7c3f13075d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <16229b1d-e4a6-7a8d-8ea0-ae7c3f13075d@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 16, 2021 at 06:30:50PM +0100, Phillip Wood wrote:

> > I have a simple reproducer here:
> > 
> > mkdir /tmp/test
> > cd /tmp/test
> > git init
> > echo 'dest="$1.tmp"; git interpret-trailers --trailer "Foo: Bar" < "$1" > "${dest}"; mv "${dest}" "$1"' > .git/hooks/commit-msg
> > chmod +x .git/hooks/commit-msg
> > git commit --allow-empty -m "Initial commit"
> > sleep 1
> > git switch -c foobar
> > git commit --allow-empty -m "Foo1"
> > sleep 1
> > git commit --allow-empty -m "Foo2"
> > git switch master
> > git merge --no-ff --no-edit foobar
> > # look at merge commit message now
> 
> Thanks for the reproducer, I can confirm it shows the bug for me. What I
> missed this morning was that we promptly chop the '\n' off the end of the
> message we get back from fmt_merge_msg(). I've looked through the history
> and this behavior dates back to the beginning of the builtin merge added in
> 1c7b76be7d ("Build in merge", 2008-07-07). Back then we added a newline to
> the end of the message before writing .git/MERGE_MSG or committing in
> finish_automerge() but merge_trivial() did not add a new line before
> committing. Commit 66f4b98ad9 ("Teach merge the '[-e|--edit]' option",
> 2011-10-08) added prepare_to_commit() which added the newline and was called
> by both finish_automerge() and merge_trivial(). This behavior was changed in
> d540b70c85 ("merge: cleanup messages like commit", 2019-04-17) after which
> we only added a newline if the message was going to be edited. I've cc'd
> Denton to see if he remembers if this was intentional or not.

I think we still end up calling cleanup_message() on the result before
using it as the final message, and that will fix any missing newline.
But we feed the intermediate state before then to the hooks (which is
exactly where one might expect to use interpret-trailers).

I'm not sure if we should be doing a preemptive call to
cleanup_message() before feeding the hooks (we'd still need to do the
final one, to clean up whatever the hooks return to us). I guess
probably not, because I think that would remove comments, as well. So
adding in just the missing newline is probably better.

> I suspect the best way to fix this is to stop stripping the newline that is
> added by fmt_merge_msg() and remove the line in prepare_to_commit() that
> adds the newline when editing. That would leave '-F' untouched so it would
> still not add missing newline in that case - I'm not sure if that is
> desirable or not but I think it matches what 'git commit -F' does.

Since it will usually be added back in by cleanup_message() anyway, I
think it's OK to just add it preemptively. The exception would be if the
user asked for no cleanup at all. So making it conditional on
cleanup_mode would work, whether -F or not.

I suppose that does mean people turning off cleanup mode would get a
message without a newline from fmt_merge_msg(), though, which is perhaps
unexpected.

So maybe just keeping the newline there, as you suggest, is the best
way.

> The commit message should explain why you're making the change - that is not
> unnecessary detail but essential context to help others reading the history
> in the future to understand the reason for the change.

Yes. A summary of the problem, the reasoning, and the discussion here
would be appropriate for the commit message.

-Peff
