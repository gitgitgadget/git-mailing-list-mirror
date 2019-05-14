Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 710D31F461
	for <e@80x24.org>; Tue, 14 May 2019 11:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfENLVR (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 07:21:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:56722 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725893AbfENLVR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 07:21:17 -0400
Received: (qmail 3900 invoked by uid 109); 14 May 2019 11:21:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 14 May 2019 11:21:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11919 invoked by uid 111); 14 May 2019 11:21:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 14 May 2019 07:21:55 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 May 2019 07:21:15 -0400
Date:   Tue, 14 May 2019 07:21:15 -0400
From:   Jeff King <peff@peff.net>
To:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
Cc:     git@vger.kernel.org
Subject: Re: some git confusion (where git's advice didn't help)
Message-ID: <20190514112115.GA26957@sigill.intra.peff.net>
References: <5CDA9063020000A10003131D@gwsmtp.uni-regensburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5CDA9063020000A10003131D@gwsmtp.uni-regensburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 14, 2019 at 11:54:43AM +0200, Ulrich Windl wrote:

> > git branch --track origin/f-gcc-4.8
> Branch origin/f-gcc-4.8 set up to track local branch next.
> > git fetch
> > git branch
>   f-systemd
>   integration
>   master
> * next
>   origin/f-gcc-4.8
> > git merge f-gcc-4.8
> merge: f-gcc-4.8 - not something we can merge
> 
> Did you mean this?
>         origin/f-gcc-4.8
> > git merge origin/f-gcc-4.8
> warning: refname 'origin/f-gcc-4.8' is ambiguous.
> Already up-to-date.
> 
> ### So actually this advice wasn't helpful at all. Cause of the
> problem most likely was "git branch --track origin/f-gcc-4.8" that
> "imported" the branch under the same name as the remote branch is
> referenced.

Right, that was the source of the problem. Having both
"refs/heads/origin/f-gcc-4.8" and "refs/remotes/origin/f-gcc-4.8" is
going to lead to confusion, and you're best off deleting the mistaken
branch as soon as possible.

But I agree we could be more helpful in the messages.

The "did you mean?" advice just blindly says "oh, you asked for X and
refs/remotes/ABC/X exists, so let's suggest ABC/X", without checking for
ambiguities. It should probably do this:

diff --git a/help.c b/help.c
index a9e451f2ee..108ca54af3 100644
--- a/help.c
+++ b/help.c
@@ -759,7 +759,8 @@ static int append_similar_ref(const char *refname, const struct object_id *oid,
 	/* A remote branch of the same name is deemed similar */
 	if (skip_prefix(refname, "refs/remotes/", &remote) &&
 	    !strcmp(branch, cb->base_ref))
-		string_list_append(cb->similar_refs, remote);
+		string_list_append(cb->similar_refs,
+				   shorten_unambiguous_ref(refname, 1));
 	return 0;
 }
 

which would print "ABC/X" in most cases, but "remotes/ABC/X" for your
ambiguous case. Incidentally, the existing code also has a memory
problem! It blindly skips past "refs/remotes/" in the refname and saves
the pointer away in a NODUP string-list. But that refname pointer isn't
ours, and isn't guaranteed to last past our for_each_ref() callback. The
hunk above fixes it because shorten_unambiguous_ref() always returns a
newly allocated string. :)

I also think the "warning: refname ... is ambiguous" message would
probably be a bit more helpful if it showed _which_ candidates it found
(and which one it chose!).

-Peff
