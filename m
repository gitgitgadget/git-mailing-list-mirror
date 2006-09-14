From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Trivial support for cloning and fetching via ftp://.
Date: Wed, 13 Sep 2006 23:57:59 -0700
Message-ID: <7vk6475408.fsf@assigned-by-dhcp.cox.net>
References: <20060914022404.GA900@sashak.voltaire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 14 08:58:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNlB1-0005QR-By
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 08:58:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbWING6D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Sep 2006 02:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbWING6D
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 02:58:03 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:12759 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751374AbWING6A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Sep 2006 02:58:00 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060914065800.JTIM21457.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Thu, 14 Sep 2006 02:58:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id N6xp1V0071kojtg0000000
	Thu, 14 Sep 2006 02:57:49 -0400
To: Sasha Khapyorsky <sashak@voltaire.com>
In-Reply-To: <20060914022404.GA900@sashak.voltaire.com> (Sasha Khapyorsky's
	message of "Thu, 14 Sep 2006 05:24:04 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26989>

Sasha Khapyorsky <sashak@voltaire.com> writes:

> This adds trivial support for cloning and fetching via ftp://.

Interesting.

I was wondering myself if our use of curl libraries in
http-fetch allows us to do this when I was looking at the
alternates breakage yesterday.

At a few places we do look at http error code that is returned
from the curl library, and change our behaviour based on that.
But it appears the difference between error code from ftp and
http has no bad effect on us.  In an empty repository, we can
run this:

	$ git-http-fetch -a -v heads/merge \
	  ftp://ftp.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git

(of course, this should normally be with http://www.kernel.org).
We notice that we get an error from a request for one object,
and switch to pack & alternates transfer.  The only difference
between http://www and ftp://ftp is that for the former we know
error code 404 and supress the error message but for the latter
we do not treat error 550 from RETR response any specially and
show an error message.  We still fall back to retrieve packs,
hoping that the missing object is in a pack.

I'd take this patch as is, but we might want to add some error
message supression logic just like we do for http.
