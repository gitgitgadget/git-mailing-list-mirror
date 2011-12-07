From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/3] grep: disable threading in all but worktree case
Date: Tue, 6 Dec 2011 23:24:31 -0500
Message-ID: <20111207042431.GA10765@sigill.intra.peff.net>
References: <cover.1322830368.git.trast@student.ethz.ch>
 <5328add8b32f83b4cdbd2e66283f77c125ec127a.1322830368.git.trast@student.ethz.ch>
 <4ED8F9AE.8030605@lsrfire.ath.cx>
 <4EDE9BBA.2010409@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Herman <eric@freesa.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed Dec 07 05:24:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RY93f-0006LV-4I
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 05:24:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755558Ab1LGEYe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Dec 2011 23:24:34 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41618
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755516Ab1LGEYd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 23:24:33 -0500
Received: (qmail 11730 invoked by uid 107); 7 Dec 2011 04:31:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 06 Dec 2011 23:31:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Dec 2011 23:24:31 -0500
Content-Disposition: inline
In-Reply-To: <4EDE9BBA.2010409@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186420>

On Tue, Dec 06, 2011 at 11:48:26PM +0100, Ren=C3=A9 Scharfe wrote:

>  #ifndef NO_PTHREADS
> -	if (use_threads) {
> +	if (nr_threads > 0) {
>  		grep_sha1_async(opt, name, sha1);
>  		return 0;
>  	} else

Should this be "if (nr_threads > 1)"?

As a user, I would do:

  git grep --threads=3D1 ...

if I wanted a single-threaded process. Instead, we actually spawn a
sub-thread and do all of the locking, which has a measurable cost:

  $ time git grep --threads=3D0 SIMPLE HEAD >/dev/null
  real    0m2.994s
  user    0m2.932s
  sys     0m0.060s

  $ time git grep --threads=3D1 SIMPLE HEAD >/dev/null
  real    0m3.407s
  user    0m3.392s
  sys     0m0.140s

Should --threads=3D1 be equivalent to --threads=3D0?

-Peff
