Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6B1E20248
	for <e@80x24.org>; Mon, 11 Mar 2019 03:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfCKDyf (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Mar 2019 23:54:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:45424 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727037AbfCKDyf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Mar 2019 23:54:35 -0400
Received: (qmail 19853 invoked by uid 109); 11 Mar 2019 03:54:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 11 Mar 2019 03:54:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20142 invoked by uid 111); 11 Mar 2019 03:54:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 10 Mar 2019 23:54:53 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 10 Mar 2019 23:54:33 -0400
Date:   Sun, 10 Mar 2019 23:54:33 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] line-log: suppress diff output with "-s"
Message-ID: <20190311035432.GC7087@sigill.intra.peff.net>
References: <20190307194514.GA29260@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1903081636350.41@tvgsbejvaqbjf.bet>
 <20190308162031.GA17326@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1903081942340.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1903081942340.41@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 08, 2019 at 07:44:22PM +0100, Johannes Schindelin wrote:

> > Do we want to do something like this:
> > 
> > diff --git a/revision.c b/revision.c
> > index eb8e51bc63..a1b4fe2aa6 100644
> > --- a/revision.c
> > +++ b/revision.c
> > @@ -2689,6 +2689,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
> >  	if (revs->first_parent_only && revs->bisect)
> >  		die(_("--first-parent is incompatible with --bisect"));
> >  
> > +	if (revs->line_level_traverse &&
> > +	    (revs->diffopt.output_format & ~(DIFF_FORMAT_PATCH|DIFF_FORMAT_NO_OUTPUT)))
> > +		die(_("-L does not yet support diff formats besides -p and -s"));
> > +
> >  	if (revs->expand_tabs_in_log < 0)
> >  		revs->expand_tabs_in_log = revs->expand_tabs_in_log_default;
> 
> Since you already have that patch, why not go wild and apply it, too? ;-)

OK, then. Here it is as a real patch.

> I guess you copy-edited the code from somewhere because you usually do
> leave spaces around the `|`... I don't care, though ;-)

Heh, nope, I wrote it by hand.

I actually wondered if there was a better way to write this. One of the
things that bugs me about the patch is that this policy check is so far
from actual line-log code, which means the two may drift apart over
time. We could put a LINE_LOG_SUPPORTED_FORMATS into line-log.h, but
that's also pretty far from the actual code. We could just make the
output logic in the line-log code something like:

  if (NO_OUTPUT)
	...do no output...
  else if (PATCH || DEFAULT)
        ...show normal patch...
  else
	die("unsupported output format");

but it's probably a little friendlier to diagnose the problem up front,
not after we did a bunch of computation.  And most of these other
"incompatible" checks in setup_revisions() suffer from the same
maintainability problem. So instead, I went with the code above (with
spaces!) and protected it with some tests.

-- >8 --
Subject: [PATCH] line-log: detect unsupported formats

If you use "log -L" with an output format like "--raw" or "--stat",
we'll silently ignore the format and just output the normal patch.
Let's detect and complain about this, which at least tells the user
what's going on.

The tests here aren't exhaustive over the set of all formats, but it
should at least let us know if somebody breaks the format-checking.

Signed-off-by: Jeff King <peff@peff.net>
---
On top of the other patch, naturally.

 revision.c          |  4 ++++
 t/t4211-line-log.sh | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/revision.c b/revision.c
index eb8e51bc63..cb69a227d5 100644
--- a/revision.c
+++ b/revision.c
@@ -2689,6 +2689,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	if (revs->first_parent_only && revs->bisect)
 		die(_("--first-parent is incompatible with --bisect"));
 
+	if (revs->line_level_traverse &&
+	    (revs->diffopt.output_format & ~(DIFF_FORMAT_PATCH | DIFF_FORMAT_NO_OUTPUT)))
+		die(_("-L does not yet support diff formats besides -p and -s"));
+
 	if (revs->expand_tabs_in_log < 0)
 		revs->expand_tabs_in_log = revs->expand_tabs_in_log_default;
 
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index c9f2036f68..1db7bd0f59 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -122,4 +122,14 @@ test_expect_success '-s shows only line-log commits' '
 	test_cmp expect actual
 '
 
+test_expect_success '-p shows the default patch output' '
+	git log -L1,24:b.c >expect &&
+	git log -L1,24:b.c -p >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--raw is forbidden' '
+	test_must_fail git log -L1,24:b.c --raw
+'
+
 test_done
-- 
2.21.0.787.gbeacff058d

