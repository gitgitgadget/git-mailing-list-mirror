From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/4] pack-objects: do not get distracted by stale refs
Date: Thu, 24 Sep 2015 13:03:21 -0400
Message-ID: <20150924170320.GA14695@sigill.intra.peff.net>
References: <cover.1443085919.git.johannes.schindelin@gmx.de>
 <a3a883ce9d7a8bf4220beb640caca5bed0f7d492.1443085919.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Sep 24 19:03:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zf9vf-0001Up-Gh
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 19:03:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbbIXRDZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 13:03:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:35775 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932110AbbIXRDX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 13:03:23 -0400
Received: (qmail 29024 invoked by uid 102); 24 Sep 2015 17:03:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 12:03:23 -0500
Received: (qmail 27281 invoked by uid 107); 24 Sep 2015 17:03:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 13:03:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Sep 2015 13:03:21 -0400
Content-Disposition: inline
In-Reply-To: <a3a883ce9d7a8bf4220beb640caca5bed0f7d492.1443085919.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278547>

On Thu, Sep 24, 2015 at 11:13:44AM +0200, Johannes Schindelin wrote:

> It is quite possible for, say, a remote HEAD to become stale, e.g. when
> the default branch was renamed.
> 
> We should still be able to pack our objects when such a thing happens;
> simply ignore invalid refs (because they cannot matter for the packing
> process anyway).
> [...]
>  	init_revisions(&revs, NULL);
> +	revs.ignore_missing = 1;

I think this is dangerous, because a repack may drop unreferenced
history. Imagine you have a corrupted repository where you are missing
the commit at the tip of "master", but still have "master^" and the rest
of the history, and "git gc --auto" triggers.

Right now, pack-objects will barf and refuse to pack. Your repo is still
corrupted, but you can use git-fsck to recover the history minus the
single commit. With your patch, the repack will delete the entire
history. Of course there are complications like other branches
referencing the history, reflogs if it is a non-bare repo, and the
2-week expiration time. But there's definitely a potential to make
things worse. I think commands that drop objects (like repack and prune)
need to be more careful than other commands about refusing to run when
there is something fishy in the repository.

I think we would want to introduce a flag to ignore dangling
symbolic refs when running for_each_ref, as those should be harmless. In
fact, I think we could omit symrefs completely for reachability
analysis; we would hit the ref they refer to anyway during the rest of
the traversal.

-Peff
