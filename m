From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-bisect problem
Date: Mon, 13 Feb 2006 16:33:05 -0800
Message-ID: <7v3bimzsn2.fsf@assigned-by-dhcp.cox.net>
References: <20060213002502.5c23122c.akpm@osdl.org>
	<7virrj1v44.fsf@assigned-by-dhcp.cox.net>
	<20060213013205.4ba47836.akpm@osdl.org>
	<20060213093938.GC11053@mythryan2.michonline.com>
	<20060213015146.26e6c09d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Morton <akpm@osdl.org>
X-From: git-owner@vger.kernel.org Tue Feb 14 01:33:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8o81-0008Fp-EU
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 01:33:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030304AbWBNAdI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 19:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030305AbWBNAdI
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 19:33:08 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:61893 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1030304AbWBNAdH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2006 19:33:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060214002943.BXAI20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 13 Feb 2006 19:29:43 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16091>

Andrew Morton <akpm@osdl.org> writes:

> git-format-patch -o ~/a 386093ef9a6c88576d8b418bf1c8616d5e410a20 git-netdev-all
>
> and that chewed 10 minutes CPU time and produced no output, so I killed it.

A single commit is either:

	git format-patch -o ~/a 386093^ 386093
	git show 386093

But if you _did_ want to get everything that builds on top of
386093 (and Linus counted 1000+ commits if I recall),
format-patch could be optimized.  It currently does a lot more
than just format 1000+ commits, to handle case where "his" and
"mine" are not linear history and may have the same change
acquired by applying the same patch:

          1---2---3 mine
         /
     ---4---5---6 his

In this picture, it does not just format 1 2 3.  It first checks
1 2 3 5 6, and if each of 1 2 3 introduces the same change as
either 5 or 6 introduces to omit it from the output.  If 2 and 5
are the same change from 1 and 4 respectively, the final result
has 1 and 3.  This is OK and useful for smaller branch, but
clearly expensive for long branches.

This is omitted when the ancestry graph would look like this:
	
          1---2---3 mine
         /
     ---4 his

but that would not have helped in this case anyway.

Maybe we could have --no-omit-common flag or something to
disable this check.
