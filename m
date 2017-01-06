Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C137B20756
	for <e@80x24.org>; Fri,  6 Jan 2017 07:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162547AbdAFHcc (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 02:32:32 -0500
Received: from cloud.peff.net ([104.130.231.41]:35870 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1034805AbdAFHc3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2017 02:32:29 -0500
Received: (qmail 25877 invoked by uid 109); 6 Jan 2017 07:32:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 06 Jan 2017 07:32:26 +0000
Received: (qmail 15168 invoked by uid 111); 6 Jan 2017 07:33:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 06 Jan 2017 02:33:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Jan 2017 02:32:25 -0500
Date:   Fri, 6 Jan 2017 02:32:25 -0500
From:   Jeff King <peff@peff.net>
To:     Trygve Aaberge <trygveaa@gmail.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: Regression: Ctrl-c from the pager in an alias exits it
Message-ID: <20170106073224.5hsrib77tx5tgx7d@sigill.intra.peff.net>
References: <20170105142529.GA15009@aaberge.net>
 <20170106064032.eqxxer5mx5hsh2md@sigill.intra.peff.net>
 <20170106064752.iccrk656c6k2wrfy@sigill.intra.peff.net>
 <20170106072602.wkbzho5z3osz5hee@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170106072602.wkbzho5z3osz5hee@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 06, 2017 at 02:26:02AM -0500, Jeff King wrote:

> You'll notice that it actually calls wait() on the pager. That's due to
> a3da882120 (pager: do wait_for_pager on signal death, 2009-01-22), which
> IIRC was addressing a very similar problem. We want to stop feeding the
> pager when we get a signal, but we don't want the main process to
> actually exit, or the pager loses the controlling terminal.
> 
> In our new scenario we have an extra process, though. The git-log child
> will wait on the pager, but the parent process can't. It doesn't know
> about it. I think that it in turn needs to wait on the child when it
> dies, and then the whole chain will stand still until the pager exits.

And here's a patch to do that. It seems to work.

I'll sleep on it and then write up a commit message tomorrow if it still
makes sense.

diff --git a/run-command.c b/run-command.c
index ca905a9e80..db47c429b7 100644
--- a/run-command.c
+++ b/run-command.c
@@ -29,6 +29,8 @@ static int installed_child_cleanup_handler;
 
 static void cleanup_children(int sig, int in_signal)
 {
+	struct child_to_clean *children_to_wait_for = NULL;
+
 	while (children_to_clean) {
 		struct child_to_clean *p = children_to_clean;
 		children_to_clean = p->next;
@@ -45,6 +47,17 @@ static void cleanup_children(int sig, int in_signal)
 		}
 
 		kill(p->pid, sig);
+		p->next = children_to_wait_for;
+		children_to_wait_for = p;
+	}
+
+	while (children_to_wait_for) {
+		struct child_to_clean *p = children_to_wait_for;
+		children_to_wait_for = p->next;
+
+		while (waitpid(p->pid, NULL, 0) < 0 && errno == EINTR)
+			; /* spin waiting for process exit or error */
+
 		if (!in_signal)
 			free(p);
 	}
