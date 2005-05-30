From: Junio C Hamano <junkio@cox.net>
Subject: Re: Problem with cg-diff <file>
Date: Sun, 29 May 2005 17:19:09 -0700
Message-ID: <7vis11ftvm.fsf@assigned-by-dhcp.cox.net>
References: <1117408555.7072.109.camel@pegasus>
	<20050529233840.GY1036@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marcel Holtmann <marcel@holtmann.org>,
	GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 30 02:17:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcXxh-0005Xk-2I
	for gcvg-git@gmane.org; Mon, 30 May 2005 02:16:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261477AbVE3ATT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 20:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261478AbVE3ATT
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 20:19:19 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:37804 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261477AbVE3ATL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2005 20:19:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050530001909.RZTY550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 29 May 2005 20:19:09 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050529233840.GY1036@pasky.ji.cz> (Petr Baudis's message of
 "Mon, 30 May 2005 01:38:40 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:

PB> ... git-diff-tree (in contrast to
PB> git-diff-cache) won't take the pathspec as its trailing arguments,

PB> Junio, is there any specific reason for that, or is the end of
PB> git-diff-tree argument list the right spot for the pathspec stuff?

Baffled.  Are you at Linus tip?

Linus correctly decided that diff-tree does not have to call
diffcore_pathspec(), which may be what confused you to make the
comment "... in contrast to git-diff-cache) won't take ...".
But it does not call it only because it does not need to.  It
filters the filepairs itself on the input side using the
trailing arguments; since diffcore_pathspec filters as the first
one in the chain as the input filter, calling it from diff-tree
would not cull anything further.

Here is what I am getting from the Linus tip binary, between my
HEAD and Linus tip:

$ git-diff-tree -r linus HEAD   >.all    ;# everything
$ git-diff-tree -r linus HEAD t >.t-only ;# limiting to the test suite
$ wc -l .all .t-only                     ;# count results
  12 .all
   3 .t-only
  15 total
$ cat .t-only				 ;# show what's in "t" output
:100644 100644 a51985518251f6c3f677438c3cb51b9716c20296 5ac29d1f98438d3530bbc8b0bdaced58200aca37 M	t/t4005-diff-rename-2.sh
:100644 100644 518892b90c7cbb3fb193d6bfb622046aff0f4431 76ae7201f0d19b7933ca44958b7c468193ec9778 M	t/t4007-rename-3.sh
:000000 100755 0000000000000000000000000000000000000000 01d276692669f2241471b8ad611b17d51e2a98ab N	t/t4009-diff-rename-4.sh
$ head -n 1 .all                         ;# prove that "t" filtered. 
:100644 100644 f85a605f0a336f506cf5cf46476a43e4c56b3e66 1d92a01a02543e55d0feb3541ee594fbc638136c M	Documentation/diff-format.txt

