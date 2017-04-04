Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C7EE20964
	for <e@80x24.org>; Tue,  4 Apr 2017 20:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753062AbdDDUki (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Apr 2017 16:40:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:56680 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752768AbdDDUkh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2017 16:40:37 -0400
Received: (qmail 31878 invoked by uid 109); 4 Apr 2017 20:40:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Apr 2017 20:40:33 +0000
Received: (qmail 9187 invoked by uid 111); 4 Apr 2017 20:40:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Apr 2017 16:40:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Apr 2017 16:40:31 -0400
Date:   Tue, 4 Apr 2017 16:40:31 -0400
From:   Jeff King <peff@peff.net>
To:     David Turner <David.Turner@twosigma.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v3] http.postbuffer: allow full range of ssize_t values
Message-ID: <20170404204031.geh72k6yuiky4wsw@sigill.intra.peff.net>
References: <20170331172631.12024-1-dturner@twosigma.com>
 <20170401060116.b2v7tyoi7fcxwbvo@sigill.intra.peff.net>
 <34d444b673c64310baa275f821037b3e@exmbdft7.ad.twosigma.com>
 <20170404020130.76thbl5rum2gxgtn@sigill.intra.peff.net>
 <6488d78232be49a69260436d1c6ed44f@exmbdft7.ad.twosigma.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6488d78232be49a69260436d1c6ed44f@exmbdft7.ad.twosigma.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 04, 2017 at 06:42:23PM +0000, David Turner wrote:

> > What does it look like when it fails? What does GIT_TRACE_CURL look like (or
> > GIT_CURL_VERBOSE if your client is older, but remember to sanitize any auth
> > lines)?
> 
> Unfortunately, we've already worked around the problem by pushing over SSH, 
> so I no longer have a failing case to examine. Last time I tried, I actually did some 
> hackery to create a push smaller than 2GB, but it still failed (this time, with 
> "502 Bad Gateway").  So, something is clearly weird in GitLab land.
> 
> I did see "Transfer-Encoding: chunked" in one of the responses from the server,
>  but not in the request (not sure if that's normal). The smaller push had: 
> Content-Length: 1048908476

The 502 makes me think it's a problem in the GitLab reverse-proxy layer
(and also my experience debugging Git-over-HTTP weirdness on GitHub's reverse
proxy layer, which had a number of pitfalls ;) ).

You should be able to do a synthetic test like:

  git init
  dd if=/dev/urandom of=foo.rand bs=1k count=1024
  git add .
  git commit -m 'random megabyte'
  GIT_TRACE_CURL=/tmp/foo.out \
    git -c http.postbuffer=0 push https://...

You should see two POSTs to /git-receive-pack, like this:

  Send header: POST /peff/test.git/git-receive-pack HTTP/1.1
  Send header: Host: github.com
  Send header: Authorization: Basic <redacted>
  Send header: User-Agent: git/2.12.2.952.g759391acc
  Send header: Content-Type: application/x-git-receive-pack-request
  Send header: Accept: application/x-git-receive-pack-result
  Send header: Content-Length: 4

  Send header: POST /peff/test.git/git-receive-pack HTTP/1.1
  Send header: Host: github.com
  Send header: Authorization: Basic <redacted>
  Send header: User-Agent: git/2.12.2.952.g759391acc
  Send header: Accept-Encoding: gzip
  Send header: Content-Type: application/x-git-receive-pack-request
  Send header: Accept: application/x-git-receive-pack-result
  Send header: Transfer-Encoding: chunked

The first is a probe to make sure we can hit the endpoint without
sending the whole payload. And the second should pass up the 1MB
packfile in chunks.

That would at least tell you if the problem is the chunked encoding, or
if it's related to the size.

> (For me to publish longer log traces requires a level of security review which is 
> probably too much of a hassle unless you think it will be really useful).

Nah, I doubt there's much to see except "did a small chunked transfer
work", and anything relevant you can pick out of the server response
(but probably "502" is the extent of it).

> > IMHO, complaining about the negative number to the user would be an
> > improvement.
> 
> That seems reasonable.

You can do that with:

   if (http_post_buffer < 0)
	die("negative http.postBuffer not allowed");

but I was trying to suggest that using git_parse_unsigned() should
detect that error for you. It doesn't seem to, though! The strtoumax()
function happily converts negatives into their twos-complement
wraparounds. We could detect it by looking for a leading "-" ourselves,
though I wonder if anybody is relying on the "-1" behavior.

-Peff
