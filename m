From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: A note on merging conflicts..
Date: Sat, 01 Jul 2006 21:29:33 +0200
Message-ID: <44A6CD1D.2000600@lsrfire.ath.cx>
References: <Pine.LNX.4.64.0606301927260.12404@g5.osdl.org>	<7vy7vedntn.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.64.0606302046230.12404@g5.osdl.org>	<20060701150926.GA25800@lsrfire.ath.cx> <7vfyhldvd2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sat Jul 01 21:29:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwlA3-0006eZ-Pq
	for gcvg-git@gmane.org; Sat, 01 Jul 2006 21:29:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751914AbWGAT3m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 1 Jul 2006 15:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751917AbWGAT3m
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Jul 2006 15:29:42 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:46030
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1751914AbWGAT3m (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jul 2006 15:29:42 -0400
Received: from [10.0.1.3] (p508E6911.dip.t-dialin.net [80.142.105.17])
	by neapel230.server4you.de (Postfix) with ESMTP id 01F3314014;
	Sat,  1 Jul 2006 21:29:35 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfyhldvd2.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23059>

Junio C Hamano schrieb:
> I suspect this has the same problem I pointed out to Kristian's=20
> attempt to make git-branch a built-in.
>=20
> Subject: Re: [PATCH] Implement git-branch and git-merge-base as
> built-ins. Date: Thu, 08 Jun 2006 11:53:48 -0700 Message-ID:
> <7vverbsclf.fsf@assigned-by-dhcp.cox.net>
>=20
> Namely, merge-base code is not set up to be called more than once
> without cleaning things up.

Eek!  This is not a nice interface.  Your example IDs from the your mai=
l
to Kristian:

   $ ./git-rev-list 89719209...262a6ef7 66ae0c77...ced9456a | wc
        75      75    3075
   $ git-rev-list 89719209 262a6ef7 \
     --not $(git-merge-base --all 89719209 262a6ef7) \
     --not 66ae0c77 ced9456a \
     --not $(git-merge-base --all 66ae0c77 ced9456a) | wc
        75      75    3075

   $ ./git-rev-list 66ae0c77...ced9456a 89719209...262a6ef7 | wc
        76      76    3116
   $ git-rev-list 66ae0c77 ced9456a \
     --not $(git-merge-base --all 66ae0c77 ced9456a) \
     --not 89719209 262a6ef7 \
     --not $(git-merge-base --all 89719209 262a6ef7) | wc
        75      75    3075

Yep, that doesn't seem right.  The additional line is 262a6ef (which is
the merge base for 66ae0c77 and ced9456a btw.).  The other 4x 75 lines
match.

I wonder why the two clear_commit_marks() calls at the end of
get_merge_bases() are not sufficient, though.

Ren=E9
