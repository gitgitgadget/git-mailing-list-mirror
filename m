Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54B981F4C0
	for <e@80x24.org>; Sat, 26 Oct 2019 17:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbfJZRhD (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Oct 2019 13:37:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:59258 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726232AbfJZRhD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Oct 2019 13:37:03 -0400
Received: (qmail 30853 invoked by uid 109); 26 Oct 2019 17:37:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 26 Oct 2019 17:37:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19363 invoked by uid 111); 26 Oct 2019 17:40:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 26 Oct 2019 13:40:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 26 Oct 2019 13:37:02 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Luke Dashjr <luke@dashjr.org>, git@vger.kernel.org
Subject: Re: GIT_COMMITTER_* and reflog
Message-ID: <20191026173702.GA5522@sigill.intra.peff.net>
References: <201910252149.23787.luke@dashjr.org>
 <20191026022039.GE39574@google.com>
 <xmqqv9scark1.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv9scark1.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 26, 2019 at 04:34:22PM +0900, Junio C Hamano wrote:

> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
> > If GIT_COMMITTER_{NAME,EMAIL} were used when writing reflogs but
> > GIT_COMMITTER_DATE weren't, would that help with your workflow?
> 
> Thanks for a thoughtful response.
> 
> My knee-jerk reaction is that it probably was a design bug that came
> out of laziness that we used the usual mechanism to obtain the
> committer date when deciding the timestamp we leave in reflog
> entries.  Given that we say master@{6.hours.ago} etc., we should
> base the timestamp on something that is coherent with what the end
> users would give us, e.g. "6.hours.ago".  IOW, we should be using
> the wallclock time without paying attention to GIT_COMMITTER_DATE,
> i.e. date.c::get_time().

FWIW, I was about to write a similar response. If people really wanted a
separate reflog ident, I could see introducing $GIT_REFLOG_NAME, etc.
But the current date handling just seems buggy (and an unintended
consequence of reusing the existing ident code).

If somebody wants to pursue a patch, I suspect the solution is probably
something like this (totally untested):

diff --git a/refs/files-backend.c b/refs/files-backend.c
index d60767ab73..2ebf2feeb8 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1658,7 +1658,10 @@ static int files_log_ref_write(struct files_ref_store *refs,
 	if (logfd < 0)
 		return 0;
 	result = log_ref_write_fd(logfd, old_oid, new_oid,
-				  git_committer_info(0), msg);
+				  fmt_ident(getenv("GIT_COMMITTER_NAME"),
+					    getenv("GIT_COMMITTER_EMAIL"),
+					    WANT_COMMITTER_IDENT, NULL, 0),
+				  msg);
 	if (result) {
 		struct strbuf sb = STRBUF_INIT;
 		int save_errno = errno;

-Peff
