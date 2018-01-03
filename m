Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C254C1F428
	for <e@80x24.org>; Wed,  3 Jan 2018 06:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751451AbeACGRH (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 01:17:07 -0500
Received: from cloud.peff.net ([104.130.231.41]:51652 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750907AbeACGRG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 01:17:06 -0500
Received: (qmail 5618 invoked by uid 109); 3 Jan 2018 06:17:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 03 Jan 2018 06:17:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24346 invoked by uid 111); 3 Jan 2018 06:17:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Wed, 03 Jan 2018 01:17:36 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Jan 2018 01:17:04 -0500
Date:   Wed, 3 Jan 2018 01:17:04 -0500
From:   Jeff King <peff@peff.net>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http: fix v1 protocol tests with apache httpd < 2.4
Message-ID: <20180103061703.GB25752@sigill.intra.peff.net>
References: <20171231023234.21215-1-tmz@pobox.com>
 <20180103002145.GA242551@google.com>
 <20180103003946.GC12108@zaya.teonanacatl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180103003946.GC12108@zaya.teonanacatl.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 02, 2018 at 07:39:46PM -0500, Todd Zullinger wrote:

> Brandon Williams wrote:
> > Seems good to me.  I think I was just being overly cautious when i was
> > implementing those patches.  Thanks!
> 
> Cool, thanks for taking a look.
> 
> In this case, the test isn't dependent on apache > 2.4, but
> before I checked that I wondered if we had any way to run a
> test only if the apache version was greater or lesser than
> some release.  Luckily, I didn't have to work out such a
> method. :)
> 
> I don't know if there's a clean way to do that
> automatically, short of parsing the output of 'httpd -v'
> should we ever need to add such a prereq.

In the general case, we could probably define an endpoint within an <If>
block, and then try to access the endpoint from the test script.

E.g., something like:

    <IfVersion >= 2.4>
    Alias /have-2.4.txt www/yes.txt
    </IfVersion>

in the apache config, and then:

  test_lazy_prereq APACHE24 '
        echo yes >"$HTTPD_DOCUMENT_ROOT_PATH/yes.txt" &&
        curl -f "$HTTPD_URL/have-2.4.txt"
  '

in the test script (of course we may not want to depend on having
command-line curl, but we could replace that with "git ls-remote" or
similar).

One nice thing about that approach is that it can be extended to other
"If" blocks, like if we have a particular module available, or if ssl is
configured.

-Peff
