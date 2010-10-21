From: Stephen Bash <bash@genarts.com>
Subject: Re: Converting to Git using svn-fe (Was: Speeding up the initial
 git-svn fetch)
Date: Thu, 21 Oct 2010 17:27:42 -0400 (EDT)
Message-ID: <20420115.537598.1287696462845.JavaMail.root@mail.hq.genarts.com>
References: <201010212037.09618.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Will Palmer <wmpalmer@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matt Stump <mstump@goatyak.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Tomas Carnecky <tom@dbservice.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 21 23:27:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P92g0-0003tV-5t
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 23:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755872Ab0JUV1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 17:27:51 -0400
Received: from hq.genarts.com ([173.9.65.1]:9594 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754016Ab0JUV1u (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 17:27:50 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 9EF211E268FF;
	Thu, 21 Oct 2010 17:27:49 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7x2YnMt81K1G; Thu, 21 Oct 2010 17:27:42 -0400 (EDT)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id E8CD41E268F0;
	Thu, 21 Oct 2010 17:27:42 -0400 (EDT)
In-Reply-To: <201010212037.09618.jnareb@gmail.com>
X-Mailer: Zimbra 6.0.7_GA_2473.UBUNTU8 (ZimbraWebClient - SAF3 (Mac)/6.0.7_GA_2473.UBUNTU8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159576>

----- Original Message -----
> From: "Jakub Narebski" <jnareb@gmail.com>
> To: "Stephen Bash" <bash@genarts.com>
> Sent: Thursday, October 21, 2010 2:37:07 PM
> Subject: Re: Converting to Git using svn-fe (Was: Speeding up the initial git-svn fetch)
>
> > > Of course, "ignoring merges" is temporary and a total cop-out
> >
> > This is still bugging me... Even with svn mergeinfo (which I think
> > is a small percentage of the SVN revisions in the world),
> 
> From what I understand to have svn:mergeinfo you have to have version
> >= 1.5 of Subversion installed on server, and to use it also >= 1.5
> client.

Correct.  I can't find a release date for 1.5, but my impression is a lot of history in SVN repositories pre-dates 1.5 (especially since it required *both* the client and the server to be updated).  That impression is mostly based on my own experience...  Using Subversion heavily from 2003 to late 2009 my memory is mostly of 1.3 and 1.4 -- I probably only upgraded if I was setting up a new machine or some fancy new tool I was using required the newest version.
 
> But because Subversion doesn't impose strict separation between branch
> namespace and in-repository paths, somebody somewhere would certainly
> at some time screw this up. And only then we would have to rely on
> subtree merge / git-subtree split similarity detection.

I don't have much experience with subtree merge...  It's possible that will improve the situation.

> BTW. Subversion doesn't have "svn cherry-pick", nor equivalent to
> "git reset" == "git cherry-pick -R"... well, at least I don't think it
> has.

See below...

> I have read some documentation about svn:mergeinfo property:
> http://svnbook.red-bean.com/en/1.5/svn.branchmerge.basicmerging.html

I guess this the first time I've read the 1.5 version of the SVN Book.  This has consequences below...
 
> ---1---B---2---3---M1--4---5---M2 <-- foo
>         \         /           /
>          \-a---b-/-----c---d-/ <-- bar
> 
> B is branching point, M1 and M2 are merge commits.
> 
> In Git, and I assume that also in Subversion, when doing merge M1, the
> VCS notices that from revision B branches 'foo' and 'bar' have common
> commits (in git we say that merge base of 'foo' and 'bar' at the point
> of doing merge M1 is commit B). 

I'm going to take a little liberty with SVN revisions because I've always thought of SVN revisions as before and after the change, so a:b in SVN is the change introduced in b, but since we're on the Git list, in the following examples I will use a:b to mean the changes introduced in both a and b.  (Since it was introduced, I've always read "svn diff -c rev" as "svn diff -r rev-1:rev")

Back to the task at hand... having read the 1.5 SVN docs, I have no idea how this works now (big caveat!!!), but prior to 1.5 M1 would have been

svn switch svn://path/to/foo
svn merge -ra:b svn://path/to/bar destination-path

which is "Take the changes introduced in revisions a through b, and apply them to the destination-path".  This is why I think of SVN merges as cherry-picks -- I was allowed to specify exactly what changesets I wanted merge to work on.  To truly illustrate this, consider a' is in between a and b:

---1---B---2---3-------M1--4---5---M2 <-- foo
        \              /           /
         \-a---a'---b-/-----c---d-/ <-- bar

I could

svn switch svn://path/to/foo
svn merge -ra':b svn://path/to/bar destination-path

and "a" would never be merged back to foo.  The concept of *not* specifying revision numbers to merge is new in 1.5. See

http://svnbook.red-bean.com/en/1.4/svn.branchmerge.copychanges.html

This is what scares me about mapping SVN merges to Git merges.  It seems post-1.5 merges have a lot more in common with Git than pre-1.5 (though mergeinfo is still brain damaged -- easy branching and merging is why I switched!), but I think we still need to support pre-1.5.

Thanks,
Stephen
