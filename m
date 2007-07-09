From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix "git log --parent -m" from emitting duplicated parent info
Date: Sun, 08 Jul 2007 23:19:09 -0700
Message-ID: <7vodimw142.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550707080737j56c161bdrf0c079b61877085b@mail.gmail.com>
	<7vd4z2za2g.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0707090220281.4248@racer.site>
	<7vps32xsof.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550707082246k39286517o58fe89d80e05e08@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 09 08:19:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7maa-0006Eb-8x
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 08:19:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbXGIGTM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 02:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751067AbXGIGTM
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 02:19:12 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:49026 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818AbXGIGTL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 02:19:11 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070709061910.BTMD19529.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Mon, 9 Jul 2007 02:19:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id MJKA1X0011kojtg0000000; Mon, 09 Jul 2007 02:19:10 -0400
In-Reply-To: <e5bfff550707082246k39286517o58fe89d80e05e08@mail.gmail.com>
	(Marco Costalba's message of "Mon, 9 Jul 2007 07:46:10 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51962>

"Marco Costalba" <mcostalba@gmail.com> writes:

> Indeed we can use and _do_ use --full-history not only for printing
> all revisions but to _walk_ the tree in a certain way, different from
> default.

Yes, --full-history essentially tells the machnery to walk all
side branches even when a merge takes all the specified paths
from one parent's version.  You will end up walking all five
branches from the first pentapus "addafaf" in git.git history,
even if history simplification with pathspec would have narrowed
it down to three paths if you did not give that option.

> IMHO --parents + --full-history is absolutely legal because the first
> flag indicate how to walk the tree and the second flag indicate what
> to show to the user.

I think we are in agreement.  You are telling the machinery to
walk all five branches with --full-history.  But you are not
telling the machinery to keep the intermediate commits (i.e. you
do not give --sparse), so these five branches can be simplified
to lead to the same parent.  I think I was confused by dense vs
simplify_history when I wrote that message in the thread
Johannes pointed out:

	http://thread.gmane.org/gmane.comp.version-control.git/29222

Making the duplicate parent removal depend on "dense" makes
sense, but the rewrite_parent() codepath is used only when dense
anyway.

Thanks for a timely objection and sanity checking.
