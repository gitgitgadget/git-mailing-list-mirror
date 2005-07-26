From: Junio C Hamano <junkio@cox.net>
Subject: Re: Why pack+unpack?
Date: Mon, 25 Jul 2005 23:14:52 -0700
Message-ID: <7vek9mayar.fsf@assigned-by-dhcp.cox.net>
References: <42D7F415.30609@pobox.com>
	<Pine.LNX.4.58.0507252145470.6074@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff Garzik <jgarzik@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 26 08:17:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DxIju-0002Bj-1E
	for gcvg-git@gmane.org; Tue, 26 Jul 2005 08:16:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbVGZGPu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jul 2005 02:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261742AbVGZGPt
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jul 2005 02:15:49 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:56994 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261744AbVGZGO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2005 02:14:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050726061454.DQTG7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 26 Jul 2005 02:14:54 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507252145470.6074@g5.osdl.org> (Linus Torvalds's message of "Mon, 25 Jul 2005 21:53:45 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> See? Trying to have one really solid code-path is not a waste of time. 

An alternative code path specialized for local case would not be
too bad.

First, finding the list of objects to copy.  You can use
alternate object pool to cover the upstream repository to pull
from, and the downstream repository to pull into (both local),
run rev-list --objects, giving it prefix '^' for all refs in the
downstream repository, and the upstream head SHA1 you are
pulling.  If the upstream head you are pulling is a tag, then
you may need to dereference it as well.

Among those objects, ones unpacked in the upstream can be
copied/linked to the downstream repository.

Handling packs involves a little bit of policy decision.  The
current pack/unpack way always unpacks, and to emulate it, we
can cat-file in the upstream object database, pipe that to
"hash-object -w" (after giving hash-object an option to read
from the standard input) to write in the downstream repository
unpacked.  Easier alternative is to just hardlink all the packs
from the upstream object database into the downstream object
database, and keep packed things packed.

Well, it starts to sound somewhat bad...
