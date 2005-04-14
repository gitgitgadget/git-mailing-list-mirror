From: Junio C Hamano <junkio@cox.net>
Subject: Re: Merge with git-pasky II.
Date: Thu, 14 Apr 2005 01:39:36 -0700
Message-ID: <7v64ypsqev.fsf@assigned-by-dhcp.cox.net>
References: <20050414002902.GU25711@pasky.ji.cz>
	<20050413212546.GA17236@64m.dyndns.org>
	<20050414004504.GW25711@pasky.ji.cz>
	<Pine.LNX.4.58.0504132020550.7211@ppc970.osdl.org>
	<7vfyxtsurd.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504140051550.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, Christopher Li <git@chrisli.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 10:36:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DLzpr-0007ki-45
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 10:36:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbVDNIjq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 04:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbVDNIjq
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 04:39:46 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:55546 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261468AbVDNIji (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 04:39:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050414083936.YYP13819.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 14 Apr 2005 04:39:36 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504140051550.7211@ppc970.osdl.org> (Linus
 Torvalds's message of "Thu, 14 Apr 2005 01:06:56 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> But I'm really happy that you seem to have implemented my first 
LT> suggestion and I seem to have been wasting my time. 

Thanks for the kind words.

>> 5. for each path involved:
>> 
>> 5.0 if neither heads change it, leave it as is;
>> 5.1 if only one head changes a path and the other does not, just
>> get the changed version;
>> 5.2 if both heads change it, check all three out and run merge.

LT> You missed one case: 

LT>     5.0.1 if both heads change it to the same thing, take the new thing

LT> but maybe you counted that as 5.0 (it _should_ fall out automatically from
LT> the fact that "diff-tree" between the two destination trees shows no
LT> difference for such a file).

Actually I am not handling that.  It really is 5.1a---the exact
same code path as 5.1 can be used for this case, and as you
point out it is really a quite important optimization.

I have to handle the following cases.  I think I currently do
wrong things to them:

  5.1a both head modify to the same thing.
  5.1b one head removes, the other does not do anything.
  5.1c both head remove.
  5.3 one head removes, the other head modifies.

Handling of 5.1a, 5.1b and 5.1c are obvious.

  5.1a Update dircache to the same new thing.  Without -f or -o
       flag do not touch ,,merge-temp/. directory; with -f or
       -o, leave the new file in ,,merge-temp/.

  5.1b Remove the path from dircache and do not have the file in
       ,,merge-temp/. directory regardless of -f or -o flags.

  5.1c Same as 5.1b

I am not sure what to do with 5.3.  My knee-jerk reaction is to
leave the modified result in ,,merge-temp/$path~ without
touching dircache.  If the merger wants to pick it up, he can
rename $path~ to $path temporarily, run show-diff on it (I think
giving an option to show-diff to specify paths would be helpful
for this workflow), to decide if he wants to keep the file or
not.  Suggestions?

