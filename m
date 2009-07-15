From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: auto-merge after push?
Date: Wed, 15 Jul 2009 22:57:18 +0300
Message-ID: <20090715195718.GA12033@redhat.com>
References: <20090511142326.GA18260@redhat.com> <alpine.DEB.1.00.0905111714250.4973@intel-tinevez-2-302> <20090511201705.GA21045@redhat.com> <alpine.DEB.1.00.0905112302130.27348@pacific.mpi-cbg.de> <20090611104020.GA12036@redhat.com> <20090711203831.GA10875@redhat.com> <alpine.DEB.1.00.0907120441440.3155@pacific.mpi-cbg.de> <7vocrplhbv.fsf@alter.siamese.dyndns.org> <20090715145430.GB9075@redhat.com> <7v1vohg2vf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 15 21:58:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRAcT-0005fp-2d
	for gcvg-git-2@gmane.org; Wed, 15 Jul 2009 21:58:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756234AbZGOT6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2009 15:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756225AbZGOT6S
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 15:58:18 -0400
Received: from mx2.redhat.com ([66.187.237.31]:42930 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756223AbZGOT6R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2009 15:58:17 -0400
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n6FJw91C029177;
	Wed, 15 Jul 2009 15:58:09 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n6FJw9Uk017541;
	Wed, 15 Jul 2009 15:58:09 -0400
Received: from redhat.com (vpn-10-95.str.redhat.com [10.32.10.95])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n6FJw2rq021394;
	Wed, 15 Jul 2009 15:58:06 -0400
Content-Disposition: inline
In-Reply-To: <7v1vohg2vf.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Scanned-By: MIMEDefang 2.58 on 172.16.27.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123333>

On Wed, Jul 15, 2009 at 12:31:00PM -0700, Junio C Hamano wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > So, let me summarize the issues:
> > - if the tree is pushed into while files are being actively read
> >   (e.g. built from), the build will get an inconsistent state
> > - even worse if one of the files is open for editing or is being written
> >   into: the file will get corrupted
> > - if there are uncommitted changes in the tree, the push is denied
> >
> > Are there others?
> 
>  - If you choose to detach-on-push, the user who _thought_ was advancing
>    the history of a branch using the work tree will get very confusing
>    results.  The branch will be advanced by the push, and the work tree
>    user is required to notice the situation, later at some point merging
>    the work done in the work tree that went to the detached HEAD state.

I never use detach on push. Let's remove that option for now?

>  - What happens if the automerge gets conflict?

push is denied, unless you push with -f, then I think you get the new
head.  Note that merge is not the right word here: only fast forward is
done I think.  Right, Dscho?

> Having said that, I think it is a _wrong_ approach to try summarizing the
> issues along these lines, without stating the most fundamental restriction.

Sure. I am just trying to figure out all the details before I try to
write this up. The coordination issue is obviously the main thing, I was
trying to enumerate the less obvious ones.

> If the push-from-sideways is done without any coordination between the
> person pushes and the person who uses the work tree, _any_ solution that
> modifies the work tree behind the back of that work-tree person will not
> work without surprising him, so listing the possible surprises is
> pointless.
> 
> On the other hand, all of the above "issues" (including yours) will become
> only implementation details of a workflow when there is a coordination
> between the pusher and the work-tree person.  In the most trivial case,
> both are you, and the repository with the work tree is your private
> working area.
> 
> So I would suggest stressing the need for this coordination before
> starting to list the "issues".
> 
> Be it "detach" or "automerge", the workflow helped with the patch is
> merely a deviation of the mothership-satellite configuration (look for
> "satellite" in the FAQ) where you push from satellite to mothership (each
> has its own work tree) to achieve logically what you would want to perform
> with a pull in the other direction, that is:
> 
>  satellite$ git push mothership:project master:refs/remotes/satellite/master
>  satellite$ ssh mothership 'cd project && git merge remotes/satellite/master'
> 
> The necessary "coordination" between the two repositories is that the last
> step, "merge what was pushed", must be done when the work tree checked out
> in the mothership repository is in a state that is suitable for performing
> the merge, e.g. no extra change to the index that is unrelated to the
> merge, no local change that interferes with the merge, etc.
> 
> The auto-merge-upon-push patch by Dscho, however, places a further
> restriction on top of the stock satellite-mothership configuration,
> exactly because it is automated.  In an unautomated workflow, you can
> afford to choose _when_ to merge, independent from when to push:
> 
>  satellite$ git push mothership:project master:refs/remotes/satellite/master
>  satellite$ ssh mothership
>  mothership$ cd project
>  ... work further to finish off what you did on the mothership ...
>  mothership$ git commit
>  mothership$ git merge remotes/satellite/master
> 
> Typically, when you are done (for the day, for example) on satellite, you
> push it out to the mothership, even though the mothership repository's
> work tree may have independent local changes (aka WIP) you have left when
> you last worked there.  After switching to work in the mothership, you
> can continue working on the WIP to finish it before merging what you did
> on the satellite the previous day.
> 
> The automated way will trade this flexibility off with convenience (you do
> not have to have the interactive session on the mothership only to perform
> the merge), so you will be required to leave the mothership work tree and
> the index in a good shape any time you might want to push into it from the
> satellite.  It is a small price to pay, and depending on the situation
> (the most obvious is when you do not even have an interactive shell access
> to the mothership) you may not even have that flexibility to begin with,
> in which case there is no downside.

Thanks for the explanation.
