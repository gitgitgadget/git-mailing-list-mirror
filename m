From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH v2] Make xmalloc and xrealloc thread-safe
Date: Wed, 7 Apr 2010 05:29:15 -0700
Message-ID: <r2xec874dac1004070529p3d21d23z533e471636194c00@mail.gmail.com>
References: <4c8ef71003231421u789c4332h461c066add0ec7b1@mail.gmail.com> 
	<alpine.LFD.2.00.1003241133430.694@xanadu.home> <ec874dac1003241122s3d592f26n1b23d23144939218@mail.gmail.com> 
	<alpine.LFD.2.00.1003241435300.694@xanadu.home> <ec874dac1003241257r3cad86c9q1af84d3732e23ca8@mail.gmail.com> 
	<alpine.LFD.2.00.1003241613020.694@xanadu.home> <4c8ef71003270626y45685e69j28ccb8a8738b9083@mail.gmail.com> 
	<alpine.LFD.2.00.1004062152260.7232@xanadu.home> <20100407031655.GA7156@spearce.org> 
	<alpine.LFD.2.00.1004070043450.7232@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Kuivinen <frekui@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Wed Apr 07 14:29:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzUO7-0004rR-CR
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 14:29:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753419Ab0DGM3h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Apr 2010 08:29:37 -0400
Received: from mail-pz0-f193.google.com ([209.85.222.193]:35484 "EHLO
	mail-pz0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216Ab0DGM3h convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Apr 2010 08:29:37 -0400
Received: by pzk31 with SMTP id 31so970026pzk.33
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 05:29:35 -0700 (PDT)
Received: by 10.142.79.5 with HTTP; Wed, 7 Apr 2010 05:29:15 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1004070043450.7232@xanadu.home>
Received: by 10.143.25.38 with SMTP id c38mr3415525wfj.251.1270643375672; Wed, 
	07 Apr 2010 05:29:35 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144215>

On Tue, Apr 6, 2010 at 9:51 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Tue, 6 Apr 2010, Shawn O. Pearce wrote:
>> Nicolas Pitre <nico@fluxnic.net> wrote:
>> > To avoid a deadlock if try_to_free_from_threads() is called while
>> > read_lock is already locked within the same thread (may happen thr=
ough
>> > the read_sha1_file() path), a simple mutex ownership is added. Thi=
s
>> > could have been handled automatically with the PTHREAD_MUTEX_RECUR=
SIVE
>> > type but the Windows pthread emulation would get much more complex=
=2E
>> ...
>> > +static void try_to_free_from_threads(size_t size)
>> > +{
>> > + =A0 int self =3D pthread_equal(read_mutex_owner, pthread_self())=
;
>> > + =A0 if (!self)
>> > + =A0 =A0 =A0 =A0 =A0 read_lock();
>> > + =A0 release_pack_memory(size, -1);
>> > + =A0 if (!self)
>> > + =A0 =A0 =A0 =A0 =A0 read_unlock();
>> > +}
>>
>> Is there any concern that a partially unset read_mutex_owner might
>> look like the current thread's identity?
>>
>> That is, memset() can be setting the bytes one by one. =A0If the loc=
k
>> is being released we might observe the current owner as ourselves
>> if we see only part of that release, and our identity is the same
>> as another thread, only with the lower-address bytes unset.
>
> In practice memset() will optimize the memory access by using words a=
nd
> no bytes. =A0But in theory this is not guaranteed. =A0The solution fo=
r this
> would be to have yet another mutex just to protect the read_mutex
> hownership information modifications in order to make it atomic to
> potential readers. =A0That is becoming ugly for a feature (the freein=
g of
> pack data) that is not supposed to be the common case.

Multi-threaded programming is hard.  Its never easy to get it right.
We had really excellent reasons for avoiding multiple threads in the
early days of Git.  We still have those excellent reasons, but we have
been pushing more and more into these async threads to support
windows, and now its making us realize we never really thought about
this stuff very much.

You mentioned avoiding a recursive mutex only because windows
emulation doesn't have support for it.  But that's exactly what we
need here.  Shouldn't windows have a recursive mutex object that can
just be used inside of the emulation layer when we really need a
recursive mutex?

--=20
Shawn.
