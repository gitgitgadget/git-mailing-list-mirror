From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] rev-list: add "--full-objects" flag.
Date: Thu, 07 Jul 2005 19:17:21 -0700
Message-ID: <7vy88ica8e.fsf@assigned-by-dhcp.cox.net>
References: <20050703234629.GF13848@pasky.ji.cz>
	<42CBC822.30701@didntduck.org> <20050707144501.GG19781@pasky.ji.cz>
	<7vk6k2sfa4.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507071158220.3293@g5.osdl.org>
	<20050707221443.GB7151@pasky.ji.cz>
	<Pine.LNX.4.58.0507071549330.25104@g5.osdl.org>
	<7vll4ifbq8.fsf_-_@assigned-by-dhcp.cox.net>
	<7vfyuqfa6r.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507071657140.25104@g5.osdl.org>
	<7vvf3mds9c.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507071841010.25104@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 08 04:18:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqiRA-0004EF-Jh
	for gcvg-git@gmane.org; Fri, 08 Jul 2005 04:17:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261456AbVGHCRu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jul 2005 22:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbVGHCRa
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jul 2005 22:17:30 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:42448 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261387AbVGHCR2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2005 22:17:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050708021721.BNLP18672.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 7 Jul 2005 22:17:21 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507071841010.25104@g5.osdl.org> (Linus Torvalds's message of "Thu, 7 Jul 2005 18:46:31 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> However, I really don't think it's a very useful option in
LT> the first place.  Any dumb web-based thing that depends on
LT> "--whole-trees" would suck horribly.

I agree with these two sentences now.

However it does not automatically mean that the avenue I have
been pursuing would not work; the server side preparation needs
to be a bit more careful than what I sent, which unconditionally
runs "prune-packed".  It instead should leave the files that
"--whole-trees" would have packed as plain SHA1 files, so that
the bulk is obtained by statically generated packs and the rest
can be handled in the commit-chain walker as before.

So, the server side preparation needs be tweaked to do something
like:

  (1) Repack when necessary (no --whole-trees).

  (2) For each .git/objects/pack/ pack, make a list of trees and
      blobs that are missing from the commits that contained in
      the same pack.

  (3) Run "prune-packed" but do not prune objects on the list
      produced in the previous step.

  (4) Take inventory, rev-cache, and pack, as done by the posted
      patch.

The determination of (1) is a bit problematic since "when
necessary" is not "when .git/objects/?? grew too big" anymore,
due to the fact that (3) would deliberately leave plain SHA1
files there.

A completely different way would be to prepare packs of objects
based on age, and create an inventory of such packs.  Have
client download such an inventory, which essentially says "if
you have this commit, then slurp these packs and you are done."
