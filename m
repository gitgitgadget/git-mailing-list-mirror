From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: [RFC] Optimize diff-delta.c
Date: Fri, 4 May 2007 08:40:24 +0200
Message-ID: <20070504064024.GA11788@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri May 04 08:40:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjrSx-0001Qe-7L
	for gcvg-git@gmane.org; Fri, 04 May 2007 08:40:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767678AbXEDGk2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 4 May 2007 02:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767688AbXEDGk2
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 02:40:28 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:33256 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767678AbXEDGk0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 02:40:26 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 3CDFC680C1D2;
	Fri,  4 May 2007 08:40:25 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IRYGGhPYxBY2; Fri,  4 May 2007 08:40:24 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id A37166800099; Fri,  4 May 2007 08:40:24 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46133>

On 2007-05-01 16:05:24, Nicolas Pitre wrote:
> > On Tue, 1 May 2007, Martin Koegler wrote:
> Right.  I think it would be a good idea to extend the delta format as=
=20
> well to allow for larger offsets in pack v4.

Is git://repo.or.cz/git/fastimport.git#sp/pack4 the current version of
pack v4 efforts?

> > The delta index has approximately the same size in memory as the
> > uncompressed blob ((blob size)/16*(sizeof(index_entry)).
>=20
> One thing that could be done with really large blobs is to create a=20
> sparser index, i.e. have a larger step than 16.  Because the delta ma=
tch=20
> loop scans backward after a match the sparse index shouldn't affect=20
> compression that much on large blobs and the index could be=20
> significantly smaller.

In the long term, I think, that the delta generation code needs to get
tunable.

I would add a init_delta function for reading the configuration
options. In create_delta and create_delta_index, different delta
heuristics can be selected based on the blob size and the
configuration options. As patch_delta is not affected by this, it
should be easy to integrate new stragegies.

> > I tried to speed up the delta generation by searching for a common=20
> > prefix, as my blobs are mostly append only. I tested it with about=20
> > less than 1000 big blobs. The time for finding the deltas decreased=
=20
> > from 17 to 14 minutes cpu time.
>=20
> I'm surprised that your patch makes so much of a difference.  Normall=
y=20
> the first window should always match in the case you're trying to=20
> optimize and the current code should already perform more or less the=
=20
> same as your common prefix match does.

A block is limited to 64k. If the file has some hundred MBs, it has to
match many blocks.

My patch can process everything except the few last thousand lines by
doing a memcmp.

Additionally, nearly every line starts with the same, longer than 16
byte prefix. So its likely, that many blocks map to the same hash
value.

> Ah, no, actually what your patch does is a pessimisation of the match=
ing=20
> code by not considering other and possibly better matches elsewhere i=
n=20
> the reference buffer whenever there is a match at the beginning of bo=
th=20
> buffers.  I don't think this is a good idea in general.

=46or small files, I agree with you.

> What you should try instead if you want to make the process faster is=
 to=20
> lower the treshold used to consider a match sufficiently large to sto=
p=20
> searching.  That has the potential for even faster processing as the=20
> "optimization" would then be effective throughout the buffer and not=20
> only at the beginning.
>=20
[...]
>=20
> You could experiment with that value to determine the best speed vs s=
ize=20
> compromize.

I will do some experiments.

mfg Martin K=F6gler
PS: Sorry for break threading, as you did not CC me.
