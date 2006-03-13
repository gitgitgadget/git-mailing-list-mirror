From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git
Date: Sun, 12 Mar 2006 21:01:06 -0800
Message-ID: <7vlkvfszu5.fsf@assigned-by-dhcp.cox.net>
References: <7v1wxg82r3.fsf@assigned-by-dhcp.cox.net>
	<46a038f90603060105m29595745ke64d4a623506c0b0@mail.gmail.com>
	<20060310104443.GA4491@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 13 06:01:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIfBC-00067p-30
	for gcvg-git@gmane.org; Mon, 13 Mar 2006 06:01:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbWCMFBK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Mar 2006 00:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWCMFBK
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Mar 2006 00:01:10 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:44210 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932316AbWCMFBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Mar 2006 00:01:09 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060313045944.ECGQ15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 12 Mar 2006 23:59:44 -0500
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20060310104443.GA4491@c165.ib.student.liu.se> (Fredrik
	Kuivinen's message of "Fri, 10 Mar 2006 11:44:43 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17547>

Fredrik Kuivinen <freku045@student.liu.se> writes:

> On Mon, Mar 06, 2006 at 10:05:41PM +1300, Martin Langhoff wrote:
>> 
>> Add fuel to the fire  ;-) Can git-blame take cached git-rev-list
>> output like annotate does with -S?
>
> Currently it cannot do that. How is that option used? If you want to
> make annotate/blame faster for certain files you might as well cache
> the output of annotate/blame instead of the git-rev-list output, no?

There are two reasons Martin's git-cvsserver uses -S to feed you
the revision list.  One is that he already has that ancestry
chain information, and there is no point for him to have the
git-annotate command to recompute it.

But there is another, more important reason.  He is giving his
clients a modified world view where the branch he is exposing to
have _no_ merges -- just a single strand of pearls.  So what is
fed to git-annotate using -S from git-cvsserver has either one
object name (single root commit) or two (the commit and its sole
parent).  IOW, he does not want you to look at other parents
when dealing with a merge commit.

What this means is that in cases where your algorithm looked at
second and subsequent parents to pass remaining blame on after
looking at the first parent for a merge, the algorithm now needs
to assign the blame to the merge commit itself.  Your
process_commit() currently reads the commit object and loops
over its true parents, but the -S flag wants to supply its own
notion of who are the parents of whom (and in the case of
git-cvsserver, it always supplies at most one parent) so you
would need to honor that instead of looking at the real
ancestry.
