From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] More permissive "git-rm --cached" behavior without -f.
Date: Sat, 14 Jul 2007 00:16:14 -0700
Message-ID: <7vy7hjjw01.fsf@assigned-by-dhcp.cox.net>
References: <vpq8x9k9peu.fsf@bauges.imag.fr>
	<11843484982037-git-send-email-Matthieu.Moy@imag.fr>
	<7vfy3rlbnp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sat Jul 14 09:16:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9bra-0000rO-Ke
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 09:16:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918AbXGNHQQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 03:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751885AbXGNHQQ
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 03:16:16 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:50344 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751891AbXGNHQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 03:16:16 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070714071616.CQUA1393.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sat, 14 Jul 2007 03:16:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id PKGF1X0021kojtg0000000; Sat, 14 Jul 2007 03:16:15 -0400
In-Reply-To: <7vfy3rlbnp.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 13 Jul 2007 23:52:42 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52451>

Junio C Hamano <gitster@pobox.com> writes:

> Although I would not be using it often myself, I think this
> would make "git rm" more pleasant to use.
>
> Thanks for the patch, and my thanks also go to people who
> commented on the patch.

Having said that, I think this comment is not quite right.

+		else if (!index_only) {
+			/* It's not dangerous to git-rm --cached a
+			 * file if the index matches the file or the
+			 * HEAD, since it means the deleted content is
+			 * still available somewhere.
+			 */

Personally I do not think "rm --cached" needs any such "safety",
even though I'll keep the check for now, primarily because
loosening the restriction later is always easier than adding new
restriction.  I really do not think this is about protecting the
user from "deleted content is not available anywhere else".

In this sequence:

	edit a-new-file
	git add a-new-file
        edit a-new-file
        git add a-new-file

we do not complain, even though we are *losing* the contents we
earlier staged.  If you replace the second "git add" with
"git-rm --cached", the sequence should work the same way.  In
either case, you are working towards your next commit, and most
likely are doing a partial commit (iow, your working tree does
not match any of the commit you create in the middle).  Earlier
you thought you would want one state of the file in the next
commit, but now you decided against putting that new file in the
first commit in the series.  You may make further updates to the
index and would make a commit, but after making the commit, your
working tree still has "a-new-file" and you can add the contents
from it for the later commit.
