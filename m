From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] "checkout-cache -m" writes unmerged contents for each
 stage.
Date: Sun, 17 Apr 2005 19:44:04 -0700
Message-ID: <7vfyxovm6j.fsf@assigned-by-dhcp.cox.net>
References: <7v1x99vwdg.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504171833450.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 04:40:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNMBU-0002FA-CG
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 04:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbVDRCoP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 22:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbVDRCoP
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 22:44:15 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:39390 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261615AbVDRCoL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 22:44:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050418024403.UMAD9923.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 17 Apr 2005 22:44:03 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504171833450.7211@ppc970.osdl.org> (Linus
 Torvalds's message of "Sun, 17 Apr 2005 19:05:53 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> I'm actually thinking that maybe the _right_ interface is to do something 
LT> like this:

LT> 	merge-cache <program> <filename>

LT> and what that does is to look up the <filename> in the cache, and if it 
LT> has any merge entries, unpack all of them (which may be just one file, of 
LT> course) into up to three separate files (mkstemp()), and then execve the 
LT> supplied program name with those three files as arguments 1,2,3 (empty 
LT> argument if no file), and "filename" as argument 4.

LT> What do you think? I can whip up a "merge-cache" program like that in five 
LT> minutes, and it _seems_ like the right interface..

One small detail.  What about the "-x" bit?

In case 2 and 3 in your sample merge script, the "merge script"
needs to know what the preferred mode bits are before running
"update-cache --add".

Yes, it can figure that out by running "show-files --unmerged"
and grepping for "$4" by itself, but then it can figure out the
information in "$1" through "$3" by itself as well, so that
makes having merge-cache wrapper less useful to begin with.

I do not think it is realistic for these three related trees to
have files that differ in -x bit, so it would not be that useful
to give the "merge script" the flexibility to pick -x bit value
among three parents --- it would be fine for the merge-cache
wrapper to dictate the value of the -x bit for the resulting
file.  So I'd suggest to add an extra parameter to the "merge
script" when merge-cache wrapper calls it.

