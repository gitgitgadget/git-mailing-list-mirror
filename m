From: Stephen Bash <bash@genarts.com>
Subject: Re: Converting to Git using svn-fe (Was: Speeding up the initial
 git-svn fetch)
Date: Thu, 21 Oct 2010 19:26:52 -0400 (EDT)
Message-ID: <4258434.537707.1287703612372.JavaMail.root@mail.hq.genarts.com>
References: <201010220049.33344.jnareb@gmail.com>
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
X-From: git-owner@vger.kernel.org Fri Oct 22 01:27:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P94XJ-000301-SE
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 01:27:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756172Ab0JUX1A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 19:27:00 -0400
Received: from hq.genarts.com ([173.9.65.1]:19852 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751287Ab0JUX07 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 19:26:59 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id C67DF1E26900;
	Thu, 21 Oct 2010 19:26:58 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vlgtzQtkJvUh; Thu, 21 Oct 2010 19:26:52 -0400 (EDT)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id 71F0F1E2690D;
	Thu, 21 Oct 2010 19:26:52 -0400 (EDT)
In-Reply-To: <201010220049.33344.jnareb@gmail.com>
X-Mailer: Zimbra 6.0.7_GA_2473.UBUNTU8 (ZimbraWebClient - SAF3 (Mac)/6.0.7_GA_2473.UBUNTU8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159589>

----- Original Message -----
> From: "Jakub Narebski" <jnareb@gmail.com>
> To: "Stephen Bash" <bash@genarts.com>
> Sent: Thursday, October 21, 2010 6:49:32 PM
> Subject: Re: Converting to Git using svn-fe (Was: Speeding up the initial git-svn fetch)
> 
> Ah, I understand now that 'svn merge' (which is rather like 'cvs
> update')
> can be used for cherry picking.
> 
> Sidenote: in Git cherry picking picks up change and applies it on top
> of current branch as one would apply a patch.

Yes.

> This is quite different
> from merge, where you find comon ancestor and then perform 3-way merge
> (ours, theirs, ancestor). 

Yes.

> Is merging in Subversion using 3-way merge
> (like 'cvs update -j ... -j ...' is), or re-applying changes?

Appears to the be 3-way merge if I'm reading the SVN archives correctly:
  "It's a basic diff3 algorithm. 'man diff3' to learn about it and play 
   with GNU's implementation of diff3."
http://svn.haxx.se/users/archive-2005-03/1232.shtml

So my *guess* is they derive a common ancestor from their copy information, but I'm sure someone else more knowledgable could say more about that.

> > > I have read some documentation about svn:mergeinfo property:
> > > http://svnbook.red-bean.com/en/1.5/svn.branchmerge.basicmerging.html
> >
> > I guess this the first time I've read the 1.5 version of the SVN
> > Book.
> > This has consequences below...
> 
> Errr... what consequences? a:b vs a-b being closed (inclusive) or open
> (exclusive) from one or other end?

No, just that post-1.5 merges do actually start to look more like Git merges.

> > Back to the task at hand... having read the 1.5 SVN docs, I have no
> > idea how this works now (big caveat!!!), but prior to 1.5 M1 would
> > have been
> >
> >   svn switch svn://path/to/foo
> >   svn merge -ra:b svn://path/to/bar destination-path
> >
> > which is "Take the changes introduced in revisions a through b, and
> > apply them to the destination-path". This is why I think of SVN
> > merges as cherry-picks -- I was allowed to specify exactly what
> > changesets I wanted merge to work on.
> 
> On one hand side you "were allowed to specify exactly what changesets
> you wanted to merge to work on", on the other hand side you *had* to
> specify what changesets etc.

My point is because the user was required to specify the revisions to merge, I don't think an automated tool (i.e. the mapper) can make assumptions about what was actually merged in any given revision.

> > To truly illustrate this, consider a' is in between a and b:
> >
> > ---1---B---2---3-------M1--4---5---M2 <-- foo
> >         \              /           /
> >          \-a---a'---b-/-----c---d-/ <-- bar
> >
> > I could
> >
> >   svn switch svn://path/to/foo
> >   svn merge -ra':b svn://path/to/bar destination-path
> >
> > and "a" would never be merged back to foo.
> 
> Such merge would be hard to represent in Git, I think.

I agree.
 
Thanks,
Stephen
