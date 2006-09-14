From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Use File::Find::find in git_get_projects_list
Date: Thu, 14 Sep 2006 02:40:54 -0700
Message-ID: <7vvenq4wgp.fsf@assigned-by-dhcp.cox.net>
References: <200609140839.56181.jnareb@gmail.com>
	<7v8xkm6gr6.fsf@assigned-by-dhcp.cox.net>
	<200609140959.04061.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 14 11:41:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNniW-0004tt-D0
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 11:41:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507AbWINJk4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Sep 2006 05:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbWINJk4
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 05:40:56 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:911 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751507AbWINJkz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Sep 2006 05:40:55 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060914094055.NVDX6235.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Thu, 14 Sep 2006 05:40:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id N9gk1V0011kojtg0000000
	Thu, 14 Sep 2006 05:40:44 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200609140959.04061.jnareb@gmail.com> (Jakub Narebski's message
	of "Thu, 14 Sep 2006 09:59:03 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26995>

Jakub Narebski <jnareb@gmail.com> writes:

> ... But I have realized that for gitweb
> for only one project one could have ".git" as a project name,
> e.g. by putting $projectroot to be live git repository (working
> directory of git repository).

I do not understand this comment.  I have /git/{git,linux-2.6}
and run test gitweb with projectroot set to /git to see it can
display them both.  Both are with working tree, so there are
/git/git/.git and /git/linux-2.6/.git directories.

Do you mean to say "project name" is always taken from the last
component of the directory name and the above setup would result
in ambiguity?  If that is the case that sounds awful, but I
haven't noticed it.

> It was intended I think to avoid adding '.' and '..' as git 
> repositories, not stray directories. Well, perhaps index file
> if it was used.

Having and not having index are both valid, so there is no value
in checking the index, even if we wanted to be more paranoid.
Existence of HEAD, refs/heads, and/or objects/ would be a more
meaningful alternative, but again only if we wanted to be more
paranoid.

>> > +		File::Find::find({
>> > +			no_chdir => 1, # do not change directory
>> > +			follow_fast => 1, # follow symbolic links
>> 
>> What is the reason behind choosing follow_fast?  By saying
>> follow_anything, you choose to care about cases where there are
>> symlinks under projectroot to point at various projects.  If
>> that is the case, don't you want to make sure you include the
>> same project only once?
>
> First, it is faster. Second, for testing if it works I used copy
> of a one "live" git repository I have (git.git repository), by making
> second symlink to it.

That was not what I wanted to ask; slower and correct is always
preferred over fast and incorrect.  I did not see anything that
compensates the duplicates follow_fast might give you in the
code, so I wondered there were some other trick you used to avoid
it.

In other words, "because I have such and such check to avoid
duplicates, so I can safely use 'follow_fast', without using
slower 'follow'" was the answer I was after.
