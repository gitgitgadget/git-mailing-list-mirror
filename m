From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH v3] Support ent:relative_path
Date: Sun, 06 May 2007 17:18:06 -0700
Message-ID: <7v6475bi69.fsf@assigned-by-dhcp.cox.net>
References: <463BD40C.6080909@gmail.com>
	<Pine.LNX.4.64.0705050324580.4015@racer.site>
	<7vwszolz26.fsf@assigned-by-dhcp.cox.net>
	<56b7f5510705042346s759a2ef9tfa3a223fe7af7c16@mail.gmail.com>
	<Pine.LNX.4.64.0705051637450.4015@racer.site>
	<7vwszmfod8.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0705061653100.4015@racer.site>
	<7v1whtdfd2.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0705070110040.4167@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dana How <danahow@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 07 02:18:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hkqvh-0000dZ-LS
	for gcvg-git@gmane.org; Mon, 07 May 2007 02:18:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbXEGASK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 20:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752449AbXEGASJ
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 20:18:09 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:54053 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060AbXEGASI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 20:18:08 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070507001808.JXZD1318.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Sun, 6 May 2007 20:18:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id w0J71W00R1kojtg0000000; Sun, 06 May 2007 20:18:08 -0400
In-Reply-To: <Pine.LNX.4.64.0705070110040.4167@racer.site> (Johannes
	Schindelin's message of "Mon, 7 May 2007 01:12:23 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46400>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sun, 6 May 2007, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> > On Sat, 5 May 2007, Junio C Hamano wrote:
>> >
>> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> >> 
>> >> >> (a) In a bare repository, I believe 
>> >> >> setup.c:setup_git_directory_gently() determines the prefix to be 
>> >> >> NULL.  This means my patch will see ALL paths as absolute, except 
>> >> >> :../path which will result in an error.
>> >> >
>> >> > My point was that it feels inconsistent to take the current path into 
>> >> > account in one case, but not in the other.
>> >> 
>> >> I do not understand your reasoning.  In a bare repository you cannot 
>> >> even be in a subdirectory to begin with.
>> >
>> > Exactly! That is my point. If you can do it in a working directory, but 
>> > also with a bare repository, I find it highly confusing and inconsistent 
>> > to have different meaning.
>> 
>> Sorry.  Now you confused me further.  I can do:
>> 
>> 	cd Documentation
>>         git diff v1.5.0 v1.5.1 -- git.txt
>> 
>> Is that confusing, inconsistent and bad for the users?
>
> Well, I am partly at fault that you _can_ execute git-diff outside of a 
> repository.
>
> But given the _arguments_ you give to git-diff as above, I'd expect it to 
> actually care about the working directory. IOW I would _not_ expect this 
> to work outside of a working directory (even if it does).

Oh, I was not thinking about "outside of repository" use.  I was
talking about your earlier "bare repository vs inside worktree
vs inside a subdirectory of worktree" point.  In a bare
repository,

	git diff v1.5.0 v1.5.1 -- Documentation/git.txt

is the only form that makes sense, as you cannot say "I am
interested in Documentation/" by _being_ in that subdirectory.
In a repository with worktree, you can, and we let you do so.

I would expect v1.5.0:Documentation/git.txt notation would be
the only sane variant that would make sense to name that blob in
a bare repository for the same reason.  I do not expect anybody
to complain because we do not allow him to say v1.5.0:git.txt in
a bare repository, either.

Also I sympathize with people who would wish to (eventually) be
able to do:

	$ cd Documentation/
	$ git show v1.5.0:git.txt

in a repository with worktree, by making the "relative path" the
default behaviour.  They would need to do either one of:

	$ git show v1.5.0:/git.c
	$ git show v1.5.0:../git.c

if we ever made the "relative path" the default.  As long as you
make sure that you make:

	$ git show v1.5.0:/git.c

work the same way in a bare repository _if_ we make the
"relative path" the default, I do not see any inconsistency
problem there.

A bare repository and a repository with working tree are
different.  In the former, you cannot say "I am interested in
this subtree" by _being_ in a subdirectory; in the latter you
can.  Taking advantage of that and allowing the user to express
himself better (only) in the latter is not an inconsistency.
Not being able to do that in a bare repository comes from what a
bare repository inherently is.
