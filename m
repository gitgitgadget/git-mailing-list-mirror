From: Junio C Hamano <junkio@cox.net>
Subject: Re: PATCH: New diff-delta.c implementation (updated)
Date: Thu, 27 Apr 2006 20:16:05 -0700
Message-ID: <7v1wvigzka.fsf@assigned-by-dhcp.cox.net>
References: <Pine.GSO.4.60.0604272132170.9650@nile.gnat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 28 05:16:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZJSs-0003zG-FF
	for gcvg-git@gmane.org; Fri, 28 Apr 2006 05:16:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723AbWD1DQM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Apr 2006 23:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751733AbWD1DQM
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Apr 2006 23:16:12 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:39876 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751723AbWD1DQL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Apr 2006 23:16:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060428031610.CYTV24290.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 27 Apr 2006 23:16:10 -0400
To: Geert Bosch <bosch@gnat.com>
In-Reply-To: <Pine.GSO.4.60.0604272132170.9650@nile.gnat.com> (Geert Bosch's
	message of "Thu, 27 Apr 2006 21:59:53 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19264>

Geert Bosch <bosch@gnat.com> writes:

> Even though the previous version did really well on large files
> with many changes, performance was lacking for the many small
> files with very few changes that are so common for a VCS.
>...
> The result has been only a slight increase in delta size for
> very large test cases (but with better performance), and
> both smaller deltas and faster execution speed for repacking
> git.git. I had trouble cloning the Linux kernel repository,
> but am now reasonably confident this will outperform the
> existing algorithm pretty consistently.

Interesting.

Initial impression, the same test as before (a full packing of
the git.git repository that does not have _any_ pack -- all 18k
objects are loose).

First, the incumbent, with the "reusing delta-index" patch applied.

Total 17724, written 17724 (delta 12002), reused 0 (delta 0)
34.02user 6.48system 0:42.87elapsed 94%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+434478minor)pagefaults 0swaps

 6188418 pack-nico-f1fac077a093ffdaf094aab2b7f11859ec0c18f1.pack

Then diff-delta.c replaced with your version.

Total 17724, written 17724 (delta 12012), reused 0 (delta 0)
44.87user 6.54system 0:54.01elapsed 95%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+441124minor)pagefaults 0swaps

 6099183 pack-geert-f1fac077a093ffdaf094aab2b7f11859ec0c18f1.pack

Second impression, in a recent kernel tree which is mostly
packed.  Packing 41k objects (v2.6.16..v2.6.17-rc3), with
"git-pack-objects --no-reuse-delta".

(Nico)
Total 41591, written 41591 (delta 29285), reused 8563 (delta 0)
169.08user 12.60system 3:27.68elapsed 87%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (2major+1099928minor)pagefaults 0swaps

37363966 pack-nico-b9e4339c482cb7d787a2117e6da6eb2114053abc.pack

(Geert)
Total 41591, written 41591 (delta 29347), reused 8427 (delta 0)
243.71user 12.32system 4:28.11elapsed 95%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+1077843minor)pagefaults 0swaps

37165890 pack-geert-b9e4339c482cb7d787a2117e6da6eb2114053abc.pack


Of course, the absolute numbers do not matter, but for the
record these are on my Duron 750, 760MB or so RAM and with
relatively slow disks.

In the kernel repository (checked out is near the tip of the
source tree), the largest files are fs/nls/nls_cp949.c (900kB
korean character encoding), drivers/usb/misc/emi62_fw_s.h
(800kB, Emagic firmware blob), arch/m68k/ifpsp060/src/fpsp.S
(750kB, floating point emulation?), and nowhere near your
algorithm really should shine.

We would probably want some internal logic that says "if we see
that blobs larger than X MB is involved in the packing, we
should use this version of diff-delta, otherwise the other one."
