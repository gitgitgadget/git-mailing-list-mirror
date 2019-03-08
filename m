Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D40120248
	for <e@80x24.org>; Fri,  8 Mar 2019 16:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfCHQUe (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 11:20:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:43914 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726294AbfCHQUe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 11:20:34 -0500
Received: (qmail 15680 invoked by uid 109); 8 Mar 2019 16:20:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Mar 2019 16:20:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1718 invoked by uid 111); 8 Mar 2019 16:20:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 08 Mar 2019 11:20:51 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Mar 2019 11:20:32 -0500
Date:   Fri, 8 Mar 2019 11:20:32 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] line-log: suppress diff output with "-s"
Message-ID: <20190308162031.GA17326@sigill.intra.peff.net>
References: <20190307194514.GA29260@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1903081636350.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1903081636350.41@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 08, 2019 at 04:38:44PM +0100, Johannes Schindelin wrote:

> On Thu, 7 Mar 2019, Jeff King wrote:
> 
> > When "-L" is in use, we ignore any diff output format that the user
> > provides to us, and just always print a patch (with extra context lines
> > covering the whole area of interest). It's not entirely clear what we
> > should do with all formats (e.g., should "--stat" show just the diffstat
> > of the touched lines, or the stat for the whole file?).
> > 
> > But "-s" is pretty clear: the user probably wants to see just the
> > commits that touched those lines, without any diff at all. Let's at
> > least make that work.
> 
> Agree. The patch looks obviously good.

Thanks. This leaves the other formats as silently ignored. Do we want to
do something like this:

diff --git a/revision.c b/revision.c
index eb8e51bc63..a1b4fe2aa6 100644
--- a/revision.c
+++ b/revision.c
@@ -2689,6 +2689,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	if (revs->first_parent_only && revs->bisect)
 		die(_("--first-parent is incompatible with --bisect"));
 
+	if (revs->line_level_traverse &&
+	    (revs->diffopt.output_format & ~(DIFF_FORMAT_PATCH|DIFF_FORMAT_NO_OUTPUT)))
+		die(_("-L does not yet support diff formats besides -p and -s"));
+
 	if (revs->expand_tabs_in_log < 0)
 		revs->expand_tabs_in_log = revs->expand_tabs_in_log_default;
 

?

-Peff
