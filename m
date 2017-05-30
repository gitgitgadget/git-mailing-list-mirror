Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2D992027C
	for <e@80x24.org>; Tue, 30 May 2017 15:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751101AbdE3P2B (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 11:28:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:59901 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750796AbdE3P2A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 11:28:00 -0400
Received: (qmail 23142 invoked by uid 109); 30 May 2017 15:27:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 May 2017 15:27:58 +0000
Received: (qmail 25426 invoked by uid 111); 30 May 2017 15:28:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 May 2017 11:28:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 May 2017 11:27:56 -0400
Date:   Tue, 30 May 2017 11:27:56 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Zero King <l2dy@macports.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 8/8] t0012: test "-h" with builtins
Message-ID: <20170530152756.vs777v6unaxg6otb@sigill.intra.peff.net>
References: <20170530050949.dkgu3u26qj6ycusy@sigill.intra.peff.net>
 <20170530051930.pqywvihwl5klg7hz@sigill.intra.peff.net>
 <xmqqwp8yc255.fsf@gitster.mtv.corp.google.com>
 <20170530060555.ponbsyp4agdo4yau@sigill.intra.peff.net>
 <xmqqshjmc1wm.fsf@gitster.mtv.corp.google.com>
 <20170530061546.tdpuhvq7yk34rvlj@sigill.intra.peff.net>
 <xmqqo9uabhqt.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo9uabhqt.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 30, 2017 at 10:23:54PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Nope, I have those patches directly on your e83352ef23, and it passes. I
> > wonder if there's something funny between our environments. What does
> > the failure look like for you?
> 
> Travis seems to be seeing the same failure.  Curiously, the topic by
> itself passes for me; iow, pu fails, pu^2 doesn't fail.
> 
>     git.git/pu$ ./git rev-list -h
>     BUG: environment.c:173: setup_git_env called without repository
>     Aborted (core dumped)
> 
> Hmph...

Ah, OK, I can reproduce when merged with pu. Bisecting it was tricky.
To see the problem, you need both my new test _and_ b1ef400ee
(setup_git_env: avoid blind fall-back to ".git", 2016-10-20). The latter
is only in v2.13, so topics forked from v2.12 need that commit applied.

Anyway, the problem is sk/dash-is-previous, specifically fc5684b47
(revision.c: args starting with "-" might be a revision, 2017-02-25). It
looks like the revision parser used to just bail on "-h", because
revision.c would say "I don't recognize this" and then cmd_rev_list()
would similarly say "I don't recognize this" and call usage(). But now
we actually try to read it as a ref, which obviously requires being
inside a repository.

Normally that's OK, but because of the "-h doesn't set up the repo"
thing from 99caeed05, we may not have setup the repo, and so looking up
refs is forbidden. The fix is probably to have revision.c explicitly
recognize "-h" and bail on it as an unknown option (it can't handle
the flag itself because only the caller knows the full usage()).

I do wonder, though, if there's any other downside to trying to look up
other options as revisions (at least it wastes time doing nonsense
revision lookups on options known only to cmd_rev_list()).  I'm not sure
why that commit passes everything starting with a dash as a possible
revision, rather than just "-".

I.e.:

diff --git a/revision.c b/revision.c
index 5470c33ac..1e26c3951 100644
--- a/revision.c
+++ b/revision.c
@@ -2233,7 +2233,14 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 			}
 			if (opts < 0)
 				exit(128);
-			maybe_opt = 1;
+			if (arg[1]) {
+				/* arg is an unknown option */
+				argv[left++] = arg;
+				continue;
+			} else {
+				/* special token "-" */
+				maybe_opt = 1;
+			}
 		}
 
 

I don't see anything in the commit message, but I didn't dig in the
mailing list. 


-Peff
