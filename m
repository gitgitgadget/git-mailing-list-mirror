From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 2/3] xdiff: avoid more compiler warnings with XDL_FAST_HASH on 32-bit machines
Date: Wed, 23 May 2012 10:30:38 +0200
Message-ID: <8762bn7101.fsf@thomas.inf.ethz.ch>
References: <CAA787r=WCJXeDipiVL37oMgji=ncoPyXXVOcCyYbSC6iCcTi1g@mail.gmail.com>
	<4FB4A4B9.3080009@lsrfire.ath.cx>
	<xmqqmx56rd2r.fsf@junio.mtv.corp.google.com>
	<4FB5460C.10807@lsrfire.ath.cx>
	<CAA787rmJixvyKhubHXZCDVYc=DdVk8_vHsHF6bOsLQ_j=39bGw@mail.gmail.com>
	<4FBBF8D7.7050701@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?=C3=98yvind_A=2E_Holm?= <sunny@sunbase.org>,
	Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed May 23 10:30:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SX6y3-0002vs-7J
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 10:30:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757559Ab2EWIap convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 May 2012 04:30:45 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:55246 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757483Ab2EWIan convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 May 2012 04:30:43 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 23 May
 2012 10:30:37 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 23 May
 2012 10:30:38 +0200
In-Reply-To: <4FBBF8D7.7050701@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of
	"Tue, 22 May 2012 22:36:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198276>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Hide literals that can cause compiler warnings for 32-bit architectur=
es in
> expressions that evaluate to small numbers there.  Some compilers war=
n that
> 0x0001020304050608 won't fit into a 32-bit long, others that shifting=
 right
> by 56 bits clears a 32-bit value completely.
>
> The correct values are calculated in the 64-bit case, which is all th=
at matters
> in this if-branch.
>
> Reported-by: =C3=98yvind A. Holm <sunny@sunbase.org>
> Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

Thanks for fixing this.  As far as logic and review goes, both patches

Acked-by: Thomas Rast <trast@student.ethz.ch>

I haven't checked whether it actually fixes the warnings, however.

> ---
>  xdiff/xutils.c |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/xdiff/xutils.c b/xdiff/xutils.c
> index 8580da7..78549e3 100644
> --- a/xdiff/xutils.c
> +++ b/xdiff/xutils.c
> @@ -272,7 +272,13 @@ static inline long count_masked_bytes(unsigned l=
ong mask)
>  		 * that works for the bytemasks without having to
>  		 * mask them first.
>  		 */
> -		return mask * 0x0001020304050608 >> 56;
> +		/*
> +		 * return mask * 0x0001020304050608 >> 56;
> +		 *
> +		 * Doing it like this avoids warnings on 32-bit machines.
> +		 */
> +		long a =3D (REPEAT_BYTE(0x01) / 0xff + 1);
> +		return mask * a >> (sizeof(long) * 7);
>  	} else {
>  		/*
>  		 * Modified Carl Chatfield G+ version for 32-bit *

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
