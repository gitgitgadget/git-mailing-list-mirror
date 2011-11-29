From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] grep: enable multi-threading for -p and -W
Date: Tue, 29 Nov 2011 15:07:04 +0100
Message-ID: <201111291507.04754.trast@student.ethz.ch>
References: <5e3bcf651b31b299ca411296e6e7c4d11f6ae617.1322232319.git.trast@student.ethz.ch> <201111291054.39477.trast@student.ethz.ch> <4ED4E2D7.9090804@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?iso-8859-1?q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Nov 29 15:07:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVOL7-00039E-5M
	for gcvg-git-2@lo.gmane.org; Tue, 29 Nov 2011 15:07:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755704Ab1K2OHJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Nov 2011 09:07:09 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:9193 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755690Ab1K2OHH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Nov 2011 09:07:07 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 29 Nov
 2011 15:07:05 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 29 Nov
 2011 15:07:04 +0100
User-Agent: KMail/1.13.7 (Linux/3.1.0-47-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <4ED4E2D7.9090804@lsrfire.ath.cx>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186060>

Ren=E9 Scharfe wrote:
> > * none of the patches:
> >   git grep --cached INITRAMFS_ROOT_UID
> >     2.13user 0.14system 0:02.10elapsed
> >   git grep --cached -W INITRAMFS_ROOT_UID    # note: broken!
> >     2.23user 0.18system 0:02.21elapsed=20
>=20
> Broken is a tad too hard a word

Sorry, I just wanted to mark it as: this is unattainable since we're
now doing extra work.

> > * my patch, but not yours:
> >   git grep --cached -W INITRAMFS_ROOT_UID
> >     3.01user 0.05system 0:03.07elapsed
> >=20
> > * my patch + your patch:
> >   git grep --cached -W INITRAMFS_ROOT_UID
> >     4.45user 0.22system 0:02.67elapsed
> >=20
> > So while it ends up being faster overall, it also uses way more CPU
> > and would presumably be *slower* on a single-processor system.
> > Apparently those attribute lookups really hurt.
>=20
> Hmm, why are they *that* expensive?
>=20
> callgrind tells me that userdiff_find_by_path() contributes only 0.18=
%
> to the total cost with your first patch.  Timings in my virtual machi=
ne
> are very volatile, but it seems that here the difference is in the
> system time while user is basically the same for all combinations of
> patches.

Not sure, perhaps callgrind does not model syscalls as expensive
enough.  I also suspect (from my very cursory look at the attributes
machinery) that loading attributes for all paths *in random order*
(i.e., threaded) causes a lot of discards of the existing attributes
data.  (The order is still random with my new patch, but we only load
them for files that have matches.)

> I wonder what caused the slight speedup for the case without -W.  It'=
s
> probably just noise, though.

Yeah, it's very noisy, but I was too lazy for best-of-50 or something ;=
-)

[...]
> > +#ifndef NO_PTHREADS
> > +static inline void grep_attr_lock(struct grep_opt *opt)
[...]
> We'd need stubs here for the case of NO_PTHREADS being defined.

Right, thanks.  Sorry for not testing with NO_PTHREADS to begin with.

> Perhaps leave the thread stuff in builtin/grep.c and export a functio=
n
> from there that does [the userdiff lookup], with locking and all?

That seems like a layering violation to me.  Isn't builtin/grep.c
supposed to call out to grep.c, but not the other way around?

Maybe it would be less messy if we had a global (across all of git)
flag that says whether threads are on.  Then subsystems that are used
from threaded code, but cannot handle it, can learn to lock themselves
around their work.  But it would be pretty much the opposite of what
git-grep now does.


Thanks for the review.  I'll reroll as a proper patch later.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
