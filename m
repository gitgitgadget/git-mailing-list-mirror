From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: Re: [TopGit PATCH] tg-create.sh: Introduce --add option to add a
 dependency.
Date: Wed, 13 Aug 2008 11:20:47 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0808131100280.1278@harper.uchicago.edu>
References: <1218637514.7561.30.camel@heerbeest>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git <git@vger.kernel.org>, Jan Holesovsky <kendy@suse.cz>
To: Jan Nieuwenhuizen <janneke-list@xs4all.nl>
X-From: git-owner@vger.kernel.org Wed Aug 13 18:23:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTJ7D-0000wz-BL
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 18:22:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756630AbYHMQUw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 12:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756622AbYHMQUv
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 12:20:51 -0400
Received: from smtp01.uchicago.edu ([128.135.12.77]:54816 "EHLO
	smtp01.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756606AbYHMQUu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 12:20:50 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp01.uchicago.edu (8.13.8/8.13.8) with ESMTP id m7DGKm1u026521;
	Wed, 13 Aug 2008 11:20:48 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m7DGKlew002036;
	Wed, 13 Aug 2008 11:20:47 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <1218637514.7561.30.camel@heerbeest>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92238>

Hi,

Jan Nieuwenhuizen wrote:

> The bad thing is that this does not play well with tg undepend;
> it won't work to re-add a previously removed dependency.  This
> --add is implemented as a merge, and all merge commits are
> already present; it is only that lateron they are reverted.
> 
> Any ideas on how to fix that?

Interesting - I had imagined changing dependencies working in an
entirely different way.

Let's say your history is

    B -- (some mess) -- P

where P is your current branch head, and B is the current top base, a
merge of all your current dependencies.  Now you change your
dependencies drastically, and you end up with a new top base B'.  Then
ideally you want your new branch head P' to have the same tree as if you
had run "git rebase --onto B' B P", but of course you want to preserve
the history, so you could

	$ git checkout -b P' P
	$ git rebase --onto B' B
	$ git checkout P
	$ git merge --no-ff --no-commit B'   (*)
	$ git read-tree -u P'
	$ git commit
	$ git branch -D P'

or something like that.  The line marked with a (*) doesn't work as it
should in current git as far as I remember, but it would be a simple
change.  The point is to achieve the result

    B -- (some mess) -- old P -- P
                                /
                              B'

with the diff from B to old P being approximately the same as the diff
from B' to P, even if we just dropped some dependencies.

The main problem I see with this story is that if B' is just B with some
new changes added this is overly complicated.  In other words, in the
simple case of moving from (say) a patch based on master to a patch
based on next, one would probably prefer

    B -- (some mess) -- old P -- P
     \                         /
      ---------------------- B'

and similarly for moving from depending on master+(one additional patch)
to next+(that same patch).

Hope this helps, and sorry I don't have something more constructive to
say.  Thanks for starting this going.

Jonathan
