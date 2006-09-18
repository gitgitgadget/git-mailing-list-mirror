From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] git-pack-refs --prune
Date: Mon, 18 Sep 2006 11:44:05 -0700
Message-ID: <7vhcz5ow0a.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0609111158390.3960@g5.osdl.org>
	<Pine.LNX.4.64.0609111632050.27779@g5.osdl.org>
	<7vy7shr5zw.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0609180934360.4388@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 18 20:44:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPO6F-0005po-Mq
	for gcvg-git@gmane.org; Mon, 18 Sep 2006 20:44:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612AbWIRSoI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Sep 2006 14:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbWIRSoI
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Sep 2006 14:44:08 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:26067 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751138AbWIRSoG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Sep 2006 14:44:06 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060918184406.HHDK18985.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>;
          Mon, 18 Sep 2006 14:44:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Pujt1V0021kojtg0000000
	Mon, 18 Sep 2006 14:43:53 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27259>

Linus Torvalds <torvalds@osdl.org> writes:

> The way to fix both these problems at once would be to add a flag to the 
> "for_each_ref()", which says whether it followed a link, or whether it was 
> already packed, so that we wouldn't pack symlinks at all, and we wouldn't 
> add already-packed refs to the "keeprefs" list.
>
> But that requires a sligh semantic extension to "do_for_each_ref()" (and 
> "struct ref_list" needs a flag to say whether it was looked up through a 
> symlink).
>
> I was thinking that the easy way to solve it is to just _pack_ everything 
> (the way we do now - incorrectly for symrefs), but never prune a symref.

I see.  Thanks for pointing out the issue with symrefs.  I think
clone with --use-separate-remote creates remote/$that_repo/HEAD
that points at the branch the remote side's HEAD points at (to
be precise, the one it guessed the remote side's HEAD points
at), so this is a real issue already.

I wanted to update for_each_ref() anyway for other reasons (it
really should take callback data -- the way the current users
use global variables to work this around is eyesore), so
hopefully I'll find time to take a look at it.

Rough outline:

 - for_each_ref() and friends become:

   typedef int each_ref_fn(const char *refname,
			   const unsigned char *sha1,
   #define REF_IS_SYMREF 01
   #define REF_IS_PACKED 02
                           int flags, /* above bits or'ed */ 
                           void *cb_data);
   int for_each_ref(each_ref_fn fn, void *cb_data);

 - handle_one_ref notices a symref and ignores it; it remembers
   refs that are not symref and are still loose for later
   pruning under --prune.

We might want to update the initial handshake of upload-pack
protocol so that peek-remote and fetch-pack can tell which one
is a symref pointing at what.  Do the usual server_capabilities
discovery in connect.c::get_remote_heads(), and if an extension
"symref" is supported than ask for symref information (typically
we would only get "HEAD points at refs/heads/foo" and nothing
else).  Then git-clone.sh does not have to make a guess.  But
that is a separate topic.



 
