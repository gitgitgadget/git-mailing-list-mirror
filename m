From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: packs and trees
Date: Tue, 20 Jun 2006 12:33:10 -0400
Message-ID: <9e4733910606200933p2e802954rdf50d5f0ac037677@mail.gmail.com>
References: <9e4733910606192257y1516e966t848a3b1e29e5667f@mail.gmail.com>
	 <46a038f90606192313l16b16132r1523f5e05ae1566a@mail.gmail.com>
	 <9e4733910606200735u5741a9adr83264ae7d51dd37@mail.gmail.com>
	 <1150816728.5382.27.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Martin Langhoff" <martin.langhoff@gmail.com>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 20 18:33:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsjAA-0000bz-TH
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 18:33:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbWFTQdM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Jun 2006 12:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbWFTQdM
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 12:33:12 -0400
Received: from nz-out-0102.google.com ([64.233.162.200]:38354 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751027AbWFTQdL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jun 2006 12:33:11 -0400
Received: by nz-out-0102.google.com with SMTP id s18so2075885nze
        for <git@vger.kernel.org>; Tue, 20 Jun 2006 09:33:11 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qNmW5rhtjWBHqtHNGx5mbK02W+YzasFVs5EZmV5/XV2uJSBYQAAfOPUb3DgzV4wePcF6XySzRJzOab7yiS0zdJrgo+vmENwe6iLQ5ASOaKqWKyButYyogilGgjn2zDjCs3ixcSpQwb11u2J1OhGte0kU5QpEZr7+6bS/pAUGxGQ=
Received: by 10.37.18.44 with SMTP id v44mr2500585nzi;
        Tue, 20 Jun 2006 09:33:10 -0700 (PDT)
Received: by 10.36.37.5 with HTTP; Tue, 20 Jun 2006 09:33:10 -0700 (PDT)
To: "Keith Packard" <keithp@keithp.com>
In-Reply-To: <1150816728.5382.27.camel@neko.keithp.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22212>

On 6/20/06, Keith Packard <keithp@keithp.com> wrote:
> > Even after spending eight hours building the changeset info iit is
> > still going to take it a couple of days to retrieve the versions one
> > at a time and write them to git. Reparsing 50MB delta files n^2/2
> > times is a major bottleneck for all three programs.
>
> The eight hours in question *were* writing out the deltas and packing
> the resulting trees. All that remained was to construct actual commit
> objects and write them out.
>
> The problem was that parsecvs's internals are structured so that this
> processes would take a large amount of memory, so I'm reworking the code
> to free stuff as it goes along.

How about writing out all of the revisions from the cvs file using the
yacc code the first time the file is encountered and parsed. Then you
only have to track git IDs and not all of those cumbersome CVS rev
numbers. When I was profiling parsecvs the hottest parts of the code
were extracting the revisions and comparing cvs rev numbers. Since the
git IDs are fixed size they work well in arrays and with pointer
compares for sorting. With the right data structure you should be able
to eliminate the CVS rev numbers that are so slow to deal with.

There are about 1M revisions in moz cvs. At eight byes for an ID and
eight bytes for a timestamp that is 16MB if ordering is achieved via
arrays. All of the symbols fit into 400K including pointers to their
revision. If the revs are written out as they are encountered there is
no need to save file names, but you do need one rev structure per
file. Throw in some more memory for relationship pointers. All of this
should fit into less than 100MB RAM.

>
> With a rewritten parsecvs, I'm hoping to be able to steal the algorithms
> from cvs2svn and stick those in place. Then work on truncating the
> history so it can deal with incremental updates to the repository, which
> I think will be straightforward if we stick a few breadcrumbs in the git
> repository to recover state from.
>
> --
> keith.packard@intel.com
>
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.3 (GNU/Linux)
>
> iD8DBQBEmBHYQp8BWwlsTdMRAvKAAJ9im3xBdUowt9af+/MtoYDXsCHGtACaAtG4
> GygX7WgiFOamLrnTMzWkIPE=
> =28dp
> -----END PGP SIGNATURE-----
>
>
>


-- 
Jon Smirl
jonsmirl@gmail.com
