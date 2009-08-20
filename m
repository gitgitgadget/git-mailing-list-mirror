From: Sam Vilain <sam@vilain.net>
Subject: Re: Continue git clone after interruption
Date: Thu, 20 Aug 2009 12:26:38 +1200
Message-ID: <1250727998.5867.185.camel@maia.lan>
References: <1250509342.2885.13.camel@cf-48>
	 <200908191719.52974.jnareb@gmail.com>
	 <alpine.LFD.2.00.0908191326360.6044@xanadu.home>
	 <200908192142.51384.jnareb@gmail.com>
	 <alpine.LFD.2.00.0908191552020.6044@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Tomasz Kontusz <roverorna@gmail.com>,
	git <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Aug 20 02:24:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdvRt-0000i9-27
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 02:24:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753380AbZHTAYD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 20:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752781AbZHTAYD
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 20:24:03 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:42173 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752543AbZHTAYB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 20:24:01 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 97A4421D161; Thu, 20 Aug 2009 12:24:01 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.69.233] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 1803121CE41;
	Thu, 20 Aug 2009 12:23:56 +1200 (NZST)
In-Reply-To: <alpine.LFD.2.00.0908191552020.6044@xanadu.home>
X-Mailer: Evolution 2.24.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126598>

On Wed, 2009-08-19 at 17:13 -0400, Nicolas Pitre wrote:
> > It's the "cheaply deepen history" that I doubt would be easy.  This is
> > the most difficult part, I think (see also below).
> 
> Don't think so.  Try this:
> 
> 	mkdir test
> 	cd test
> 	git init
> 	git fetch --depth=1 git://git.kernel.org/pub/scm/git/git.git
> 
> REsult:
> 
> remote: Counting objects: 1824, done.
> remote: Compressing objects: 100% (1575/1575), done.
> Receiving objects: 100% (1824/1824), 3.01 MiB | 975 KiB/s, done.
> remote: Total 1824 (delta 299), reused 1165 (delta 180)
> Resolving deltas: 100% (299/299), done.
> From git://git.kernel.org/pub/scm/git/git
>  * branch            HEAD       -> FETCH_HEAD
> 
> You'll get the very latest revision for HEAD, and only that.  The size 
> of the transfer will be roughly the size of a daily snapshot, except it 
> is fully up to date.  It is however non resumable in the event of a 
> network outage.  My proposal is to replace this with a "git archive" 
> call.  It won't get all branches, but for the purpose of initialising 
> one's repository that should be good enough.  And the "git archive" can 
> be fully resumable as I explained.
> 
> Now to deepen that history.  Let's say you want 10 more revisions going 
> back then you simply perform the fetch again with a --depth=10.  Right 
> now it doesn't seem to work optimally, but the pack that is then being 
> sent could be made of deltas against objects found in the commits we 
> already have.  Currently it seems that a pack that also includes those 
> objects we already have in addition to those we want is created, which 
> is IMHO a flaw in the shallow support that shouldn't be too hard to fix.  
> Each level of deepening should then be as small as standard fetches 
> going forward when updating the repository with new revisions.

Nicholas, apart from starting with most recent commits and working
backwards, this is very similar to the "bundle slicing" idea defined in
GitTorrent.  What the GitTorrent research project has so far achieved is
defining a slicing algorithm, and figuring out how well slicing works,
in terms of wasted bandwidth.

If you do it right, then you can support download spreading across
mirrors, too.  Eg, given a starting point, a 'slice size' - which I
based on uncompressed object size but could as well be based on commit
count - and a slice number to fetch, you should be able to look up in
the revision list index the revisions to select and then make a thin
pack corresponding to those commits.  Currently creating this index is
the slowest part of creating bundle fragments in my Perl implementation.

Once Nick Edelen's project is mergeable, we have a mechanism for being
able to relatively quickly draw a manifest of objects for these slices.

So how much bandwidth is lost?

