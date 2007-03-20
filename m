From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: New index-pack "keep" violates "never overwrite"
Date: Tue, 20 Mar 2007 01:38:13 -0400
Message-ID: <20070320053813.GC29288@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 20 06:38:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTX37-0002ck-BX
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 06:38:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933594AbXCTFiS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 01:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933608AbXCTFiS
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 01:38:18 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38452 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933594AbXCTFiR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 01:38:17 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HTX31-0000p1-8C
	for git@vger.kernel.org; Tue, 20 Mar 2007 01:38:15 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0CB3B20FBAE; Tue, 20 Mar 2007 01:38:14 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42712>

This is something that has been bothering me for several weeks now.

Waaaaaaay back Git was considered to be secure as it never overwrote
an object it already had.  This was ensured by always unpacking the
packfile received over the network (both in fetch and receive-pack)
and our already existing logic to not create a loose object for an
object we already have.

Lately however we keep "large-ish" packfiles on both fetch and push
by running them through index-pack instead of unpack-objects.  This
would let an attacker perform a birthday attack. 

How?  Assume the attacker knows a SHA-1 that has two different
data streams.  He knows the client is likely to have the "good"
one.  So he sends the "evil" variant to the other end as part of
a "large-ish" packfile.  The recipient keeps that packfile, and
indexes it.  Now since this is a birthday attack there is a SHA-1
collision; two objects exist in the repository with the same SHA-1.
They have *very* different data streams.  One of them is "evil".

Currently the poor recipient cannot tell the two objects apart,
short of by examining the timestamp of the packfiles.  But lets
say the recipient repacks before he realizes he's been attacked.
We may wind up packing the "evil" version of the object, and deleting
the "good" one.  This is made *even more likely* by Junio's recent
rearrange_packed_git patch (b867092f).

SHA-1 is generally considered to be broken, as there have been some
attacks implemented where a massive amount of garbage is injected
into a comment, producing a source file that a compiler/interpreter
can still process just fine, but that contains "evil bits of code"
and has the same hash as a "non-evil" version of that same file.
Yes, of course, if you look at the comment you would immediately
realize its crap.  You probably would even realize the file is crap
just by looking at the file size, as typically several megabytes
of garbage is required.

But how likely are you to look at a file content, or even size,
during say git-bisect?  Especially on a large project?  Would you
really notice that "usb.c" took 3 seconds longer than normal to
compile because the preprecessor had to wade through a gigantic
garbage comment?


We broke a fundemental assumption in the Git security model, and I
don't think anyone blinked.  Oops.  Either the SHA-1 birthday attack
I just described is still thought to be a non-issue for at least
the next few years (due to current computing power limitations),
or we all missed that one, big time.

The fix does appear to be simple.  Just don't write the existing
object to the output packfile.  But really that is a lot more like
what unpack-objects does: buffer deltas we cannot resolve yet, and
only write out what we cannot find through our ODB.  The logic in
index-pack ain't built for that...


For those that are really paranoid about this, you can disable the
pack keeping by setting transfer.unpackLimit to a *huge* value,
one that is far larger than any packfile you might receive.

-- 
Shawn.
