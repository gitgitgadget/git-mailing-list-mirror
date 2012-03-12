From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH v2 2/2] index-pack: support multithreaded delta resolving
Date: Mon, 12 Mar 2012 11:57:41 +0100
Message-ID: <87y5r684t6.fsf@thomas.inf.ethz.ch>
References: <1331519549-28090-1-git-send-email-pclouds@gmail.com>
	<1331519549-28090-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 12 11:58:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S72wy-0007gK-Dq
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 11:58:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754158Ab2CLK5s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Mar 2012 06:57:48 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:3340 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754105Ab2CLK5p convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Mar 2012 06:57:45 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 12 Mar
 2012 11:57:40 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 12 Mar
 2012 11:57:41 +0100
In-Reply-To: <1331519549-28090-3-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 12
 Mar 2012 09:32:29 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192851>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> This puts delta resolving on each base on a separate thread, one base
> cache per thread. Per-thread data is grouped in struct thread_local.
> When running with nr_threads =3D=3D 1, no pthreads calls are made. Th=
e
> system essentially runs in non-thread mode.

As discussed when we took the git-grep measurements, it may be
interesting to have a way to run 1 thread.  Can you put in such an
option?

> An experiment on a Xeon 24 core machine with linux-2.6.git shows that
> performance does not increase proportional to the number of cores. So
> by default, we use maximum 3 cores. Some numbers with --threads from =
1
> to 16:
>
> 1..4
> real    1m16.310s  0m48.183s  0m37.866s  0m32.834s
> user    1m13.773s  1m15.537s  1m15.781s  1m16.233s
> sys     0m2.480s   0m3.936s   0m4.448s   0m4.852s
>
> 5..8
> real    0m33.170s  0m30.369s  0m28.406s  0m26.968s
> user    1m31.474s  1m30.322s  1m29.562s  1m28.694s
> sys     0m6.096s   0m6.268s   0m6.684s   0m7.172s

Interesting.  Is this a real 24-core machine or 12*2 hyperthreaded?
Does it use Turbo Boost and how far (how fast and on how many cores
simultaneously) does that go?

I'm asking because if Turbo Boost starts to wear off around 4 cores,
like these measurements suggest, then it may not be beneficial to spawn
threads on 2*2HT CPUs (found in many laptops) where Turbo Boost only
really works if you only use a single core.

Oh, and could you write a perf test for this? :-)

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
