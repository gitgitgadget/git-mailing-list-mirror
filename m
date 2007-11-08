From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 3/3] git-fetch: avoid local fetching from alternate (again)
Date: Thu, 8 Nov 2007 05:00:40 -0500
Message-ID: <20071108100039.GM14735@spearce.org>
References: <20071108080058.GC16690@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 11:01:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq4C4-00031x-3u
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 11:01:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756910AbXKHKAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 05:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753667AbXKHKAp
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 05:00:45 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:36348 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414AbXKHKAo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 05:00:44 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Iq4Bj-0004KD-IE; Thu, 08 Nov 2007 05:00:39 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 198E420FBCC; Thu,  8 Nov 2007 05:00:40 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20071108080058.GC16690@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63988>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> Back in e3c6f240fd9c5bdeb33f2d47adc859f37935e2df Junio taught
> git-fetch to avoid copying objects when we are fetching from
> a repository that is already registered as an alternate object
> database.  In such a case there is no reason to copy any objects
> as we can already obtain them through the alternate.

I haven't figured it out yet but this patch seriously breaks
t5515-fetch-merge-logic.  For some reason the tag tag-three-file is
not being included in .git/FETCH_HEAD as a not-for-merge ref, but all
of the test vectors are expecting it to be present.  Prior to this
patch it was included and I don't think the test vectors are wrong.

If I run git-fetch from outside the test library it does the right
thing and fetches this annotated tag pointing to a blob just fine.
But during the test vector it never even mentions that tag as part
of the status output, nor does it include it into .git/FETCH_HEAD.
Its almost like the tag ain't there.

I'm starting to suspect heap corruption again in builtin-fetch.
This patch alters the malloc() calls we are doing and may be shifting
something around just enough in memory to cause a data overwrite or
something and that's why this tag just drops out of the linked list?
But then why does that happen in the test suite but not outside.
Maybe because the test suite is setting environment variables that
I'm not and the impact of those combined with these additional
mallocs is what is breaking it?  *sigh*

-- 
Shawn.
