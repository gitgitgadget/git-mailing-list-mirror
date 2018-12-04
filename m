Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F3C3211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 04:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbeLDEuy (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 23:50:54 -0500
Received: from cloud.peff.net ([104.130.231.41]:58130 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725971AbeLDEux (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 23:50:53 -0500
Received: (qmail 22917 invoked by uid 109); 4 Dec 2018 04:50:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 04 Dec 2018 04:50:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16638 invoked by uid 111); 4 Dec 2018 04:50:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 03 Dec 2018 23:50:21 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Dec 2018 23:50:52 -0500
Date:   Mon, 3 Dec 2018 23:50:52 -0500
From:   Jeff King <peff@peff.net>
To:     Jamie Zawinski <jwz@jwz.org>
Cc:     git@vger.kernel.org
Subject: Re: sharedrepository=group not working
Message-ID: <20181204045051.GA23351@sigill.intra.peff.net>
References: <F9365CBF-3D2D-4A05-AC0D-4604067B5826@jwz.org>
 <20181204040903.GA17059@sigill.intra.peff.net>
 <53C59F2A-6D97-45F9-AF86-E255F6777E7F@jwz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <53C59F2A-6D97-45F9-AF86-E255F6777E7F@jwz.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 03, 2018 at 08:19:12PM -0800, Jamie Zawinski wrote:

> On Dec 3, 2018, at 8:09 PM, Jeff King <peff@peff.net> wrote:
> > 
> > but it works fine. Might there be some effective-uid trickiness with the
> > way the server side of git is invoked? Or is this a network mount where
> > the filesystem uid might not match the process uid?
> 
> Huh. They're on the same ext4 fs (it's an AWS EBS sc1 volume, but I
> think that still counts as "not a network mount" as far as Linux is
> concerned.)

Yeah, I think we can discount any oddness there.

> The way I was seeing this fail was a CGI invoking "git push", as user
> "httpd" (and I verified that when the cgi was invoked, "groups"
> reported that "httpd" was a member of group "cvs") but when I tried to
> reproduce the error with "sudo -u apache git push" it didn't fail. So
> possibly something hinky is going on with group permissions when httpd
> invokes git, but I did verify that whoami, groups and pwd were as
> expected, so I couldn't tell what that might be... (Oh, I didn't check
> what umask was, but it should have been 022...)

Hrm. I don't think group permissions would even matter. We asked to
mkdir() with 0700 anyway, so we know they'd be zero.

But a funny umask does seem like a likely candidate for causing the
problem. We asked for 0700, but if there were bits set in umask (say,
0200 or something), that would restrict that further. And it would
explain what you're seeing (inability to write into a directory we
just created), and it might have worked with previous versions (which
was less strict on the group permissions).

I don't suppose this is leaving those incoming-* directories sitting
around so we can inspect their permissions (it's suppose to clean them
up, so I doubt it). If you're up for it, it might be interesting to
patch Git to inspect the umask and "ls -l" the objects/ directory at the
problematic moment. The interesting point is when we call into
tmp-objdir.c:setup_tmp_objdir().

-Peff
