From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 3/3] completion: improve shell expansion of items
Date: Fri, 28 Sep 2012 12:05:30 +0200
Message-ID: <20120928100530.GL10144@goldbirke>
References: <20120926214653.GA18628@sigill.intra.peff.net>
 <20120926215119.GC18653@sigill.intra.peff.net>
 <20120927003751.GI10144@goldbirke>
 <20120927062855.GA22890@sigill.intra.peff.net>
 <20120927064338.GA4789@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 28 12:06:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THXSK-0003PG-9v
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 12:06:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756922Ab2I1KFu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Sep 2012 06:05:50 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:62568 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138Ab2I1KFt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 06:05:49 -0400
Received: from localhost6.localdomain6 (p5B130716.dip0.t-ipconnect.de [91.19.7.22])
	by mrelayeu.kundenserver.de (node=mrbap4) with ESMTP (Nemesis)
	id 0Led14-1To4hx2Zsk-00px3d; Fri, 28 Sep 2012 12:05:32 +0200
Content-Disposition: inline
In-Reply-To: <20120927064338.GA4789@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:aGCXvyDUqUwemwSrBGo18hrrekM5hCo8gDKmjvG52YI
 FWTZz5zZXQdBR94uGmdljSP/7V4aXtrd/pfIXau3DIQI2NFSAD
 7c69/q1S/2QacCIgBVyVBe4WMt5dlB4nI9ouSDiT+m/duvWIDg
 HMrd6Z0XBiwoRdzFyVsZkS/wsqPHiQRF6j6q+iNC22zYmdNuIZ
 E79r+Z7u7jMtGsTeOE4qFoONaCdhWXi+2cgdU6SXTleIFMkzsN
 L6sMBZtevLmZVgFixMv5NHCEVv5obmMZTJoYVFRxVpd6fIqwNQ
 hnLEU3K5AOrhorYUpfCRaKhrKIy+puICdAZNmVw+6ELZAB7+wg
 ch096jxsNWrSOtnejSylYOLNsa+ZA46PNfOZUHiFY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206548>

On Thu, Sep 27, 2012 at 02:43:38AM -0400, Jeff King wrote:
> Here are the numbers using sed[1]
> instead:
=20
> -# Quotes each element of an IFS-delimited list for shell reuse
> +# Quotes each element of a newline-delimited list for shell reuse
>  __git_quote()
>  {
> -	local i
> -	local delim
> -	for i in $1; do
> -		local quoted=3D${i//\'/\'\\\'\'}
> -		printf "${delim:+$IFS}'%s'" "$quoted"
> -		delim=3Dt
> -	done
> +	echo "$1" |
> +	sed "
> +	  s/'/'\\\\''/g
> +	  s/^/'/
> +	  s/$/'/
> +	"
>  }
> =20
>  # Generates completion reply with compgen, appending a space to poss=
ible

Your usage of sed got me thinking and come up with this.

The first two fix benign bugs in completion tests, and the third adds
tests for __gitcomp_nl().  These are good to go.

The fourth adds __gitcomp() and __gitcomp_nl() tests for this
expansion breakage.  The expected results might need some adjustments,
because they contain special characters unquoted, but I'm tempted to
say that a branch called $foo is so rare in practice, that we
shouldn't bother.

The final one is a proof of concept for inspiration.  It gets rid of
compgen and its crazy additional expansion replacing it with a small
sed script.  It needs further work to handle words with whitespaces
and special characters.


SZEDER G=E1bor (5):
  completion: fix non-critical bugs in __gitcomp() tests
  completion: fix args of run_completion() test helper
  completion: add tests for the __gitcomp_nl() completion helper
    function
  completion: test __gitcomp() and __gitcomp_nl() with expandable words
  completion: avoid compgen to fix expansion issues in __gitcomp_nl()

 contrib/completion/git-completion.bash |  6 ++-
 t/t9902-completion.sh                  | 91 ++++++++++++++++++++++++++=
+++++---
 2 files changed, 90 insertions(+), 7 deletions(-)