Eg, for git.git, taking the complete object list, slicing it into 1024k
(uncompressed) bundle slices, and making thin packs from those slices we
get:

Generating index...
Length is 1291327524, 1232 blocks
Slice #0: 1050390 => 120406 (11%)
Slice #1: 1058162 => 124978 (11%)
Slice #2: 1049858 => 104363 (9%)
...
Slice #51: 1105090 => 43140 (3%)
Slice #52: 1091282 => 45367 (4%)
Slice #53: 1067675 => 39792 (3%)
...
Slice #211: 1086238 => 25451 (2%)
Slice #212: 1055705 => 31294 (2%)
Slice #213: 1059460 => 7767 (0%)
...
Slice #1129: 1109209 => 38182 (3%)
Slice #1130: 1125925 => 29829 (2%)
Slice #1131: 1120203 => 14446 (1%)
Final slice: 623055 => 49345
Overall compressed: 39585851
Calculating Repository bundle size...
Counting objects: 107369, done.
Compressing objects: 100% (28059/28059), done.
Writing objects: 100% (107369/107369), 29.20 MiB | 48321 KiB/s, done.
Total 107369 (delta 78185), reused 106770 (delta 77609)
Bundle size: 30638967
Overall inefficiency: 29%

In the above output, the first figure is the complete un-delta'd,
uncompressed size of the slice - that is, the size of all of the new
objects that the commit introduces.  The second figure is the full size
of a thin pack with those objects in it.  ie the above tells me that in
git.git there are 1.2GB of uncompressed objects.  Each slice ends up
varying in size between about 10k and 200k, but most of the slices end
up between 15k and 50k.

Actually the test script was thrown off by a loose root and that added
about 3MB to the compressed size, so the overall inefficiency with this
block size is actually more like 20%.  I think I am running into the
flaw you mention above, too, especially when I do a larger block size
run:

Generating index...
Length is 1291327524, 62 blocks
Slice #0: 21000218 => 1316165 (6%)
Slice #1: 20988208 => 1107636 (5%)
...
Slice #59: 21102776 => 1387722 (6%)
Slice #60: 20974960 => 876648 (4%)
Final slice: 6715954 => 261218
Overall compressed: 50071857
Calculating Repository bundle size...
Counting objects: 107369, done.
Compressing objects: 100% (28059/28059), done.
Writing objects: 100% (107369/107369), 29.20 MiB | 48353 KiB/s, done.
Total 107369 (delta 78185), reused 106770 (delta 77609)
Bundle size: 30638967
Overall inefficiency: 63%

Somehow we made larger packs but the total packed size was larger.

Trying with 100MB "blocks" I get:

Generating index...
Length is 1291327524, 13 blocks
Slice #0: 104952661 => 4846553 (4%)
Slice #1: 104898188 => 2830056 (2%)
Slice #2: 105007998 => 2856535 (2%)
Slice #3: 104909972 => 2583402 (2%)
Slice #4: 104909440 => 2187708 (2%)
Slice #5: 104859786 => 2555686 (2%)
Slice #6: 104873317 => 2358914 (2%)
Slice #7: 104881597 => 2183894 (2%)
Slice #8: 104863418 => 3555224 (3%)
Slice #9: 104896599 => 3192564 (3%)
Slice #10: 104876697 => 3895707 (3%)
Slice #11: 104903491 => 3731555 (3%)
Final slice: 32494360 => 1270887
Overall compressed: 38048685
Calculating Repository bundle size...
Counting objects: 107369, done.
Compressing objects: 100% (28059/28059), done.
Writing objects: 100% (107369/107369), 29.20 MiB | 48040 KiB/s, done.
Total 107369 (delta 78185), reused 106770 (delta 77609)
Bundle size: 30638967
Overall inefficiency: 24%

In the above, we broke the git.git download into 13 partial downloads of
a few meg each, at the expense of an extra 24% of download.

Anyway I've hopefully got more to add to this but this will do for a
starting point.

Sam
