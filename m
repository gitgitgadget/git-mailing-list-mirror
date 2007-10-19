From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Proposed git mv behavioral change
Date: Thu, 18 Oct 2007 21:54:19 -0400
Message-ID: <20071019015419.GV14735@spearce.org>
References: <c594999b2337.2337c594999b@nyroc.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: lmage11@twcny.rr.com
X-From: git-owner@vger.kernel.org Fri Oct 19 03:54:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iih4N-00040Z-Cl
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 03:54:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759992AbXJSByY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 21:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759801AbXJSByX
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 21:54:23 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:42356 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758621AbXJSByW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 21:54:22 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Iih3u-0006uC-9E; Thu, 18 Oct 2007 21:54:06 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B2B6A20FBAE; Thu, 18 Oct 2007 21:54:19 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <c594999b2337.2337c594999b@nyroc.rr.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61596>

Line wrapping email at under 80 columns would be nice.  It makes it
easier to read the message, and more importantly, easier to quote
a few times during discussion.

lmage11@twcny.rr.com wrote:
> Therefore, I propose that git mv's behavior be changed. I think it
> would make far more sense for a move to only change the actual name
> of the file and to not pull in unstaged changes. In other words,
> I'd like the index entry for the original file name to be removed
> and an index entry to be added with a different name, but using the
> exact same blob hash as the original file. I don't know exactly how
> git manages the index internally, but a shortcut for this would be
> to simply rename the index entry in place.

I'm somewhat hesistant to change existing behavior, as users may
be used to it or relying upon it within their scripts.  But you
make an excellent argument about why the current git-mv behavior
is perhaps less than ideal.

Elsewhere in git we use the --cached command line option to mean
"only make the change in the index".  For example the git-apply
--cached option.  You could start a patch that uses --cached to
trigger the new behavior you propose and see if people are interested
in changing the default once the feature is working and available
for experimentation.
 
> I'm willing to look into what changes would need to be made to the
> code for this change to happen; I'm not asking for someone to do
> all the work for me. :)
> 
> So... Yeah. I'd like to know what people think about this before
> I put a significant amount of effort into it. After all, we know
> how lazy programmers are... :)

See builtin-mv.c around l.264-283.  This is where we are removing
the old names from the index (in memory) and inserting the new
names.  Instead of calling add_file_to_cache() you would want
to use something like add_cacheinfo() in builtin-update-index.c,
specifying the old sha1, ce_flags and ce_mode.

I'm sure Junio could probably give you a better starting point
than I can, as he's more familiar with this sort of code, but that
should still get you looking in the right direction and maybe get
a working implementation together that you can share for discussion.

-- 
Shawn.
