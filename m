From: Junio C Hamano <junkio@cox.net>
Subject: Re: git and time
Date: Sat, 30 Sep 2006 16:04:00 -0700
Message-ID: <7vd59d7y8v.fsf@assigned-by-dhcp.cox.net>
References: <20060928022917.29678.qmail@web51011.mail.yahoo.com>
	<Pine.LNX.4.64.0609272232040.9349@xanadu.home>
	<7vfyec63jx.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0609281029300.9349@xanadu.home>
	<7vd59ejokp.fsf@assigned-by-dhcp.cox.net>
	<20060930045037.GB18479@spearce.org>
	<7v4pupizix.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0609301033460.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 01 01:04:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTnsV-0000xv-BG
	for gcvg-git@gmane.org; Sun, 01 Oct 2006 01:04:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670AbWI3XEM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Sep 2006 19:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751677AbWI3XEM
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Sep 2006 19:04:12 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:13249 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751544AbWI3XEK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Sep 2006 19:04:10 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060930230410.GFWR21457.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>;
          Sat, 30 Sep 2006 19:04:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Un481V0121kojtg0000000
	Sat, 30 Sep 2006 19:04:12 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28163>

Linus Torvalds <torvalds@osdl.org> writes:

> On Sat, 30 Sep 2006, Junio C Hamano wrote:
>
>> Shawn Pearce <spearce@spearce.org> writes:
>> 
>> > Agreed.  I've been missing such a command and have wanted to add
>> > one but it wasn't important enough to me to actually code it.  :)
>> 
>> Everything you said in your message sounds sane and makes sense
>> to me.  Now we have to find a sucker^Wvolunteer to implement it
>> ;-).
>
> Ehh. As far as I can see it's 
>  - a damn hard thing to do efficiently
>  - essentially exactly the same problem you already solved with "git 
>    describe"
>
> In other words, I think you could make git describe do it, by simply 
> making it parse not just all tags, but also walking the branch log.

As a user interface, I think it makes a lot of sense to have
"git describe" do it without introducing a new command.

However, I think the traditional "find the closest ancestor"
behaviour and ref-log behaviour are mutually incompatible, while
they both return information to help address similar issues to
the end user when viewed at a very high level.

Especially, "find the closest ancestor" behaviour means when you
get "tag-gXXXX" as an answer, the tag proper does _not_ contain
the given commit (e.g. commit v1.4.2-g4839bd8 is not part of
v1.4.2).  To answer "when did the fix deadbeef go into master
branch", reporting "master@{yesterday}-gdeadbeef" with the same
logic and format is misleading; "master@{yesterday}" may be the
closest ancestor of commit deadbeef, but that means it does
_not_ contain the fix.  When walking ref-log, we want it the
other way around: "find the earliest descendant among the
entries in ref-log for a particular branch".

The internal logic for doing that may be somewhat different and
I suspect you may not be able to share much code with the
existing logic..
