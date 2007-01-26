From: Junio C Hamano <junkio@cox.net>
Subject: More precise tag following
Date: Fri, 26 Jan 2007 03:07:19 -0800
Message-ID: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 26 12:07:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAOvU-0002m8-W8
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 12:07:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932872AbXAZLHW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 06:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932838AbXAZLHW
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 06:07:22 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:64330 "EHLO
	fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932872AbXAZLHV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 06:07:21 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070126110720.ROSF9173.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Fri, 26 Jan 2007 06:07:20 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Fn6N1W00C1kojtg0000000; Fri, 26 Jan 2007 06:06:23 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37838>

What if (I know, this discussion does not belong here until
1.5.0 final) we had a "reverse" database that keeps track of
what tag references which object, and "git rev-list" knows how
to exploit it?  That is, just like generating a list of objects
that are reachable with --objects option, if we can add a new
option --with-tag very cheaply to list tag objects that would
reach what are in the generated list of objects?

The way current git-fetch "follows" tags is very imprecise,
although it is good enough in practice.  If you happen to
locally have an object that is tagged (and currently we get the
list of non-tag objects that tags eventually refer to in an
out-of-band-ish way), then we fetch the tag and everything it
reaches.  This means if you copied a single commit that is tagged
from somewhere without objects that it refers to, we would end
up fetching beyond that commit to complete it.  Which would not
result in a corrupted repository, but ideally we should not be
fetching the tag in such a case.  And with something like
enhanced rev-list that knows --with-tag it might be possible (I
need to think a bit more about have/want exchange and what
should happen later in fetch-pack and push-pack protocol,
though).

The application of this actually may not be limited to tag
following.  We could define a tag-like objects that attaches to
other objects and enhance its meanings (annotates them) and
treat them the same way as tags for objects traversal and
transfer purposes, so if we were to do this, the option to
exploit reverse database would be called --with-annotation and
not --with-tag.

 - If a single-path following turns out to be too expensive
   (there was a longstanding talk about "git log --single-follow
   $path"; "git blame" also follows a single path although the
   target it follows can fork into two or more when following
   cut&pastes) because we need to explode multi-level trees for
   each commit while traversing commit ancestry, we could define
   an annotation to a commit that lists the set of paths the
   commit touches relative to each of its parents (so the object
   contains N lists of paths), so that pathspec limiting needs
   to open and read only one object to figure out that the trees
   do not have to be opened to skip the commit and/or a merge
   can be simplified.

 - We could define an annotation to a commit that describes what
   fake parents it should have instead of the real ones
   (i.e. grafts implemented in the object database).

Just an idle thought.
