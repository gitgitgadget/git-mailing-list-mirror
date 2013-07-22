From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: git log anomalities
Date: Mon, 22 Jul 2013 12:40:01 +0200
Message-ID: <87bo5u28l6.fsf@linux-k42r.v.cablecom.net>
References: <20130722090854.GA22222@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, <kernel@pengutronix.de>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Mon Jul 22 12:40:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1DXH-0001Fw-GN
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jul 2013 12:40:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757375Ab3GVKkE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Jul 2013 06:40:04 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:34766 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757239Ab3GVKkD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Jul 2013 06:40:03 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 22 Jul
 2013 12:40:01 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (217.235.60.35) by
 CAS22.d.ethz.ch (172.31.51.112) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Mon, 22 Jul 2013 12:40:01 +0200
In-Reply-To: <20130722090854.GA22222@pengutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [217.235.60.35]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230974>

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> writes:

> Hello,
>
> today I looked at the changes to drivers/net/ethernet/freescale/fec.c=
 in
> the kernel since v3.8 using
>
> 	git log --stat v3.8.. --full-diff -- drivers/net/ethernet/freescale/=
fec.c
>
> which looks as expected. But when I added --graph the diffstats chang=
e.
> E.g. for 793fc0964be1921f15a44be58b066f22b925d90b it changes from:
>
>  drivers/net/ethernet/freescale/Makefile   |    3 +-
>  drivers/net/ethernet/freescale/fec.c      | 1966 -------------------=
----------
>  drivers/net/ethernet/freescale/fec_main.c | 1966 +++++++++++++++++++=
++++++++++
>  drivers/net/ethernet/freescale/fec_ptp.c  |    3 -
>  4 files changed, 1968 insertions(+), 1970 deletions(-)
>
> to
>
> |  Documentation/devicetree/bindings/net/dsa/dsa.txt |   91 +
> |  .../bindings/net/marvell-orion-mdio.txt           |    3 +
> |  Documentation/networking/ip-sysctl.txt            |   35 +-
[...]
> |  404 files changed, 15373 insertions(+), 8563 deletions(-)
>
> Is that a bug, or a feature I don't understand?

Nice catch.  It's a bad interaction between --full-diff, --stat and
--parents (which --graph implies in an internal-workings kind of way).

The parent rewriting gets to mess with the history *before* we generate
the diffs.  Normally this wouldn't matter, because the pathspec filter
would then again exclude all but the "real" change from the diff.  But
with --full-diff, you see all the changes between 793fc096 and the next
commit that touches the given pathspec (47a5247f), which is -- at this
stage, after rewriting -- the "parent".

I suspect to fix this we'll need to separate the "real" from the
"rewritten" parents, which might take a bit of work.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
