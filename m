From: Johan Herland <johan@herland.net>
Subject: Re: bug in git notes fanout
Date: Wed, 03 Nov 2010 00:36:28 +0100
Message-ID: <201011030036.28318.johan@herland.net>
References: <AANLkTi=JfwJq8wq_1an014WO+A_Dwp5cDKa+xHi10awr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Nov 03 00:37:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDQQJ-0006ES-Un
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 00:37:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665Ab0KBXgu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Nov 2010 19:36:50 -0400
Received: from smtp.getmail.no ([84.208.15.66]:40365 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751003Ab0KBXgt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Nov 2010 19:36:49 -0400
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LBA005DU6WVEI80@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Wed, 03 Nov 2010 00:36:31 +0100 (MET)
Received: from get-mta-scan01.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 840B51799090_CD0A07EB	for <git@vger.kernel.org>; Tue,
 02 Nov 2010 23:36:30 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id C62801797F7D_CD0A07DF	for <git@vger.kernel.org>; Tue,
 02 Nov 2010 23:36:29 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LBA00BY66WTZP00@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 03 Nov 2010 00:36:29 +0100 (MET)
User-Agent: KMail/1.13.5 (Linux/2.6.35-ARCH; KDE/4.5.2; x86_64; ; )
In-reply-to: <AANLkTi=JfwJq8wq_1an014WO+A_Dwp5cDKa+xHi10awr@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160565>

On Tuesday 02 November 2010, Shawn Pearce wrote:
> Why doesn't the fan-out work for this case?
> 
>   git notes --ref buggy.fanout add -m test HEAD
>   perl -e 'for($i=0;$i<1024;$i++){printf "%s %s%4.4x\n", $ARGV[0],
> "0"x36, $i}' $(git rev-parse HEAD) | git notes --ref buggy.fanout copy
> --stdin
>   git ls-tree refs/notes/buggy.fanout
> 100644 blob ...	0000000000000000000000000000000000000000
> 100644 blob ...	0000000000000000000000000000000000000001
> 100644 blob ...	0000000000000000000000000000000000000002
> 100644 blob ...	0000000000000000000000000000000000000003
> ...
> 100644 blob ...	000000000000000000000000000000000000018c
> ...
> 100644 blob ...	00000000000000000000000000000000000003e1
> ...
> 100644 blob ...	00000000000000000000000000000000000003e2
> ...
> 100644 blob ...	00000000000000000000000000000000000003fd
> 100644 blob ...	00000000000000000000000000000000000003fe
> 100644 blob ...	00000000000000000000000000000000000003ff
> 100644 blob ...	638d3d9244720e0f07f22a953d25db878e9ad3f5

Yes, for your extremely far-fetched testcase, the current implementation is 
pessimal. However, please, consider exactly _what_ the notes tree contains. 
Yes, that's right: SHA1 sums. Now, try to come up with a real-world scenario 
where your notes tree would end up looking like the above.

I guess the same "problem" exists with the 2/38 fanout that is done for 
loose objects in .git/objects/. If you happen to only add objects whose SHA1 
start with 00..., you will get worst case behaviour there as well. Again, if 
you can construct a real-world testcase for this, I am probably not the only 
one interested in looking at it...

> I thought the entire points of the notes fanout being 0/40, 2/38,
> 2/2/36, 2/2/2/34 was to prevent git from having a big linear search
> within any single tree when a large number of notes are added to a
> note branch.

Yes, and by assuming that SHA1 gives a fairly uniform distribution of keys 
(a pretty safe assumption if the rest of Git's design is anything to go by), 
we can conclude that the large number of keys would be fairly evenly spread 
out across the notes tree.

> IIRC when the notes stuff was being debated on this list we insisted
> that the fan-out algorithm had to be consistent, ensuring that if I
> create a note for 638d3d92 and Junio creates a note on the same
> object, they will wind up at the same path in the notes, and we won't
> have doppleganger notes (two different notes in the same tree with the
> same object).

Let's separate the cases here:

A. There is absolutely no guarantee that two different notes trees will 
place a note for 638d3d92 at the same location/path. I.e. if you add a note 
to your notes tree, and Junio adds one to his, they might end up at 
different paths. This depends on how many, and which other notes are in your 
respective notes trees.

B. When combining/merging those notes tree, the notes code _does_ guarantee 
that there won't be doppelganger notes. I.e. if you're both working in the 
same notes tree (in the same repo), the notes code will not allow you to add 
two notes to 638d3d92 at different locations in the notes tree.

Of course you might artificially construct a notes tree that contains 
doppelganger notes, and the current implementation will successfully read 
that notes tree (combining the doppelganger notes using the configured 
combine_notes function), but - crucially - the notes code will _never_ 
generate a notes tree with doppelganger notes.

> Basically this issue arises because we are adding node support to
> JGit.  Our planned implementation would have inserted
> 00000000000000000000000000000000000003ff into
> 00/00/00/00/00/00/00/00/00/00/00/00/00/00/00/00/00/00/03/ff because
> there are so many notes that at each depth we wind up with >255
> entries, and split the tree again.  But that results in a very
> different structure from what the C implementation is doing today.
> 
> As far as I can tell from the C code, it won't split unless every hex
> digit in the 0..f range is used.  That is just a weird heuristic, and
> actual paths used depend on the actual SHA-1s that we add to the tree.

Read that sentence again. As explained above, since SHA1 provides a near-
uniform distribution, looking at hex digits in the 0..f range is a very 
inexpensive and moderately good heuristic to estimating whether it's time to 
make a split.

Granted, there might be better heuristics, and the current design allows us 
to implement such heuristics without making pre-existing notes trees 
invalid.

>  If I get "unlucky" and add 5 commits that start with "f" and never
> add one that starts with "0", I won't get fan-out, even though my
> notes tree has more than 256 items in it.

True, however, the uniform distribution of SHA1 pretty much guarantees that 
as you keep adding notes, you're going to get one that starts with "0", and 
then you'll get the needed split.


Hope this helps,

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
