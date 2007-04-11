From: Junio C Hamano <junkio@cox.net>
Subject: Re: Rebase, please help
Date: Wed, 11 Apr 2007 00:38:41 -0700
Message-ID: <7v8xczqs1q.fsf@assigned-by-dhcp.cox.net>
References: <200704110852.00540.litvinov2004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexander Litvinov <litvinov2004@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 14:57:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbXPj-0001vM-3C
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 09:38:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbXDKHin (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 03:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbXDKHin
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 03:38:43 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:36417 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982AbXDKHim (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 03:38:42 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070411073841.VDWF1226.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Wed, 11 Apr 2007 03:38:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ljeh1W00F1kojtg0000000; Wed, 11 Apr 2007 03:38:41 -0400
In-Reply-To: <200704110852.00540.litvinov2004@gmail.com> (Alexander Litvinov's
	message of "Wed, 11 Apr 2007 08:52:00 +0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44213>

Alexander Litvinov <litvinov2004@gmail.com> writes:

> I have found that rebase have (new) option : --merge
> Looking at the code show me that regular rebase is a simply format-patch and 
> am but --merge (or -s) use some merge stratyegy to merge changes between two 
> commits into current head.
>
> What is --merge for ? Will the result be the same ?

Regular "rebase" uses "format-patch" piped to "am -3", so if you
do not have renames the file-level patch conflict can be
resolved using the 3-way merge logic.  However, because we do
not give -M to format-patch, it does not deal with case where
you have renames in the series of commits you are rebasing, nor
where you have renames between the current base commit and the
commit you are rebasing onto (the latter won't be solved with
giving -M to format-patch anyway, so we do not even try).

In cases involving such renames, giving --merge option would
probably be nicer to work with.  It invokes merge-recursive
logic to deal with the renames.

I find that the regular rebase without --merge is faster (at
least it feels to me that it is, and I kind of understand why;
patch application to write out a tree is optimized to take
advantage of cache-tree extension, as opposed to merging three
trees which clobbers it), when there is no patch conflict.
Since most rebases do not involve patch conflict for me and
seldom involve rebases, I almost never use --merge myself, but
this would depend highly on personal taste and project.
