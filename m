From: Nick Edelen <sirnot@gmail.com>
Subject: Re: [PATCH 0/5] Suggested for PU: revision caching system to 
	significantly speed up packing/walking
Date: Thu, 6 Aug 2009 22:01:39 +0200
Message-ID: <c77435a80908061301n5e855aeci16af392ed3128651@mail.gmail.com>
References: <op.ux8i6hrbtdk399@sirnot.private>
	 <alpine.DEB.1.00.0908061645470.8306@pacific.mpi-cbg.de>
	 <4A7AEFA8.5010001@drmicha.warpmail.net>
	 <c77435a80908061039p30b83511qb7c378cfd68a6cf6@mail.gmail.com>
	 <alpine.DEB.1.00.0908062030340.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Sam Vilain <sam@vilain.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 06 22:01:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZ99r-0005wJ-Bb
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 22:01:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756594AbZHFUBl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Aug 2009 16:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756512AbZHFUBk
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 16:01:40 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:51137 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756224AbZHFUBj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Aug 2009 16:01:39 -0400
Received: by ewy10 with SMTP id 10so1063875ewy.37
        for <git@vger.kernel.org>; Thu, 06 Aug 2009 13:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=F4U4A89QyeNL9ccK8XXw+05kLAwm/97WBtGlLW9+WG4=;
        b=HjzJ3gVhqBm3Wz0rjt30QUn4h2vP45fXVZua1zH5TwEHQA/V5dwUJ+GNk+jP3wgtLt
         cLqug//Kl0XUYSchJUGHCpiovjgPuvlbXu/SvwEkxj7BuwBkAEoy+chM+Y96vLvMHBTE
         /2hPWoJ/BHrWs0iV6Dc+YlTe2VP5i4IijImiI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tqUIwQGjuIOzU5rp7/m2e9uI0iDWL60h4/pqPRlWlSSlShtFKyU6ltHVEbqShQa0m3
         1SbyBLp+KzVKtoNl/1Dzm+6re9QYI58qROxaJTP/o1eWa3rzSfNTDeizFFNc/1xOHtBr
         A+nbR7QGTJb6PjDBhfnEM5QC+wSowVRvRje0Q=
Received: by 10.216.93.66 with SMTP id k44mr49277wef.67.1249588899418; Thu, 06 
	Aug 2009 13:01:39 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0908062030340.8306@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125118>

Hi,

>My idea with that was that you already have a SHA-1 map in the pack in=
dex,
>and if all you want to be able to accelerate the revision walker, you'=
d
>probably need something that adds yet another mapping, from commit to
>parents and tree, and from tree to sub-tree and blob (so you can avoid
>unpacking commit and tree objects).

As I mention in one of the patch descriptions, along with each commit
a list of objects introduced per commit is cached, so no extra I/O is
necessary for tree recursion, etc. during traversal.

>I just thought that it could be more efficient to do it at the time th=
e
>pack index is written _anyway_, as nothing will change in the pack aft=
er
>that anyway.

Nothing might change in the pack, but the slices were made to allow
for continual addition and refinement of the cache.  In a typical
usage slices will be added and fused on a regular basis, which would
require tinkering in pack indexes if they were combined.

>But I guess I can answer my question easily myself: the boundary commi=
ts
>will not be handled that way.
>
>Still, there is some redundancy between the pack index and your cache,=
 as
>you have to write out the whole list of SHA-1s all over again.  I gues=
s it
>is time to look at the code instead of asking stupid questions.

The whole revision cache is redundant, technically speaking: nothing
in it can't be found by rummaging through packs or objects.  The point
of it was to distill out important information for fast, easy access
of the commit tree.

On another note, I've eliminated the python dependancy.  Shall I
resend the patchset now or should I wait until it has been further
reviewed? (don't want to flood the list with resubmits)

 - Nick

On Thu, Aug 6, 2009 at 9:06 PM, Johannes
Schindelin<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Thu, 6 Aug 2009, Nick Edelen wrote:
>
>> > Sorry, I forgot the details, could you quickly remind me why these
>> > caches are not in the pack index files?
>>
>> Er, I'm not sure what you mean. =A0Are you asking why these revision
>> caches are required if we have a pack index, or why they aren't in t=
he
>> pack index, or something different? =A0I'm thinking probably the sec=
ond:
>
> Yep.
>
>> the short answer is that cache slices are totally independant of pac=
k
>> files.
>
> My idea with that was that you already have a SHA-1 map in the pack i=
ndex,
> and if all you want to be able to accelerate the revision walker, you=
'd
> probably need something that adds yet another mapping, from commit to
> parents and tree, and from tree to sub-tree and blob (so you can avoi=
d
> unpacking commit and tree objects).
>
> I just thought that it could be more efficient to do it at the time t=
he
> pack index is written _anyway_, as nothing will change in the pack af=
ter
> that anyway.
>
> But I guess I can answer my question easily myself: the boundary comm=
its
> will not be handled that way.
>
> Still, there is some redundancy between the pack index and your cache=
, as
> you have to write out the whole list of SHA-1s all over again. =A0I g=
uess it
> is time to look at the code instead of asking stupid questions.
>
>> It might be possible to somehow merge revision cache slices with pac=
k
>> indexes, but I don't think it'd be a very suitable modification. =A0=
The
>> rev-cache slices are meant to act almost like topo-relation pack fil=
es:
>> new slices are simply new files, seperate slice files can be fused
>> ("repacked") into a larger one, the index is a (recreatable) single =
file
>> associating file (positions) with objects. =A0The format was geared =
to
>> reducing potential cache/data loss and preventing overly large cache
>> slices.
>>
>> >> Hmpf.
>> >>
>> >> We got rid of the last Python script in Git a long time ago, but =
now
>> >> two different patch series try to sneak that dependency (at least=
 for
>> >> testing) back in.
>> >>
>> >> That's all the worse because we cannot use Python in msysGit, and
>> >> Windows should be a platform benefitting dramatically from your w=
ork.
>> >
>> > In fact, the test the script performs could be easily rephrased wi=
th
>> > "sort", "uniq" and "comm". OTOH: If the walker is supposed to retu=
rn
>> > the exact same orderd list of commits you can just use test_cmp.
>>
>> The language that script is written in isn't important. =A0I origina=
lly
>> wrote it in python because I wanted something quick and wasn't much =
of
>> a sh guru (sorry :-/ ). =A0As Micheal said I've no doubt it can easi=
ly
>> be converted to shell script
>
> That is not what I wanted to hear.
>
>> -- in fact, I'll try to get a shell version working today.
>
> That is.
>
> Thanks,
> Dscho
>
