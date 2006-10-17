From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/2] Delete ref $frotz by moving ref file to "deleted-$frotz~ref".
Date: Tue, 17 Oct 2006 06:26:25 +0200
Message-ID: <200610170626.25654.chriscool@tuxfamily.org>
References: <20061014153949.2994a114.chriscool@tuxfamily.org> <7vr6xa91kj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 06:19:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZgQe-0007dj-W2
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 06:19:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422941AbWJQETq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 00:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161159AbWJQETq
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 00:19:46 -0400
Received: from smtp4-g19.free.fr ([212.27.42.30]:7555 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S1161153AbWJQETp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Oct 2006 00:19:45 -0400
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g19.free.fr (Postfix) with ESMTP id 150AE526E0;
	Tue, 17 Oct 2006 06:19:44 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.4
In-Reply-To: <7vr6xa91kj.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29014>

Junio C Hamano wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
> > The idea is that moving:
> >
> > $GIT_DIR/refs/<refpath>/frotz
> >
> > to:
> >
> > $GIT_DIR/deleted-refs/<refpath>/frotz~ref
> >
> > maybe cheaper and safer than repacking the refs without the
> > deleted one.
>
> Before actually implementing delete_ref(), we discussed this
> "deleted-refs/" idea. but I do not think it is a direction we
> would want to go.
>
> Ref deletion is an operation that happens far far rarer than
> updates and lookups, and I deliberately chose to optimize for
> the latter.

I think that the ref deletion usage depends on the policy of people using 
git, and there may be people that delete a ref very often.

For example, when git becomes a major SCM, there may be people working on 
big projects that want to create a new branch for each new bug and then 
delete the branch when the code on the bug branch has been integrated into 
a new release and the bug is closed.

> There are valid reasons to delete refs, and one most frequent
> one would be to discard throw-away temporary branches you may
> have needed to switch to when your work was interrupted.  But
> even counting that kind of deletion, I imagine that you would
> not be creating and removing more than one branch per every 10
> commits you would create, and I also imagine you would be
> invoking not less than 5 operations that inspect project
> history, such as git-log and git-diff, between commits you make.

The operations that inspect project history may use a ref cache or something 
so that a lookup on the disk may not be needed. So only the ref creation or 
update rate versus delete rate may matter.

> An operation to build a new commit itself needs at least two
> lookups (one to see what's current upfront, and another to see
> nobody touched it upon lockless update).  Most history-related
> operations at least need to look at one (typically, HEAD), and
> any refname you use to spell the name of an object or revision
> range (e.g. "v2.6.17..v2.6.18~10" needs to look at tags/v2.6.17
> and tags/v2.6.18).  Optimizing for deletion path at the expense
> of giving even a tiny penalty to lookup path is optimizing for a
> wrong case, and that is why I rejected deleted-refs/ idea when I
> originally did the delete_ref() implementation.

The lookup code is already using cached packed refs. It could also use 
cached loose and deleted refs, so the lookup penalty would be very very 
small. By the way, the OS may already cache loose and deleted ref file stat 
information, so that may right now be a very small penalty.

And at least, algorythmically speaking, with my patch the deletion path is 
now independent of the number of existing refs, so it's much better (while 
the lookup path stay the same).

If there are thousand of refs and a heavy I/O load, rewritting the packed 
ref file for each deletion means writing on disk something that may not fit 
in the disk cache. It may be very bad.

My patch also has a few added benefits like making it possible to have a 
read only packed ref file, while still letting people delete refs. It also 
make it possible to resurect a deleted ref, or to control branch deletion 
rights on a per ref directory basis (though that may not be very usefull).

And the fact that the packed ref file (which may be read only for added 
safety) is not rewritten each time a ref is deleted make things much safer 
if there are many users working on the same git repository.

Christian.
