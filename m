Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0680F1FE4E
	for <e@80x24.org>; Sun, 19 Jun 2016 10:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751656AbcFSKAz (ORCPT <rfc822;e@80x24.org>);
	Sun, 19 Jun 2016 06:00:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:56876 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751635AbcFSKAz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2016 06:00:55 -0400
Received: (qmail 31023 invoked by uid 102); 19 Jun 2016 10:00:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 19 Jun 2016 06:00:54 -0400
Received: (qmail 6360 invoked by uid 107); 19 Jun 2016 10:01:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 19 Jun 2016 06:01:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 19 Jun 2016 06:00:51 -0400
Date:	Sun, 19 Jun 2016 06:00:51 -0400
From:	Jeff King <peff@peff.net>
To:	Vadim Eisenberg <VADIME@il.ibm.com>
Cc:	Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [BUG REPORT] git 2.9.0 clone --recursive fails on cloning a
 submodule
Message-ID: <20160619100051.GA14584@sigill.intra.peff.net>
References: <OFC76C15DC.FC882C57-ONC2257FD7.00261552-C2257FD7.002660FC@LocalDomain>
 <OFE09D48F2.D1D14F49-ONC2257FD7.00280736-C2257FD7.0028245A@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <OFE09D48F2.D1D14F49-ONC2257FD7.00280736-C2257FD7.0028245A@notes.na.collabserv.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Jun 19, 2016 at 10:17:36AM +0300, Vadim Eisenberg wrote:

> /usr/local/bin/git clone --recursive --depth 10 
> https://github.com/IBM-Swift/Kitura-net.git
> Cloning into 'Kitura-net'...
> remote: Counting objects: 253, done.
> remote: Compressing objects: 100% (142/142), done.
> remote: Total 253 (delta 134), reused 188 (delta 86), pack-reused 0
> Receiving objects: 100% (253/253), 63.28 KiB | 0 bytes/s, done.
> Resolving deltas: 100% (134/134), done.
> Checking connectivity... done.
> Submodule 'Kitura-Build' (https://github.com/IBM-Swift/Kitura-Build.git) 
> registered for path 'Kitura-Build'
> Cloning into '/home/vadime/Kitura-net/Kitura-Build'...
> error: no such remote ref d0d9d6c739a79627641e6438fe4f39bd0eba83bb
> Fetched in submodule path 'Kitura-Build', but it did not contain 
> d0d9d6c739a79627641e6438fe4f39bd0eba83bb. Direct fetching of that commit 
> failed.

The problem seems to be the shallow clone. The super-project points to a
commit in the submodule that is not near the tip of any branch, so
shallow-cloning the submodule means we don't get that commit. Prior to
d22eb04 (clone: add `--shallow-submodules` flag, 2016-04-25), submodules
were _always_ cloned fully.

The immediate workaround is to add "--no-shallow-submodules" to your
clone invocation.

Stefan, I think it might be worth revisiting the default set by d22eb04
to propagate shallowness from the super-project clone. In an ideal
world, we would be asking each submodule for the actual commit we are
interested in, and shallowness would not matter. But until
uploadpack.allowReachableSHA1InWant works everywhere, I suspect this is
going to be a problem.

-Peff
