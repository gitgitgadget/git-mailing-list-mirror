Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D3991F404
	for <e@80x24.org>; Tue,  3 Apr 2018 13:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932198AbeDCNOu (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 09:14:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:51778 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932151AbeDCNOu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 09:14:50 -0400
Received: (qmail 30775 invoked by uid 109); 3 Apr 2018 13:14:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Apr 2018 13:14:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25267 invoked by uid 111); 3 Apr 2018 13:15:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 03 Apr 2018 09:15:50 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Apr 2018 09:14:48 -0400
Date:   Tue, 3 Apr 2018 09:14:48 -0400
From:   Jeff King <peff@peff.net>
To:     Jens =?utf-8?Q?Kr=C3=BCger?= <Jens.Krueger@frm2.tum.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: Test 5561 failed
Message-ID: <20180403131447.GB18824@sigill.intra.peff.net>
References: <66ac8aec-3e4c-43be-83d1-7bd823ec2b20@frm2.tum.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <66ac8aec-3e4c-43be-83d1-7bd823ec2b20@frm2.tum.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 03, 2018 at 01:43:37PM +0200, Jens Krüger wrote:

> expecting success: 
> 	GET refs/heads/master "404 Not Found"
> 
> not ok 2 - direct refs/heads/master not found

That GET function is:

  GET() {
        curl --include "$HTTPD_URL/$SMART/repo.git/$1" >out 2>/dev/null &&
        tr '\015' Q <out |
        sed '
                s/Q$//
                1q
        ' >act &&
        echo "HTTP/1.1 $2" >exp &&
        test_cmp exp act
  }

The tarball you sent shows "out" as empty, and "act" is missing. So
"curl" produced no output, and we did not make it as far as the tr/sed
pipe. Just a guess, but are you missing the "curl" command-line tool on
your system? If so, "apt install curl" should fix the failure.

As far as code changes in Git, perhaps (assuming my guess is right):

  - drop the redirect of stderr here; the test suite already handles
    hiding stderr from the user (without "-v"), and in "-v" mode you
    probably would have gotten a useful error like "curl: not found"

  - it's rare but possible to have libcurl installed (which is needed
    for the server side, and what we key on for running the httpd tests)
    but not the curl binary. This test probably should check for the
    existence of the curl binary as a prerequisite.

-Peff
