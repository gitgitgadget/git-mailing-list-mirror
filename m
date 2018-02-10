Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D70511F404
	for <e@80x24.org>; Sat, 10 Feb 2018 12:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751027AbeBJMQK (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Feb 2018 07:16:10 -0500
Received: from cloud.peff.net ([104.130.231.41]:48070 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750968AbeBJMQK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Feb 2018 07:16:10 -0500
Received: (qmail 24564 invoked by uid 109); 10 Feb 2018 12:16:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 10 Feb 2018 12:16:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30728 invoked by uid 111); 10 Feb 2018 12:16:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 10 Feb 2018 07:16:53 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Feb 2018 07:16:07 -0500
Date:   Sat, 10 Feb 2018 07:16:07 -0500
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Andreas Kalz <andreas-kalz@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Bug? Error during commit
Message-ID: <20180210121607.GA21843@sigill.intra.peff.net>
References: <trinity-cb66d9d6-9035-4c98-948e-6857a7bd4de2-1517838396145@3c-app-gmx-bs16>
 <trinity-5e3c4029-b348-4bd5-9337-215808436a12-1517838482997@3c-app-gmx-bs16>
 <CACsJy8CGQ4ynYFT0mY1DfcGGdzwP36eonMvr-kEZazX_82ag2Q@mail.gmail.com>
 <20180207204520.GA31757@sigill.intra.peff.net>
 <CACsJy8C72Gv4D46tOmgTqi=8aHVG7D=yZR2F7VPLRcm1e_jTYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8C72Gv4D46tOmgTqi=8aHVG7D=yZR2F7VPLRcm1e_jTYg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 10, 2018 at 05:21:05PM +0700, Duy Nguyen wrote:

> > But it doesn't seem to work:
> >
> >   $ yes | head -c $((1024*1024*1024 - 10*1024*1024)) >file
> >   $ git add file
> >   $ git commit -m one
> >   $ yes | head -c $((1024*1024*1024)) >file
> >   $ git commit -am two
> >   fatal: unable to generate diffstat for file
> >
> > What's weird is that if I run "git show --stat" on the same commit, it
> > works! So there's something about how commit invokes the diff that
> > doesn't let the big-file check kick in.
> 
> I have a flashback about checking big_file_threshold in this code. I
> vaguely remember doing something in this code but not sure if it was
> merged.
> 
> I finally found 6bf3b81348 (diff --stat: mark any file larger than
> core.bigfilethreshold binary - 2014-08-16) so it's merged after all,
> but this commit is about --stat apparently ;-)

The confounding factor here is actually the break-detection that
"commit" does. After running the "commit" above (which does succeed
despite the "fatal", since that happens only as part of the diff summary
we print), you can replicate the problem with "git show -B --stat".

The break-detection code unconditionally loads the file data. Then when
the stat code later checks whether it's binary, it just uses the data
as-is. So that leads me to a few questions / lines of thought:

  1. When we're checking binary-ness, we shouldn't assume if the data
     is loaded that the size is sane. We should check it against
     big_file_threshold.

  2. Should break detection (and probably inexact rename detection) skip
     files that are over big_file_threshold?

     I think our code is capable of actually performing these operations
     on large files (at least on systems with 64-bit ulong; I'd be
     willing to bet you get funny results due to integer overflow on
     32-bit systems or on 64-bit Windows). But I'm not sure it's doing
     anybody any good. And it's way faster not to. For example, here's
     "git show" before and after the patch below (running on the repo
     from my example):

          $ time git show --oneline -B --stat | cat
          fatal: unable to generate diffstat for file
          883cbdc two
          
          real	0m10.153s
          user	0m9.929s
          sys	0m0.224s
          
          peff@sigill:~/tmp [master]
          $ time git.compile show --oneline -B --stat | cat
          883cbdc two
           file | Bin 1063256064 -> 1073741824 bytes
           1 file changed, 0 insertions(+), 0 deletions(-)
          
          real	0m0.008s
          user	0m0.002s
          sys	0m0.010s

     We can produce the useful answer in a fraction of the time, since
     we don't even need to load the blob content. The downside is that
     in theory we could break-detect these, and then find renames. So I
     guess it comes down to the philosophy of core.bigfilethreshold: how
     much effort are we willing to put into such files on the off chance
     that they produce a useful output?

     If we go this route, then in theory the fix in (1) becomes
     redundant, though I'd probably do both just as a
     belt-and-suspenders thing.

  3. To what degree should we override the user's config to treat these
     files as binary. If I set core.bigfilethreshold to "10G", or if I
     use gitattributes to mark the file as non-binary, then we're still
     going to feed it to xdiff (which is going to choke and die).

     Should we override these when we approach MAX_DIFF_SIZE, and just
     treat the file as binary? Should we barf and tell the user to fix
     their config?

     I guess I argued for overriding attributes earlier, and that
     probably ought to be independent of core.bigfilethreshold. Perhaps
     we should issue a warning in that case, to let the user know their
     config is nonsense.

> > I think we probably ought to consider anything over big_file_threshold
> > to be binary, no matter what. Possibly even if the user gave us a
> > .gitattribute that says "no really, this is text". Because that 1GB
> > limit is a hard limit that the code can't cope with; our options are
> > either to generate a binary diff or to die.
> 
> Agreed. While at there perhaps we need to improve this "unable to
> generate diffstat" message a bit too.

One reason the message is so vague is that we don't actually have any
kind of error code. Though really the only reason for xdiff to fail is
due to file size. So we could perhaps offer some advice there. But if we
do all the things I suggested above, then we'd automatically handle all
the cases we know about.

so my hope was that we would make it impossible to trigger this message.
In which case it maybe ought to be a BUG(). :)

Here's the patch to make "show -B --stat" work. I'll give some more
thought to whether this is a good idea and prepare a series.

One downside is that in the common case it causes us to look up each
object twice (once to get its size, and then again to load the content).
I wonder if we should have a function for "read this object, unless it's
over N bytes, in which case just tell me the size". That's weirdly
specific, but I think pretty much every user of core.bigfilethreshold
would want it.

---
diff --git a/diffcore-break.c b/diffcore-break.c
index c64359f489..35f5b50bcc 100644
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -61,6 +61,13 @@ static int should_break(struct diff_filespec *src,
 	    !oidcmp(&src->oid, &dst->oid))
 		return 0; /* they are the same */
 
+	if (diff_populate_filespec(src, CHECK_SIZE_ONLY) ||
+	    diff_populate_filespec(dst, CHECK_SIZE_ONLY))
+		return 0; /* error but caught downstream */
+
+	if (src->size > big_file_threshold || dst->size > big_file_threshold)
+		return 0; /* too big to be worth computation */
+
 	if (diff_populate_filespec(src, 0) || diff_populate_filespec(dst, 0))
 		return 0; /* error but caught downstream */
 
