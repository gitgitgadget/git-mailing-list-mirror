X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: fetching packs and storing them as packs
Date: Sat, 28 Oct 2006 23:50:25 -0400
Message-ID: <20061029035025.GC3435@spearce.org>
References: <Pine.LNX.4.64.0610252333540.12418@xanadu.home> <4540CA0C.6030300@tromer.org> <Pine.LNX.4.64.0610271310450.3849@g5.osdl.org> <7v3b99e87c.fsf@assigned-by-dhcp.cox.net> <20061028034206.GA14044@spearce.org> <Pine.LNX.4.64.0610272109500.3849@g5.osdl.org> <7vwt6l9etn.fsf@assigned-by-dhcp.cox.net> <20061028072146.GB14607@spearce.org> <20061028084001.GC14607@spearce.org> <7vfyd88d6s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 29 Oct 2006 03:50:34 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vfyd88d6s.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30410>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ge1gu-0007pY-9l for gcvg-git@gmane.org; Sun, 29 Oct
 2006 04:50:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964978AbWJ2Du3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 28 Oct 2006
 23:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964980AbWJ2Du3
 (ORCPT <rfc822;git-outgoing>); Sat, 28 Oct 2006 23:50:29 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:56530 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S964978AbWJ2Du3
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2006 23:50:29 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Ge1gc-0006Rx-SZ; Sat, 28 Oct 2006 23:50:15 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 E461620E45B; Sat, 28 Oct 2006 23:50:25 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> > Shawn Pearce <spearce@spearce.org> wrote:
> >> Why not just use create a new flag file?
> >> 
> >> Lets say that a pack X is NOT eligible to be repacked if
> >> "$GIT_DIR/objects/pack/pack-X.keep" exists.
> >
> > Here's the `git repack -a -d` portion of that.
> > Thoughts?
> 
> > +	args=--unpacked
> > +	active=
> > +	if test -d "$PACKDIR"
> > +	then
> > +		for p in `find "$PACKDIR" -type f -name '*.pack' -print`
> 
> This change to run 'find "$PACKDIR"' is fragile when your
> $GIT_OBJECT_DIRECTORY has $IFS in it; running "find ." after
> "cd" in a subprocess was done very much on purpose to avoid that
> issue.  Please don't break it.

I only broke it because you backed me into a corner with --unpacked=
:-)

The issue is --unpacked= uses the path of the pack name, which
includes $GIT_OBJECT_DIRECTORY, whatever that may be.  This makes it
impossible for the shell script to hand through a proper --unpacked=
line for the active packs without including $GIT_OBJECT_DIRECTORY
as part of the option.

I agree with you about the $IFS issue.  I'll redraft this patch
tonight such that $IFS doesn't get broken here but that's going
to take a small code patch over in revisions.c, which I'll also
do tonight.

> > +	if test "X$args" = X--unpacked
> > +	then
> > +		args='--unpacked --incremental'
> > +	fi
 
> I do not remember offhand what --incremental meant, but
> presumably this is for the very initial "repack" (PACKDIR did
> not exist or find loop did not find anything to repack) and the
> flag would not make a difference?  Care to explain?
 
I think there is a bug in pack-objects but I couldn't find it last
night.  Using --incremental worked around it.  :-)

According to the documentation:

  --unpacked tells pack-objects to only pack loose objects.

  --incremental tells pack-objects to skip any object that is
  already contained in a pack even if it appears in the input list.

What I really wanted here was to just use '--unpacked'; if there
are no active packs and the user asked for '-a' we actually just
want to pack the loose objects into a new active pack as we aren't
allowed to touch any of the existing packs (they are all kept or
there simply aren't any packs yet).

However on the git.git repository if I ran `git repack -a -d`
with every single object in a kept pack and no loose objects I kept
repacking the same 102 objects into a new active pack, even though
there were no loose objects to repack and no active packs.  Uh, yea.

Adding --incremental in this case kept it from repacking those
same 102 objects on every invocation.  Yea, its a bug.  I meant to
mention it in my email.

-- 
