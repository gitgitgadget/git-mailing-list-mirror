From: Junio C Hamano <junkio@cox.net>
Subject: Re: PATCH: New diff-delta.c implementation (updated)
Date: Thu, 27 Apr 2006 21:28:30 -0700
Message-ID: <7vfyjyfhn5.fsf@assigned-by-dhcp.cox.net>
References: <Pine.GSO.4.60.0604272132170.9650@nile.gnat.com>
	<7v1wvigzka.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 28 06:28:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZKay-0006qt-LZ
	for gcvg-git@gmane.org; Fri, 28 Apr 2006 06:28:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbWD1E2f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Apr 2006 00:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751840AbWD1E2f
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Apr 2006 00:28:35 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:63361 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751056AbWD1E2e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Apr 2006 00:28:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060428042833.IFHH24290.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 28 Apr 2006 00:28:33 -0400
To: Geert Bosch <bosch@gnat.com>
In-Reply-To: <7v1wvigzka.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 27 Apr 2006 20:16:05 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19265>

Junio C Hamano <junkio@cox.net> writes:

> In the kernel repository (checked out is near the tip of the
> source tree), the largest files are fs/nls/nls_cp949.c (900kB
> korean character encoding), drivers/usb/misc/emi62_fw_s.h
> (800kB, Emagic firmware blob), arch/m68k/ifpsp060/src/fpsp.S
> (750kB, floating point emulation?), and nowhere near your
> algorithm really should shine.
>
> We would probably want some internal logic that says "if we see
> that blobs larger than X MB is involved in the packing, we
> should use this version of diff-delta, otherwise the other one."

Third impression, synthetic workload.  A sequence of single file
project, the file is tarball of git.git tree (that is,
"git-tar-tree vX.Y.Z >tarball"), 120 objects or so (1 commit per
rev, 1 tree to hold 1 blob).  The (uncompressed) size of the 40
blobs in the pack are between 2.06MB - 2.86MB (average 2.30MB).

(Nico)
Total 123, written 123 (delta 38), reused 0 (delta 0)
67.26user 1.03system 1:08.76elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+136066minor)pagefaults 0swaps

1822079 pack-nico-26989d516c62197592d0d52db24dfc6a58b633eb.pack


(Geert)
Total 123, written 123 (delta 38), reused 0 (delta 0)
67.23user 1.35system 1:09.25elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+164124minor)pagefaults 0swaps

1683139 pack-geert-26989d516c62197592d0d52db24dfc6a58b633eb.pack

That's an 8% improvement in the same time, which is quite
impressive.  But I am _very_ unhappy about this particular
synthetic workload.  I wonder if there are projects with many
large blobs that is updated often, so that we can use it as a
yardstick.  Maybe Wine people have icons, background images and
sounds perhaps?  But I suspect you would not update them that
often.

Thinking about it, it does not make much sense, at least to me,
to store large tarballs or binary blobs or whatnot in a SCM (we
are _not_ in the archival business) and keeping track of their
changes.  The tarball is out of question -- it is not a source
(in GPL sense of the word -- it is not a preferred way to make
modification; you modify constituent files and bundle up the
result as a new tarball).  Graphics images, perhaps.
