From: Junio C Hamano <gitster@pobox.com>
Subject: Re: --ignore-invalid flag to git log et al.?
Date: Wed, 11 Jul 2007 14:26:15 -0700
Message-ID: <7vvecq3a4o.fsf@assigned-by-dhcp.cox.net>
References: <18068.34542.502048.222112@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Jul 11 23:27:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8jiP-0007v9-5u
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 23:27:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758386AbXGKV1K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 17:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758456AbXGKV1J
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 17:27:09 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:45857 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758308AbXGKV1I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 17:27:08 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070711212617.DSHQ1349.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Wed, 11 Jul 2007 17:26:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id NMSF1X00W1kojtg0000000; Wed, 11 Jul 2007 17:26:16 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52206>

Paul Mackerras <paulus@samba.org> writes:

> What would you think about a --ignore-invalid flag for things like git
> rev-list and git log, to tell it to ignore any refs on the command
> line that are not valid objects?
>
> Currently there is a buglet in gitk where if a user puts some sort of
> ref on the command line, and then makes the ref invalid (e.g. by
> deleting the ref if it is a head or tag, or doing a git prune if it is
> a sha1 ID with no head/tag pointing to it), and then does "Update" in
> gitk, it will get an error because of the now-invalid ref.  (Yes, this
> is a bit of a corner case, but I have had a user point out this
> behaviour to me.)  With a --ignore-invalid flag, gitk could use this
> when doing "Update" to avoid the error.

I suspect a much less corner case schenario is an old saved view
where you used to care about "master..experimental -- gitweb/",
but now you are done with gitweb experiments and got rid of the
branch.  Then choosing that view would say "experimental? what
are you talking about?".

I wonder what the "--ignore-invalid" option should do.  If it
silently ignores, the command line to rev-list from the saved
view would become "^master -- gitweb" and the user is left with
emptiness without any indication of errors.  Is that a better
behaviour?  I would think not.  Giving results from a command
that is different from what the user thought is done without
telling the user is not very nice, so I think you would instead
need "--error-on-invalid".

> An alternative would be to have some way to validate refs.  I don't
> know how to do that efficiently.  I think I would not want to have to
> do a fork/exec for every ref that I wanted to check.

Is it a possibility to let the rev-list do its job when there is
no error, but catch the error if it does not understand the
command line, because of a revision that is now made invalid,
and then in the error path validate the revs one by one?  At
that point in the error path you do not particularly care about
the efficiency I would think.
