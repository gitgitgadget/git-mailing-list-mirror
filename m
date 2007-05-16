From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] import-tars: Use the "Link indicator" to identify directories
Date: Wed, 16 May 2007 11:24:39 -0700
Message-ID: <7vsl9weie0.fsf@assigned-by-dhcp.cox.net>
References: <6efbd9b70705111308v47a76b04n9328ebf393a209e6@mail.gmail.com>
	<Pine.LNX.4.64.0705161659530.6410@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Riddoch <riddochc@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed May 16 20:24:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoOB5-00008Y-Nq
	for gcvg-git@gmane.org; Wed, 16 May 2007 20:24:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756534AbXEPSYl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 14:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756332AbXEPSYl
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 14:24:41 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:53136 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753395AbXEPSYk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 14:24:40 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070516182440.DVJL2758.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Wed, 16 May 2007 14:24:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id zuQf1W00A1kojtg0000000; Wed, 16 May 2007 14:24:39 -0400
In-Reply-To: <Pine.LNX.4.64.0705161659530.6410@racer.site> (Johannes
	Schindelin's message of "Wed, 16 May 2007 17:22:26 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47447>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Earlier, we used the mode to determine if a name was associated with
> a directory. This fails, since some tar programs do not set the mode
> correctly. However, the link indicator _has_ to be set correctly.

> 	The problem is -- again -- that a directory is overwritten, since 
> 	it is not recognized as a directory. Earlier, I tried to use the 
> 	trailing "/" for that. Which fails with your example.
>
> 	I actually took the time to research in Wikipedia what should be 
> 	the correct way to find out if the current item is a directory...

This matches my reading of GNU tar as well.  The patch would not
break a correctly made tar archive, would fix importing archives
created by a broken tar that does not do mode right (but uses the
correct typeflag), _and_ would _break_ archives created by tar
that is broken in a different way, sets the mode right but uses
a wrong typeflag.

I do not know which breakages are more common, and this one
being in contrib/ I do not think it really matters in practice,
but as a principle, I think we should try to adhere to the same
"no regression" policy the kernel folks try to adhere to.  If
something used to work, even if its was by accident or a bug, we
had better have a pretty good reason to break it by a change
that fixes things for other people, _even_ when that other
people outnumber the people who are affected by the regression.

I'd first ask GNU tar maintainer if he knows of existing
implementations of tar that are broken in the latter sense (iow,
sets modes correctly but typeflag incorrectly), as the tarball
extraction codepath would have the exact same issue.
