From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH v3 0/2] cvsimport: add test illustrating a bug in cvsps
Date: Mon, 23 Mar 2009 18:47:45 +0100
Message-ID: <20090323174734.GA26678@macbook.lan>
References: <49B52F74.1090006@alum.mit.edu> <49C13062.4020400@hvoigt.net> <7vfxhag07g.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heiko Voigt <git-list@hvoigt.net>,
	Michael Haggerty <mhagger@alum.mit.edu>, ydirson@altern.org,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 18:56:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LloNV-00005O-QB
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 18:56:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753768AbZCWRya (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 13:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753261AbZCWRya
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 13:54:30 -0400
Received: from darksea.de ([83.133.111.250]:51706 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753531AbZCWRy3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 13:54:29 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Mar 2009 13:54:28 EDT
Received: (qmail 30497 invoked from network); 23 Mar 2009 18:47:34 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 23 Mar 2009 18:47:34 +0100
Content-Disposition: inline
In-Reply-To: <7vfxhag07g.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114337>

On Wed, Mar 18, 2009 at 11:22:43AM -0700, Junio C Hamano was talking about:
> Heiko Voigt <git-list@hvoigt.net> writes:
> 
> > This is an updated version of the first patch and an addition to ensure
> > correct handling of branches in fixes. 
> 
> I've already merged the first one to 'next' so this needs to be turned
> into an incremental update if we were to continue building on top in the
> git project.
> 
> I however have a bigger issue with this, perhaps because I do not have the
> feeling that I fully understand where these patches are going.

To explain my intentions a little more: I recently imported a huge
repository with ~11 years of history from a RCS based system. 

The final step into git land was through CVS. Here I really struggled to
find the right tool and it costed me quite some time just to find a
robust tool for the job (and to figure out why the "standard" tool
failed). 

So my main goal is to save some time and hassle for everyone else going
this route. There are really nicer things to spend time on than
importing and repairing RCS files.

I think many people when starting with git get the feeling: Oh look at
this SHA1 based database and stuff these people have written a really
neat robust system. Then you look at getting your history (from CVS)
into it and it becomes a nightmare. The command git cvsimport just does
not fit with the rest of the git tools quality.

> 
> Your approach seems to me to:
> 
>  - add tests to git test suite that expose issues the current cvsimport
>    that runs on an unpatched cvsps has;
> 
>  - diagnose and fix
> 
>    - the issues in cvsimport, if the problem is because cvsimport is
>      mishandling correct output from cvsps; or
> 
>    - the issues in cvsps (and adjust cvsimport to patched cvsps if
>      necessary), if the problem is because output from cvsps is incorrect.
> 
> That all feels sane, and having the tests to verify the end result would
> help the people who collaborate on these tasks.
> 
> But how much of the actual fix will be made to cvsps, and how much to
> cvsimport? 

I can not answer this question at the moment. One thing would be fixing
cvsps, which just for one test (mine) seems like a lot of work. I
haven't even looked into the other issues.

After writing my last email it came to my mind that it could be a
simpler approach to take parsecvs (only because its already written in C
otherwise probably cvs2svn/cvs2git) and change the interface so it
matches the one of git cvsimport and integrate it with git.

To let this happen the question is how important various features of the
current cvsimport are:

  * incremental import

  * keyword substitution

  * ...

> If the majority of the changes are to happen on cvsps (which
> is not unexpected, given that many people who tried and wrote various cvs
> importers put blame on the shortcomings of its output), I am afraid that
> it would not help majority of git users until the fixes to cvsps that come
> out of this effort hit their distros for me to keep these tests in the
> git.git repository.  I do not build and install custom cvsps (because I
> haven't had to work with complex history in CVS that your improvements to
> cvsps are need to deal with correctly), and I suspect many others are in
> the same boat.  In addition, if your tests are in the git.git repository,
> they need to say test_expect_success for people with patched cvsps and
> test_expect_failure for people without, and because I suspect that the
> majority of git developers do not run bleeding edge cvsps, it does not do
> anything but slowing down the test suite.
> 
> It feels as if you are scratching my feet through my shoes while I still
> am wearing them.  I wonder if it would be more direct and simpler approach
> to add tests to cvsps and handle these improvements as part of the cvsps
> maintenance/development effort, not as part of cvsimport fixes, at least
> initially.
> 
> I think it is great that you started actively working on identifying and
> fixing issues with cvsps, that many others have gave up and gone to
> different avenues, and I certainly do not mind keeping the new tests in
> 'pu' for wider exposure, in order to make it easier for other people who
> use cvsimport and want to collaborate with you improving it through
> improving cvsps.
> 
> But I am starting to think that it was a mistake on my part to have merged
> the initial set of tests to 'next'.
> 
> Thoughts?

In the long run I think at least a basic test for the current issues
should be in git.  Otherwise if cvsimport gets fixed you do not have a
way of making sure all tools (cvsps) in their right versions are
installed. Even with another non cvsps importer this property needs to
be ensured to handle non trivial repositories.
 
The only people who actually need to know about issues in cvsimport are
the ones who are trying to get away from CVS. So its probably best to
disable the "advanced" tests and have an environment variable e.g.:
"ALL_CVSIMPORT_TESTS" for enabling them.

cheers Heiko
