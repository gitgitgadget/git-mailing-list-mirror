From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] git integrated bugtracking
Date: Sat, 9 Jun 2007 22:44:58 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0706092152180.5848@iabervon.org>
References: <20070603114843.GA14336@artemis> <20070609121244.GA2951@artemis>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sun Jun 10 04:45:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxDQL-0002dk-4L
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 04:45:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754754AbXFJCpA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 22:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754976AbXFJCpA
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 22:45:00 -0400
Received: from iabervon.org ([66.92.72.58]:2583 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753666AbXFJCo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 22:44:59 -0400
Received: (qmail 28659 invoked by uid 1000); 10 Jun 2007 02:44:58 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Jun 2007 02:44:58 -0000
In-Reply-To: <20070609121244.GA2951@artemis>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49653>

On Sat, 9 Jun 2007, Pierre Habouzit wrote:

>   FWIW I've begun to work on this (for real). I've called the tool
> "grit". You can follow the developpement on:
> 
>   * gitweb: http://git.madism.org/?p=grit.git;a=summary
>   * git:    git://git.madism.org/grit.git/

I've been working on a completely orthogonal portion of the bug-tracking 
problem (software to try to generate bug reports containing the 
information that a particular project would like for a particular sort of 
bug), and I've been thinking about how it would fit in with 
git-the-content-addressed-filesystem. I haven't actually implemented 
anything at all in this area, some you're ahead of me, but I have some 
ideas.

1) It's probably best to use some new types, rather than trees and 
commits. This gives you more flexibility to structure things in ways that 
exactly fit what's going on, which is one of the main reasons git is so 
good for version control. It also means that you can use inline strings 
for short answers (what's the name of the program that makes your kernel 
oops), and blobs for long answers (what's your lspci -vvv), and commits 
when appropriate (what commit did git-bisect find? what version resolves 
it?)

2) It's probably best to have the history be per-bug, with each revision 
being an update to that report, and have the complete database be a refs/ 
subdirectory. The complete list of bugs is going to become vast, and it's 
probably best to retain old bugs, at least in the databases at archival 
sites, so that you can get information on how often a bug turns out to be 
misuse of a particular API or something. This means that you really don't 
want each addition to be O(number of bugs).

3) I think it's worth separately representing "what problem somebody had" 
and "what was wrong with the program to cause problems" and linking these 
to each other. This will help in being able to at least represent multiple 
reports of the same bug, which is useful for finding patterns when the bug 
is non-trivial.

My idea of what the structure of the data is:

 - The project has essentially a troubleshooting procedure, written up 
   like a classic expert system (or like Kconfig). This takes the user 
   through a set of all the questions developers ever ask, with only the 
   appropriate ones visible (if you've got a build failure, it doesn't ask 
   for lspci output; it only asks for sysrq-t output if the system is 
   still sort of responding; etc).

 - The failure report is the set of all the questions the user answered 
   and the answers.

 - The hash of the initial failure report is the ID for the failure. 
   Revisions of the report (adding more information as people ask for 
   special things) retain the same ID.

 - After you generate a failure report, it searches for similar failures 
   and bugs in the main database. If it finds stuff, the user can try any 
   resolutions, and skip sending the report in. If there's nothing there 
   or there's still uncertainty as to what to do about the issue or the 
   resolution doesn't work for this case, the report is added to the 
   database.

 - It's up to developers to create bug records to pull together failure 
   reports, analysis of the situations, advice, and the ultimate 
   resolution. Failures get revised to link them to bugs so that people 
   with problems can find answers, and bugs list the failures they cause, 
   so that people working on something can find people to test.

 - Reports can be made on (1) failures that somebody would be able to test 
   resolutions to, but which aren't attached to any bugs; (2) bugs that 
   aren't resolved in a particular commit (which may be resolved in some 
   later or parallel commit, or have a patch). These are the things that a 
   release engineer would want to check on before releasing.

 - Reports can be made on clusters of unattached failures with similar 
   features. This would include unreproduceable failures, because they 
   might become fixable based on a large number of reports, or a test case 
   could be generated that makes them easier to trigger based on 
   distilling the common features of the rare failures.

	-Daniel
*This .sig left intentionally blank*
