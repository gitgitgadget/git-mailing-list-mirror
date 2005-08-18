From: Junio C Hamano <junkio@cox.net>
Subject: Multi-head pulling series
Date: Thu, 18 Aug 2005 00:24:28 -0700
Message-ID: <7vek8rlnbn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Aug 18 09:27:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5elR-0004vi-7v
	for gcvg-git@gmane.org; Thu, 18 Aug 2005 09:24:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbVHRHYc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Aug 2005 03:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750904AbVHRHYc
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Aug 2005 03:24:32 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:51863 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750890AbVHRHYb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2005 03:24:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050818072428.DDXD8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 18 Aug 2005 03:24:28 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Here is the current status of the multi-head download support.

    [PATCH 1/3] Start adding the $GIT_DIR/remotes/ support.
    [PATCH 2/3] Multi-head fetch.
    [PATCH 3/3] Update git-pull to match updated git-fetch.

The first one in the series adds support for the long promised
$GIT_DIR/remotes/ files; they use the following format:

	$ cat $GIT_DIR/remotes/www
	URL: http://www.kernel.org/pub/scm/git/git.git/
	Pull: master:ko-master pu:ko-pu

	$ cat $GIT_DIR/remotes/mko
	URL: master.kernel.org:/pub/scm/git/git.git/
	Pull: master:ko-master pu:ko-pu
	Push: master:master pu:pu foo:bar

The idea is that you should be able to say:

	$ git push mko ;# push our master and pu to the same
			# name, foo to .git/refs/heads/bar.
        
	$ git push mko pu:refs/heads/testing
			# instead of pushing to the usual ref,
                        # push our pu to refs/heads/testing,
                        # this time only. 
        
	$ git fetch www ;# get their master and pu to our ko-master
 			 # and ko-pu.

	$ git pull www bar
 			# instead of fetching from usual ref,
                        # fetch from there bar, and merge with it.

Having a Push: entry that uses anything but hostname:/path or
just local directory as its URL does not make any sense at this
moment, because git native send-pack transport is the only one
that is supported for push, as before.

Note that using a $GIT_DIR/branches/ file as a short-cut is
still supported, for both upload and download.

The second one extends "git fetch" to allow pulling from more
than one head.  Earlier, "git fetch <remote>" with shorthand
form (i.e. a file $GIT_DIR/branches/<remote> exists and
describes the URL) always overwrote
$GIT_DIR/refs/heads/<remote>, but it does the "reverse push",
meaning it does not overwrite when the update does not result in
a fast-forward merge with the existing value of the reference.
The above "git fetch www" example would fetch both their master
and pu, and tries to fast forward our ko-master and ko-pu with
them.  When fast forwarding fails, currently it just stops and
does not try to download all the heads.  This may need to
change.  The fetch results, whether they update the local
refs/heads/ hierarchy by fast forwarding or not, will be also
stored in $GIT_DIR/FETCH_HEAD.

Note that the format of this file has changed to accomodate
multiple heads.  I've checked that neither Cogito nor StGIT
looks at this file, so this change should hopefully be a safe
one.

The third one is to update the "git pull" to prevent people from
abusing the extended "git fetch" and attempt to create a king
ghidorah.  "git resolve" has not been updated to do anything but
two-head merge yet, so when you say "git pull www master pu rc",
it would run "git fetch www master pu rc" but stops without
running the resolving step.  While it would not make much sense
xsto do an octopus merge against master, pu and rc from git.git
repository, doing an octopus would probably make a lot more
sense when pulling from a repository like what Jeff Garzik has,
so that would be an interesting future project.

I have tested the very basic form of the above works reasonably
well, but there probably are bugs, maybe attempting to pull
heads to a wrong local heads, or something silly like that.
Please handle it with care.  It will stay in "pu" branch for
now.
