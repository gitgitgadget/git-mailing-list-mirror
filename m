From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH v2] Make xmalloc and xrealloc thread-safe
Date: Wed, 7 Apr 2010 07:30:09 -0700
Message-ID: <w2kec874dac1004070730rd1e5c149x88a7d6b4b649792f@mail.gmail.com>
References: <4c8ef71003231421u789c4332h461c066add0ec7b1@mail.gmail.com> 
	<alpine.LFD.2.00.1003241435300.694@xanadu.home> <ec874dac1003241257r3cad86c9q1af84d3732e23ca8@mail.gmail.com> 
	<alpine.LFD.2.00.1003241613020.694@xanadu.home> <4c8ef71003270626y45685e69j28ccb8a8738b9083@mail.gmail.com> 
	<alpine.LFD.2.00.1004062152260.7232@xanadu.home> <20100407031655.GA7156@spearce.org> 
	<alpine.LFD.2.00.1004070043450.7232@xanadu.home> <r2xec874dac1004070529p3d21d23z533e471636194c00@mail.gmail.com> 
	<alpine.LFD.2.00.1004070859540.7232@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Kuivinen <frekui@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Wed Apr 07 16:37:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzWNT-00058Y-Oh
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 16:37:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932674Ab0DGOhG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Apr 2010 10:37:06 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:36562 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932659Ab0DGOhF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Apr 2010 10:37:05 -0400
Received: by pva18 with SMTP id 18so712748pva.19
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 07:37:04 -0700 (PDT)
Received: by 10.142.78.2 with HTTP; Wed, 7 Apr 2010 07:30:09 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1004070859540.7232@xanadu.home>
Received: by 10.142.66.13 with SMTP id o13mr3513102wfa.72.1270650629236; Wed, 
	07 Apr 2010 07:30:29 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144225>

On Wed, Apr 7, 2010 at 6:17 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> Maybe. =A0That would in fact just mean pushing the double mutex issue=
 into
> the pthread emulation instead of having it outside it. =A0This would
> impact performances for all mutexes although only one instance of the=
m
> currently require a recursive behavior.

But we know when the mutex is created whether or not it needs
recursive support.  So in the Windows emulation we may need to
allocate two mutexes for each pthread_mutex_t storage-wise, but we
don't necessarily need to use that owner thread mutex on every
lock/unlock request, do we?

> Yet, the memset() issue comes up only because pthread_t is meant to b=
e
> an opaque type. =A0The only information we would need here is the act=
ual
> thread ID as returned by gettid() on Linux or GetCurrentThreadId() on
> Windows, and then the read_mutex_owner could be a simple atomically
> modifiable integer. =A0But what about other pthread-capable non Linux
> systems?

Indeed.  If Windows threads are atomic words, then actually you don't
need that double mutex in the emulation layer, and can instead use the
atomic word to determine ownership.  Which makes this entire debate
somewhat moot, doesn't it?

Use a standard recursive pthread mutex, and implement recursive
support in the emulation layer using the atomic word holding a
GetCurrentThreadId() result.  We don't need to worry about how
pthread_t is stored on any particular system, the thread library will
do it for us.

--=20
Shawn.
