From: Matt Porter <mporter@kernel.crashing.org>
Subject: cogito: linux-2.6 merge fails due to cg-rm
Date: Mon, 2 May 2005 10:12:50 -0700
Message-ID: <20050502101250.A21716@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon May 02 19:11:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSeR2-000166-1Q
	for gcvg-git@gmane.org; Mon, 02 May 2005 19:10:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbVEBRP7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 13:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbVEBRPc
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 13:15:32 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:17114 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261218AbVEBROs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2005 13:14:48 -0400
Received: from liberty.homelinux.org ([68.2.41.86]) by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050502171440.XCBI23392.fed1rmmtao04.cox.net@liberty.homelinux.org>
          for <git@vger.kernel.org>; Mon, 2 May 2005 13:14:40 -0400
Received: (from mmporter@localhost)
	by liberty.homelinux.org (8.9.3/8.9.3/Debian 8.9.3-21) id KAA21996
	for git@vger.kernel.org; Mon, 2 May 2005 10:12:50 -0700
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I guess it was bound to happen after reading rmk's issues. I finally
had a working tree of mine fail to merge from linus' tree while doing
a cg-update. I'm using cogito 0.8.  I had to hand merge something
due to DocBook Makefile changes but the real problem was in the
set of files that were removed:

Documentation/DocBook/tulip-user.tmpl
Documentation/DocBook/via-audio.tmpl
arch/um/kernel/sys_call_table.c
drivers/video/intelfb/intelfbdrv.h
scripts/makeman
scripts/split-man

These kept showing up as "needs merged" even though I explicitly
tried to cg-rm them or "update-cache --remove" them. It turns out
that cg-rm is 'rm -f'ing the files before calling update-cache.
By touching each file, and then modifying cg-rm as follows, I
was able to complete the merge. I'm not sure yet if this is the
proper fix to the cogito script. It at least made update-cache
happy for this remove case.

-Matt

--- c3aa1e6b53cc59d5fbe261f3f859584904ae3a63/cg-rm  (mode:100755 sha1:029a03128eb7a8dd807335fea2ff52cb2bcda4fa)
+++ uncommitted/cg-rm  (mode:100755)
@@ -10,5 +10,5 @@

 [ "$1" ] || die "usage: cg-rm FILE..."

-rm -f "$@"
 update-cache --remove -- "$@"
+rm -f "$@"

