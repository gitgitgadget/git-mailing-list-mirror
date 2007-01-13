From: Peter Baumann <siprbaum@stud.informatik.uni-erlangen.de>
Subject: Re: Importing from tarballs; add, rm, update-index?
Date: Sat, 13 Jan 2007 17:48:11 +0100
Message-ID: <20070113164811.GC4825@xp.machine.xx>
References: <6efbd9b70701120541n5dc4d0e1va50ae96543d8c80@mail.gmail.com> <7virfct737.fsf@assigned-by-dhcp.cox.net> <slrneqfnb8.a6s.Peter.B.Baumann@xp.machine.xx> <7vejq0t4ij.fsf@assigned-by-dhcp.cox.net> <20070112210403.GB6262@xp.machine.xx> <7v7ivrpx9y.fsf@assigned-by-dhcp.cox.net> <87y7o6x60w.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 13 17:47:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5m2K-0004p4-HT
	for gcvg-git@gmane.org; Sat, 13 Jan 2007 17:47:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422716AbXAMQrS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Jan 2007 11:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422719AbXAMQrS
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jan 2007 11:47:18 -0500
Received: from matlock.hofmann.stw.uni-erlangen.de ([131.188.24.35]:43164 "HELO
	mail.hofmann.stw.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1422716AbXAMQrR (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Jan 2007 11:47:17 -0500
Received: (qmail 7613 invoked by uid 0); 13 Jan 2007 16:47:13 -0000
Received: from p54aaa36b.dip0.t-ipconnect.de (HELO localhost) (p.b@hofmann.stw.uni-erlangen.de@84.170.163.107)
  by mail.hofmann.stw.uni-erlangen.de with SMTP; 13 Jan 2007 16:47:13 -0000
To: Carl Worth <cworth@cworth.org>
Mail-Followup-To: Carl Worth <cworth@cworth.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <87y7o6x60w.wl%cworth@cworth.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36760>

On Sat, Jan 13, 2007 at 08:09:35AM -0800, Carl Worth wrote:
> On Fri, 12 Jan 2007 16:48:09 -0800, Junio C Hamano wrote:
> > Peter Baumann <waste.manager@gmx.de> writes:
> >
> > > Yes. I fully second Linus opinion. But I think there should be
> > > a difference in adding completly new content to the index
> > > (number of entries in the index grows) or replacing content in
> > > the index.
> >
> > Huh?
> 
> Here's an easy way to see the difference that Peter is trying to point
> out, (and it really has nothing to do with whether "git add" for a new
> file should add the content of that file to the index---that's a
> totally separate issue that Linus was talking about in that other
> message).
> 
> Just look at "commit -a" and how its documented right now. Currently
> it's documented as doing an automatic "add" to all known files. That
> descriptions is unsatisfactory for two reasons:
> 
> 1. "commit -a" will also commit the removal of files---which requires
>    an index modification that "git add" cannot do
> 
> 2. "add" can cause an entirely new path (with content, Vader!) to be
>    added to the index. So the user has to carefully separate out this
>    behavior of "add" to properly understand what "commit -a" is
>    doing. The documentation tries to help here with "known files", but
>    the talk of an "automatic 'add'" that never adds any new paths
>    really goes against the primary functionality of "git add".
> 
>    I say "primary functionality" because the 'commit -a' workflow,
>    (which we've all agreed should be the thing that is taught first),
>    requires users to use 'git add' when adding a new path to the
>    index, but never requires the user to use the 'update the index'
>    sense of 'git add', (instead, the user just needs to _learn_ this
>    sense to understand commit -a).
> 
> So there's lots of room for potential confusion there, and we've got
> evidence of that confusion in the messages that started this an other
> recent threads about how to remove files.
> 
> I like the idea of adding a porcelain command for update-index, and
> it's nice to try to describe "commit -a" in terms of the new porcelain
> command. But, to make that really work, I think that porcelain for
> update-index should really match the semantics needed by "commit
> -a". That is, it should never add new paths to the index, but it
> should update content for existing paths, and it should remove paths
> >from the index when files have been removed from the working tree.
> 
> Let's call this new command "refresh", just to experiment with another
> name. If it existed, then "commit -a" could be described as simply
> doing "refresh" on all files, (with no need to have a notion of
> "tracked files", nor any extra language about file removal). That is,
> "commit -a" could be understood as something like:
> 
> 	git refresh -a
> 	git commit
> 
> (or maybe "git refresh .; git commit" if one prefers that, but I think
> it'd be nice to carry the -a option over to the new porcelain).
> 
> Also, this would even make it possible to provide an accurate
> index-based description of "commit paths...". Namely, something like:
> 
> 	commit paths...
> 
> 	This command starts with a new index initialized from the
> 	contents of the current commit (HEAD). It then performs the
> 	following commands:
> 
> 		git refresh paths...
> 		git commit
> 
> 	[Some extra language needed here about restoring into the
> 	index other changes that were "skipped over".]
> 
> So, someone might like to have that kind of description somewhere in
> the technical documentation of git. (I'd still prefer to see "commit
> paths..." documented as simply "commits the working-tree content of
> all specified paths").
> 
> Anyway, did I succeed in pointing out why some of us think that the
> "add a new path (with content) to the index" and the "update content
> for existing path" really shouldn't be mixed up in the same "add"
> command?
> 

Yes. At least for me :-)

-Peter

> -Carl
