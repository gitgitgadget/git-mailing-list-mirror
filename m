From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH v2 2/2] index-pack: support multithreaded delta resolving
Date: Mon, 12 Mar 2012 12:47:55 +0100
Message-ID: <87boo282hg.fsf@thomas.inf.ethz.ch>
References: <1331519549-28090-1-git-send-email-pclouds@gmail.com>
	<1331519549-28090-3-git-send-email-pclouds@gmail.com>
	<87y5r684t6.fsf@thomas.inf.ethz.ch>
	<CACsJy8CyLgKrEAriS-uLU9qG6ahBeQ6qLbvHiLvsbTjMZsMW+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 12 12:48:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S73jP-0000fX-2i
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 12:48:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753402Ab2CLLr7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Mar 2012 07:47:59 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:7386 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752709Ab2CLLr6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Mar 2012 07:47:58 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 12 Mar
 2012 12:47:54 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 12 Mar
 2012 12:47:55 +0100
In-Reply-To: <CACsJy8CyLgKrEAriS-uLU9qG6ahBeQ6qLbvHiLvsbTjMZsMW+g@mail.gmail.com>
	(Nguyen Thai Ngoc Duy's message of "Mon, 12 Mar 2012 18:42:14 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192857>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> 2012/3/12 Thomas Rast <trast@inf.ethz.ch>:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes=
:
>>
>>> This puts delta resolving on each base on a separate thread, one ba=
se
>>> cache per thread. Per-thread data is grouped in struct thread_local=
=2E
>>> When running with nr_threads =3D=3D 1, no pthreads calls are made. =
The
>>> system essentially runs in non-thread mode.
>>
>> As discussed when we took the git-grep measurements, it may be
>> interesting to have a way to run 1 thread. =C2=A0Can you put in such=
 an
>> option?
>
> Sorry I wasn't clear, nr_threads =3D=3D 1 is equivalent to --threads=3D=
1. So
> yes it supports running in non-thread mode.

Well, in that case I wasn't clear: I meant that there should be a way t=
o
run with the whole threading machinery enabled, but still only have one
thread (doing the work, possibly having another that fills the queue).

That allows us to see how big the overhead is.

>> Oh, and could you write a perf test for this? :-)
>
> Yeah, about that, index-pack is mostly used as part of git-fetch or
> git-clone. Maybe we need to add --threads to those commands too, then
> we can see how clone/fetch performs. I'll need such tests anyway if
> I'm going to push for cheaper connectivity check in git-fetch in
> another thread.
>
> I guess one test with --threads=3D1, one with threads=3D2 and one wit=
hout
> --threads. Any ideas? We can try testing it on half available cores,
> all cores, double available cores, but that would require exporting
> online_cpus(), perhaps via test command. I didn't see grep --threads
> perf test either (wanted to use it as template..)

A simple one is in t/perf/p7810-grep.sh (in master already).  It doesn'=
t
test threads though.  For index-pack you'll also have to find a good wa=
y
to choose a pack, perhaps simply the biggest one in the repo.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
