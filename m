From: Alan Manuel Gloria <almkglor@gmail.com>
Subject: Re: Problem with large files on different OSes
Date: Thu, 28 May 2009 07:09:14 +0800
Message-ID: <f95910c20905271609u63d04965oa38b8af34d7704c1@mail.gmail.com>
References: <submission.1M9Gk0-0000N8-MQ@mail.cs.st-andrews.ac.uk>
	 <m3y6siboij.fsf@localhost.localdomain>
	 <alpine.LFD.2.01.0905270922250.3435@localhost.localdomain>
	 <alpine.LFD.2.01.0905270942580.3435@localhost.localdomain>
	 <alpine.LFD.2.00.0905271312220.3906@xanadu.home>
	 <20090527215314.GA10362@coredump.intra.peff.net>
	 <alpine.LFD.2.01.0905271457310.3435@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Nicolas Pitre <nico@cam.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Christopher Jefferson <caj@cs.st-andrews.ac.uk>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu May 28 01:09:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9SFS-0000Lu-6r
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 01:09:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756182AbZE0XJP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 May 2009 19:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755917AbZE0XJO
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 19:09:14 -0400
Received: from rv-out-0506.google.com ([209.85.198.234]:55485 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755718AbZE0XJN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 May 2009 19:09:13 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1553080rvb.1
        for <git@vger.kernel.org>; Wed, 27 May 2009 16:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wEEhtiSoQ3dxFBW7Faz2XNNloq4bIZ2xI9UjS4N8gtc=;
        b=ig//RnKaiYLJakktDoqUPwGDopd1B/AldjW4ii/z4JRjb8Ygqz0DdZO8m6glktNxMW
         xTPK7kQrlDxyxK2EpbOUYY236d/t5mKExV3OfYgs77EbD9TYFD1jOMMELTnBOy8hBiC/
         Z0JZOY9t9WyqC3GZvPsr6aIg6gGeRA7hwEpWA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tjQgy9/LGScDlOttQEcjo0XYAZ94Y3nxFvL8HErpUU9dgUql3vBalHuMK94mDueu1F
         HzUScEA0p13/8WodKNTmPUJH44YH58tj/RHvwywsRoNFywTX33MTuJVYY9A7NI6ev5UQ
         DKbhgF9exPb284Ms9ve9Lt0a+mSl+mTjJGYqI=
Received: by 10.143.6.19 with SMTP id j19mr195108wfi.338.1243465754617; Wed, 
	27 May 2009 16:09:14 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.01.0905271457310.3435@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120129>

On Thu, May 28, 2009 at 6:07 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>
> On Wed, 27 May 2009, Jeff King wrote:
>>
>> Linus' "split into multiple objects" approach means you could perhap=
s
>> split intelligently into metadata and "uninteresting data" sections
>> based on the file type.
>
> I suspect you wouldn't even need to. A regular delta algorithm would =
just
> work fairly well to find the common parts.
>
> Sure, if the offset of the data changes a lot, then you'd miss all th=
e
> deltas between two (large) objects that now have data that traverses
> object boundaries, but especially if the split size is pretty large (=
ie
> several tens of MB, possibly something like 256M), that's still going=
 to
> be a pretty rare event.
>
> IOW, imagine that you have a big file that is 2GB in size, and you pr=
epend
> 100kB of data to it (that's why it's so big - you keep prepending dat=
a to
> it as some kind of odd ChangeLog file). What happens? It would still =
delta
> fairly well, even if the delta's would now be:
>
> =A0- 100kB of new data
> =A0- 256M - 100kB of old data as a small delta entry
>
> and the _next_ chunk woul be:
>
> =A0- 100kB of "new" data (old data from the previous chunk)
> =A0- 256M - 100kB of old data as a small delta entry
>
> .. and so on for each chunk. So if the whole file is 2GB, it would be
> roughly 8 256MB chunks, and it would delta perfectly well: except for=
 the
> overlap, that would now be 8x 100kB "slop" deltas.
>
> So even a totally unmodified delta algorithm would shrink down the tw=
o
> copies of a ~2GB file to one copy + 900kB of extra delta.
>
> Sure, a perfect xdelta thing that would have treated it as one huge f=
ile
> would have had just 100kB of delta data, but 900kB would still be a *=
big*
> saving over duplicating the whole 2GB.
>
>> That would make things like rename detection very fast. Of course it=
 has
>> the downside that you are cementing whatever split you made into his=
tory
>> for all time. And it means that two people adding the same content m=
ight
>> end up with different trees. Both things that git tries to avoid.
>
> It's the "I can no longer see that the files are the same by comparin=
g
> SHA1's" that I personally dislike.
>
> So my "fixed chunk" approach would be nice in that if you have this k=
ind
> of "chunkblob" entry, in the tree (and index) it would literally be o=
ne
> entry, and look like that:
>
> =A0 100644 chunkblob <sha1>
>
> so you could compare two trees that have the same chunkblob entry, an=
d
> just see that they are the same without ever looking at the (humongou=
s)
> data.
>
> The <chunkblob> type itself would then look like just an array of SHA=
1's,
> ie it would literally be an object that only points to other blobs. K=
ind
> of a "simplified tree object", if you will.
>
> I think it would fit very well in the git model. But it's a nontrivia=
l
> amount of changes.
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Linus

I'd like to pitch in that our mother company uses Subversion, and they
consistently push very large binaries onto their Subvesion
repositories (I know it's not a good idea.  They do it nevertheless.
The very large binary is a description of a design in a proprietary
format by a proprietary tool; they don't want to keep running that
tool because of licensing etc issues, so they archive it on
Subversion).

I'm trying to convince the mother company to switch to git, mostly
because our company (the daughter company) doesn't have direct access
to their Subversion repo (we're in another country), and I've become
convinced that distributed repos like git are the way to go.  But the
fact that large binaries require me to turn off gc.auto and otherwise
avoid packing large filles makes my case a harder sell; quite a bit of
the mother company's workflow has been integrated with Subversion.

Note that in my case "large binary" is really a 164Mb file, but my
work system is a dual-core 512Mb computer, so I suppose my hardware is
really the limitation; still, some of the computers at the mother
company are even lousier.

If you'd prefer someone else to hack it, can you at least give me some
pointers on which code files to start looking?  I'd really like to
have proper large-file-packing support, where large file is anything
much bigger than a megabyte or so.

Admittedly I'm not a filesystems guy and I can just barely grok git's
blobs (they're the actual files, right? except they're named with
their hash), but not packs (err, a bunch of files?) and trees (brown
and green stuff you plant?).  Still, I can try to learn it.

Sincerely,
AmkG
