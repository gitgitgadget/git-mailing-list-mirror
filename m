From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/10] re-based and expanded tree-walker cleanup patches
Date: Wed, 31 May 2006 15:53:19 -0700
Message-ID: <7vpshtyffk.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0605291145360.5623@g5.osdl.org>
	<7virno79a7.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605291739430.5623@g5.osdl.org>
	<7vmzd05i25.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605292112530.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 01 00:53:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlZZ8-0004js-N5
	for gcvg-git@gmane.org; Thu, 01 Jun 2006 00:53:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965223AbWEaWxV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 May 2006 18:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965212AbWEaWxV
	(ORCPT <rfc822;git-outgoing>); Wed, 31 May 2006 18:53:21 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:44220 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S965223AbWEaWxV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 May 2006 18:53:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060531225320.VEXN15447.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 31 May 2006 18:53:20 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605292112530.5623@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 29 May 2006 21:17:06 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21096>

Linus Torvalds <torvalds@osdl.org> writes:

>  (a) git-rev-list --pretty=oneline "$upstream"..ORIG_HEAD > rev-list
>
>  (b) edit the rev-list, moving the single lines around, deleting them, etc
>
>  (c) cat rev-list |
>      git-format-patch -k --stdout --stdin --full_index |
>      git-am
>
> because the "--pretty=oneline" format is actually very nice as a way to 
> re-order things and select single commits to be deleted or whatever..

I am thinking about doing "format-patch --stdin" while I am
futzing with it for other reasons, and one issue is where to
"tac" the revision list.

We could internally reverse topo-sort what we read from --stdin
inside format-patch, but that would defeat the reordering that
is done in the step (b) above, so that is not a useful thing to
do.

If we wanted to make rev-list piped straight to format-patch
equilvalent to giving the arguments you would have given rev-list
directly to format-patch, then format-patch should read --stdin
and reverse the list before emitting them out.

However, that would mean in the step (b) above the user needs to
be conscious that the list being edited is in the reverse order,
so if the list of commits needs to be reordered (and that is one
of the reasons the user is doing this step) what comes earlier
in the edited list will be output later in the result.

Tentatively my feeling is that we should make it known that the
list format-patch takes from --stdin is supposed to be _not_
reversed, and do nothing in format-patch.  In other words, the
list fed is a moral equivalent to quilt "series" file.

What this means is:

	git-format-patch $revargs

is not equivalent to

	git-rev-list $revargs | git-format-patch --stdin

but is equivalent to

	git-rev-list $revargs | tac | git-format-patch --stdin


Thoughts from the list?
