From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH v2] git-p4: Ask "p4" to interpret View setting
Date: Sat, 24 Aug 2013 22:29:44 -0400
Message-ID: <20130825022944.GA16027@padd.com>
References: <CACGba4zdA=3tBE9UR=i9P9kNAL1HUc3UwSHbYeq4s9fwaN4=Mw@mail.gmail.com>
 <20130810201123.GA31706@padd.com>
 <CACGba4wbqyHzXDCQxG31EKawfc-D4jpVYqbB4GdmK4hM=Oi4mw@mail.gmail.com>
 <20130816012420.GA20985@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: kazuki saitoh <ksaitoh560@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 25 04:33:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDQ9F-0001xj-6E
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 04:33:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754976Ab3HYC3t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Aug 2013 22:29:49 -0400
Received: from honk.padd.com ([74.3.171.149]:50392 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754908Ab3HYC3s (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Aug 2013 22:29:48 -0400
Received: from arf.padd.com (unknown [50.105.10.190])
	by honk.padd.com (Postfix) with ESMTPSA id 991247098;
	Sat, 24 Aug 2013 19:29:47 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id E437822777; Sat, 24 Aug 2013 22:29:44 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20130816012420.GA20985@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232894>

pw@padd.com wrote on Thu, 15 Aug 2013 21:24 -0400:
> ksaitoh560@gmail.com wrote on Wed, 14 Aug 2013 09:59 +0900:
> > > My only concern is in the commit message, about performance.  A
> > > change that has lots of files in it will cause many roundtrips to
> > > p4d to do "p4 where" on each.  When the files don't have much
> > > edited content, this new approach will make the import take twice
> > > as long, I'll guess.  Do you have a big repository where you
> > > could test that?
> > 
> > I measured performance of "git p4 clone  --use-client-spec" with a
> > repository it has 1925 files, 50MB.
> >   Original:    8.05s user 32.02s system 15% cpu 4:25.34 total
> >   Apply patch:    9.02s user 53.19s system 14% cpu 6:56.41 total
> > 
> > It is acceptable in my situation, but looks quite slow...
> > 
> > Then I implemented one batch query version
> >    7.92s user 33.03s system 15% cpu 4:25.59 total
> > 
> > It is same as original
> > 
> > My additional patch is below.
> > I investigate call graph (attached rough sketch) and
> > implement batch query in "commit()" and "splitFilesIntoBranches()".
> > In addition, modified "map_in_client" to just search cache value.
> > 
> > Could you accept?
> 
> This looks good.  I've started my own performance testing
> on a few-hundred-thousand file repo to confirm your findings.
> 
> If it seems to work out, we can clean up the patch.  Otherwise
> maybe need to think about having both implementations and use
> the by-hand one for "...".  I don't like that approach.  Let's
> hope it's not needed.

I tried with a few repos:

Small repo, single-commit clone:

    Current:     0m0.35s user 0m0.30s sys 0m11.52s elapsed 5.69 %CPU
    No batching: 0m0.66s user 0m0.77s sys 0m34.42s elapsed 4.17 %CPU
    Batching:    0m0.28s user 0m0.29s sys 0m10.85s elapsed 5.27 %CPU

Big repo, single-commit clone:

    Current:     6m21.38s user 1m35.36s sys 19m44.83s elapsed 40.23 %CPU
    No batching: 1m53.13s user 24m34.35s sys 146m13.80s elapsed 18.09 %CPU (*)
    Batching:    6m22.01s user 1m44.23s sys 21m19.73s elapsed 37.99 %CPU

    The "no batching" run died with an unrelated p4 timeout.

Big repo, 1000 incremental changes:

    Current:     0m13.43s user 0m19.82s sys 11m12.58s elapsed 4.94 %CPU
    No batching: 0m20.29s user 0m39.94s sys 38m44.69s elapsed 2.59 %CPU (*)
    Batching:    0m16.15s user 0m26.60s sys 13m55.69s elapsed 5.11 %CPU

    The "no batching" run died at 28% of the way through.

There is probably a 20%-ish slowdown in my environment with this
approach.  But given that the timescale for these operations is
measured in the tens of minutes, I don't think a couple more matters
too much to anybody.

The attractiveness of the simplicity and increased client spec feature
coverage weighs in its favor.  Let's go ahead and inflict this on the
world and see what they think.

Do you have an updated patch?  Want to take some time to clean up and
resubmit the entire series?  The batching should be incorporated with
the last 2/2 that I sent out.

		-- Pete
