From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFC] Add --create-cache to repack
Date: Sun, 30 Jan 2011 11:29:49 -0800
Message-ID: <AANLkTin_7jHRAx4yDw3DirLX7Lbdv3s3iz+-Q-QXCZqq@mail.gmail.com>
References: <1296201984-24426-1-git-send-email-spearce@spearce.org>
 <4D42878E.2020502@viscovery.net> <AANLkTim+AUY9SdeAFfkny2_a3qQ9SCDLUHR3s9Q3M98u@mail.gmail.com>
 <alpine.LFD.2.00.1101281304270.8580@xanadu.home> <AANLkTikPcp5CUTWfhy6FYbCEkNG6epGBAMNT5vTfSbvy@mail.gmail.com>
 <alpine.LFD.2.00.1101281502170.8580@xanadu.home> <AANLkTi=U7qRRij=BQXC1Goqa9toDFfaVKT=+-8zYxCcc@mail.gmail.com>
 <7voc6yc2au.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	John Hawley <warthog19@eaglescrag.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 30 20:30:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PjcyZ-0000wM-Hp
	for gcvg-git-2@lo.gmane.org; Sun, 30 Jan 2011 20:30:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754190Ab1A3TaM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Jan 2011 14:30:12 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47564 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754159Ab1A3TaL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Jan 2011 14:30:11 -0500
Received: by fxm20 with SMTP id 20so4948645fxm.19
        for <git@vger.kernel.org>; Sun, 30 Jan 2011 11:30:10 -0800 (PST)
Received: by 10.102.244.18 with SMTP id r18mr1977181muh.5.1296415809914; Sun,
 30 Jan 2011 11:30:09 -0800 (PST)
Received: by 10.103.1.2 with HTTP; Sun, 30 Jan 2011 11:29:49 -0800 (PST)
In-Reply-To: <7voc6yc2au.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165692>

On Sat, Jan 29, 2011 at 22:51, Junio C Hamano <gitster@pobox.com> wrote=
:
> Shawn Pearce <spearce@spearce.org> writes:
>
>> I fully implemented the reuse of a cached pack behind a thin pack id=
ea
>> I was trying to describe in this thread. =A0It saved 1m7s off the JG=
it
>> running time, but increased the data transfer by 25 MiB. =A0I didn't
>> expect this much of an increase, I honestly expected the thin pack
>> portion to be well, thinner. =A0The issue is the thin pack cannot de=
lta
>> against all of the history, its only delta compressing against the t=
ip
>> of the cached pack. =A0So long-lived side branches that forked off a=
n
>> older part of the history aren't delta compressing well, or at all,
>> and that is significantly bloating the thin pack. =A0(Its also why t=
hat
>> "newer" pack is 57M, but should be 14M if correctly combined with th=
e
>> cached pack.) =A0If I were to consider all of the objects in the cac=
hed
>> pack as potential delta base candidates for the thin pack, the entir=
e
>> benefit of the cached pack disappears.
>
> What if you instead use the cached pack this way?
>
> =A00. You perform the proposed pre-traversal until you hit the tip of=
 cached
> =A0 =A0pack(s), and realize that you will end up sending everything.
>
> =A01. Instead of sending the new part of the history first and then s=
ending
> =A0 =A0the cached pack(s), you send the contents of cached pack(s), b=
ut also
> =A0 =A0note what objects you sent;

This is the part I was trying to avoid.  Making this list of objects
from the cached pack(s) costs working set inside of the pack-objects
process.  I had hoped that the cached packs would let me skip this
step.

But lets say that's acceptable cost.  We cannot efficiently make a
useful list of objects from the pack.  Scanning the .idx file only
tells us the SHA-1.  It does not tell us the type, nor does it tell us
what the path hash code would be for the object if it were a tree or
blob.  So we cannot efficiently use this pack listing to construct the
delta window.

> =A02. Then you send the new part of the history, taking full advantag=
e of
> =A0 =A0what you have already sent, perhaps doing only half of the reu=
se-delta
> =A0 =A0logic (i.e. you reuse what you can reuse, but you do _not_ pun=
t on an
> =A0 =A0object that is not a delta in an existing pack).

Well, I guess we could go half-way.  We could try to use only
non-delta objects from the cached pack as potential delta bases for
this delta search.

To do that we would build the reverse index for the cached pack, then
check each object's type code just before we send that part of the
cached pack.  If its non-delta, we can get its SHA-1 from the reverse
index, toss the object into the delta search list, and copy out the
length of the object until the next object starts.

However... I suspect our delta results would be the same as the thin
pack before cached pack test I did earlier.  The objects that are
non-delta in the cached pack are (in theory) approximately the objects
immediately reachable from the cached pack's tip.  That was already
put into the delta window as the base candidates for the thin pack.
This may be a faster way to find that thin pack edge, but the data
transfer will still be sub-optimal because we cannot consider deltas
as bases.

--=20
Shawn.
