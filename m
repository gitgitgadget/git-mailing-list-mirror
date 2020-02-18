Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9274CC34031
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 05:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6417C20679
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 05:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbgBRFT6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 00:19:58 -0500
Received: from cloud.peff.net ([104.130.231.41]:46510 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725832AbgBRFT6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 00:19:58 -0500
Received: (qmail 14399 invoked by uid 109); 18 Feb 2020 05:19:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 18 Feb 2020 05:19:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14504 invoked by uid 111); 18 Feb 2020 05:28:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Feb 2020 00:28:57 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 18 Feb 2020 00:19:56 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     lyle.ziegelmiller@gmail.com, git@vger.kernel.org
Subject: Re: ! [remote rejected] master -> master (unpacker error)
Message-ID: <20200218051956.GA1641086@coredump.intra.peff.net>
References: <000001d5e4e3$91ffb0a0$b5ff11e0$@gmail.com>
 <20200216211604.GE6134@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200216211604.GE6134@camp.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 16, 2020 at 09:16:04PM +0000, brian m. carlson wrote:

> On 2020-02-16 at 16:10:12, lyle.ziegelmiller@gmail.com wrote:
> > Hi
> > 
> > Any updates on this error I emailed a while back?
> > 
> > lylez@LJZ-DELLPC ~/python
> > $ git push
> > Enumerating objects: 5, done.
> > Counting objects: 100% (5/5), done.
> > Delta compression using up to 4 threads
> > Compressing objects: 100% (2/2), done.
> > Writing objects: 100% (3/3), 279 bytes | 23.00 KiB/s, done.
> > Total 3 (delta 1), reused 0 (delta 0)
> > remote: fatal: not a git repository: '.'
> 
> This error is telling you that Git doesn't think the remote location is
> a Git repository.  It could be because it really isn't one, or it could
> be that the permissions are wrong.
> 
> It could also be that the repository is mostly there but very slightly
> corrupt and therefore can't be detected as one.  For example, it could
> be missing its HEAD reference.

I think it's more subtle than that, though. If it wasn't a git
repository at all, then receive-pack would fail to start, and you'd get
something like this:

  $ git push /foo/bar
  fatal: '/foo/bar' does not appear to be a git repository
  fatal: Could not read from remote repository.
  
  Please make sure you have the correct access rights
  and the repository exists.

The output above, plus the:

  error: remote unpack failed: unpack-objects abnormal exit

makes it looks like receive-pack started just fine, but something about
the way it set up the environment made the child unpack-objects unhappy
when it tried to initialize its internal repo variables.

I have no clue what that "something" is, though. Windows and UNC paths
were mentioned elsewhere, which seem plausible. It mentions ".", so
presumably we've chdir()'d into the receiving repository and set
$GIT_DIR. Which I'd think rules out any weird interpretations of UNC
paths in $GIT_DIR.

I'd expect that error if we did a chdir() internally to some other path
after setting up $GIT_DIR, but I don't know why we'd do that (I thought
at first that the quarantine code in receive-pack might be related, but
we don't ever chdir() into the quarantine dir; we just set up
GIT_OBJECT_DIRECTORY).

-Peff
