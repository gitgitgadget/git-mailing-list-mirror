Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFFBF20899
	for <e@80x24.org>; Thu, 10 Aug 2017 07:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752244AbdHJHkm (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 03:40:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:34170 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752231AbdHJHkk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 03:40:40 -0400
Received: (qmail 26064 invoked by uid 109); 10 Aug 2017 07:40:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Aug 2017 07:40:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2283 invoked by uid 111); 10 Aug 2017 07:41:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Aug 2017 03:41:03 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Aug 2017 03:40:38 -0400
Date:   Thu, 10 Aug 2017 03:40:38 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/5] interpret-trailers: add an option to show only the
 trailers
Message-ID: <20170810074038.3q5sclod7ag7xnti@sigill.intra.peff.net>
References: <20170809122147.g44nwaitzctbadzm@sigill.intra.peff.net>
 <20170809122402.7y4g5g5y2kkrky5e@sigill.intra.peff.net>
 <20170809113527.292c1776@twelve2.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170809113527.292c1776@twelve2.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 09, 2017 at 11:35:27AM -0700, Jonathan Tan wrote:

> > -static void print_all(FILE *outfile, struct list_head *head, int trim_empty)
> > +static void print_all(FILE *outfile, struct list_head *head,
> > +		      struct process_trailer_options *opts)
> 
> This can be const, I think. (Same thing for patch 1.)

OK. We often leave these kinds of option structs as non-const because
they can sometimes grow to carry state between functions (e.g.,
diff_opt). But it's certainly const-able now, so we can let somebody
undo it later if they want.

> > @@ -897,9 +899,10 @@ static int process_input_file(FILE *outfile,
> >  	trailer_info_get(&info, str);
> >  
> >  	/* Print lines before the trailers as is */
> > -	fwrite(str, 1, info.trailer_start - str, outfile);
> > +	if (outfile)
> 
> Any reason why you expect outfile to possibly be NULL?
> 
> > +		fwrite(str, 1, info.trailer_start - str, outfile);
> >  
> > -	if (!info.blank_line_before_trailer)
> > +	if (outfile && !info.blank_line_before_trailer)
> 
> Same comment here.

Because of this hunk from later in the file where we pass in NULL:

        /* Print the lines before the trailers */
-       trailer_end = process_input_file(outfile, sb.buf, &head);
+       trailer_end = process_input_file(opts->only_trailers ? NULL : outfile,
+                                        sb.buf, &head);

-Peff
