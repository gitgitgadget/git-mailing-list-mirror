Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B85C433DF
	for <git@archiver.kernel.org>; Thu, 21 May 2020 19:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B27820823
	for <git@archiver.kernel.org>; Thu, 21 May 2020 19:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729964AbgEUTzP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 15:55:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:53932 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728635AbgEUTzO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 15:55:14 -0400
Received: (qmail 15383 invoked by uid 109); 21 May 2020 19:55:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 21 May 2020 19:55:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1097 invoked by uid 111); 21 May 2020 19:55:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 21 May 2020 15:55:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 21 May 2020 15:55:13 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Anyone know what is creating commits with bogus dates?
Message-ID: <20200521195513.GA1542632@coredump.intra.peff.net>
References: <CABPp-BFfa6q96qMUN07Dq3di6d3WuUzhyktBytbX=FGgarXgjg@mail.gmail.com>
 <20200521185753.GB1308489@coredump.intra.peff.net>
 <CABPp-BG+XdbeOgaL1Th6U8g-gRON41DCwZ-RDnN7CEgk2fvwDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BG+XdbeOgaL1Th6U8g-gRON41DCwZ-RDnN7CEgk2fvwDg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 21, 2020 at 12:31:36PM -0700, Elijah Newren wrote:

> > I can't remember the source of the bug, but we've had a workaround in
> > GitHub's incoming fsck checks to allow 6-digit zones like this since
> > August 2011. I'm almost certain that it came up because of that
> > rails/rails commit, but I don't remember the culprit implementation. I'm
> > sure we would have dug it up and fixed it at the time.
> 
> What about 7- and 8- digit timezones (like the ones in the linked
> filter-repo issue report)?  Do you currently prevent users from
> pushing those to GitHub, or do you allow those too?
> I'm curious about whether there is anything else out there that might
> help flag these commits or if it's just filter-repo.

Our loosening allows any size:

--- a/fsck.c
+++ b/fsck.c
[...]
@@ -772,14 +778,16 @@ static int fsck_ident(const char **ident,
        if ((end == p || *end != ' '))
                return report(options, oid, type, FSCK_MSG_BAD_DATE, "invalid author/committer line - bad date");
        p = end + 1;
-       if ((*p != '+' && *p != '-') ||
-           !isdigit(p[1]) ||
-           !isdigit(p[2]) ||
-           !isdigit(p[3]) ||
-           !isdigit(p[4]) ||
-           (p[5] != '\n'))
+       if (*p != '+' && *p != '-')
                return report(options, oid, type, FSCK_MSG_BAD_TIMEZONE, "invalid author/committer line - bad time zone");
-       p += 6;
+       p++;
+
+       do {
+               if (!isdigit(*p))
+                       return report(options, oid, type, FSCK_MSG_BAD_TIMEZONE, "invalid author/committer line - bad time zone");
+               p++;
+       } while (*p != '\n');
+

I don't remember the nature of the bug well enough to know if the longer
ones are likely to have the same cause.

> > But I think it would be safe to assume the bug is long-since fixed, and
> > it's nice if you can be a bit more lenient on the parsing for historical
> > issues like this. Arguably fast-export ought to be normalizing it to
> > something syntactically correct (just like we probably do with other
> > unparsable dates), though I guess you could argue that a filter might
> > want to see the broken form in order to fix it in a custom way.
> 
> If we're going to be more lenient on the parsing, does that suggest
> fast-import shouldn't die on these?  Currently, fast-import is the
> thing dying, not fast-export or filter-repo (though filter-repo of
> course halts when it notices that fast-import has died under it).

Ah, I thought filter-repo was noticing. I think it would be nice for
either fast-export or fast-import to normalize syntactically invalid
values to something sane (like just resetting a bogus timezone to
+0000). I could see arguments for putting it in either spot (putting it
in fast-import has the downside that we wouldn't catch invalid output
generated by a script; putting it in fast-export has the downside that
you can't notice and fix it up yourself if you choose to).

Probably it should be in fast-export, but with an option to turn it off
for people who want more control (or leave it off by default, and let
people who run into problems turn it on). We already have similar
options for handling un-exportable cases like signed tags.

> I put in special-case code in filter-repo to munge the +051800
> timezone case to keep fast-import from dying, but these new cases seem
> to suggest it's not just one bad timezone that I can check for and
> correct, but rather that they are completely random 7- or 8- (or who
> knows how many) digit timezones coupled with bogus
> (century-into-the-future) unix epochs.  I'm a little less comfortable
> working around all of these than the very specific +051800 issue.  On
> the filter-repo side, I think the most I would want to do here is
> provide cleaner warning or error messages than "fast-import died,
> here's a traceback."  But I'm unusre if there are other steps we
> should take as well, such as making the fast-import parser more
> lenient.

I think if filter-repo does anything, it would probably be to read any
syntactically invalid timezone and normalize it. But again, I think it
would be fine to push that into fast-export.

-Peff
