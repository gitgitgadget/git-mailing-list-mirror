From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Tue, 17 Apr 2007 03:09:58 -0700
Message-ID: <7v7isbpb0p.fsf@assigned-by-dhcp.cox.net>
References: <200704171041.46176.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 12:10:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hdkde-0002Kw-Ls
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 12:10:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753247AbXDQKKA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 06:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753256AbXDQKKA
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 06:10:00 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:43977 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753247AbXDQKJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 06:09:59 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070417100959.SGNY1271.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Tue, 17 Apr 2007 06:09:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id oA9y1W00Y1kojtg0000000; Tue, 17 Apr 2007 06:09:58 -0400
In-Reply-To: <200704171041.46176.andyparkins@gmail.com> (Andy Parkins's
	message of "Tue, 17 Apr 2007 10:41:45 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44754>

Andy Parkins <andyparkins@gmail.com> writes:

> No parsing of the keyword itself is performed, the content is simply
> dropped.

You are sidestepping the most important problem by doing this.

The only sensible keyword you could have, without destroying
what git is, is blob id.  No commit id, no date, no author.

In http://article.gmane.org/gmane.comp.version-control.git/44654,
Linus said:

    I'll finish off trying to explain the problem in fundamental git terms: 
    say you have a repository with two branches, A and B, and different 
    history  on a file "xyzzy" in those two branches, but because they both 
    ended up applying the same patches, the actual file contents do end up 
    being 100% identical. So they have the same SHA1.

    What is

            git diff A..B -- xyzzy

    supposed to print?

    And *I* claim that if you don't get an immediate and empty diff, your 
    system is TOTALLY BROKEN.

Another thing he could have said is this:

	When you have such two branches, A and B, and you are on
	branch A:

	$ git checkout B

	should be immediate and instantaneous.

If you try to keyword expand commit id, date or anything that is
sensitive to *how* you got there, even though A and B have the
exact same set of blobs, you have to essentially update all of
them.  Computing what to expand to takes (perhaps prohibitively
expensive) time, but more importantly rewriting the whole 20k
(or howmanyever you have in your project) files out becomes
necessary, if your keyword expansion wants to say "oh, this file
was taken from a checkout of branch B", for obvious reasons.

Keyword expanding blob-id, or munging line-endings to CRLF form
on platforms that want it, do not have this problem, as how you
reached to the blob content does not affect the result of
expansion, therefore not just the blobs in commit A and commit B
but the working tree checked out of them must match with each
other.

Having reiterated what Linus already said why keyword expansion
and git are not friendly with each other (perhaps the reason is
because the former is stupid and git is smart), I'd try to be a
bit constructive and point out the areas you _could_ help with
in the nearby codepaths:

 * When 'diff' borrows from the working tree because the
   filesystem data matches the blob we are interested in, we
   already have a call to convert_to_git().  The diff machinery
   operates on the canonicalized representation (i.e. this is an
   area we do not need help from you). 

 * When 'checkout', 'read-tree -u' and 'merge-recursive' write
   things, we already have calls to convert_to_working_tree() to
   munge blob representation to working tree representation
   (i.e. again, this is an area we do not need help from you).

 * We do not do the borrowing from working tree when doing
   grep_sha1(), but when we grep inside a file from working tree
   with grep_file(), we do not currently make it go through
   convert_to_git() to fix line endings.  Maybe we should, if
   only for consistency.

 * We do not currently run convert_to_git() on the patch text
   given to git-apply; we could do so in parse_single_patch().
