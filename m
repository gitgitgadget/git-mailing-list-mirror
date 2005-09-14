From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-diff-tree rename detection bug
Date: Wed, 14 Sep 2005 11:09:32 -0700
Message-ID: <7vwtljjzc3.fsf@assigned-by-dhcp.cox.net>
References: <59a6e583050914094777c4fe96@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 14 20:11:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFbi3-0003wf-Cp
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 20:10:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932576AbVINSJf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 14:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932575AbVINSJe
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 14:09:34 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:8614 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932576AbVINSJd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2005 14:09:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050914180933.MTQL20473.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 14 Sep 2005 14:09:33 -0400
To: wsc9tt@gmail.com
In-Reply-To: <59a6e583050914094777c4fe96@mail.gmail.com> (Wayne Scott's
	message of "Wed, 14 Sep 2005 11:47:56 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8548>

Wayne Scott <wsc9tt@gmail.com> writes:

> Look at the diffs between ad6571a78ac74e9fa27e581834709067dba459af and
> it's parent with and without rename detection enabled.  (In linux-2.6
> git tree)

> Notice how the the fact that include/asm-ppc64/termios.h is
> deleted gets lost?  Looks broken to me.

I suspect that what is deleted is not asm-ppc64/termios.h but
asm-ppc/termios.h.  The below is an output without grep which
seems to confuse things.

$ git-diff-tree -r -M ad6571a78ac74e9fa27e581834709067dba459af |
  sed -ne 's/^.* \([AMCRDU]\)/\1/p'
R092    include/asm-ppc64/mman.h        include/asm-powerpc/mman.h
R097    include/asm-ppc64/termbits.h    include/asm-powerpc/termbits.h
R098    include/asm-ppc64/termios.h     include/asm-powerpc/termios.h
D       include/asm-ppc/mman.h
D       include/asm-ppc/termbits.h
D       include/asm-ppc/termios.h

$ git-diff-tree -r ad6571a78ac74e9fa27e581834709067dba459af |
  sed -ne 's/^.* \([AMCRDU]\)/\1/p'
A       include/asm-powerpc/mman.h
A       include/asm-powerpc/termbits.h
A       include/asm-powerpc/termios.h
D       include/asm-ppc/mman.h
D       include/asm-ppc/termbits.h
D       include/asm-ppc/termios.h
D       include/asm-ppc64/mman.h
D       include/asm-ppc64/termbits.h
D       include/asm-ppc64/termios.h

The first 3 A and last 3 D are accounted for in the -M output as
renames from asm-ppc64 to asm-powerpc.  Middle 3 D from asm-ppc
are shown in the -M output.  So I do not think we are losing
anything.  Am I missing something?
