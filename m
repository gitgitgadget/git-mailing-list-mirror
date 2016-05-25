From: Eric Wong <e@80x24.org>
Subject: Re: [BUG] t9801 and t9803 broken on next
Date: Wed, 25 May 2016 22:49:07 +0000
Message-ID: <20160525224907.GA18894@dcvr.yhbt.net>
References: <3A110437-F778-42E2-A987-86B4EAB3D963@gmail.com>
 <20160513103621.GA12329@dcvr.yhbt.net>
 <xmqqpospap8g.fsf@gitster.mtv.corp.google.com>
 <4830D469-3885-4010-9A04-D809F0C6159D@gmail.com>
 <xmqq37pk8q0h.fsf@gitster.mtv.corp.google.com>
 <5E7631C9-DD59-4358-B907-D7C7AEA1739C@gmail.com>
 <20160517121330.GA7346@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Luke Diamand <luke@diamand.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 26 00:49:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5hcV-0002mO-0n
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 00:49:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752312AbcEYWtj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 18:49:39 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:42594 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752275AbcEYWti (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 18:49:38 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94B471FCC6;
	Wed, 25 May 2016 22:49:37 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20160517121330.GA7346@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295608>

Jeff King <peff@peff.net> wrote:
> On Tue, May 17, 2016 at 10:07:16AM +0200, Lars Schneider wrote:
> 
> > I think that is pretty much the problem. Here is what is happening:
> > 
> > 1.  git-p4 imports all changelists for the "main" branch
> > 
> > 2.  git-p4 starts to import a second branch and creates a fast-import
> >     "progress checkpoint". This triggers:
> > 
> >     --> fast-import.c: cycle_packfile
> >     --> fast-import.c: end_packfile
> >     --> fast-import.c: loosen_small_pack
> > 
> >     At this point we have no packfile anymore.
> > 
> > 3.  git-p4 sends the command "commit refs/remotes/p4/depot/branch2"
> >     to fast-import in order to create a new branch. This triggers:
> > 
> >     --> fast-import.c: parse_new_commit
> >     --> fast-import.c: load_branch
> >     --> fast-import.c: load_tree
> > 
> >     "load_tree" calls "find_object" and the result has a "pack_id" of 0.
> >     I think this indicates that the object is in the packfile. Shouldn't
> >     the "pack_id" be "MAX_PACK_ID" instead?

Yes; I think that is correct.  Alternative patch to Jeff's
coming in reply to this message.

> >         myoe = find_object(sha1);
> >         if (myoe && myoe->pack_id != MAX_PACK_ID) {
> 
> Thanks for the analysis. I think this is definitely the problem.  After
> fast-import finalizes a packfile (either at the end of the program or
> due to a checkpoint), it never discards its internal mapping of objects
> to pack locations. It _has_ to keep such a mapping before the pack is
> finalized, because git's regular object database doesn't know about it.
> But afterwards, it should be able to rely on the object database.

Almost; but relying on marks is a problem since that set can contain
mark => object_entry mappings which the normal object database won't
know about.

> The patch below probably makes your case work, but there are a lot of
> open questions:
> 
>   1. Should we always discard the mapping, even when not loosening
>      objects? I can't think of a real downside to always using git's
>      object lookups.

I'm not sure.  It's safe to clear the top-level table, but it
might speedup some lookups for just oe->type if we keep it
around.

I decided to keep it, anyways, because the mark set references them.

>   2. Can we free memory associated with object_entry structs at this
>      point? They won't be accessible via the hash, but might other bits
>      of the code have kept pointers to them?

Yes, invalid entries are also held in "struct mark_set marks";
this is a major problem with merely clearing the top-level
object table.

>      I suspect it may screw up the statistics that fast-import prints at
>      the end, but that's a minor point.

I still need to check, on that; but yeah, minor.

>   3. I notice that a few other structs (branch and tag) hold onto the
>      pack_id, which will now point to a pack we can't access. Does this
>      matter? I don't think so, because checkpoint() seems to dump the
>      branches and tags.

I don't think it matters unless a crash log or core dump is
created; then it becomes confusing to the person tracking down a
problem, so I've invalidated pack_id.  This doesn't affect
dump_branches or dump_tags from what I can tell.

>   4. In general, should we be loosening objects at checkpoints at all?

I think so.  It should be useful to checkpoint to make objects
available to other read-only processes while leaving a
fast-import running indefinitely.
