From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Skip writing out sha1 files for objects in packed git.
Date: Mon, 27 Jun 2005 20:33:20 -0700
Message-ID: <7vekanyx33.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0506271755140.19755@ppc970.osdl.org>
	<7vwtofi6jk.fsf@assigned-by-dhcp.cox.net>
	<7vr7eni6fy.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506271935260.19755@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 28 05:27:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dn6lG-0008N0-8u
	for gcvg-git@gmane.org; Tue, 28 Jun 2005 05:27:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262492AbVF1Ddx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Jun 2005 23:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262498AbVF1Ddx
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jun 2005 23:33:53 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:33745 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S262492AbVF1Dd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2005 23:33:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050628033320.HSWT23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 27 Jun 2005 23:33:20 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506271935260.19755@ppc970.osdl.org> (Linus
 Torvalds's message of "Mon, 27 Jun 2005 19:43:57 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> If we want to expand a packed file and really write the objects to the 
LT> .git/objects directories, we should just not have that packed file in the 
LT> .git/objects/pack directory.

What I was aiming for was this:

 (1) Introduce an interface to sha1_file.c that lets you say
     "use this file as one of the packs, although it is not
     under .git/objects/pack";

 (2) Introduce another interface to sha1_file.c that lets you
     enumerate the index entries for a given pack file.

 (3) Remove the unpacking logic from unpack-object.c; instead
     call the above interfaces to register the pack and
     enumerate entries, and call read_sha1_file() followed by
     write_sha1_file() with do_expand repeatedly.

However, the infrastructure (1) and (2) may end up being a
special case only to support unpack-object (and removing the
code duplication for unpacking), in which case what you suggest
would make more sense.

LT> And if we have a pack-file in .git/objects/ that already has
LT> the object, that may not be the _same_ pack-file that we're
LT> expanding at all, so if that pack file already has the
LT> object, then not writing it out is actually the right thing
LT> to do.

This I have to think about a bit.
