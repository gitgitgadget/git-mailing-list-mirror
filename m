Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DDFB1F404
	for <e@80x24.org>; Fri, 29 Dec 2017 13:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751070AbdL2NWk (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Dec 2017 08:22:40 -0500
Received: from cloud.peff.net ([104.130.231.41]:49156 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750744AbdL2NWk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Dec 2017 08:22:40 -0500
Received: (qmail 23481 invoked by uid 109); 29 Dec 2017 13:22:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 29 Dec 2017 13:22:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32184 invoked by uid 111); 29 Dec 2017 13:23:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Fri, 29 Dec 2017 08:23:08 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Dec 2017 08:22:37 -0500
Date:   Fri, 29 Dec 2017 08:22:37 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: Rewrite cat-file.c : need help to find a bug
Message-ID: <20171229132237.GA12561@sigill.intra.peff.net>
References: <CAL21BmnycG4=Wm_e1S85QVPfs3vV_Q=TAjTAG-sv+f2mK6wbBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL21BmnycG4=Wm_e1S85QVPfs3vV_Q=TAjTAG-sv+f2mK6wbBQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 29, 2017 at 01:05:50PM +0300, Оля Тележная wrote:

> Hi everyone,
> I am trying to reuse formatting logic from ref-filter in cat-file
> command. Now cat-file uses its own formatting code.
> I am trying to achieve that step-by-step, now I want to invoke
> populate_value function, and I have a bug somewhere.
> My code is here.
> https://github.com/telezhnaya/git/commits/catfile
> All commits that starts from "cat-file: " are successfully passing all tests.
> So for now my last commit fails, and I am tired of searching for the
> error. Actually, I just copied some values to another variable and
> move some code to other place. All "intelligent" work will go further,
> but now I need to fix current situation.

The problem is that "cat_file_info" is NULL when you get to
populate_value(), so the moved code doesn't trigger.

That variable is usually pulled from format->cat_file_data during
verify_ref_format(). But it triggers only when there's an actual format
atom to parse, and in this particular test the format is empty! But
cat-file is somewhat special here, in that even without any atoms it
needs to make sure the object exists.

So the patch below makes the test pass, though I think in the long run
all of this cat_file_info stuff would just get folded into regular
atoms, and you'd want cat-file to pass a special flag to ask ref-filter
to make sure the object exists.

-Peff

---
diff --git a/ref-filter.c b/ref-filter.c
index 62ca83807f..3acea4d2ef 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -742,6 +742,10 @@ int verify_ref_format(struct ref_format *format)
 {
 	const char *cp, *sp;
 
+	/* do this unconditionally, even if we have no atoms! */
+	if (format->cat_file_data)
+		cat_file_info = format->cat_file_data;
+
 	format->need_color_reset_at_eol = 0;
 	for (cp = format->format; *cp && (sp = find_next(cp)); ) {
 		const char *color, *ep = strchr(sp, ')');
@@ -753,7 +757,6 @@ int verify_ref_format(struct ref_format *format)
 
 		if (format->cat_file_data)
 		{
-			cat_file_info = format->cat_file_data;
 			at = parse_ref_filter_atom(format, valid_cat_file_atoms,
 						   ARRAY_SIZE(valid_cat_file_atoms), sp + 2, ep);
 		} else
