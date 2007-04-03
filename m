From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-index-pack really does suck..
Date: Tue, 3 Apr 2007 17:03:19 -0400
Message-ID: <20070403210319.GH27706@spearce.org>
References: <Pine.LNX.4.64.0704030754020.6730@woody.linux-foundation.org> <db69205d0704031227q1009eabfhdd82aa3636f25bb6@mail.gmail.com> <Pine.LNX.4.64.0704031304420.6730@woody.linux-foundation.org> <alpine.LFD.0.98.0704031625050.28181@xanadu.home> <Pine.LNX.4.64.0704031346250.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Chris Lee <clee@kde.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Apr 03 23:03:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYqAL-0002Qi-7H
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 23:03:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753651AbXDCVDm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 17:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753666AbXDCVDm
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 17:03:42 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:50991 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753651AbXDCVDl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 17:03:41 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HYq9o-00024C-HV; Tue, 03 Apr 2007 17:03:12 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 82C7420FBAE; Tue,  3 Apr 2007 17:03:19 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0704031346250.6730@woody.linux-foundation.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43663>

Linus Torvalds <torvalds@linux-foundation.org> wrote:
> Actually, even in the normal workflow it will do all the extra unnecessary 
> work, if only because the lookup costs of *not* finding the entry.
> 
> Lookie here:
> 
>  - git index-pack of the *git* pack-file in the v2.6/linux directory (zero 
>    overlap of objects)
> 
>    With --paranoid:
> 
> 	2.75user 0.37system 0:03.13elapsed 99%CPU
> 	0major+5583minor pagefaults
> 
>    Without --paranoid:
> 
> 	2.55user 0.12system 0:02.68elapsed 99%CPU
> 	0major+2957minor pagefaults
> 
> See? That's the *normal* workflow. Zero objects found. 7% CPU overhead 
> from just the unnecessary work, and almost twice as much memory used. Just 
> from the index file lookup etc for a decent-sized project.

OK, but what about that case with unpack-objects?  Didn't we there
do all this work to also check for the object already existing?
During update-index, write-tree and commit-tree don't we also do
a lot of work (per object anyway) to check for a non-existing object?

So even with --paranoid (aka what we have now) index-pack still
should be faster than unpack-objects for any sizeable transfer,
and is just as "safe".

If its the missing-object lookup that is expensive, maybe we should
try to optimize that.  We do it enough already in other parts of
the code...

-- 
Shawn.
