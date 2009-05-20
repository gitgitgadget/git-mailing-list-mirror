From: Nicolas Pitre <nico@cam.org>
Subject: Re: Reverting an uncommitted revert
Date: Wed, 20 May 2009 14:19:09 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0905201406280.3906@xanadu.home>
References: <4A136C40.6020808@workspacewhiz.com>
 <alpine.LFD.2.00.0905192300070.3906@xanadu.home>
 <20090520032139.GB10212@coredump.intra.peff.net>
 <alpine.LFD.2.00.0905192328310.3906@xanadu.home>
 <025225A0-FACC-4A29-A747-40201A7FBA19@wincent.com>
 <alpine.LFD.2.00.0905200853010.3906@xanadu.home>
 <20090520141709.GO30527@spearce.org> <7vab57zmd8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Wincent Colaiuta <win@wincent.com>, Jeff King <peff@peff.net>,
	Joshua Jensen <jjensen@workspacewhiz.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 20 20:21:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6qNw-0004yc-Pa
	for gcvg-git-2@gmane.org; Wed, 20 May 2009 20:19:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754852AbZETSTQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2009 14:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754790AbZETSTP
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 14:19:15 -0400
Received: from relais.videotron.ca ([24.201.245.36]:12464 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754339AbZETSTO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2009 14:19:14 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KJY005I0G7XWN90@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 20 May 2009 14:19:10 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vab57zmd8.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119626>

On Wed, 20 May 2009, Junio C Hamano wrote:

> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > You did say "uncommitted entry causes reflog append", so in Peff's
> > original example of "git add a; vi a; git add a", we should be
> > creating a reflog entry for that first added state, which is clearly
> > not a disagreement.
> >
> > FWIW, I think this is a great idea, but lack the time to code it
> > myself, otherwise I probably would start hacking on it right now.
> 
> The devil's in the details.  There are at least four things you would need
> to design before start hacking.
> 
>  (0) Do you want this to apply only to Porcelains, or do you want to use
>      this for plumbing operations as well?

Depends if current plumbing already takes care of reflogs for normal 
operations.

>  (1) When would you "auto" write-tree?  When you do "git add" or anything
>      that adds new contents to the index?  Or immediately before you do
>      something destructive like "git reset"?  Or perhaps both?

Delaying any IO until it is clear that something is to be discarded is 
the best approach performance wise.  So perhaps not on the first 'git 
add' but certainly on the second one with an already cached path for 
which new (different) content is going to replace previous content.

>  (2) Enumerate the operations that falls into the category you decided in
>      the above question.  For example, "git apply --index" and "git apply
>      --cached" would fall into the same category as "git add".  If you
>      cover plumbing, you would also need to cover "git update-index".

Plumbing should probably have the mechanism to create those trash 
reflogs if desired, but not active by default.  Plumbing is normally for 
scripts, and once a script is debugged it shouldn't discard data by 
mistake.  Let's not forget that this is a feature for mistake inducing 
humans.

>  (3) What should happen when you cannot write the index out as a tree?  I
>      think it is easier to make mistakes during a conflicted merge
>      resolution than during a straight linear development of your own, and
>      one of the cases that would benefit most would be that you have
>      resolved a path to your satisfaction but then later you screw up
>      while resolving some other paths, losing an earlier resolution.

This one is tricky.  Maybe storing two reflog entries corresponding to 
the unresolved stages?


Nicolas
