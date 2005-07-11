From: Junio C Hamano <junkio@cox.net>
Subject: Re: Bootstrapping into git, commit gripes at me
Date: Mon, 11 Jul 2005 16:03:45 -0700
Message-ID: <7vll4dndwu.fsf@assigned-by-dhcp.cox.net>
References: <20050708230750.GA23847@buici.com>
	<Pine.LNX.4.58.0507081842550.17536@g5.osdl.org>
	<20050711222046.GA21376@buici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marc Singer <elf@buici.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 12 01:06:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ds7Lk-0002ny-FW
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 01:06:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262285AbVGKXFh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 19:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbVGKXFg
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 19:05:36 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:35788 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S262207AbVGKXEO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2005 19:04:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050711230344.HVNX22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 11 Jul 2005 19:03:44 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20050711222046.GA21376@buici.com> (Marc Singer's message of "Mon, 11 Jul 2005 15:20:46 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Marc Singer <elf@buici.com> writes:

> I picked 2.6.12
>
>   # git checkout -f v2.6.12
>
> applied the patch and was greeted with an error about being unable to
> commit telling me that I LONG_HEX_NUMBER is not a valid commit object.
> Isn't 2.6.12 later than 2.6.12-rcX?

Aha.  Marc is not doing anything wrong --- he is doing as he is
told.

Linus, there is a bad interaction between tag objects and
commits right now.  For example:

 - we allow git-checkout-script with a tag; I think we store the tag
   object without dereferencing in .git/HEAD;

 - git-commit-tree says check_valid("commit") and barfs.

I think other things are covered already and the above two are
the only remaining major ones.  The merge-base command dereferences tags
and produces a commit as its result.  The rev-list command also
derefs tags, so log and whatchanged would work sensibly.

My current preference is to keep .git/refs/heads tag free.  At
least, I do not think we should ever write non commits to
.git/*_HEAD.

What do you think?  An alternative would be to allow tags
(recursively) pointing at a commit as a commit parent, but I do
not think we would want to go that route.
