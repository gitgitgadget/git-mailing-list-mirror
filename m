From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFC] Add --create-cache to repack
Date: Fri, 28 Jan 2011 18:34:13 -0800
Message-ID: <AANLkTimuW-7D4YA2jeF+y4DPE=CdqtL713MQK+1Gtp-d@mail.gmail.com>
References: <1296201984-24426-1-git-send-email-spearce@spearce.org>
 <4D42878E.2020502@viscovery.net> <AANLkTim+AUY9SdeAFfkny2_a3qQ9SCDLUHR3s9Q3M98u@mail.gmail.com>
 <alpine.LFD.2.00.1101281304270.8580@xanadu.home> <AANLkTikPcp5CUTWfhy6FYbCEkNG6epGBAMNT5vTfSbvy@mail.gmail.com>
 <alpine.LFD.2.00.1101281502170.8580@xanadu.home> <AANLkTi=U7qRRij=BQXC1Goqa9toDFfaVKT=+-8zYxCcc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	John Hawley <warthog19@eaglescrag.net>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Jan 29 03:34:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pj0eI-0000in-0n
	for gcvg-git-2@lo.gmane.org; Sat, 29 Jan 2011 03:34:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753999Ab1A2Cej convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Jan 2011 21:34:39 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43033 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753452Ab1A2Cef convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Jan 2011 21:34:35 -0500
Received: by fxm20 with SMTP id 20so3998440fxm.19
        for <git@vger.kernel.org>; Fri, 28 Jan 2011 18:34:34 -0800 (PST)
Received: by 10.103.221.3 with SMTP id y3mr1842973muq.95.1296268474035; Fri,
 28 Jan 2011 18:34:34 -0800 (PST)
Received: by 10.103.1.2 with HTTP; Fri, 28 Jan 2011 18:34:13 -0800 (PST)
In-Reply-To: <AANLkTi=U7qRRij=BQXC1Goqa9toDFfaVKT=+-8zYxCcc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165649>

On Fri, Jan 28, 2011 at 17:32, Shawn Pearce <spearce@spearce.org> wrote=
:
>
> Well, scratch the idea in this thread. =A0I think.
>
> I retested JGit vs. CGit on an identical linux-2.6 repository. =A0The
> repository was fully packed, but had two pack files. =A0362M and 57M,
> and was created by packing a 1 month old master, marking it .keep, an=
d
> then repacking -a -d to get most recent last month into another pack.
> This results in some files that should be delta compressed together
> being stored whole in the two packs (obviously).
>
> The two implementations take the same amount of time to generate the
> clone. =A03m28s / 3m22s for JGit, 3m23s for C Git. =A0The JGit create=
d
> pack is actually smaller 376.30 MiB vs. C Git's 380.59 MiB.

I just tried caching only the object list of what is reachable from a
particular commit.  The file is a small 20 byte header:

  4 byte magic
  4 byte version
  4 byte number of commits (C)
  4 byte number of trees (T)
  4 byte number of blobs (B)

Then C commit SHA-1s, followed by T tree SHA-1 + 4 byte path_hash,
followed by B blob SHA-1 + 4 byte path_hash.  For any project the size
is basically on par with the .idx file for the pack v1 format, so ~41
MB for linux-2.6.  The file is stored as
$GIT_OBJECT_DIRECTORY/cache/$COMMIT_SHA1.list, and is completely
pack-independent.

Using this for object enumeration shaves almost 1 minute off server
packing time; the clone dropped from 3m28s to 2m29s.  That is close to
what I was getting with the cached pack idea, but the network transfer
stayed the small 376 MiB.  I think this supports your pack v4 work...
if we can speed up object enumeration to be this simple (scan down a
list of objects with their types declared inline, or implied by
location), we can cut a full minute of CPU time off the server side.

--=20
Shawn.
