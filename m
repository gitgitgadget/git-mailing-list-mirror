From: worley@alum.mit.edu (Dale R. Worley)
Subject: Re: What happens when the repository is bigger than gc.autopacklimit * pack.packSizeLimit?
Date: Fri, 29 Aug 2014 11:47:35 -0400
Message-ID: <201408291547.s7TFlZ4F002412@hobgoblin.ariadne.com>
References: <201408271936.s7RJarOh011358@hobgoblin.ariadne.com> <xmqqa96pd59s.fsf@gitster.dls.corp.google.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 17:47:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNOOs-0000pY-Vb
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 17:47:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753097AbaH2Prj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 11:47:39 -0400
Received: from qmta03.westchester.pa.mail.comcast.net ([76.96.62.32]:38509
	"EHLO qmta03.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752755AbaH2Pri (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Aug 2014 11:47:38 -0400
Received: from omta15.westchester.pa.mail.comcast.net ([76.96.62.87])
	by qmta03.westchester.pa.mail.comcast.net with comcast
	id ke0Y1o0021swQuc53fnbmq; Fri, 29 Aug 2014 15:47:35 +0000
Received: from hobgoblin.ariadne.com ([24.34.72.61])
	by omta15.westchester.pa.mail.comcast.net with comcast
	id kfnb1o00T1KKtkw3bfnbch; Fri, 29 Aug 2014 15:47:35 +0000
Received: from hobgoblin.ariadne.com (hobgoblin.ariadne.com [127.0.0.1])
	by hobgoblin.ariadne.com (8.14.7/8.14.7) with ESMTP id s7TFlZqL002413;
	Fri, 29 Aug 2014 11:47:35 -0400
Received: (from worley@localhost)
	by hobgoblin.ariadne.com (8.14.7/8.14.7/Submit) id s7TFlZ4F002412;
	Fri, 29 Aug 2014 11:47:35 -0400
In-reply-to: <xmqqa96pd59s.fsf@gitster.dls.corp.google.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1409327255;
	bh=gI2uWKa1bDID+eUe9gv1ATtreqZ4zVyHTsnbVQooEBs=;
	h=Received:Received:Received:Received:Date:Message-Id:From:To:
	 Subject;
	b=ICwgtu2N1TNrUa1ouSxlPePXEDSRcZ2R33mUCZzIUASn6ArlP21pTbAzy9eiK5Whm
	 e0NjUeA0PyetRbURPuBSTCTBQVYq3clC2BlF0EGlT5J5R+/q/JK0NGc21ktWiwC4OO
	 HTb5nEzf9Y+3YXJnVInKCrkGIH8MhSBHB5ct7IoWfV+7Tl7lvBrU0g6es/AbqCuM7R
	 6frDcXN9juMv4B0YVxXQF2pHfdq0Gmv5v/bZIVKja2SBDAdODUir+qHo2uqTOt82jR
	 4YA2yhm82hhUOQUBVoH/598IwMlDaZRx01PLUeghOojYz9VWqQNFB1vcTExvpVWrh0
	 xEaHbZVgE2u2g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256150>

> From: Junio C Hamano <gitster@pobox.com>

> But if your definition of the boundary between "small" and "large"
> is unreasonably low (and/or your definition of "too many" is
> unreasonably small), you will always have the problem you found.

I would propose that a pack whose size is "close enough" to
packSizeLimit should be assumed to have already been built by
repacking, and shouldn't count against autopacklimit.

That's easy to implement, and causes the desirable result that "git gc
--auto" isn't triggerable immediate after repacking.

Of course, eventually there will be enough loose objects, and
everything will get repacked (even the "full" packs).  But that will
happen only occasionally.

That does leave open the question of what is "close enough".  Off the
top of my head, a pack which is larger than packSizeLimit minus (the
size limit for files we put in packs) can be considered "full" in this
test.

Then again, maybe the solution is to just set autopacklimit very high,
perhaps even by default -- in real use, eventually the gc.auto test
will be triggered.

Dale
