Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 124141F731
	for <e@80x24.org>; Tue,  6 Aug 2019 04:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbfHFETN (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 00:19:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:34946 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725853AbfHFETN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 00:19:13 -0400
Received: (qmail 12191 invoked by uid 109); 6 Aug 2019 04:19:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 06 Aug 2019 04:19:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31502 invoked by uid 111); 6 Aug 2019 04:21:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 06 Aug 2019 00:21:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 6 Aug 2019 00:19:11 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Lukas Gross <lukasgross@u.northwestern.edu>, git@vger.kernel.org
Subject: Re: amend warnings with no changes staged
Message-ID: <20190806041911.GA9243@sigill.intra.peff.net>
References: <CAOY1tUUmkRBEDkF3GiP45WSi50uUGBaamx9-PGej0Z-yt0ioPg@mail.gmail.com>
 <20190806013030.GA61803@google.com>
 <CAOY1tUVpeUftgHNuZg-2fMD9D+Qz08hfvRvQDe1f8+MV2xYv2w@mail.gmail.com>
 <20190806021618.GC61803@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190806021618.GC61803@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 05, 2019 at 07:16:18PM -0700, Jonathan Nieder wrote:

> Lukas Gross wrote:
> 
> > I had intended to stage commits but forgot to do so. Git responded
> > with a normal commit creation message, so I pushed to the remote to
> > begin a CI build. When the build failed for the same reason, I
> > realized I had forgotten to stage the changes. An additional line in
> > the response to the effect of “Warning: did you mean to amend with no
> > changes?” would be very helpful to shorten this feedback loop.
> 
> On second thought:
> 
> 	$ git commit --amend --no-edit
> 	[detached HEAD 33a3db8805] Git 2.23-rc1
> 	 Author: Junio C Hamano <gitster@pobox.com>
> 	 Date: Fri Aug 2 13:12:24 2019 -0700
> 	 2 files changed, 2 insertions(+), 1 deletion(-)
> 	$
> 
> Some non-judgemental descriptive output like
> 
> 	$ git commit --amend --no-edit
> 	No changes.
> 	$
> 
> would address this case, without bothering people who are doing it
> intentionally.  So I think there's room for a simple improvement here.
> 
> Care to take a stab at it?  builtin/commit.c would be the place to
> start.

I'm not clear on the situation from your second change. There are two
sets of changes to talk about here: the changes between the new commit
and its parent, and the changes between the original commit and the
amended version.

The output in your first example is showing the differences to the
parent. Do you mean in the second example that there are no changes to
the parent, and thus we say "No changes"? If not, then what happened to
that output? :)

And if so, then I don't think it is solving Lukas's problem. I imagine
the issue to be (because I have done this myself many times):

  git commit -m 'buggy commit'
  echo fix >>file.c
  git commit --amend ;# oops, should have been "-a"
  git push

But perhaps that gets to the heart of the matter. Could we perhaps be
providing a more detailed summary of what happened for an --amend? I.e.,
to summarize _both_ sets of changes (and if one set is empty, say so)?

I'm not quite sure how to make that readable. Something like:

  $ git commit --amend
  [master 5787bce] some commit subject
   Date: Tue Aug 6 00:03:28 2019 -0400
  Changes introduced by this commit (diff HEAD^):
   1 file changed, 1 insertion(+)
   create mode 100644 added-by-broken-commit
  Changes from the amend commit (diff HEAD@{1}):
   1 file changed, 1 insertion(+)
   create mode 100644 added-during-amend

is pretty ugly. And anyway, because it's just the diffstat total, it's
hard to see whether it contains your changes or not (i.e., would you
notice if you forgot to stage 3 lines from some random file). OTOH, if
the common case we care about is just "you didn't stage anything as part
of the amend", then it would be enough to let you know (without making a
judgement about whether it's an error, since it may well be that you
were simply rewording the commit message).

-Peff
