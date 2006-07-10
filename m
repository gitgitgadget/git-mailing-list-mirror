From: Carl Baldwin <cnb@fc.hp.com>
Subject: Revisiting large binary files issue.
Date: Mon, 10 Jul 2006 17:01:32 -0600
Organization: Hewlett Packard
Message-ID: <20060710230132.GA11132@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jul 11 01:01:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G04ky-0004hF-Ly
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 01:01:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422787AbWGJXBe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 19:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422925AbWGJXBd
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 19:01:33 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:17853 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1422787AbWGJXBd (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Jul 2006 19:01:33 -0400
Received: from smtp1.fc.hp.com (smtp.fc.hp.com [15.15.136.127])
	by atlrel8.hp.com (Postfix) with ESMTP id 6FCCC3466C
	for <git@vger.kernel.org>; Mon, 10 Jul 2006 19:01:32 -0400 (EDT)
Received: from hpsvcnb.fc.hp.com (hpsvcnb.fc.hp.com [15.6.94.42])
	by smtp1.fc.hp.com (Postfix) with ESMTP id 37C233B94C
	for <git@vger.kernel.org>; Mon, 10 Jul 2006 23:01:32 +0000 (UTC)
Received: by hpsvcnb.fc.hp.com (Postfix, from userid 21523)
	id 205571AFD8; Mon, 10 Jul 2006 17:01:32 -0600 (MDT)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
X-Origin: hpsvcnb.fc.hp.com
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23665>

Hi,

Some of this stuff has been discussed before but I thought I'd bring it
up again.

I am using git in a way for which, admittedly, it was not intended.  I
have repositories in which I'm storing some source code mixed with some
large binary files (from 20MB up to 1GB in the worst case).  The large
files easily dominate the space in the repository and the time that it
takes to perform network operations between repositories.

Just to refresh your memory a sample of these files led to work that
Nicolas did to improve the performance of packing large binary files.
Thank you Nicolas, I think your work improved the speed of git in the
face of largish files.

Attempting to delta compress these blobs is a frivolous effort.  The
nature of the blobs is such that if given two blobs:  'A', and the next
revision, 'B' it is just as good --- from a pack-size standpoint --- to
compress the entire contents of 'B' than try to find a delta from A ->
B.  It is also much faster than trying to find deltas.  In git, I can
accomplish this by setting the pack window (I think this is right) to 0.

When I set the window to 0 I one more issue.  Even though the blobs are
already compressed on disk I still seem to pay the penalty of inflating
them into memory and then deflating them into the pack.  When the window
size is 0 this is just wasted cycles.  With large binary files these
wasted cycles slow down the push/fetch operation considerably.  Couldn't
the compressed blobs be copied into the pack without first deflating
them in this 0 window case?

My 'porcelain' on top of git works around these issues by first rsyncing
the object directories and then running the git push/fetch command
afterward.  The push/fetch command sees that the remote is up-to-date
with all the necessary objects and skips packing.  This works and is
fast (much faster than even packing with window of 0 because of the time
to inflate/deflate the objects) but I'd like to remove this work-around
in the long-term.

Ideally, there are two things that I would like available with git to be
able to remove my work-around.

First, I would like to be able to set the packing window to 0 for all of
the git commands.  It would be nice if I could set this in a
per-repository config file so that any push/fetch operation would honor
this window.  Is there currently a way to do this?

Second, I would like to not pay the penalty to inflate and then deflate
the objects into the pack when I use a window of 0.  How hard would this
be?  I am a capable programmer and wouldn't mind getting my hands dirty
in the code to implement this if someone could point me in the right
direction.

Thanks for your time,
Carl Baldwin

-- 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 Carl Baldwin                        RADCAD (R&D CAD)
 Hewlett Packard Company
 MS 88                               work: 970 898-1523
 3404 E. Harmony Rd.                 work: Carl.N.Baldwin@hp.com
 Fort Collins, CO 80525              home: Carl@ecBaldwin.net
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
