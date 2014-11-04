From: Jeff King <peff@peff.net>
Subject: [PATCH 0/2] fetch, reflogs, and bare repositories
Date: Tue, 4 Nov 2014 08:10:07 -0500
Message-ID: <20141104131006.GA1077@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 04 14:10:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XldsE-0007pV-D0
	for gcvg-git-2@plane.gmane.org; Tue, 04 Nov 2014 14:10:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753536AbaKDNKJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2014 08:10:09 -0500
Received: from cloud.peff.net ([50.56.180.127]:36635 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751732AbaKDNKI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2014 08:10:08 -0500
Received: (qmail 25557 invoked by uid 102); 4 Nov 2014 13:10:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Nov 2014 07:10:08 -0600
Received: (qmail 17684 invoked by uid 107); 4 Nov 2014 13:10:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Nov 2014 08:10:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Nov 2014 08:10:07 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I ran into a rather confusing case of fetching into a bare repository
with reflogs turned on:

    # make a repo with a two-component branch name
    git init -q &&
    git commit -q --allow-empty -m one &&
    git branch foo/bar &&
    
    # now fetch it all into a bare repo with reflogs
    git init -q --bare parent.git &&
    cd parent.git &&
    git config core.logallrefupdates true &&
    git fetch --prune .. +refs/*:refs/* &&
    
    # now replace the branch with one that has a d/f conflict
    cd .. &&
    git branch -d foo/bar &&
    git branch foo &&
    
    # and fetch again
    cd parent.git &&
    git fetch --prune .. +refs/*:refs/*

The final fetch fails and produces this output:

    From ..
     x [deleted]         (none)     -> foo/bar
    error: Unable to append to ./logs/refs/heads/foo: Is a directory
     ! [new branch]      foo        -> foo  (unable to update local ref)

This turns out to be caused by two subtle bugs: one that makes "git
fetch" use reflogs inconsistently, and the other that causes some ref
updates to fail when reflogs are turned on and off. Details are in the
fixes themselves.

  [1/2]: fetch: load all default config at startup
  [2/2]: ignore stale directories when checking reflog existence

-Peff
