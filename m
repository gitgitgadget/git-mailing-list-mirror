From: David Roundy <droundy@abridgegame.org>
Subject: using git directory cache code in darcs?
Date: Sat, 16 Apr 2005 09:22:36 -0400
Message-ID: <20050416132231.GJ2551@abridgegame.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: darcs-devel@darcs.net
X-From: git-owner@vger.kernel.org Sat Apr 16 15:24:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMnHD-0004m8-QM
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 15:24:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262659AbVDPN1d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 09:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262660AbVDPN1d
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 09:27:33 -0400
Received: from user-10mt71s.cable.mindspring.com ([65.110.156.60]:5198 "EHLO
	localhost") by vger.kernel.org with ESMTP id S262659AbVDPN10 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 09:27:26 -0400
Received: from droundy by localhost with local (Exim 4.50)
	id 1DMnFs-0003ZF-Eb; Sat, 16 Apr 2005 09:22:36 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org, darcs-devel@darcs.net
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello Linus and various git developers (ccing darcs developers),

I've been thinking about the possibility of using the git "current
directory cache" code in darcs.  Darcs already has an abstraction layer
over its pristine directory cache, so this shouldn't be too hard--provided
the git code is understandable.  The default in darcs is currently to use
an actual directory ("_darcs/current/") as the cache, and we synchronize
the file modification times in the cache with those of identical files in
the working directory to speed up compares.  We (the darcs developers) have
talked for some time about introducing a single-file directory cache, but
noone ever got around to it, partly because there wasn't a particularly
compelling need.

It seems that the git directory cache is precisely what we want.  Also, if
we switch to (optionally) using the git directory cache, I imagine it'll
make interfacing with git a lot easier.  And, of course, it would
significantly speed up a number of darcs commands, which are limited by the
slowness of the readdir-related code.  We haven't tracked this down why
this is, but a recursive directory compare in which we readdir only one of
the directories (since we don't care about new files in the other one)
takes half the time of a compare in which we readdir both directories.

So my questions are:

1) Would this actually be a good idea? It seems good to me, but there may
be other considerations that I haven't thought of.

2) Will a license be chosen soon for git? Or has one been chosen, and I
missed it? I can't really include git code in darcs without a license.  I'd
prefer GPLv2 or later (since that's how darcs is licensed), but as long as
it's at least compabible with GPLv2, I'll be all right.

3) Is it likely that git will switch to not using global variables for
active_cache, active_nr and active_alloc? I'd be more comfortable passing
these things around, since it would make the haskell interface easier and
safer.  e.g. I'd like

struct git_cache {
        struct cache_entry **cache;
        unsigned int nr, alloc;
};

git_cache *read_cache(char *path_to_index);

or alternatively

int read_cache(char *path_to_index, git_cache *);

Would anyone on the git side be interested in making such changes? If not,
would they be likely to be accepted if a darcs person submitted patches?

4) Would there be interest in creating a libgit? I've been imagining taking
git source files and including them directly in darcs' code, but in the
long run it would be easier if there were a standard git API we could use.

I guess that's about all.
-- 
David Roundy
http://www.darcs.net
