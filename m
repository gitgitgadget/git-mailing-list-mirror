From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH v3] Prevent megablobs from gunking up git packs
Date: Sun, 27 May 2007 11:09:01 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705271049280.3366@xanadu.home>
References: <465887AB.1010001@gmail.com>
 <alpine.LFD.0.99.0705262304200.3366@xanadu.home>
 <56b7f5510705262246o54a38a44xc0c261c4b4161155@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 27 17:09:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsKMq-0006Ww-Ka
	for gcvg-git@gmane.org; Sun, 27 May 2007 17:09:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754184AbXE0PJG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 11:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754168AbXE0PJF
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 11:09:05 -0400
Received: from relais.videotron.ca ([24.201.245.36]:16299 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754184AbXE0PJE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 11:09:04 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JIP006YNGR13RB0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 27 May 2007 11:09:02 -0400 (EDT)
In-reply-to: <56b7f5510705262246o54a38a44xc0c261c4b4161155@mail.gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48559>

On Sat, 26 May 2007, Dana How wrote:

> I've been discussing these plans with IT here since they maintain
> everything else.
> They would like any part of the database that is going to be reorganized
> and replaced to be backed up first.  If only (1) is available,  and I
> repack every
> night,  then I need to back up the entire repository every night as well.

Why so?  The initial repack would create a set of packs where the last 
packs to be produced will contain large blobs that you don't have to 
ever repack.  Or maybe you produce large blobs every day and you want to 
prevent those from entering the pack up front?

> If I use (2) or (3),  then I back up just the repacked portion each night,
> back up the kept packs only when they are repacked (on a slower schedule),
> and/or back up the loose blobs on a similar schedule.
> 
> Besides this back up issue,  I simply don't want to have to repack _all_
> of such a large repository each night.  With (1), nightly repacks get longer
> and longer, and harder to schedule.
> 
> I think the minimum features needed to support (2) and (3) are the same:
> (a) An easy way to prevent loose blobs exceeding some size limit
>     from migrating into "nice" packs;
> (b) A way to prevent packed objects from being copied when
>     (i) they no longer meet the (new or reduced) size limit AND
>     (ii) they exist in some other safe form in the repository.
> The behavior of --max-blob-size=N in this patch provides both of these
> while deleting other behavior people didn't like.
> 
> You mentioned "incoherency" above;
> I'm not too sure how to proceed on that.
> If you have a more coherent way to provide (a) and (b) above,
> please let me know.

I think it boils down to a question of proper wordings.  Describing this 
as max-blob-size is misleading if in the end you still can end up with 
larger blobs in your pack.  I think there are two solutions to this 
incoherency: either the feature is called something else to reflect the 
fact that it concerns itself only with migration of loose blobs into the 
packed space (I cannot come up with a good name though), or the whole 
pack-objects process is aborted with an error whenever the max-blob-size 
condition cannot be satisfied due to large blobs existing in packed form 
only indicating that a separate extraction of large blobs process is 
required.


Nicolas
