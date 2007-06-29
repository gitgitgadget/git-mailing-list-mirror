From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git add: respect core.filemode even with unmerged entriesin  the index
Date: Fri, 29 Jun 2007 03:20:45 -0700
Message-ID: <7v3b0bf4ea.fsf@assigned-by-dhcp.pobox.com>
References: <20070625064017.GA2839@mellanox.co.il>
	<7vlke833wr.fsf@assigned-by-dhcp.pobox.com>
	<20070625071752.GB15343@mellanox.co.il>
	<Pine.LNX.4.64.0706250846200.4059@racer.site>
	<81b0412b0706280152g5cbd777y76757d9c608ea483@mail.gmail.com>
	<Pine.LNX.4.64.0706281408280.4438@racer.site>
	<4683BDA5.996874EF@eudaptics.com>
	<Pine.LNX.4.64.0706281506390.4438@racer.site>
	<4683C5D2.FDF4ED02@eudaptics.com> <4683CA7A.7F8070D7@eudaptics.com>
	<Pine.LNX.4.64.0706281653260.4438@racer.site>
	<4684AD41.9868C32F@eudaptics.com>
	<Pine.LNX.4.64.0706291106190.4438@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 29 12:20:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4Dar-0007vY-3X
	for gcvg-git@gmane.org; Fri, 29 Jun 2007 12:20:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755346AbXF2KUr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jun 2007 06:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755336AbXF2KUr
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jun 2007 06:20:47 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:60149 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755287AbXF2KUq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jun 2007 06:20:46 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070629102046.OGDC6565.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Fri, 29 Jun 2007 06:20:46 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id HNLl1X0081kojtg0000000; Fri, 29 Jun 2007 06:20:45 -0400
In-Reply-To: <Pine.LNX.4.64.0706291106190.4438@racer.site> (Johannes
	Schindelin's message of "Fri, 29 Jun 2007 11:07:00 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51170>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 29 Jun 2007, Johannes Sixt wrote:
>
>> However, if only two stages are present, the file mode is still taken 
>> from the file instead of from the index. As that easy to solve (at least 
>> for the unambiguous case)?
>
> It might be related to the bug Junio found, i.e. that I assumed stage 1 to 
> be "ours".

Actually it is because (-1-pos) and (1-pos) are two apart.  By
starting to scan from (1-pos), you are jumping directly to
either the next path (in which case you do not pick it up), or
"their" version (i.e. stage #3) iff there are three stages for
the path in question.

I am all for refactoring the funny "pick up an existing entry at
any stage, but favor 0 then 2 then 1 and finally 3" into a
separate function.  It makes sense, although I do not offhand
know of a place that we can immediately reuse it (logically,
diff-files ought to do that, but I haven't checked).
