From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] merge_blobs: use strbuf instead of manually-sized
 mmfile_t
Date: Tue, 16 Feb 2016 00:50:43 -0500
Message-ID: <20160216055043.GB28237@sigill.intra.peff.net>
References: <56C2459B.5060805@uni-graz.at>
 <20160216011258.GA11961@sigill.intra.peff.net>
 <20160216050915.GA5765@flurp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan =?utf-8?Q?Fr=C3=BChwirth?= <stefan.fruehwirth@uni-graz.at>,
	git@vger.kernel.org
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 06:50:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVYXD-00089F-85
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 06:50:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753530AbcBPFur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 00:50:47 -0500
Received: from cloud.peff.net ([50.56.180.127]:42879 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753165AbcBPFuq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 00:50:46 -0500
Received: (qmail 25123 invoked by uid 102); 16 Feb 2016 05:50:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Feb 2016 00:50:46 -0500
Received: (qmail 18077 invoked by uid 107); 16 Feb 2016 05:50:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Feb 2016 00:50:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Feb 2016 00:50:43 -0500
Content-Disposition: inline
In-Reply-To: <20160216050915.GA5765@flurp.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286323>

On Tue, Feb 16, 2016 at 12:09:15AM -0500, Eric Sunshine wrote:

> > -	ecb.priv = res;
> > -	return xdi_diff(f1, f2, &xpp, &xecfg, &ecb);
> > +	res->size = out.len; /* avoid long/size_t pointer mismatch below */
> 
> It took a minute or two for me to realize that "mismatch below" was
> talking about the second argument to strbuf_detach(). I tried
> rewriting the comment to mention the second argument explicitly, but
> couldn't come up with one sufficiently succinct. Oh well.

Maybe "avoid long/size_t mismatch in strbuf_detach" would be better.

> > +	res->ptr = strbuf_detach(&out, NULL);
> > +	return 0;
> >  }
> 
> My reviewed-by may not be worth much since this code is new to me
> too, but this patch looks "obviously correct" to me, so:
> 
>     Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
> 
> Perhaps squash in the following test which I adapted from the
> reproduction recipe provided by Chris Rossi[1]?
> 
> [1] https://gist.github.com/chrisrossi/f09c8bed70b364f9f12e

Yeah, maybe. There were two reasons I avoided adding a test.

One, I secretly hoped that by dragging my feet we could get consensus on
just ripping out merge-tree entirely. ;)

Two, I'm not sure what the test output _should_ be. I think this case is
buggy. So we can check that we don't corrupt the heap, which is nice,
but I don't like adding a test that doesn't test_cmp the expected output
(and see my earlier comments re: thinking hard).

But if we are going to keep it, maybe some exercise of the code is
better than none.

-Peff
