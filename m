From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/7] gitweb: Cleanups, fixes and small improvements
Date: Sat, 26 Aug 2006 13:58:08 -0700
Message-ID: <7vd5an1afz.fsf@assigned-by-dhcp.cox.net>
References: <1156612392716-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 26 22:58:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GH5E9-0000Tw-Ii
	for gcvg-git@gmane.org; Sat, 26 Aug 2006 22:58:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbWHZU5r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Aug 2006 16:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbWHZU5r
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Aug 2006 16:57:47 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:13533 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750892AbWHZU5q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Aug 2006 16:57:46 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060826205746.IVPM6235.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Sat, 26 Aug 2006 16:57:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
	by fed1rmimpo01.cox.net with bizsmtp
	id Ekxk1V00M4Noztg0000000
	Sat, 26 Aug 2006 16:57:44 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <1156612392716-git-send-email-jnareb@gmail.com> (Jakub Narebski's
	message of "Sat, 26 Aug 2006 19:13:12 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26068>

Jakub Narebski <jnareb@gmail.com> writes:

* gitweb: Restore old git_blame using git-annotate under "annotate"

  I actually was hoping to see a patch to remove the git_blame
  which is not used as far as I can see.

  Although we carried annotate and blame in git.git tree for
  quite a while, the intention was always to deprecate one over
  the other once pros-and-cons of each implementation become
  clear (and I think people would not miss annotate if we remove 
  annotate and make it an alias for blame -c anymore).  What's
  the reason we would want to have both?

* gitweb: Remove workaround for git-diff bug fixed in f82cd3c
. gitweb: Fix typo in git_patchset_body

  I think you had separate patches for these; applied.

* gitweb: Use 'local $/ = undef;' before 'print <$fd>;'

  You changed:

	$/ = undef;
	print <$fd>;
        ... hope that nobody depends on standard value of $/
	... around here, which may still break if you did sub
	... calls, the sub did not localize $/ (who would?),
        ... and depended to have a sane $/.
	$/ = "\n";

  to

	local $/ = undef;
	print <$fd>;
        ... hope that nobody depends on standard value of $/
	... until the end of scope, and whoever changes this
        ... sub is careful enough in the future

  which I think is worse.  Introducing an extra scope explicitly
  delimit the part you want to use localized $/ like this

	{ local $/; print <$fd>; } 

  might have been more palatable.  Am I guessing the reason of
  your change wrong?

* gitweb: Always link to plain version of the blob

  Needs a better description to justify the change by describing
  in what way the current implementation is broken.

The ones above I won't apply just yet (I first applied, merged
into "next" and then commented on the earlier 19 series, but I'm
not going to repeat that mistake again this time).

The rest look OK so I'll apply them; [6/7] depended on [5/7] so
I manually adjusted the context.
