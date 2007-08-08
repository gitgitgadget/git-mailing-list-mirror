From: Scott Lamb <slamb@slamb.org>
Subject: Re: [PATCH] git-p4: Fix support for symlinks.
Date: Tue, 07 Aug 2007 18:36:25 -0700
Message-ID: <46B91E19.9010005@slamb.org>
References: <200708071025.47965.simon@lst.de> <7vtzrb68kq.fsf@assigned-by-dhcp.cox.net> <20070807091049.GA13308@bulgaria>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Simon Hausmann <simon@lst.de>,
	git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>
To: Brian Swetland <swetland@google.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 03:36:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIaTR-0000r9-Ig
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 03:36:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759317AbXHHBga (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 21:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756947AbXHHBga
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 21:36:30 -0400
Received: from hobbes.slamb.org ([208.78.103.243]:34804 "EHLO hobbes.slamb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756685AbXHHBg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 21:36:29 -0400
Received: from [172.19.17.162] (216-239-45-4.google.com [216.239.45.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hobbes.slamb.org (Postfix) with ESMTP id 34114980F3;
	Tue,  7 Aug 2007 18:36:27 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.12 (Macintosh/20070509)
In-Reply-To: <20070807091049.GA13308@bulgaria>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55289>

Brian Swetland wrote:
> One observation on git-p4 -- it's a little memory hungry when processing
> large syncs.  I haven't tried incremental syncs on top of the initial
> one though -- if it's only the initial that's expensive it's not that
> big a deal.
> 
> It seemed to top out around 988MB resident.  The branch I was importing
> is about 562MB when checked out and the resulting git repository is
> about 175MB.

While importing each change, I think git-p4 puts into memory two copies 
of the contents of all changed files, one in p4CmdList and one in 
readP4Files. (That's the raw contents, not just the delta.) I don't 
think there's any fundamental reason it couldn't stream them instead.

So incremental syncs may or may not take less memory. If the first 
change imports a huge project and no subsequent change ever touches all 
those files at once, then yeah. But if, say, you periodically change the 
copyright dates in all files in the repository, you'll have this memory 
usage whenever syncing such a change.

As long as we're listing git-p4 complaints, here are a couple of mine:

1) coding style. *self-nag* Simon Hausmann mentioned he was happy to 
accept patches...and I made one up a while ago; I just need to do a 
merge and final check that I haven't broken anything before sending it off.

2) it breaks on tempfile purges. My previous employer has these in their 
repository, and I think for the moment they're working around it by 
treating a "purge" as a "delete". If I read the Perforce documentation 
right, though, only the latest version of a tempfile's contents is kept 
in the repository anyway. Their history can't be captured accurately, so 
the proper thing is probably to omit tempfiles entirely. (And deleting 
files when they become tempfiles and creating files when they become a 
normal type.)

Best regards,
Scott

-- 
Scott Lamb <http://www.slamb.org/>
