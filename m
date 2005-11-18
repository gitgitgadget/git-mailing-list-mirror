From: Mitchell Blank Jr <mitch@sfgoth.com>
Subject: [ANNOUNCE] gitfs pre-release 0.03
Date: Fri, 18 Nov 2005 04:45:32 -0800
Message-ID: <20051118124532.GG87234@gaz.sfgoth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Nov 18 13:31:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ed5Ny-0001dX-ML
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 13:30:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161086AbVKRMaQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 07:30:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161084AbVKRMaQ
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 07:30:16 -0500
Received: from gaz.sfgoth.com ([69.36.241.230]:2271 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S1161082AbVKRMaM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Nov 2005 07:30:12 -0500
Received: from gaz.sfgoth.com (localhost.sfgoth.com [127.0.0.1])
	by gaz.sfgoth.com (8.12.10/8.12.10) with ESMTP id jAICjWi0036497
	for <git@vger.kernel.org>; Fri, 18 Nov 2005 04:45:32 -0800 (PST)
	(envelope-from mitch@gaz.sfgoth.com)
Received: (from mitch@localhost)
	by gaz.sfgoth.com (8.12.10/8.12.6/Submit) id jAICjWu9036496
	for git@vger.kernel.org; Fri, 18 Nov 2005 04:45:32 -0800 (PST)
	(envelope-from mitch)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.2 (gaz.sfgoth.com [127.0.0.1]); Fri, 18 Nov 2005 04:45:32 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12229>

I've released another pre-release of my gitfs tool tonight.  The isn't a ton
of new functionality, but there has been a lot of changes:

  % for dir in gitfs-0.0[123]; do echo `cat $dir/*.[ch] | wc -l` $dir; done
  2228 gitfs-0.01
  2334 gitfs-0.02
  8276 gitfs-0.03

This is mostly because I've been working on taking it from the "proof of
concept" phase to a real filesystem.  To that end:

  * gitfs now does all git operations in a separate thread so accessing a
    large file won't cause other filesystem operations to stall.  In order
    to allow multithreaded operations we no longer use the libfuse API -- we
    speak the kernel/fuse API directly.  This was a lot of work but it's
    actually a much better fit for gitfs since it allows me to map directly
    between inode #'s and the internal "gnode"'s, saving a lot of work.

    Because of this you no longer need libfuse installed to use gitfs --
    all you need to compile is point the Makefile at a <linux/fuse.h>
    header -- the one that comes with a >=2.6.14 kernel will work fine.
    However, to actually mount a fuse filesystem you'll need the "fusermount"
    helper binary from fuse somewhere in $PATH

  * We use the sha1_object_info() API in current versions of libgit to
    avoid uncompressing blob objects if they're only being stat()'ed.
    This is another big speed-up

  * gitfs mounts now also create a UNIX domain socket so external clients
    can make requests (for instance to optimize things like "diff")
    Currently only a few simple commands are implemented, as described in
    the README

  * Lots of other infrastructure and data-structure work.  I'm particularly
    proud of my rather scary red-black tree implementation :-)

As usual tarballs are available at:
	http://www.sfgoth.com/~mitch/linux/gitfs/

-Mitch
