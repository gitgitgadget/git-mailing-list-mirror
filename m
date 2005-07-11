From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/6] git-gnu-progs-Makefile: git Makefile update
Date: Mon, 11 Jul 2005 14:59:58 -0700
Message-ID: <7vmzotovfl.fsf@assigned-by-dhcp.cox.net>
References: <20050711101417.10318.64006.sendpatchset@bryan-larsens-ibook-g4.local>
	<20050711101454.10318.70399.sendpatchset@bryan-larsens-ibook-g4.local>
	<7vk6jxupxs.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507111206240.17536@g5.osdl.org>
	<42D2CBA2.8060705@yahoo.com> <7virzhrtfy.fsf@assigned-by-dhcp.cox.net>
	<7vy88dqe4h.fsf@assigned-by-dhcp.cox.net> <42D2E47E.8060602@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, bryan.larsen@gmail.com,
	pasky@suse.cz, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 12 00:01:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ds6L4-00037B-Px
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 00:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262664AbVGKWAr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 18:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262734AbVGKWAc
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 18:00:32 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:8928 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S262664AbVGKWAB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2005 18:00:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050711215957.MFSZ12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 11 Jul 2005 17:59:57 -0400
To: Bryan Larsen <bryanlarsen@yahoo.com>
In-Reply-To: <42D2E47E.8060602@yahoo.com> (Bryan Larsen's message of "Mon, 11 Jul 2005 17:28:30 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Bryan Larsen <bryanlarsen@yahoo.com> writes:

> For the record, "${XARGS} -0r" may be uglier than "xargs -0r", but
> replacing it with several lines of shell magic is a loss.

OK, OK, the one I suggested for xargs was _U_G_L_Y_.

The one Linus suggested looks to me the cleanest.  That is, to
give an extra parameter upfront to the command run by xargs.  My
favorite trick is like this:

  git-fsck-cache --cache --unreachable "$@" |
  sed -ne '/unreachable /{
      s/unreachable [^ ][^ ]* //
      s|\(..\)|\1/|p
  }' | {
          cd "$GIT_OBJECT_DIRECTORY" || exit
-         xargs -r $dryrun rm -f
+         xargs $dryrun rm -f ""
  }

Dry-run would say: 

    rm -f  00/012345...
    rm -f  01/234567...

without visual distraction of having printable phoney names, or
just (with an invisible trailing space):

    rm -f  

During a real run, "rm -f" would not complain "cannot remove `':
Is a directory", either.
