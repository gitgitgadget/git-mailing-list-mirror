From: Junio C Hamano <junkio@cox.net>
Subject: Re: keeping remote repo checked out?
Date: Mon, 28 Nov 2005 11:35:23 -0800
Message-ID: <7vsltgtvk4.fsf@assigned-by-dhcp.cox.net>
References: <m3k6et9rdw.fsf@lugabout.cloos.reno.nv.us>
	<7vbr051ad1.fsf@assigned-by-dhcp.cox.net>
	<20051128105736.GO22159@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Nov 28 20:35:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Egome-0006Dr-QP
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 20:35:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbVK1TfZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 14:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbVK1TfZ
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 14:35:25 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:31203 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932199AbVK1TfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2005 14:35:25 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051128193443.FLKL6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 28 Nov 2005 14:34:43 -0500
To: git@vger.kernel.org
In-Reply-To: <20051128105736.GO22159@pasky.or.cz> (Petr Baudis's message of
	"Mon, 28 Nov 2005 11:57:36 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12900>

Petr Baudis <pasky@suse.cz> writes:

> Dear diary, on Mon, Nov 28, 2005 at 08:48:26AM CET, I got a letter
> where Junio C Hamano <junkio@cox.net> said that...
>> James Cloos <cloos@jhcloos.com> writes:
>> 
>> > Is it possible to arrange that a push does a checkout on the remote
>> > the same way a pull does on the local?
>> 
>> Creative use of hooks/post-update would solve that.
>> 
>> However, you should be very careful if you sometimes edit on
>> server and sometimes push from other machine to the server on
>> the same branch on the server.
>
> Why? At worst you will get files with conflict markers on the server,
> which isn't that huge problem and just what you have to expect when you
> do this kind of thing.

Both of us are right and talking about the same thing.  You are
right that as long as hooks/post-update is done correctly the
one who works on the server should not have to worry.  I am
right that the hooks/post-update for that setup needs to be done
very carefully ;-).

Here are the things whoever is doing the hooks/post-update for
this particular setup needs to think about.

 - is it safe to assume that the guy working on the server
   working tree never switch branches?  otherwise, what to do if
   the working tree has different branch checked out when push
   called post-update?

 - should it allow forced-push that sets HEAD to non descendant
   of the current HEAD?  In a shared repository setup,
   disallowing forced-push is a good discipline.  OTOH, if this
   is primarily used as an installation mechanism to a remote
   hosting site, allowing forced-push may be ok.

 - should it do 'git-checkout', 'git-reset --hard HEAD', or
   'git-pull . branch_to_push_into'?  The former two pretty much
   assumes no development happens on the server repository and
   git push is used primarily as an installation mechanism.  The
   latter is to keep a branch, other than "master" that is
   always checked out on the server machine, and have people
   push into a different branch and merge with it automatically
   when a push happens.  what would you do when a merge conflict
   happens?

On a tangent, the last point brings up an interesting
shared-repo usage pattern.  When you have a shared central
repository like CVS, you could arrange things this way:

 * On the shared repository, prepare one branch per developer
   who is pushing into it, plus "master".

 * The developer pull from "master" and work in her private
   repository.  The changes are pushed into her own branch on
   the shared repository machine.

 * The the shared repository machine tries to merge "master"
   into developer branches when the developer branch head is
   updated.  If it does not trivially resolve, the developer
   branch head is left as the last push by the developer
   (i.e. not recording the merge).  If it does resolve, it is
   checked out into playpen area, built and testsuite run, and
   if all look well, "master" is updated with the result of the
   merge.  A notification is sent to the developer to tell which
   of the above actions happened.

   This does not have to happen in the update hook and you
   probably would not want to because it would be a lenthy
   operation.  The update hook can be used to maintain recent
   push log for a cron job that runs the "merge-test-integrate"
   procedure to decide which branch is interesting.

I am not sure if people would find this useful, though.
