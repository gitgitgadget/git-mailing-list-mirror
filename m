From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Possible strategy cleanup for git add/remove/diff etc.
Date: Tue, 19 Apr 2005 23:07:13 -0700
Message-ID: <7voecakmlq.fsf@assigned-by-dhcp.cox.net>
References: <20050419035107.GB5554@pasky.ji.cz>
	<7vacnumgot.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504191846290.6467@ppc970.osdl.org>
	<Pine.LNX.4.58.0504192102140.6467@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 08:03:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO8J7-0006BI-0k
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 08:03:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbVDTGHZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 02:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbVDTGHZ
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 02:07:25 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:28619 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261416AbVDTGHO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2005 02:07:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050420060713.YEFI7956.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 20 Apr 2005 02:07:13 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504192102140.6467@ppc970.osdl.org> (Linus
 Torvalds's message of "Tue, 19 Apr 2005 21:32:44 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

>> I'll immediately write a tool to diff the current working directory 
>> against a tree object, and hopefully that will just make pasky happy with 
>> this model too. 

The model you have always had is that there are three things the
user needs to be aware of:

 * files in working tree -- this is what you touch with your
   editor and feed compilers with.

 * files in dircache -- update-cache copies from working
   tree to here, checkout-cache copies from here to working
   tree.

 * committed tree state -- write-tree + commit-tree copies from
   dircache to this state, read-tree copies from here to
   dircache.

The original message I started this thread with suggested that I
wish if Cogito sugarcoating layer treated the dircache invisible
to the user by keeping it virtually and lazily in sync with the
working tree, as opposed to the way the current git-pasky does,
which is to keep it in sync with the committed state.

But after thinking about it more, I changed my mind.  With
something like diff-cache available to the user, making aware of
the three hierarchy to the user might be cleaner.  

The workflow becomes:
 
 * Initial read-tree + checkout-cache -f -a; makes the three in
   sync.

 * Hack away.  Makes the working tree drift from dircache.

 * show-diff to see what's changed since your last "checkpoint".
   update-cache when happy.  Working tree is in sync with
   dircache which is the "staging area" for my half-baked but
   still good stuff.  Makes the dircache different from the
   committed.

 * Hack away more.  show-diff does not show your earlier changes
   anymore.  This is sometimes inconvenient when you want to see
   what you earlier changed but not committed.  Here comes the
   new shiny diff-cache to rescue.

 * When satisfied with all the changes diff-cache --cached
   shows, finally, say write-tree + commit-tree.  This makes all
   three in sync again.

I vaguely recall having heard about some SCM that distinguishes
check-in and commit.  Maybe this two-staged update-cache and
write-tree + commit-tree workflow is similar to it?

