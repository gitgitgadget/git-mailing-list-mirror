From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] pack-objects: reuse data from existing pack.
Date: Thu, 16 Feb 2006 01:13:04 -0800
Message-ID: <7vr763bra7.fsf@assigned-by-dhcp.cox.net>
References: <7vd5hpm2x0.fsf@assigned-by-dhcp.cox.net>
	<7vbqx8m62q.fsf@assigned-by-dhcp.cox.net> <43F438AA.1040508@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 16 10:13:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9fCP-0003KR-Pw
	for gcvg-git@gmane.org; Thu, 16 Feb 2006 10:13:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbWBPJNI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Feb 2006 04:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbWBPJNI
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Feb 2006 04:13:08 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:17132 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751263AbWBPJNH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2006 04:13:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060216091006.EPEB17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 16 Feb 2006 04:10:06 -0500
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <43F438AA.1040508@op5.se> (Andreas Ericsson's message of "Thu, 16
	Feb 2006 09:32:42 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16287>

Andreas Ericsson <ae@op5.se> writes:

> Whoa! Columbus and the egg. Strange noone saw it before. It's so
> obvious when you shove it under the nose like that. :)

I wished the pack format were not so dense as we have today.  It
is very expensive to obtain the uncompressed size of a deltified
object.  For this reason, a delta newly created (either from a
non-delta in an existing pack or from a loose object) by the
experimental algorithm is never made against an object that is
in deltified form in a pack.  Also it incurs nontrivial cost to
obtain the size of the in-pack representation of an object
(either deltified or not).  But the inefficiency in the
resulting pack due to these factors may not matter in practice.

I just packed v2.6.16-rc3 object list (184141 objects) using the
current and the experimental, just for fun.  Tonight's one runs
just under 1 minutes on my Duron 750 (with slow disks I should
add).  This was done in a repository that has about 1500 loose
objects and a single mega pack; reuse rate of packed data by the
experimental algorithm is about 99%.  I am hoping the one from
the "master" would come back before I finish writing this
message ;-).

There are subtleties.

For example, in a typical project, files tend to grow rather
than shrink on average, and older ones tend to be in packs.  If
you do packing the traditional way, the largest one (which is
typically the latest) is kept as non-delta, and all the smaller
ones will be incremental delta from that, no matter how your
packs and loose objects are organized.

Usually, you have the latest objects as loose objects in your
repository to be packed (either you push from it, or somebody
else pulls from you).  In other words, as you develop after your
last repack, you would accumulate loose objects, and they are
the ones that typically matter the most.

Let's say you have been changing the same file in every commit
(1..N), then you fully packed and then created another commit
(revision N+1) that touches the file.  The experimental
reuse-packer would:

    - notice blobs from revision 1..(N-1) are deltified,
      relative to the rev one greater than each of them.
      these would be reused.
    - notice blob from revision N is in the pack but not
      deltified.
    - notice blob from revision N+1 is loose.

Then emit the bigger one between N or N+1 as non-delta, the
other one as delta.  1..(N-1) are output as delta.  If it
happens to choose N as plain, it does not have to uncompress and
recompress so the pack process would go very fast, but you would
end up always having to apply a delta to bring rev N to N+1 on
top of the non-delta N to get to the latest blob in rev N+1, and
you typically would want to access rev N+1 blob more often.

In other words, the experimental reuse-packer would create a
suboptimal pack in such a case.  Not a big deal, though.

We may want an option to disable the optimization for
weekly/monthly repacking.  git-daemon (or whatever runs
pack-objects via upload-pack) should use the default with the
optimization, since this is so obviously faster.

> Now that pack-creation went from bizarrely expensive to insanely cheap
> (well, comparable to "tar czf" anyways), what's BCP for packing a
> public repository? Always one mega-pack and never worry, or should one
> still use incremental and sometimes overlapping pack-files?

I would say an optimum single mega-pack would work the best, but
"repack -a -d" to create the mega-pack _with_ the optimization
may have performance impact for users of resulting packs.

Oh, the traditional one finally came back after 11 minutes.
