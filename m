From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] Cogito-0.12
Date: Thu, 07 Jul 2005 10:21:39 -0700
Message-ID: <7vk6k2sfa4.fsf@assigned-by-dhcp.cox.net>
References: <20050703234629.GF13848@pasky.ji.cz>
	<42CBC822.30701@didntduck.org> <20050707144501.GG19781@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 07 19:24:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dqa6W-0003pX-AI
	for gcvg-git@gmane.org; Thu, 07 Jul 2005 19:24:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbVGGRXZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jul 2005 13:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbVGGRXK
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jul 2005 13:23:10 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:36825 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261297AbVGGRVo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2005 13:21:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050707172141.GISR7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 7 Jul 2005 13:21:41 -0400
To: Petr Baudis <pasky@suse.cz>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "PB" == Petr Baudis <pasky@suse.cz> writes:

PB> It won't happen. Or rather, I hope the HTTP pulls become more efficient
PB> soon. Actually, perhaps Linus has something done already, my workstation
PB> is a bit derailed now so I couldn't pull from him in the last few days
PB> (hopefully will sort that out today).

PB> Hmm, yes, I guess Linus won't be touching the HTTP backend at all. ;-) I
PB> suggest you to check the last development in Linus' branch and sync with
PB> Daniel Barkalow, who promised improving the pull tools as well.

If this weekend is not too late, I have been brewing what is
called an "efficient pull from dumb servers" suite, which would
hopefully fill this gap.  I am still in the process of finishing
the details, but basically it already seems to work.

Linus, please drop the patch I sent you earlier, privately by
mistake not CCing the list, that implemented only the server
end.  I've changed some file formats already from that one.

The outline of how it works is like this.

 * I assume a dumb transport (read: static files only HTTP
   server) and no on-request server side processing.  All the
   smarts must go in the client.  The server side X.git being an
   ordinary GIT archive (no need for files in the work tree),
   plus:

   - X.git/objects/pack can have packed GIT archives.  I
     envision that this will be a series of 5 to 20 MB packs,
     occasionally adding a new incremental pack when
     X.git/objects/??/ directories accumulate enough standalone
     SHA1 files.  It is not necessary to have X.git/objects/??/
     files if an object is contained in one of the packs.

   - X.git/info/ has three extra files.

     - "inventory" lists all the branches stored in X.git/refs
       and looks like this (contents and path):

          ff83c8f3554ceb444b413beaeb49b4a781dae944 snap/0
          013e7c7ff498aae82d799f80da37fbd395545456 snap/10
          ff83c8f3554ceb444b413beaeb49b4a781dae944 heads/master
          dd7ba8b4949535c24e604a37709db0e3be9ccbbc heads/linus

       This is to facilitate discovery from a transport that is
       not so "ls" friendly, like HTTP.

     - "pack" lists available packs under X.git/objects/pack and
       looks like this (size and name):

          432495 pk-65fe69e9bc2e8a3e0881e008dde182522156ba7c.pack

       The file is there for discovery.  The size is used by the
       client to discover optimum set of packs to slurp.

     - "rev-cache" is a binary file that describes commit
       ancestry information in a dense format.  It lists all
       commits available from this repository along with who
       its parents are for each of the commit.  This file is
       produced append-only, so that the server side can use
       rsync based mirroring scheme.

   A new command "git-update-dumb-server" is used to prepare
   these three files.  There may need a helper script that uses
   git-pack-objects and friends to prepare packs partitioned to
   allow pulling a popular branch efficiently.

 * The client side is called "git-dumb-pull-script".  This
   downloads the above three files, and .idx files associated
   with packs described in "pack".  With the information in
   "inventory" about desired branch to pull from along with
   "rev-cache" ancestry information, it discovers the set of
   commits that is lacking from its local store.  By comparing
   that list with downloaded .idx files, along with size
   information for each pack, it comes up a list of packs to
   download to cover the most commits that it wants to obtain,
   and downloads them, verifies them and stores them in its
   .git/objects/pack/ directory.

   The above process of downloading packs would typically not
   cover all the things lacking, because some new commits may
   not be in any of the packs.  After this point, the usual
   commit-walking git-http-pull can be used to fill the rest,
   and it does not have to pull that many objects.  Dan's
   http-pull parallelism improvement would be very useful
   independently here.
