Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C79A12036D
	for <e@80x24.org>; Fri, 24 Nov 2017 17:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753901AbdKXRcF (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 12:32:05 -0500
Received: from cloud.peff.net ([104.130.231.41]:39464 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753565AbdKXRcD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Nov 2017 12:32:03 -0500
Received: (qmail 20197 invoked by uid 109); 24 Nov 2017 17:32:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 24 Nov 2017 17:32:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15609 invoked by uid 111); 24 Nov 2017 17:32:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Fri, 24 Nov 2017 12:32:20 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Nov 2017 12:32:01 -0500
Date:   Fri, 24 Nov 2017 12:32:01 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/5] sha1_file: don't re-scan pack directory for null sha1
Message-ID: <20171124173201.GA29190@sigill>
References: <20171120202607.tf2pvegqe35mhxjs@sigill.intra.peff.net>
 <20171120203523.c3pt5qi43e24ttqq@sigill.intra.peff.net>
 <xmqqd14cjr13.fsf@gitster.mtv.corp.google.com>
 <20171121225744.GA21197@sigill>
 <xmqqwp2jxf5l.fsf@gitster.mtv.corp.google.com>
 <20171122223613.GA1405@sigill>
 <xmqqpo89rac6.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpo89rac6.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 23, 2017 at 11:35:21AM +0900, Junio C Hamano wrote:

> Not limiting us to the caller in the "fetch" codepath, I think the
> expectation by callers of lookup_commit_reference_gently() in the
> ideal world would be:
> 
>  - It has an object name, and wants to use it as point in the commit
>    DAG to define the traversal over the DAG, if it refers to a
>    commit known to us.
> 
>  - It does not know if these object names represent a tag object, a
>    commit object, or some other object.  It does not know if the
>    local repository actually has them (e.g. we received a "have"
>    from the other side---missing is expected).
> 
>  - Hence, it would happily accept a NULL as "we do not have it" and
>    "we do have it, but it is not a commit-ish".
> 
> And from that point of view, 2, 3a (missing), and 4 (0{40}) to yield
> NULL is perfectly fine.  3b (exists but broken) may be a noteworthy
> event, but for the purpose of the caller, it may want to proceed as
> if the object is missing from our end, so it might deserve warning()
> but not die(), at least as the default behaviour.

Hmm, yeah, I did not differentiate 3a and 3b in my analysis. How we'd
want to handle "missing" would vary from caller to caller, I think.
Certainly for this case in "fetch" where it's the "old" value for a ref,
it would be a corruption not to have it. Just grepping around a few of
the other callers, I see:

  - archive.c:parse_treeish_arg: fine not to have it (we'd complain soon
    after that it doesn't point to a tree either). But also fine to
    complain hard.

  - blame.c:dwim_reverse_initial, and checkout_paths and switch_branches
    in checkout.c: missing object would mean a broken HEAD

  - show-branch.c:append_ref: missing would mean a broken ref

  - clear_commit_marks_for_object_array: conceptually OK to have a
    missing object, though I suspect practically impossible since we
    examined and marked the objects earlier

  - ref-filter's --merged, --contains, etc: the low-level code quietly
    ignores a missing object or non-commit, but the command-line parser
    enforces that we find a commit. So probably impossible to trigger,
    but arguably the second call should be a BUG().

So I dunno. That is far from exhaustive, but it does seem like most
cases should assume the presence of the file.

As for your proposed behavior:

> And from that point of view, 2, 3a (missing), and 4 (0{40}) to yield
> NULL is perfectly fine.  3b (exists but broken) may be a noteworthy
> event, but for the purpose of the caller, it may want to proceed as
> if the object is missing from our end, so it might deserve warning()
> but not die(), at least as the default behaviour.

That's actually not far from what happens now, with the only difference
being that we _do_ actually die() on a corruption (really any error
except ENOENT). I forgot that when I wrote my earlier message. You can
see it by updating the "fetch" reproduction I sent earlier to corrupt:

-- >8 --
git init parent
git -C parent commit --allow-empty -m base

git clone parent child
git -C parent commit --allow-empty -m more

cd child
for i in .git/objects/??/*
do
	chmod +w $i
	echo corrupt >$i
done
git fetch
-- 8< --

which gives something like:

error: inflate: data stream error (incorrect header check)
error: unable to unpack 55c66a401fd4190382f9cd8b70c11f9f5adb044e header
fatal: loose object 55c66a401fd4190382f9cd8b70c11f9f5adb044e (stored in .git/objects/55/c66a401fd4190382f9cd8b70c11f9f5adb044e) is corrupt

So that's good. I do still think that many of the callers of
lookup_commit_reference_gently() probably ought to die() in the
"missing" case rather than continue (and produce subtly wrong answers).
But it may not be that big a deal. For the most part, all bets are off
in a corrupt repo. My main concern is just that we do not want the
corruption to spread or to make it harder for us to recover from (and
that includes allowing us to delete or overwrite other data that would
otherwise be forbidden, which is what's happening in the fetch case).
Most of the callers probably don't fall into that situation, but it
might be nice to err on the side of caution.

-Peff
