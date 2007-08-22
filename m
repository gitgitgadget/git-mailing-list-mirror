From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Fix new-workdir (again) to work on bare repositories
Date: Tue, 21 Aug 2007 23:36:26 -0400
Message-ID: <20070822033625.GN27913@spearce.org>
References: <20070822015012.GA11085@spearce.org> <7v1wdwntc6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 05:36:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INh1K-0003W2-OK
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 05:36:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754666AbXHVDgb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Aug 2007 23:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754537AbXHVDgb
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 23:36:31 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:36165 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754593AbXHVDga (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2007 23:36:30 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1INh0x-0007kt-QE; Tue, 21 Aug 2007 23:36:16 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5266420FB65; Tue, 21 Aug 2007 23:36:26 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7v1wdwntc6.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56345>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> > My day-job workflow involves using multiple workdirs attached to a
> > bunch of bare repositories.
> 
> Are you sure the patch would help?

Yes.  I tested it in this use case.  It works with the patch, it
fails rather nicely without.  Fun errors about not being able to
cp HEAD from a directory that shouldn't have a HEAD...

> For one thing, I do not think we supported such a layout,
> officially or unofficially --- the thing is in contrib so it
> could not be official, but that is besides the point ;-).  Older
> git might have worked by accident, though.

True, but it works, and uh, we have this new fangled --work-tree
thing to go along with --git-dir, so why can't I symlink my entire
.git content over to somewhere else and pretend like the mess that
is --work-tree doesn't exist?
 
> You may have made the part to create the new directory and make
> bunch of symbolic links to work with your patch, but as far as I
> know, new-workdir is designed to share the .git/config file with
> the borrowed repository, which means the configuration would say
> "core.bare = yes" for a bare repository.  So I suspect that the
> initial checkout after creating the new directory and populating
> its .git would barf, although I haven't tested it.

Indeed.  I have a driver script that sets up my bare repos, it
removes core.bare from their configs.  So if you go into the bare
repo our auto-sensing bare thing gets activated and says "Hmm, it
ends in .git but isn't exactly .git so its bare!" (correct answer).
If you cd into a workdir created by git-new-workdir the auto-sensing
bare thing gets activated and says "Hmm, it is exactly .git so its
not-bare!" (correct answer).

So removing that core.bare thing makes the magic work.  But if you
leave core.bare in foo.git/config, yes, a workdir created from it
is mighty confused.

-- 
Shawn.
