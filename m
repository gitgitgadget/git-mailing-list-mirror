Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F13AC43334
	for <git@archiver.kernel.org>; Thu,  9 Jun 2022 18:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345496AbiFISnj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 14:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345517AbiFISn2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 14:43:28 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C0E1CAD25
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 11:43:26 -0700 (PDT)
Received: (qmail 11547 invoked by uid 109); 9 Jun 2022 18:43:26 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.0.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Jun 2022 18:43:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Date:   Thu, 9 Jun 2022 14:43:25 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kyle Meyer <kyle@kyleam.com>, Tassilo Horn <tsdh@gnu.org>,
        Tao Klerks <tao@klerks.biz>, git@vger.kernel.org
Subject: Re: [BUG?] Major performance issue with some commands on our repo's
 master branch
Message-ID: <YqI/TcZyXomxtXtN@coredump.intra.peff.net>
References: <87h750q1b9.fsf@gnu.org>
 <CAPMMpohzqKo-+q-tOcXymmzGxuOY-mf2NPRviHURm8-+3MPjZg@mail.gmail.com>
 <87y1yb2xc8.fsf@gnu.org>
 <YqEyh5opAaJxph2+@coredump.intra.peff.net>
 <87sfoe7hio.fsf@kyleam.com>
 <YqILyX97zKg5ViUS@coredump.intra.peff.net>
 <xmqqedzxlmpt.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqedzxlmpt.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 09, 2022 at 11:23:58AM -0700, Junio C Hamano wrote:

> > I think you'd do better to have a mode specific to git-show that skips
> > the diff if we're not showing it, but makes sure to always show the
> > commit anyway.
> 
> Meaning an explicit option "git show --log-only"?  We'd need to
> careful to make it either (1) be incompatible with certain features
> of "git show" (like giving a pathspec) and error out, or (2) ignore
> these features of "git show" silently and document that.  But it
> would work as a new option.

Certainly a new option would mean we weren't regressing any existing
behavior. I do think it would be a hard option to explain, though.

But what I wondered is whether "show" in particular, because it would
never want to skip showing a commit, could get away with avoiding the
diff automatically. I.e., currently "git show -Sfoo HEAD" will always
show HEAD, even if "-S" does not match anything. So if we are not
showing any diff output, there is no need to compute the diff in that
case. That is unlike "git log", which would omit commits that didn't
match.

And really it is not "git show" that is special there, but the
always_show_header flag it sets. So something like this might work:

diff --git a/log-tree.c b/log-tree.c
index d0ac0a6327..ed57386938 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -1024,6 +1024,10 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 	if (!all_need_diff && !opt->merges_need_diff)
 		return 0;
 
+	if (opt->diffopt.output_format == DIFF_FORMAT_NO_OUTPUT &&
+	    opt->always_show_header)
+		return 0;
+
 	parse_commit_or_die(commit);
 	oid = get_commit_tree_oid(commit);
 

It produces the same output in the cases I tried. And running with
GIT_TRACE2_PERF shows that it doesn't diff and rename code.

I'm not overly confident that it isn't violating some other subtle
assumption / corner case that I haven't thought of, though. :)

-Peff
