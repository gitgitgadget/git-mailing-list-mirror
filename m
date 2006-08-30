From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Mozilla .git tree
Date: Tue, 29 Aug 2006 21:51:22 -0400
Message-ID: <20060830015122.GE22935@spearce.org>
References: <9e4733910608290943g6aa79855q62b98caf4f19510@mail.gmail.com> <20060829165811.GB21729@spearce.org> <9e4733910608291037k2d9fb791v18abc19bdddf5e89@mail.gmail.com> <20060829175819.GE21729@spearce.org> <9e4733910608291155g782953bbv5df1b74878f4fcf1@mail.gmail.com> <20060829190548.GK21729@spearce.org> <9e4733910608291252q130fc723r945e6ab906ca6969@mail.gmail.com> <20060829232007.GC22935@spearce.org> <9e4733910608291807q9b896e4sdbfaa9e49de58c2b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 30 03:51:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIFFD-0004yu-Fj
	for gcvg-git@gmane.org; Wed, 30 Aug 2006 03:51:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbWH3Bvw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Aug 2006 21:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbWH3Bvw
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Aug 2006 21:51:52 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:18874 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751148AbWH3Bvv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Aug 2006 21:51:51 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GIFEv-0007MJ-Pu; Tue, 29 Aug 2006 21:51:38 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0EB3320FB7F; Tue, 29 Aug 2006 21:51:22 -0400 (EDT)
To: Jon Smirl <jonsmirl@gmail.com>
Content-Disposition: inline
In-Reply-To: <9e4733910608291807q9b896e4sdbfaa9e49de58c2b@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26218>

Jon Smirl <jonsmirl@gmail.com> wrote:
> I suspect the bulk of the file will be the base blobs. A zlib
> dictionary would help more with the trees and the 120K copies of the
> GPL in the files.

Here's what I got by taking the output of verify-pack -v run
against the 430 MiB Mozilla pack and running that through a simple
Perl script:

  COUNT  BASE  commit: 197613
  COUNT  BASE  tree:   154496
  COUNT  BASE  blob:    49860
  COUNT  BASE  tag:      1203
  COUNT  DELTA commit:   3308
  COUNT  DELTA tree:   976712
  COUNT  DELTA blob:   579780
  COUNT  DELTA tag:       353

Those are just raw numbers of objects of each type broken out by
base and delta.  We gotta alotta objects.  :-)

We probably also have around 49,860 copies of the identical license
text (one per base object).  I'm just assuming the xdelta algorithm
would recognize the identical run in the dependent object and
copy it from the base rather than use a literal insert command.
Thus I'm assuming the 579,780 deltas don't contain the license text.

  UNCOMP BASE  commit: 55 MiB
  UNCOMP BASE  tree:   30 MiB
  UNCOMP BASE  blob:  597 MiB
  UNCOMP BASE  tag:     0 MiB
  UNCOMP DELTA commit:  0 MiB
  UNCOMP DELTA tree:   44 MiB
  UNCOMP DELTA blob:  190 MiB
  UNCOMP DELTA tag:     0 MiB

These are the sizes of the objects and deltas prior to using zlib
to deflate them (aka the decompression buffer size, stored in the
object header).

  ZIPPED BASE  commit: 38 MiB
  ZIPPED BASE  tree:   26 MiB
  ZIPPED BASE  blob:  164 MiB
  ZIPPED BASE  tag:     0 MiB
  ZIPPED DELTA commit : 0 MiB
  ZIPPED DELTA tree:   73 MiB
  ZIPPED DELTA blob:  126 MiB
  ZIPPED DELTA tag:     0 MiB

These are the sizes of the objects within the pack, determined by
computing the difference in adjacent objects' offsets.


55 MiB of commits compressed into 38 MiB (saved 30%).
We can probably do better.

30 MiB of tree bases compressed into 26 MiB (saved 13.3%).
With 154,496 tree bases I think we can do better _somehow_.  It may
just mean using more deltas so we have less bases.  We don't have
154k unique directories.  It may just mean using a tree specific
pack dictionary is enough.

44 MiB of tree deltas compressed into 73 MiB (saved -65.9%).
Ouch!  We wasted 29 MiB by trying to compress tree deltas.
Way to go zlib!

Blob bases were 597 MiB uncompressed, 164 MiB compressed (saved 72%).
Blob deltas were 190 MiB uncompressed, 126 MiB compressed (saved 33%).
We might be able to do better here, but we're already fairing pretty
well.


To compare a .tar.gz of the ,v files from CVS is around 550 MiB.
We're already smaller than that in a pack file.  But ,v is not the
most compact representation.  I hoped we could do even better than
430 MiB.


I ran the same script against my Git pack.  There I'm seeing the
same explosion of tree deltas: uncompressed they are 1380174 bytes,
compressed they are 1620439 bytes (-17.4% saved).

We may well have a general problem here with always compressing
tree deltas.  It appears to be a minor dent in the space required
for a pack but its certainly a non-trivial amount on the larger
Mozilla pack.  The wasted space is 2% of the Git pack and its 6.7%
of the Mozilla pack.

-- 
Shawn.
