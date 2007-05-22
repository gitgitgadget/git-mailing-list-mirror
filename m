From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH] git-pack-objects: cache small deltas between big objects
Date: Tue, 22 May 2007 00:01:10 -0700
Message-ID: <56b7f5510705220001q78b42d08kffd95d25c0af478e@mail.gmail.com>
References: <11796954641778-git-send-email-mkoegler@auto.tuwien.ac.at>
	 <56b7f5510705202135s8c9cd9qf4489b2b5bb2e264@mail.gmail.com>
	 <20070521175950.GA13818@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <junkio@cox.net>,
	danahow@gmail.com
To: "Martin Koegler" <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Tue May 22 09:01:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqOMv-00020b-R6
	for gcvg-git@gmane.org; Tue, 22 May 2007 09:01:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759150AbXEVHBN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 May 2007 03:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759201AbXEVHBM
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 03:01:12 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:22784 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759150AbXEVHBL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 03:01:11 -0400
Received: by ug-out-1314.google.com with SMTP id 44so182662uga
        for <git@vger.kernel.org>; Tue, 22 May 2007 00:01:10 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=apZ3Os4FKgosAEKBj2Wi32LmE6KWFJAWPIEBMg++NHwEy1Q115TXmkUalaCa9tK6dWtUirKjI5iX5pARCV8niy7of3rOGn+ik0U7r4ReevQdH1S+pJp6MGgJpT6ZKEswZe6hqi1qB+zurvqKfF5X7bTf01CUw0wobqS4N+xebwY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=O7ZXajjiKvBXd/h0JdX1hVMpQuoSp7PDCLHpnULmy92ubPdGRIirPLGDLK27XeBk5obBuZMbay7bQO+0qWjeByyqg3JdbBz9kwEnX2g8cFa2nO00bDieSN/NrANdxxzgx01fprpYMXMrBqvHFs1jHLEYVNOkKA4xrhDKhqWU5i8=
Received: by 10.78.118.5 with SMTP id q5mr1324714huc.1179817270427;
        Tue, 22 May 2007 00:01:10 -0700 (PDT)
Received: by 10.78.129.3 with HTTP; Tue, 22 May 2007 00:01:10 -0700 (PDT)
In-Reply-To: <20070521175950.GA13818@auto.tuwien.ac.at>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48082>

On 5/21/07, Martin Koegler <mkoegler@auto.tuwien.ac.at> wrote:
> On Sun, May 20, 2007 at 09:35:56PM -0700, Dana How wrote:
> > On 5/20/07, Martin Koegler <mkoegler@auto.tuwien.ac.at> wrote:
> > > This patch adds support for caching deltas from the deltifing phase, so
> > > that that the writing phase is faster.
> > >
> > > The caching is limited to small deltas to avoid increasing memory usage
> > > very much.
> > > The implemented limit is (memory needed to create the delta)/1024.
> >
> > Your limit is applied per-object,  and there is no overall limit
> > on the amount of memory not freed in the delta phase.
> > I suspect this caching would be disastrous for the large repo
> > with "megablobs" I'm trying to wrestle with at the moment.
>
> http://www.spinics.net/lists/git/msg31241.html:
> > At the moment I'm experimenting on a git repository with
> > a 4.5GB checkout,  and 18 months of history in 4K commits
> > comprising 100GB (uncompressed) of blobs stored in
> > 7 packfiles of 2GB or less. Hopefully I'll be able to say
> > more about tweaking packing shortly.
>
> I you have 100 GB of uncompressed data in your pack files, the cache
> limit is between 100MB and 200MB with the current policy.
Yes,  there is an implicit limit in your patch, and it would be
sufficient in my case.  It's still the case that there is no absolute
limit,  but perhaps you have to do something truly insane
for that to matter.

> The aim of my patch is to speed up pack writing without increasing
> memory usage very much, if you have blobs of some hundred MB size in
> your repository.
>
> The caching policy could be extended to speed more memory on caching
> other deltas. Ideas on this topic are welcome.
There _is_ something useful in your patch.
Unfortunately I don't think it helps my problem that much.

> PS: If you are trying to optimize packing speed/size, you could test
> the following patch: http://marc.info/?l=git&m=117908942525171&w=2
I remember this post -- I hope you continue to refine it.

What I've concluded is that there are cases where the packfile
treatment is just not appropriate for some part of the data.
[NOTE: I'm talking about disk storage here, not packs for communications.]
With the "delta" attribute Junio proposed,  and the "repack"
attribute I proposed in response,  we were starting to move in that
direction already.

The order of objects in the packfile(s) in my test repo after repacking
seems to be commit+ [ tree+ blob+ ]+, in other words,  the commits
are all at the beginning and the new tree blobs are interspersed amongst
the data blobs (this was imported with only straightline history, no branching).
If some of these blobs are enormous,  the tree blobs which are accessed
all the time get pushed apart.  This seemed to really hurt performance.

If I simply refuse to insert enormous blobs in the packfiles,  and keep
them loose,  the performance is better.  More importantly,  my packfiles
are now sized like everyone else's, so I'm in an operating regime which
everyone is testing and optimizing.  This was not true with 12GB+ of packfiles.
Of course, loose objects are slower, but slight extra overhead to access
something large enough to be noticeable already doesn't bother me.

Finally, loose objects don't get deltified.  This is a problem,  but I would
need to repack at least every week,  and nonzero window/depth would
be prohibitive with large objects included.  So if I put the large objects
in the packs,  not only are the large objects still undeltified, but everything
else is undeltified as well.  Note also that Perforce, what we're currently
using, doesn't deltify large objects either,  so people here who migrate
to git aren't going to lose anything, but they will gain compression
on the remaining "normal" objects (Perforce uses deltification or compression,
but not both).

So at the moment I'm finding keeping enormous objects loose
to be a reasonable compromise which keeps my packfiles
"normal" and imposes overheads only on objects whose size
already imposes an even larger overhead.

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
