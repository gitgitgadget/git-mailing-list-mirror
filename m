From: "David E. Wheeler" <david@kineticode.com>
Subject: Re: Again with git-svn: File was not found in commit
Date: Sat, 25 Apr 2009 19:40:27 -0700
Message-ID: <81EFD289-5E46-4B27-8DA4-C2039915CE2D@kineticode.com>
References: <747CFDA3-AC27-44EB-A69C-BF9C29B05A31@kineticode.com> <20090421180231.GB16642@dcvr.yhbt.net> <8EDD65AC-9C25-4281-86F6-E52A41331B00@kineticode.com> <20090426015300.GA17212@dcvr.yhbt.net>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Apr 26 04:43:29 2009
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxuL2-0003yv-Bi
	for gcvg-git-2@gmane.org; Sun, 26 Apr 2009 04:43:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752006AbZDZCkb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2009 22:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751960AbZDZCka
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Apr 2009 22:40:30 -0400
Received: from host-201.commandprompt.net ([207.173.203.201]:54914 "EHLO
	smtp.kineticode.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212AbZDZCka (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2009 22:40:30 -0400
Received: from [192.168.1.100] (97-125-32-5.eugn.qwest.net [97.125.32.5])
	by smtp.kineticode.com (Postfix) with ESMTPSA id 1BF0150805C;
	Sat, 25 Apr 2009 19:39:24 -0700 (PDT)
In-Reply-To: <20090426015300.GA17212@dcvr.yhbt.net>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117582>

On Apr 25, 2009, at 6:53 PM, Eric Wong wrote:

> Hopefully the workaround is working out for you.

[Finally], yes.

[Finally]: http://justatheory.com/computers/vcs/git/bricolage-to-git.html

> The problem with r5256 is quite nasty and I can't think of a good
> automated solution right now involving --stdlayout/branches/tags
>
> ------------------------------------------------------------------------
> r5256 | theory | 2004-05-09 19:17:49 -0700 (Sun, 09 May 2004) | 2  
> lines
> Changed paths:
>   A /bricolage/branches/rev_1_8 (from /bricolage/branches/ 
> rev_1_8_temp/bricolage:5255)
>   D /bricolage/branches/rev_1_8_temp/bricolage
>
> Permanent home.
>
> ------------------------------------------------------------------------
>
> The problem is that the "bricolage" subdirectory became the top-level
> tree and git-svn doesn't have a way of detecting that.  This is
> occasionally a problem with other repos, too

We moved shit around a *lot*. There were two times we moved things  
around: First, when Bricolage was first imported from CVS, it assumed  
that the root directory was the project directory, even though we had  
several projects. So we had

/trunk/
/branches/
/tags/

We spent several hundred commits moving things around so that we would  
have the more standard:

/bricolage/trunk/
/bricolage/branches/
/bricolage/tags/

Fortunately, we did all of this moving before we committed anything  
useful to Subversion. So for this project, I first converted the old  
SourceForge CVS repository to Git, then converted the Subversion  
repository starting from after all this moving around (r5517, well  
after the problematic commit), and then I joined them together, as  
detailed in my blog post.

> Overall, this repo is very nasty given the amount of times follow- 
> parent
> needs to be used (refs with a "@<revno>" suffix).  The --stdlayout
> switch is really for the common repositories with a consistent depth  
> for
> branches/tags.  Unfortunately, SVN is way too freeform in this regard
> and mixed-depth branches/tags hierarchies have always been a  
> problem :<

Tell me about it. This is why it took 30 hours before `git-svn` failed.

The other time we moved stuff around was to reorganize tags into  
subdirectories. This was because we had so many tags that they were  
unwieldy as a directory listing in SVN. This turned out to be a PITA  
when migrating, but I was able to [work around it] using GitX and some  
pretty hacky code to generate grafts. It'd be nice if there was a way  
to tell git-svn how deep a hierarchy to look for for tags (and perhaps  
branches), although it wouldn't have helped us, because we *changed*  
that hierarchy.

[work around it]: http://justatheory.com/computers/vcs/git/bricolage-svn-to-git.html

I'm so glad to have it all in Git now where things are far more  
rationally organized.

> It might be a bit easier to write (or script) the "fetch" lines
> (like the one --stdlayout generates for trunk) for each tag/branch
> and maybe use --no-follow-parent.

--no-follow-parent was indeed key for me being able to get this done.  
Thanks for writing such a capable client that, although it couldn't  
reconstruct what we were thinking when we moved things around, it let  
me tell it where to stop and what stuff to ignore (ultimately, I had  
it ignore all tag directories) so that I could get the job done.

The new Git repository is now on [GitHub], if you're curious.

[GitHub]: http://github.com/bricoleurs/bricolage/

Thanks,

David
