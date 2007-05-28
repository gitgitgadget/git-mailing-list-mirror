From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 00/15] git-note: A mechanisim for providing free-form after-the-fact annotations on commits
Date: Mon, 28 May 2007 13:45:36 -0700
Message-ID: <7vps4kbrtb.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0705091406350.18541@iabervon.org>
	<200705271608.02122.johan@herland.net>
	<alpine.LFD.0.98.0705272131370.26602@woody.linux-foundation.org>
	<200705281254.23297.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon May 28 22:45:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hsm61-0006A4-4k
	for gcvg-git@gmane.org; Mon, 28 May 2007 22:45:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbXE1Upj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 May 2007 16:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751815AbXE1Upi
	(ORCPT <rfc822;git-outgoing>); Mon, 28 May 2007 16:45:38 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:63256 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751457AbXE1Upi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2007 16:45:38 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070528204537.GOD12190.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Mon, 28 May 2007 16:45:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 4kld1X0051kojtg0000000; Mon, 28 May 2007 16:45:37 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48641>

Johan Herland <johan@herland.net> writes:

> And while we're on the subject of changing the tag object, I'd like for
> the "tag" header (the one holding the tag name) to become optional.
> When doing my ref <-> name trick above, I conveniently forgot this little
> bugger. Basically the only reason for this one to exist is to include the
> name of the tag in the data passed to gpg for signing. This is of course
> necesssary in order to make renaming a signed tag impossible. (Allowing
> renaming would make it possible to replace it with a malicious tag with
> the original name.) Therefore the "tag" header must be mandatory for
> signed tags. But for all other tags (including notes) this header is
> pretty much useless.

This brings up an interesting point, by the way.

Currently when you say

	$ git show v2.6.22

we "dwim_ref" v2.6.22.  That is, we try to see if ".git/v2.6.22"
is there (it isn't), check ".git/refs/v2.6.22" (no, again), then
happily find that ".git/refs/tags/v2.6.22" is there and use it.

During this process we _never_ check if the tag object pointed
at by the ref v2.6.22 has tagname v2.6.22 at all.

I do not think it is a problem at all that we do not use "tag"
name during the look-up process.  However it would be a good
idea to add logic to fsck to warn upon inconsistencis (perhaps
by mistake) between refname and tag's true name.

The check would say something like:

	If an annotated (signed or unsigned) tag has a "tag"
	line to give it the official $name, and if it is pointed
	at by a ref, the refname must end with "/$name".
	Otherwise we warn.

Trivially, the above rule says that having v2.6.22 tag under
refs/tags/v2.6.20 is a mistake we would want to be warned upon.

The "/$name" part is to support merging a separate project into
another project after the fact better.  Shawn graciously names
his tags in git-gui project "gitgui-0.7.1", to avoid tag name
collisions with "v1.5.0" style tag names in git.git project, but
we could have stored his v0.7.1 tag as refs/tags/gitgui/v0.7.1
to differenciate the tag namespace (this needs an update to the
"tag following" code in git-fetch with a new configuration).
