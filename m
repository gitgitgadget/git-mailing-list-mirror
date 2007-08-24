From: Junio C Hamano <gitster@pobox.com>
Subject: Re: tracking perms/ownership
Date: Fri, 24 Aug 2007 13:37:38 -0700
Message-ID: <7vfy28d5yl.fsf@gitster.siamese.dyndns.org>
References: <1187716461.5986.71.camel@beauty>
	<20070821134030.b763e9d3.seanlkml@sympatico.ca>
	<1187817948.5986.159.camel@beauty>
	<alpine.LFD.0.999.0708221618510.30176@woody.linux-foundation.org>
	<1187905879.5986.199.camel@beauty>
	<7vtzqpsy3q.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.999.0708231626580.30176@woody.linux-foundation.org>
	<85ir75h2zb.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0708232327100.25853@woody.linux-foundation.org>
	<86mywhfk17.fsf@lola.quinscape.zz>
	<alpine.LFD.0.999.0708241039250.25853@woody.linux-foundation.org>
	<1187979317.6357.155.camel@beauty>
	<alpine.LFD.0.999.0708241119140.25853@woody.linux-foundation.org>
	<1187981803.6357.173.camel@beauty>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"David Kastrup" <dak@gnu.org>, git@vger.kernel.org
To: "Josh England" <jjengla@sandia.gov>
X-From: git-owner@vger.kernel.org Fri Aug 24 22:37:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOfui-0005iZ-Ii
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 22:37:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755496AbXHXUhs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Aug 2007 16:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755922AbXHXUhr
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 16:37:47 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:60665 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755868AbXHXUhq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2007 16:37:46 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 43340127B1F;
	Fri, 24 Aug 2007 16:38:02 -0400 (EDT)
In-Reply-To: <1187981803.6357.173.camel@beauty> (Josh England's message of
	"Fri, 24 Aug 2007 12:56:43 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56600>

"Josh England" <jjengla@sandia.gov> writes:

> But the stat data (even uid/gid) is in there nonetheless, right?  If
> everything is in there already I wouldn't need to add a thing.  I just
> want to access the index cache rather than hitting the filesystem
> directly.

But to use that data you would need extra code to move things
from there to gitattributes, wouldn't you?  I can see that you
could "stage" change of ownership in the index and attempt to
commit by nonexisting

	git update-index --chown root foo.c

which would say "foo.c is now owned by uid #0", but before the
next git-commit-tree runs, somebody (namely, "git-commit") has
to run a possibly enhanced "git diff-files" (traditionally
uid/gid are NOT part of contents at all, so diff-files would not
say ownership has changed between the filesystem and index in
what way at all) to notice that ownership has changed, and
update .gitattributes.

Then you need to also "git update-index" the .gitattributes as
well, to record the ownership change in the commit.  What if the
user had unrelated changes that the user does not want to commit
in .gitattributes?

It will quickly become a mess.

It would rather be more effective for the user action "I want to
change the ownership of foo.c to root" to cause a direct
manipulation of .gitattributes file.  For this, we can add a
nice wrapper if there is a need, but the initial cut could be
just running "${EDITOR-${VISUAL-vi}} .gitattributes", nothing
more.

The user can say "git diff" to view .gitattributes changes, and
if that is what he wants (maybe he wants to do "git add -i" to
pick only the hunk about the ownership change for the next
commit), the change to .gitattributes can be committed.
