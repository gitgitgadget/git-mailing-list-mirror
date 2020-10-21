Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD36C388F9
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 20:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16C3921D6C
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 20:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505298AbgJUU0o (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 16:26:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:38642 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505284AbgJUU0n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 16:26:43 -0400
Received: (qmail 4049 invoked by uid 109); 21 Oct 2020 20:26:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 21 Oct 2020 20:26:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20374 invoked by uid 111); 21 Oct 2020 20:26:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 21 Oct 2020 16:26:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 21 Oct 2020 16:26:42 -0400
From:   Jeff King <peff@peff.net>
To:     Nikos Chantziaras <realnc@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: git svn log: Use of uninitialized value $sha1_short
Message-ID: <20201021202642.GA60606@coredump.intra.peff.net>
References: <rmpve5$q2s$1@ciao.gmane.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <rmpve5$q2s$1@ciao.gmane.io>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 21, 2020 at 09:42:12PM +0300, Nikos Chantziaras wrote:

> Running 'git svn log' in a repository that was cloned from an SVN repo
> results in this warning:
> 
> $ git svn log > /dev/null
> Use of uninitialized value $sha1_short in regexp compilation at
> /usr/lib64/perl5/vendor_perl/5.30.3/Git/SVN/Log.pm line 301, <$fh> line 6.
> 
> This doesn't appear to have any ill effects, but the warning might indicate
> a problem somewhere.

It seems to only get mentioned once and never set:

  $ git grep sha1_short perl
  perl/Git/SVN/Log.pm:            } elsif (/^${esc_color}:\d{6} \d{6} $::sha1_short/o) {

Looks like it got renamed, and this reference was somehow missed?

  $ git log -1 -Ssha1_short perl
  commit 9ab33150a0d14089d0496dd8354d4a969e849571
  Author: brian m. carlson <sandals@crustytoothpaste.net>
  Date:   Mon Jun 22 18:04:12 2020 +0000
  
      perl: create and switch variables for hash constants
      
      git-svn has several variables for SHA-1 constants, including short hash
      values and full length hash values.  Since these are no longer SHA-1
      specific, let's start them with "oid" instead of "sha1".  Add a
      constant, oid_length, which is the length of the hash algorithm in use
      in hex.  We use the hex version because overwhelmingly that's what's
      used by git-svn.
  [...]

-Peff
