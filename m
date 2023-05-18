Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD08C77B73
	for <git@archiver.kernel.org>; Thu, 18 May 2023 23:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjERXLA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 19:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjERXK7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 19:10:59 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F5EB5
        for <git@vger.kernel.org>; Thu, 18 May 2023 16:10:58 -0700 (PDT)
Received: (qmail 5308 invoked by uid 109); 18 May 2023 23:10:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 18 May 2023 23:10:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26144 invoked by uid 111); 18 May 2023 23:10:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 18 May 2023 19:10:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 18 May 2023 19:10:56 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Todd Zullinger <tmz@pobox.com>, git@vger.kernel.org,
        Matthew John Cheetham <mjcheetham@outlook.com>
Subject: Re: [BUG 2.41.0] t/lib-httpd/apache.conf incompatible with
 RHEL/CentOS 7
Message-ID: <20230518231056.GA1752284@coredump.intra.peff.net>
References: <ZGUlqu7sP7yxbaTI@pobox.com>
 <20230518184532.GC557383@coredump.intra.peff.net>
 <20230518192102.GA1514485@coredump.intra.peff.net>
 <xmqqpm6xs51l.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpm6xs51l.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 18, 2023 at 02:28:22PM -0700, Junio C Hamano wrote:

> > Commit 988aad99b4 (t5563: add tests for basic and anoymous HTTP access,
> > 2023-02-27) added tests that require Apache to support the CGIPassAuth
> > directive, which was added in Apache 2.4.13. This is fairly old (~8
> > years), but recent enough that we still encounter it in the wild (e.g.,
> > RHEL/CentOS 7, which is not EOL until June 2024).
> 
> nitpick: we are fine to encountering 2.4.13 in the wild---encountering
> something a bit older than that is problematic.  A quick internet
> search tells me that CentOS 7 ships Apache 2.4.6, so if we trust that...
> 
>     ... fairly old (~8 years), but recent enough that we still
>     encounter versions older than that in the wild (e.g.  CentOS 7,
>     which is not EOL until June 2024, comes with Apache 2.4.6 from
>     2014 plus security fixes).
> 
> or something?

Yeah, I agree what I wrote is a bit unclear. I think what I meant was
"..recent enough that we'll still encounter older versions in the wild".

But yours is even better, since you dug up the actual version it ships.
Do you want to squash that into the commit message, or do you prefer a
re-send?

> > +enable_cgipassauth () {
> > +	# We are looking for 2.4.13 or more recent. Since we only support
> > +	# 2.4 and up, no need to check for older major/minor.
> > +	if test "$HTTPD_VERSION_MAJOR" = 2 &&
> > +	   test "$HTTPD_VERSION_MINOR" = 4 &&
> > +	   test "$(echo $HTTPD_VERSION | cut -d. -f3)" -lt 13
> 
> As HTTPD_VERSION comes from 
> 
> 	$LIB_HTTPD_PATH -v | sed -n 's|^Server version: Apache/\([0-9.]*\).*|p'
> 
> and parses a line like "Server version: Apache/2.4.6 (CentOS)",
> unless somebody ships 2.4 without any digit after it, the above
> should be safe ;-)

Yep. I wondered about trying to be more paranoid here, but I think
there's not much point until we see a real world example. The most
likely outcome of a mis-parse is that we'd claim "this looks too old"
and skip the t5536 tests, which seems OK (at least nobody gets an
unexpected test failure, though it may mean that they simply gloss over
the problem).

-Peff
