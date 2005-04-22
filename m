From: Junio C Hamano <junkio@cox.net>
Subject: Re: "GIT_INDEX_FILE" environment variable
Date: Fri, 22 Apr 2005 13:20:29 -0700
Message-ID: <7vbr867ecy.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0504211100330.2344@ppc970.osdl.org>
	<7vis2fbr0p.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504212200400.2344@ppc970.osdl.org>
	<7vzmvr72j6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504221147050.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 22 22:17:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP4ZX-00086D-Ry
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 22:16:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262120AbVDVUUj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 16:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262121AbVDVUUj
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 16:20:39 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:28344 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S262120AbVDVUUb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2005 16:20:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050422202030.JGAB19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 22 Apr 2005 16:20:30 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504221147050.2344@ppc970.osdl.org> (Linus
 Torvalds's message of "Fri, 22 Apr 2005 12:24:58 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> ... The fact is, you can do _exactly_ what you are talking
LT> about by just wrapping the calls in

LT> 	( cd $WORKING_DIR && git-cmd )

LT> which simply doesn't have any downsides that I can see.

Almost, with a counter-example.  Please try this yourself:

  $ cd mozilla-sha1
  $ echo '/* garbage */' >>sha1.c
  $ sh -c 'cd .. && show-diff "$0" "$@"' sha1.c
  $ cd .. && show-diff mozilla-sha1/sha1.c

Some commands that take working tree relative paths do strange
things without the path munging I discussed in the original
message ("$R- prefixing") if you chdir to the $WORKING_DIR.  The
jit-update-cache wrapper I sent in the previous message is an
example of how Cogito layer can work it around.  It does not
break my "yuck" meter but I think it probably makes most people
barf ;-).  I was trying to make this path munging part easier
for the upper layer by making the core aware of WORKING_DIR.

Here is an updated set of commands that needs such path munging:

  check-files paths...
  show-diff [-R] [-q] [-s] [-z] [paths...]
  update-cache [--add] [--remove] [--refresh]
      [--cacheinfo mode blob-id] paths...
  checkout-cache [-f] [-a] paths...

That said, I do not think the above set is too many to warrant a
core surgery (I am agreeing with your conclusion here).  Unless
we also normalize path to support something like:

  $ cd mozilla-sha1
  $ echo '/* garbage */' >>cache.h
  $ sh -c 'cd .. && show-diff "$0" "$@"' ../cache.h

in the core, that is.

