From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 1/2] Make xmalloc and xrealloc thread-safe
Date: Wed, 24 Mar 2010 11:22:23 -0700
Message-ID: <ec874dac1003241122s3d592f26n1b23d23144939218@mail.gmail.com>
References: <20100323161713.3183.57927.stgit@fredrik-laptop> 
	<20100323173114.GB4218@fredrik-laptop> <20100323184309.GA31668@spearce.org> 
	<4c8ef71003231421u789c4332h461c066add0ec7b1@mail.gmail.com> 
	<alpine.LFD.2.00.1003231945480.31128@xanadu.home> <4c8ef71003240823o7cd733bn5f19699305c94cba@mail.gmail.com> 
	<alpine.LFD.2.00.1003241133430.694@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Kuivinen <frekui@gmail.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Wed Mar 24 19:22:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuVEB-00030q-Ls
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 19:22:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756693Ab0CXSWo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Mar 2010 14:22:44 -0400
Received: from mail-pz0-f200.google.com ([209.85.222.200]:34958 "EHLO
	mail-pz0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756659Ab0CXSWn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Mar 2010 14:22:43 -0400
Received: by pzk38 with SMTP id 38so1113259pzk.33
        for <git@vger.kernel.org>; Wed, 24 Mar 2010 11:22:43 -0700 (PDT)
Received: by 10.142.151.26 with SMTP id y26mr2169785wfd.6.1269454963265; Wed, 
	24 Mar 2010 11:22:43 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1003241133430.694@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143099>

On Wed, Mar 24, 2010 at 10:53 AM, Nicolas Pitre <nico@fluxnic.net> wrot=
e:
> On Wed, 24 Mar 2010, Fredrik Kuivinen wrote:
>
>> On Wed, Mar 24, 2010 at 00:50, Nicolas Pitre <nico@fluxnic.net> wrot=
e:
>> > On Tue, 23 Mar 2010, Fredrik Kuivinen wrote:
>> >
>> >> On Tue, Mar 23, 2010 at 19:43, Shawn O. Pearce <spearce@spearce.o=
rg> wrote:
>> >> > If that is what we are doing, disabling the release of pack win=
dows
>> >> > when malloc fails, why can't we do that all of the time?
>> >>
>> >> The idea was that most git programs are single threaded, so they =
can
>> >> still benefit from releasing the pack windows when they are low o=
n
>> >> memory.
>> >
>> > This is bobus. The Git program using the most memory is probably
>> > pack-objects and it is threaded. =A0Most single-threaded programs =
don't
>> > use close to as much memory.
>>
>> Ok, you are right. But xmalloc/xrealloc cannot be used in multiple
>> threads simultaneously without some serialization.
>>
>> For example, I think there are some potential race conditions in the
>> pack-objects code. In the threaded code we have the following call
>> chains leading to xcalloc, xmalloc, and xrealloc:
>>
>> find_deltas -> xcalloc
>> find_deltas -> do_compress -> xmalloc
>> find_deltas -> try_delta -> xrealloc
>> find_deltas -> try_delta -> read_sha1_file -> ... -> xmalloc =A0(cal=
led
>> with read_lock held, but it can still race with the other calls)
>>
>> As far as I can see there is no serialization between these calls.
>
> True. =A0We already have a problem. =A0This is nasty.

The easy solution is probably to remove the use of xmalloc from
find_deltas code path.  But then we run into hard failures when we
can't get the memory we need, there isn't a way to recover from a
malloc() failure deep within read_sha1_file for example.  The current
solution is the best we can do, try to ditch pack windows and hope
that releases sufficient virtual memory space that a second malloc()
attempt can succeed by increasing heap.

We could use a mutex during the malloc failure code-path of xmalloc,
to ensure only one thread goes through that pack window cleanup at a
time.  But that will still mess with the main thread which doesn't
really want to acquire mutexes during object access as it uses the
existing pack windows.

I thought pack-objects did all object access from the main thread and
only delta searches on the worker threads?  If that is true, maybe we
can have the worker threads signal the main thread on malloc failure
to release pack windows, and then wait for that signal to be
acknowledged before they attempt to retry the malloc.  This means the
main thread would need to periodically test that condition as its
dispatching batches of objects to the workers.

Ugly.

--=20
Shawn.
