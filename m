From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] use xread where we are not checking for EAGAIN/EINTR
Date: Fri, 05 Jan 2007 03:19:55 -0800
Message-ID: <7vvejlg1pg.fsf@assigned-by-dhcp.cox.net>
References: <1cb8699724ff000fbf0c14ba3e15031e@pinky>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 05 12:20:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2n7B-0003qc-Gs
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 12:20:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161063AbXAELT5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 06:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161064AbXAELT5
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 06:19:57 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:64229 "EHLO
	fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161063AbXAELT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 06:19:57 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070105111956.FIVB3976.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>;
          Fri, 5 Jan 2007 06:19:56 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 7PLB1W0071kojtg0000000; Fri, 05 Jan 2007 06:20:11 -0500
To: Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <1cb8699724ff000fbf0c14ba3e15031e@pinky> (Andy Whitcroft's
	message of "Fri, 05 Jan 2007 10:54:33 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35995>

Andy Whitcroft <apw@shadowen.org> writes:

>     We have an xread() wrapper to help us with those nasty
>     interrupt returns and yet we fail to use it consistently.
>     This patch updates those plain read()'s which do not
>     have any handling for errors, or which treat those errors
>     as user visible fatal errors.
>
>     This feels right to me, but perhaps there is some good
>     reason that things are done this way ... if so could
>     someone elighten me.

Thanks.

I do not think any of the changes you did introduced new bugs,
but I think some of them are still wrong.  xread() protects us
from EINTR happening before any byte is read, but it can still
give a short read.  Many callers have a loop like this:

	do {
        	size = xread(...);
                yet_to_go -= size;
	} while (yet_to_go);

but some are not (e.g. add_excludes_from_file_1() in dir.c
expects xread() does not return before reading full buffer).
