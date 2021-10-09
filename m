Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADE8C433F5
	for <git@archiver.kernel.org>; Sat,  9 Oct 2021 02:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C789560D07
	for <git@archiver.kernel.org>; Sat,  9 Oct 2021 02:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244245AbhJICiA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 22:38:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:36298 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232256AbhJICh7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 22:37:59 -0400
Received: (qmail 7201 invoked by uid 109); 9 Oct 2021 02:36:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 09 Oct 2021 02:36:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27976 invoked by uid 111); 9 Oct 2021 02:36:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 08 Oct 2021 22:36:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 8 Oct 2021 22:36:02 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Krzysztof =?utf-8?Q?=C5=BBelechowski?= <giecrilj@stegny.2a.pl>,
        git@vger.kernel.org, Hamza Mahfooz <someguy@effective-light.com>
Subject: Re: *Really* noisy encoding warnings post-v2.33.0
Message-ID: <YWEAEjIN0HVHbIpg@coredump.intra.peff.net>
References: <9896630.2IqcCWsCYL@localhost.localdomain>
 <YSWVi8uLHZCTtG0l@coredump.intra.peff.net>
 <xmqqeeahjxj4.fsf@gitster.g>
 <YSkvNyR4uT52de13@coredump.intra.peff.net>
 <87ily7m1mv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ily7m1mv.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 09, 2021 at 02:58:10AM +0200, Ævar Arnfjörð Bjarmason wrote:

> I ran into this while testing the grep coloring patch[1] (but it's
> unrelated). Before this commit e.g.:
> 
>     LC_ALL=C ~/g/git/git -P -c i18n.commitEncoding=ascii log --author=Ævar -100|wc -l
>     28333
> 
> So ~3k lines for my last 100 commits, but then:
> 
>     $ LC_ALL=C ~/g/git/git -P -c i18n.commitEncoding=ascii log --author=Ævar -100 2>&1|grep -c ^warning
>     299
> 
> At first I thought it was spewing warnings for every failed re-encoded
> line in some cases, because I get hundreds at a time sometimes, but it's
> because stderr and stdout I/O buffering is different (a common
> case). Adding a "fflush(stderr)" "fixes" that.

I don't think the buffering is the issue. By default stderr flushes on
lines, and we flush commits after showing them. If you take away "-P"
(or look at the combined 2>&1 output in order), you'll see that they are
grouped.

Now one thing you might notice is that there may be multiple warnings
between output commits. But that's because we really are re-encoding
each of those intermediate commits to do your --author grep. And if that
re-encoding fails, we may well be producing the wrong output, because
the matching won't be correct (in your case, presumably the correct
output should be _nothing_, because Æ is not an ascii character).

I do think the current warning is particularly bad there, because it
doesn't even mention the commit oid. So something like:

diff --git a/pretty.c b/pretty.c
index 708b618cfe..ddf501632d 100644
--- a/pretty.c
+++ b/pretty.c
@@ -673,7 +673,8 @@ const char *repo_logmsg_reencode(struct repository *r,
 	 * case we just return the commit message verbatim.
 	 */
 	if (!out) {
-		warning("unable to reencode commit to '%s'", output_encoding);
+		warning("unable to reencode commit %s to '%s'",
+			oid_to_hex(&commit->object.oid), output_encoding);
 		return msg;
 	}
 	return out;

means you get output like:

  $ git -c i18n.commitEncoding=ascii log --format='%h %s' --author=Ævar -100
  warning: unable to reencode commit c90cfc225baaf64af311f7e2953267e4de636205 to 'ascii'
  warning: unable to reencode commit 1d1d731d30cbcd5f3a6a5cbac1fe218e4d4db72b to 'ascii'
  warning: unable to reencode commit 66237bcf60df357f188551e1ea4db90f94c519ae to 'ascii'
  warning: unable to reencode commit 100c2da2d3a330366588143d720f09a88926972a to 'ascii'
  warning: unable to reencode commit 59580685bee17de3efff614df7f508133d1e4a7a to 'ascii'
  59580685be config.h: remove unused git_config_get_untracked_cache() declaration
  warning: unable to reencode commit 067e73c8aee9aeb05eac939205274cd2ad8b7cae to 'ascii'
  067e73c8ae log-tree.h: remove unused function declarations
  [...etc...]

If that were coupled with, say, an advise() call to explain that output
and matching might be inaccurate (and show that _once_), that might
might it more clear what's going on.

Now I am sympathetic to flooding the user with too many messages, and
maybe reducing this to a single instance of "some commit messages could
not be re-encoded; output and matching might be inaccurate" is the right
thing. But in a sense, it's also working as designed: what you asked for
is producing wrong output over and over, and Git is saying so.

I'm not even sure what you're trying to do with that command. It could
never output a single correct commit, because you've asked to match only
commits that will be shown in the wrong encoding.

> But anyway, I think we've got a lot of users who say *do* want to
> reencode something from say UTF-8 to latin1, but then might have the
> occasional non-latin1 representable data. The old behavior of silently
> falling back is going to be much better for those users, or maybe show
> one warning at the end or something, if you feel it really needs to be
> kept.

If there are real-world cases where the quantity of errors is really
getting in the way, I'm open to the idea of having a single error
message. And personally, I don't really have any experience working with
broken encodings (all my commits are in utf8, and that's what I use as
output). It just seems weird to me that 'git log --encoding=foo' would
quietly ignore the option entirely (i.e., the old behavior, which did
lead to a confused user and a post to the list).

-Peff
