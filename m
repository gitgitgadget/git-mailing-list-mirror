From: Junio C Hamano <junkio@cox.net>
Subject: Re: Handling large files with GIT
Date: Wed, 08 Feb 2006 12:11:30 -0800
Message-ID: <7v4q39pq4t.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90602080114r2205d72cmc2b5c93f6fffe03d@mail.gmail.com>
	<Pine.LNX.4.63.0602081248270.31700@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0602080815180.2458@g5.osdl.org>
	<Pine.LNX.4.64.0602080853480.2458@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 08 21:12:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6vfR-0004Ol-Qo
	for gcvg-git@gmane.org; Wed, 08 Feb 2006 21:11:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030598AbWBHULd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Feb 2006 15:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030599AbWBHULd
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Feb 2006 15:11:33 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:5366 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1030598AbWBHULc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2006 15:11:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060208200957.DFUW20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 8 Feb 2006 15:09:57 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602080853480.2458@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 8 Feb 2006 09:01:13 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15749>

Linus Torvalds <torvalds@osdl.org> writes:

> Side note: the original explicit git "delta" objects by Nicolas Pitre 
> would have handled this large-file-case much more gracefully. 

True.

> The pack-files had absolutely huge advantages, though, so I think we (I) 
> did the right thing there in making the delta code only a very specific 
> special case..

Well the blame for ripping that out falls on me, actually...

> It is possible that we could re-introduce the "explicit delta" object, 
> though (it's not incompatible with also doing pack-files, it's just that 
> pack-files made 99% of all the arguments for an explicit delta go away).

I do not remember we had 'rev-list --objects' support for Nico's
explicit delta object chains.  If we didn't that would be a new
development that needs to be done to resurrect it.  I know
pack-objects never had support for it so obviously that needs to
be added as well.  Probably explicit delta objects should always
be packed in full without spending cost to find delta candidates.

Personally I feel that post-1.2.0 would be a good time to start
looking at enhancing the pack generation chain, rev-list piped
to pack-objects.  This "large files" use case is helped by
less self-contained packs while "shallow clone" use case
we discussed earlier is helped by more self-contained packs (we
had a discussion long time ago on this and I think we have the
code to do so [*1*]). 

An addition to pack-objects is needed to make it capable to read
a list of objects that we do not want to include in the
resulting pack but can be used as base objects for delitified.

BTW, as to the "shallow clone", I changed my mind and am
inclined to agree with Johannes that handling cut-offs
differently from grafts is easier for dealing with later "give
me more history" operation, so I am planning to chuck my jc/clone
topic branch that I have included in the proposed updates so
far.

[Footnote]

*1* http://article.gmane.org/gmane.comp.version-control.git/5779
