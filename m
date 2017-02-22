Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 023BE201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 21:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934347AbdBVVN2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 16:13:28 -0500
Received: from cloud.peff.net ([104.130.231.41]:60178 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934378AbdBVVNV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 16:13:21 -0500
Received: (qmail 24209 invoked by uid 109); 22 Feb 2017 21:06:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Feb 2017 21:06:38 +0000
Received: (qmail 20072 invoked by uid 111); 22 Feb 2017 21:06:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Feb 2017 16:06:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Feb 2017 16:06:36 -0500
Date:   Wed, 22 Feb 2017 16:06:36 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <dturner@twosigma.com>, git@vger.kernel.org,
        sandals@crustytoothpaste.net,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] http(s): automatically try NTLM authentication first
Message-ID: <20170222210636.k2ps3qhhpiyyv6cp@sigill.intra.peff.net>
References: <20170222173936.25016-1-dturner@twosigma.com>
 <xmqqpoiaasgj.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpoiaasgj.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 22, 2017 at 12:19:56PM -0800, Junio C Hamano wrote:

> > It would be one thing if cURL would not let the user specify credentials
> > interactively after attempting NTLM authentication (i.e. login
> > credentials), but that is not the case.
> >
> > It would be another thing if attempting NTLM authentication was not
> > usually what users need to do when trying to authenticate via https://.
> > But that is also not the case.
> 
> Some other possible worries we may have had I can think of are:
> 
>  - With this enabled unconditionally, would we leak some information?
> 
>  - With this enabled unconditionally, would we always incur an extra
>    roundtrip for people who are not running NTLM at all?
> 
> I do not think the former is the case, but what would I know (adding a
> few people involved in the original thread to CC: ;-)

I don't think it incurs an extra round-trip now, because of the way
libcurl works. Though I think it _does_ make it harder for curl to later
optimize out that extra round-trip.

The easiest way to see the difference is to run something like:

  GIT_CURL_VERBOSE=1 \
  git ls-remote https://example.com/repo-which-needs-auth.git 2>trace
  egrep '^>|^< HTTP|Authorization' trace

Before this patch, I get (this is against github.com, which only does
Basic auth):

  > GET /repo.git/info/refs?service=git-upload-pack HTTP/1.1
  < HTTP/1.1 401 Authorization Required
  > GET /repo.git/info/refs?service=git-upload-pack HTTP/1.1
  < HTTP/1.1 401 Authorization Required
  > GET /repo.git/info/refs?service=git-upload-pack HTTP/1.1
  Authorization: Basic <actual credentials>
  < HTTP/1.1 200 OK

And after I get:

  > GET /repo.git/info/refs?service=git-upload-pack HTTP/1.1
  < HTTP/1.1 401 Authorization Required
  > GET /repo.git/info/refs?service=git-upload-pack HTTP/1.1
  Authorization: Basic Og==
  < HTTP/1.1 401 Authorization Required
  > GET /repo.git/info/refs?service=git-upload-pack HTTP/1.1
  Authorization: Basic <actual credentials>
  < HTTP/1.1 200 OK

In the current trace, you can see that libcurl insists on making a
second auth-less request after we've fed it credentials. I'm not sure
how to get rid of this useless extra round-trip, but it would be nice to
do so (IIRC, it is a probe request to find out the list of auth types
that the server supports, which are not remembered from the previous
request).

With http.emptyauth, the second round-trip _isn't_ useless. It's trying
to send the empty credential.

So while curl isn't currently optimizing out the second call, I think
http.emptyauth makes it harder to do the right thing. That's probably
fixable if the logic ends up more like:

  - curl reports a 401 to us; actually look at the list of auth methods.

  - if there was gss-negotiate, then kick in the empty-auth magic
    automatically.

  - if empty-auth failed (or if we decided not to try it), ask for a
    credential and retry the request. Either way, tell curl that we want
    to use "Basic" so it doesn't have to do the probe request (and
    obviously if the server did not support Basic, then fail
    immediately).

I think that would keep it to 2 round-trips for the normal "Basic" case,
as well as for the GSSNegotiate case. It would be 3 requests when the
server offers GSSNegotiate but you can't use it (but you could set
http.emptyauth=false to optimize that out).

That's all theoretical, though. I might not even be right about the
reason for the second request, and I certainly haven't written any code
(nor do I have a GSSNegotiate setup to test against).

-Peff
