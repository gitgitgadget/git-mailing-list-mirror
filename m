From: Junio C Hamano <junkio@cox.net>
Subject: Re: speeding up cg-log -u
Date: Sat, 14 May 2005 04:17:44 -0700
Message-ID: <7vk6m212g7.fsf@assigned-by-dhcp.cox.net>
References: <20050514061914.GB14353@tumblerings.org>
	<7vu0l62l27.fsf@assigned-by-dhcp.cox.net>
	<20050514061914.GB14353@tumblerings.org>
	<20050514103937.GA3905@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zack Brown <zbrown@tumblerings.org>, git@vger.kernel.org,
	torvalds@osdl.org
X-From: git-owner@vger.kernel.org Sat May 14 13:18:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWueS-0002CU-LG
	for gcvg-git@gmane.org; Sat, 14 May 2005 13:17:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262739AbVENLRs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 May 2005 07:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262740AbVENLRs
	(ORCPT <rfc822;git-outgoing>); Sat, 14 May 2005 07:17:48 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:16555 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S262739AbVENLRq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2005 07:17:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050514111745.QLLX16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 14 May 2005 07:17:45 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050514103937.GA3905@pasky.ji.cz> (Petr Baudis's message of
 "Sat, 14 May 2005 12:39:37 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:

PB> Dear diary, on Sat, May 14, 2005 at 11:50:24AM CEST, I got a letter
PB> where Junio C Hamano <junkio@cox.net> told me that...
>> +	buffer = read_sha1_file(item->object.sha1, type, &size);

PB> If it do that, I wonder how much speedup would be using this instead.
PB> But probably still significant one.

I would imagine so (only benchmark would tell), because you
would not spawn git-cat-file for each individual commit object.

Whenever I work with those "struct object" derivatives, I get
very frustrated by the fact that they are designed to cater only
to the need of very narrow immediate users.  The first round of
tree objects did not even have names for each entry because the
only thing it cared about was connectivity checking, and for
that purpose callers would not care about what each blob or
subtree was referred as.  Now when I want to use commit objects
I find that it only records the commit date (other than
connectivity information).  It really appears that connectivity
is the primary thing and everything else is bolted on top.

Not wanting to keep the whole object because of their size is
understandable since the users of "struct object" derivatives
rarely if ever seem to free them once they get hold of them.
And not wanting to think ahead about what is worth keeping (like
names for tree entries back then, or commit author names) is
also understandable, but it still is frustrating.  Not that I
would want to solve this myself ...

