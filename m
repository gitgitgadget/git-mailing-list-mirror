From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH] git-pack-objects: cache small deltas between big objects
Date: Tue, 22 May 2007 02:25:24 -0700
Message-ID: <56b7f5510705220225m754a7e8fmb90a0cc0200060d3@mail.gmail.com>
References: <11796954641778-git-send-email-mkoegler@auto.tuwien.ac.at>
	 <56b7f5510705202135s8c9cd9qf4489b2b5bb2e264@mail.gmail.com>
	 <20070521175950.GA13818@auto.tuwien.ac.at>
	 <56b7f5510705220001q78b42d08kffd95d25c0af478e@mail.gmail.com>
	 <7vhcq58et1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Martin Koegler" <mkoegler@auto.tuwien.ac.at>, git@vger.kernel.org,
	danahow@gmail.com
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 22 11:25:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqQcY-00032e-M5
	for gcvg-git@gmane.org; Tue, 22 May 2007 11:25:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755027AbXEVJZ1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 May 2007 05:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755571AbXEVJZ1
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 05:25:27 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:31970 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755027AbXEVJZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 05:25:26 -0400
Received: by ug-out-1314.google.com with SMTP id 44so216639uga
        for <git@vger.kernel.org>; Tue, 22 May 2007 02:25:24 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bcyt6sttZXRSd3iurJg4gfDG3A7V0K8WyKP2i/4m6ZCcDGlp577y4XIioEFEjZCjyeU7ZnJMBrqHM/542m+wbRGmEtGSOUKHi8oVUNmO+KuUCD0+3yRoGmdLCP8jBEPSHCIn25VbbsmwVymxPEJCmdzC66+rPJ3n85yM42p+HzU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZOsMAq+hhunzb6wLwGX7ans8/Rj1kl6AXpQ++nCyCpmgHCD0oUrMF6BRlBz0F4cf/AR/Kowa9pYGPwJm7smfoc+C/axqNoule5MQgBxULKNSgad6lnI1Kdql9uCQfokjpDUYEBCBWgkkkC+VAD2l3rr4pXusHhEyUXX1ImnuLN0=
Received: by 10.78.195.9 with SMTP id s9mr1348262huf.1179825924111;
        Tue, 22 May 2007 02:25:24 -0700 (PDT)
Received: by 10.78.129.3 with HTTP; Tue, 22 May 2007 02:25:24 -0700 (PDT)
In-Reply-To: <7vhcq58et1.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48088>

On 5/22/07, Junio C Hamano <junkio@cox.net> wrote:
> "Dana How" <danahow@gmail.com> writes:
> > If I simply refuse to insert enormous blobs in the packfiles,  and keep
> > them loose,  the performance is better.  More importantly,  my packfiles
> > are now sized like everyone else's, so I'm in an operating regime which
> > everyone is testing and optimizing.  This was not true with 12GB+ of packfiles.
> > Of course, loose objects are slower, but slight extra overhead to access
> > something large enough to be noticeable already doesn't bother me.
> >
> > Finally, loose objects don't get deltified.  This is a problem,  but I would
> > need to repack at least every week,  and nonzero window/depth would
> > be prohibitive with large objects included.
>
> Here are a few quick comments before going to bed.
>
>  * The objects in the packfile are ordered in "recency" order,
>    as "rev-list --objects" feeds you, so it is correct that we
>    get trees and blobs mixed.  It might be an interesting
>    experiment, especially with a repository without huge blobs,
>    to see how much improvement we might get if we keep the
>    recency order _but_ emit tags, commits, trees, and then
>    blobs, in this order.  In write_pack_file() we have a single
>    loop to call write_one(), but we could make it a nested loop
>    that writes only objects of each type.
Already tried that, almost.  Added a --types=[ctgb]+ flag to
pack-objects, and changed to git-repack to run in 2 passes
when -a && --max-pack-size.  The first pass would create
packfiles with all Commits/Trees/taGs [of course just 1],
the second made packfiles with just Blobs.  With a warm cache,
this was 3X to 7X slower than --max-blob-size= approach
(for the git-log --pretty=oneline example).  Why?  I'm guessing
because each lookup had to go through 7 index files instead of 1,
which would be significant when processing very small blobs
(commits and trees).  And the _slower_ one had window/depth=0/0,
so it had no delta expansion to do.

>  * Also my earlier "nodelta" attribute thing would be worth
>    trying with your repository with huge blobs, with the above
>    "group by object type" with further tweak to write blobs
>    without "nodelta" marker first and then finally blobs with
>    "nodelta" marker.
I started out enthusiastic about "nodelta",  causing me to
quickly propose "norepack" as well.  However, there is no
simple way in my repository to specify these.  Most of the
enormous files have certain suffixes,  but each of these
appears on a continuum of file sizes,  so I can't write
any *.sfx rules in .gitattributes.  I could make rules
specific to specific files,  but then I would have to write
scripts to auto-generate them.  (At commit time?)

Assuming I *could* get "nodelta" properly specified,
putting these last would help somewhat.  But we would
still be left with the problem caused by extra index files
(resulting from 2GB packfile limit).

> I suspect the above two should help "git log" and "git log --
> pathspec..."  performance, as these two do not look at blobs at
> all (pathspec limiting does invoke diff machinery, but that is
> only at the tree level).
>
> The "I want to have packs with reasonable size as everybody
> else" (which I think is a reasonable thing to want, but does not
> have much technical meaning as other issues do) wish is
> something we cannot _measure_ to judge pros and cons, ...
?? A depressingly large portion of my career has been spent
fooling optimization programs to work on new problems,  by
making the new problem look just like what they're used to.  So
wanting a program's input to look "conventional", or similar
to something in a regression,  seems pretty reasonable.
It's just the data-side version of preferring small changes in an algorithm.

> ... but with
> the above experiment, you could come up with three set of packs
> such that, all three sets use "nodelta" to leave the huge blobs
> undeltified, and use the default window and depth for others,
> and:
>
>  (1) One set has trees and blobs mixed;
>
>  (2) Another set has trees and blobs grouped, but "nodelta" blobs
>      and others are not separated;
>
>  (3) The third set has trees and blobs grouped, and "nodelta"
>      blobs and others are separated.
>
> Comparing (1) and (2) would show how bad it is to have huge
> blobs in between trees (which are presumably accessed more
> often).  I suspect that comparing (2) and (3) would show that
> for most workloads, the split is not worth it.
>
> And compare (3) with another case where you leave "nodelta"
> blobs loose.  That's the true comparison that would demonstrate
> why placing huge blobs in packs is bad and they should be left
> loose.  I'm skeptical if there will be significant differences,
> though.
I think the difference will come from at least the different number of
index files,
as pointed out above.  I can certainly start on these comparisons.

I must say,  getting the whole repository to repack -a under an hour
with great git-log performance after just a 55-line change was a much better
experience than the 10X larger max-pack-size patch...

BTW,  why the attachment to keeping *everything* in a packfile?
If I implement the changes above,  they will be more extensive than
max-blob-size (even max-pack-size only added *1* new nested loop
to pack-objects),  and they'll be climbing uphill due to the packfiles
being THREE orders of magnitude larger and the index files one
order of magnitude more numerous.

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
