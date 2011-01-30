From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFC] Add --create-cache to repack
Date: Sun, 30 Jan 2011 11:43:22 -0800
Message-ID: <AANLkTi=mbeBsR5tr4J7kQCL6YqiGfttK01VUN016aapC@mail.gmail.com>
References: <1296201984-24426-1-git-send-email-spearce@spearce.org>
 <4D42878E.2020502@viscovery.net> <AANLkTim+AUY9SdeAFfkny2_a3qQ9SCDLUHR3s9Q3M98u@mail.gmail.com>
 <alpine.LFD.2.00.1101281304270.8580@xanadu.home> <AANLkTikPcp5CUTWfhy6FYbCEkNG6epGBAMNT5vTfSbvy@mail.gmail.com>
 <alpine.LFD.2.00.1101281502170.8580@xanadu.home> <AANLkTi=U7qRRij=BQXC1Goqa9toDFfaVKT=+-8zYxCcc@mail.gmail.com>
 <AANLkTimuW-7D4YA2jeF+y4DPE=CdqtL713MQK+1Gtp-d@mail.gmail.com> <7vk4hmbyuo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	John Hawley <warthog19@eaglescrag.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 30 20:43:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PjdBe-0006jW-8s
	for gcvg-git-2@lo.gmane.org; Sun, 30 Jan 2011 20:43:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754160Ab1A3Tnp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Jan 2011 14:43:45 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58957 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753972Ab1A3Tno convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Jan 2011 14:43:44 -0500
Received: by fxm20 with SMTP id 20so4954806fxm.19
        for <git@vger.kernel.org>; Sun, 30 Jan 2011 11:43:43 -0800 (PST)
Received: by 10.103.241.16 with SMTP id t16mr1760843mur.23.1296416623157; Sun,
 30 Jan 2011 11:43:43 -0800 (PST)
Received: by 10.103.1.2 with HTTP; Sun, 30 Jan 2011 11:43:22 -0800 (PST)
In-Reply-To: <7vk4hmbyuo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165694>

On Sun, Jan 30, 2011 at 00:05, Junio C Hamano <gitster@pobox.com> wrote=
:
> Shawn Pearce <spearce@spearce.org> writes:
>
>> Using this for object enumeration shaves almost 1 minute off server
>> packing time; the clone dropped from 3m28s to 2m29s. =A0That is clos=
e to
>> what I was getting with the cached pack idea, but the network transf=
er
>> stayed the small 376 MiB.
>
> I like this result.

I'm really leaning towards putting this cached object list into JGit.

I need to shave that 1 minute off server CPU time. I can afford the 41
MiB disk (and kernel buffer cache), but I cannot really continue to
pay the 1 minute of CPU on each clone request for large repositories.
The object list of what is reachable from commit X isn't ever going to
change, and the path hash function is reasonably stable.  With a
version code in the file we can desupport old files if the path hash
function changes.  10% more disk/kernel memory is cheap for some of my
servers compared to 1 minute of CPU, and some explicit cache
management by the server administrator to construct the file.

> The amount of transfer being that small was something I didn't quite
> expect, though. =A0Doesn't it indicate that our pathname based object
> clustering heuristics is not as effective as we hoped?

I'm not sure I follow your question.

I think the problem here is old side branches that got recently
merged.  Their _best_ delta base was some old revision, possibly close
to where they branched off from.  Using a newer version of the file
for the delta base created a much larger delta.  E.g. consider a file
where in more recent revisions a function was completely rewritten.
If you have to delta compress against that new version, but you use
the older definition of the function, you need to use insert
instructions
for the entire content of that old function.  But if you can delta
compress against the version you branched from (or one much closer to
it in time), your delta would be very small as that function is
handled by the smaller copy instruction.

Our clustering heuristics work fine.

Our thin-pack selection of potential delta base candidates is not.  We
are not very aggressive in loading the delta base window with
potential candidates, which means we miss some really good compression
opportunities.


Ooooh.

I think my test was flawed.  I injected the cached pack's tip as the
edge for the new stuff to delta compress against.  I should have
injected all of the merge bases between the cached pack's tip and the
new stuff.  Although the cached pack tip is one of the merge bases,
its not all of them.  If we inject all of the merge bases, we can find
the revision that this old side branch is based on, and possibly get a
better delta candidate for it.

IIRC, upload-pack would have walked backwards further and found the
merge base for that side branch, and it would have been part of the
delta base candidates.  I think I need to re-do my cached pack test.
Good thing I have history of my source code saved in this fancy
revision control thingy called "git".  :-)

--=20
Shawn.
