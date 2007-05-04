From: Junio C Hamano <junkio@cox.net>
Subject: Re: repack: handling of .keep files
Date: Fri, 04 May 2007 09:59:00 -0700
Message-ID: <7vslacttij.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0705040225p26679dbib6a1261a1a43ee67@mail.gmail.com>
	<7vy7k4ud3d.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0705040342p4fed3a4bnee92cce6b5fb6b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 04 18:59:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hk17w-00056I-3K
	for gcvg-git@gmane.org; Fri, 04 May 2007 18:59:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031406AbXEDQ7T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 12:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031415AbXEDQ7T
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 12:59:19 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:51652 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031406AbXEDQ7B (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 12:59:01 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070504165901.QZNW1268.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Fri, 4 May 2007 12:59:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id v4z01W0031kojtg0000000; Fri, 04 May 2007 12:59:00 -0400
In-Reply-To: <81b0412b0705040342p4fed3a4bnee92cce6b5fb6b9@mail.gmail.com>
	(Alex Riesen's message of "Fri, 4 May 2007 12:42:10 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46191>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> Still, git-log shouldn't crash (nothing should, of course).

Honestly, I think that's borderline.  If you "dd if=/dev/random
of=/dev/hda", should the kernel keep going, perhaps gracefully
declining access to the filesystem on that drive?

> And, the temporary pack is created in working tree, instead of in GIT_DIR
> (why not GIT_OBJECT_DIR, btw?)

Not limited to the temporary pack (the detail of exact use
pattern escapes me -- I do not think it was temporary pack that
initiated the use of GIT_DIR for temporary things), I think
trying to not create things in the working tree came after
somebody who had a read-only (to him, not necessarily to
everybody) working tree and read-write GIT_DIR (separate
location, specified with the environment variable) had trouble.
At least the theory was GIT_DIR would be writable as long as you
are doing a "write" oriented operation, regardless of what.

Back then we did not support working in subdirectory of the
project as fully as we do now, so using such configuration was
not much less convenient than you have the normal layout of
having $project/.git directory at the top of the working tree.

While I do not think it is worth to try "supporting" use of
read-only working tree for write oriented operations, which
means that it should be safe to assume that the working tree is
writable and we _could_ create temporary pack in working tree
instead, I do not think the "_could_" means we should.  In the
case of temporary pack I do not think there would be a risk of
filename collisions, I think it makes sense to use either
GIT_DIR or GIT_OBJECT_DIRECTORY instead of the working tree.  

I do not know pros-and-cons between .git/ and .git/objects/;
filesystems tend to cluster nearby things better, so the latter
might be more logical, but packs are about using smaller (much
much much smaller) number of files than you would use otherwise
to store objects _and_ keeping them in use, so I suspect it
would not make much practical difference even if we try to
encourage the filesystem to allocate the disk blocks for new
pack near existing packs by creating the temporary file.
